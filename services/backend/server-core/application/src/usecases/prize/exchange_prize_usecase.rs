use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::exchange_prize_history::{
    ActiveModel as ExchangePrizeHistoryActiveModel, Model as ExchangePrizeHistory,
};
use domain::entities::prizes::Model as Prize;
use domain::entities::txs_fsp::ActiveModel as FspTxActiveModel;

use domain::repositories::exchange_prize_history_repo::ExchangePrizeHistoryRepository;
use domain::repositories::prizes_repo::PrizesRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct ExchangePrizeInput {
    pub user_id: String,
    pub prize_id: i32,
    pub amount: Option<i32>,
}

pub struct UsePrizeInput {
    pub representation_user_id: String,
    pub user_id: String,
    pub prize_id: i32,
    pub code: Option<String>,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait ExchangePrizeUsecaseTrait: Send + Sync {
    async fn exchange(&self, input: ExchangePrizeInput) -> Result<(i32, Uuid), anyhow::Error>;
    async fn use_prize(&self, input: UsePrizeInput) -> Result<i32, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct ExchangePrizeUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
    exchange_prize_history_repo: Arc<dyn ExchangePrizeHistoryRepository>,
    users_repo: Arc<dyn UsersRepository>,
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
}

impl ExchangePrizeUsecase {
    pub fn new(
        prizes_repo: Arc<dyn PrizesRepository>,
        exchange_prize_history_repo: Arc<dyn ExchangePrizeHistoryRepository>,
        users_repo: Arc<dyn UsersRepository>,
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
    ) -> Self {
        Self {
            prizes_repo,
            exchange_prize_history_repo,
            users_repo,
            txs_fsp_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl ExchangePrizeUsecaseTrait for ExchangePrizeUsecase {
    async fn exchange(&self, input: ExchangePrizeInput) -> Result<(i32, Uuid), anyhow::Error> {
        // prizeの確認
        let prize = self
            .prizes_repo
            .get_by_id(input.prize_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Prize not found"))?;

        let amount = input.amount.unwrap_or(1);
        let total_points = prize.point * amount;

        // ユーザーの残高チェック
        let user = self
            .users_repo
            .find_by_id(&input.user_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found"))?;

        if user.fsp < total_points {
            return Err(anyhow::anyhow!("Insufficient balance"));
        }

        // 残高の更新
        let user = self.users_repo.update_fsp(&user.id, -total_points).await?;

        // representation_userのfsp残高の更新
        self.users_repo
            .update_fsp(&prize.representation, total_points)
            .await?;

        // exchange_prize_historyの作成
        let exchange_prize_history: ExchangePrizeHistoryActiveModel =
            ExchangePrizeHistoryActiveModel {
                user: ActiveValue::Set(input.user_id.clone()),
                prize_id: ActiveValue::Set(input.prize_id),
                point_used: ActiveValue::Set(total_points),
                amount: ActiveValue::Set(amount),
                ..Default::default()
            };

        // fsp_txの作成
        let fsp_tx: FspTxActiveModel = FspTxActiveModel {
            from: ActiveValue::Set(Some(user.id.clone())),
            to: ActiveValue::Set(prize.representation),
            amount: ActiveValue::Set(total_points),
            notes: ActiveValue::Set(Some(format!("Exchange prize: {}", prize.name))),
            ..Default::default()
        };

        // 並行して実行
        let (created_exchange_prize_history, created_fsp_tx_id) = tokio::try_join!(
            self.exchange_prize_history_repo
                .create(exchange_prize_history),
            self.txs_fsp_repo.create(fsp_tx)
        )?;

        Ok((created_exchange_prize_history.id, created_fsp_tx_id.id))
    }

    async fn use_prize(&self, input: UsePrizeInput) -> Result<i32, anyhow::Error> {
        let exchange_prize_history: ExchangePrizeHistory = self
            .exchange_prize_history_repo
            .get_by_user_id_and_prize_id(&input.user_id, input.prize_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Exchange prize history not found"))?;

        if exchange_prize_history.is_used {
            return Err(anyhow::anyhow!("Prize already used"));
        }

        let prize: Prize = self
            .prizes_repo
            .get_by_id(input.prize_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Prize not found"))?;

        if prize.representation != input.representation_user_id {
            return Err(anyhow::anyhow!("Invalid representation user"));
        }

        let updated_history: ExchangePrizeHistoryActiveModel = ExchangePrizeHistoryActiveModel {
            id: ActiveValue::Set(exchange_prize_history.id),
            is_used: ActiveValue::Set(true),
            used_at: ActiveValue::Set(Some(chrono::Utc::now().naive_utc())),
            ..Default::default()
        };

        let updated_history = self
            .exchange_prize_history_repo
            .update(updated_history)
            .await?;

        Ok(updated_history.id)
    }
}
