use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use tracing::info;
use uuid::Uuid;

use domain::entities::artists::Model as Artist;
use domain::entities::txs_fsp::ActiveModel as TxsFspActiveModel;
use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct TransferPointBetweenAccountsInput {
    pub from: Option<String>,
    pub to: String,
    pub amount: i32,
    pub notes: Option<String>, // abstract
}

pub struct TransferPointBetweenAccountsByUsernameOrEmailInput {
    pub from: Option<String>,
    pub to: String,
    pub amount: i32,
    pub notes: Option<String>, // abstract
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait TransferPointBetweenAccountsUsecaseTrait: Send + Sync {
    async fn transfer(
        &self,
        input: TransferPointBetweenAccountsInput,
    ) -> Result<Uuid, anyhow::Error>;
    async fn bulk_transfer(
        &self,
        input: Vec<TransferPointBetweenAccountsInput>,
    ) -> Result<Uuid, anyhow::Error>;
    async fn transfer_by_username_or_email(
        &self,
        input: TransferPointBetweenAccountsInput,
    ) -> Result<Uuid, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct TransferPointBetweenAccountsUsecase {
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl TransferPointBetweenAccountsUsecase {
    pub fn new(
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            txs_fsp_repo,
            users_repo,
            artists_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl TransferPointBetweenAccountsUsecaseTrait for TransferPointBetweenAccountsUsecase {
    async fn transfer(
        &self,
        input: TransferPointBetweenAccountsInput,
    ) -> Result<Uuid, anyhow::Error> {
        if let Some(from) = &input.from {
            if from != "admin_0000000000000000000001" {
                let from_user = self
                    .users_repo
                    .find_by_id(from)
                    .await?
                    .ok_or_else(|| anyhow::anyhow!("User not found"))?;
                if from_user.fsp < input.amount {
                    return Err(anyhow::anyhow!("Insufficient balance"));
                }
                let from_user_info: User = self
                    .users_repo
                    .update_fsp(&from_user.id, -input.amount)
                    .await?;
                info!("from_user_info: {:?}", from_user_info.id);
            }
        }

        let to_user = self
            .users_repo
            .find_by_id(&input.to)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found"))?;
        let to_user_info: User = self
            .users_repo
            .update_fsp(&to_user.id, input.amount)
            .await?;
        info!("to_user_info: {:?}", to_user_info.id);

        let tx_fsp: TxsFspActiveModel = TxsFspActiveModel {
            from: ActiveValue::Set(input.from),
            to: ActiveValue::Set(input.to),
            amount: ActiveValue::Set(input.amount),
            notes: ActiveValue::Set(input.notes),
            ..Default::default()
        };
        let res = self.txs_fsp_repo.create(tx_fsp).await?;

        Ok(res.id)
    }

    async fn transfer_by_username_or_email(
        &self,
        input: TransferPointBetweenAccountsInput,
    ) -> Result<Uuid, anyhow::Error> {
        let to_user = self
            .users_repo
            .find_by_username_or_email(&input.to)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found"))?;
        let to_user_info: User = self
            .users_repo
            .update_fsp(&to_user.id, input.amount)
            .await?;
        info!("to_user_info: {:?}", to_user_info.id);

        if let Some(from) = &input.from {
            if from != "admin_0000000000000000000001" {
                let from_user = self
                    .users_repo
                    .find_by_id(from)
                    .await?
                    .ok_or_else(|| anyhow::anyhow!("User not found"))?;
                if from_user.fsp < input.amount {
                    return Err(anyhow::anyhow!("Insufficient balance"));
                }
                let from_user_info: User = self
                    .users_repo
                    .update_fsp(&from_user.id, -input.amount)
                    .await?;
                info!("from_user_info: {:?}", from_user_info.id);
            }
        }

        let tx_fsp: TxsFspActiveModel = TxsFspActiveModel {
            from: ActiveValue::Set(input.from),
            to: ActiveValue::Set(to_user.id),
            amount: ActiveValue::Set(input.amount),
            notes: ActiveValue::Set(input.notes),
            ..Default::default()
        };
        let res = self.txs_fsp_repo.create(tx_fsp).await?;

        Ok(res.id)
    }

    async fn bulk_transfer(
        &self,
        input: Vec<TransferPointBetweenAccountsInput>,
    ) -> Result<Uuid, anyhow::Error> {
        let mut tx_fsps: Vec<TxsFspActiveModel> = Vec::with_capacity(input.len());

        for transfer in &input {
            if let Some(from) = &transfer.from {
                if from == "admin_0000000000000000000001" {
                    // 管理者アカウントの処理（スキップ）
                } else if from.starts_with("artist_") {
                    // アーティストアカウント用の特別処理をここに実装
                    let from_artist: Artist = self
                        .artists_repo
                        .find_by_id(from)
                        .await?
                        .ok_or_else(|| anyhow::anyhow!("Artist not found"))?;
                    if from_artist.fsp < transfer.amount {
                        return Err(anyhow::anyhow!("Insufficient artist balance"));
                    }

                    let from_artist_info: Artist =
                        self.artists_repo.update_fsp(from, -transfer.amount).await?;
                    info!("BulkTx::artist_from_artist_info: {:?}", from_artist_info.id);
                } else {
                    // 通常ユーザーの処理
                    if let Ok(Some(from_user)) = self.users_repo.find_by_id(from).await {
                        if from_user.fsp < transfer.amount {
                            return Err(anyhow::anyhow!("Insufficient balance"));
                        }
                        let from_user_info: User =
                            self.users_repo.update_fsp(from, -transfer.amount).await?;
                        info!("BulkTx::from_user_info: {:?}", from_user_info.id);
                    }
                }
            }

            let _to_user = self
                .users_repo
                .find_by_id(&transfer.to)
                .await?
                .ok_or_else(|| anyhow::anyhow!("To user not found"))?;
            let to_user_info: User = self
                .users_repo
                .update_fsp(&transfer.to, transfer.amount)
                .await?;
            info!("BulkTx::to_user_info: {:?}", to_user_info.id);

            let tx_fsp = TxsFspActiveModel {
                from: ActiveValue::Set(transfer.from.clone()),
                to: ActiveValue::Set(transfer.to.clone()),
                amount: ActiveValue::Set(transfer.amount),
                notes: ActiveValue::Set(transfer.notes.clone()),
                ..Default::default()
            };
            tx_fsps.push(tx_fsp);
        }

        let res = self.txs_fsp_repo.create_many(tx_fsps).await?;

        Ok(res.id)
    }
}
