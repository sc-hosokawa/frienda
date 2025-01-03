use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use tracing::info;
use uuid::Uuid;

use domain::entities::artists::Model as Artist;
use domain::entities::notification_user::ActiveModel as NotificationUserActiveModel;
use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::ActiveModel as NotificationActiveModel;
use domain::entities::txs_fsp::ActiveModel as TxsFspActiveModel;
use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

use crate::services::push_notification::PushNotificationServiceTrait;
use crate::services::send_email::EmailServiceTrait;
use domain::repositories::notification_user_repo::NotificationUserRepository;
use domain::repositories::notifications_repo::NotificationsRepository;
use domain::services::email::Email;
use domain::services::notification::PushNotification;
use shared::error::domain_err::DomainError;

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
    async fn _send_notifications(
        &self,
        to_user: String,
        fcm_token: Option<String>,
        email: String,
        amount: i32,
    ) -> Result<(), DomainError>;
}

//
// Implement the usecase
//
pub struct TransferPointBetweenAccountsUsecase {
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    notifications_repo: Arc<dyn NotificationsRepository>,
    notification_user_repo: Arc<dyn NotificationUserRepository>,
    push_notification_service: Arc<dyn PushNotificationServiceTrait>,
    email_service: Arc<dyn EmailServiceTrait>,
}

impl TransferPointBetweenAccountsUsecase {
    pub fn new(
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        notifications_repo: Arc<dyn NotificationsRepository>,
        notification_user_repo: Arc<dyn NotificationUserRepository>,
        push_notification_service: Arc<dyn PushNotificationServiceTrait>,
        email_service: Arc<dyn EmailServiceTrait>,
    ) -> Self {
        Self {
            txs_fsp_repo,
            users_repo,
            artists_repo,
            notifications_repo,
            notification_user_repo,
            push_notification_service,
            email_service,
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

        self._send_notifications(to_user.id, to_user.fcm_token, to_user.email, input.amount)
            .await?;

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
            to: ActiveValue::Set(to_user.id.clone()),
            amount: ActiveValue::Set(input.amount),
            notes: ActiveValue::Set(input.notes),
            ..Default::default()
        };
        let res = self.txs_fsp_repo.create(tx_fsp).await?;

        self._send_notifications(to_user.id, to_user.fcm_token, to_user.email, input.amount)
            .await?;

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
                from: match &transfer.from {
                    Some(from) if from.starts_with("artist_") => ActiveValue::Set(None),
                    other => ActiveValue::Set(other.clone()),
                },
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

    async fn _send_notifications(
        &self,
        to_user: String,
        fcm_token: Option<String>,
        email: String,
        amount: i32,
    ) -> Result<(), DomainError> {
        let notification_title: String = "ポイントを受け取りました".to_string();
        let notification_body: String = format!("{}ポイント受け取りました", amount);

        // 通知の作成
        let notification = {
            let notification_active_model = NotificationActiveModel {
                title: ActiveValue::Set(notification_title.clone()),
                content: ActiveValue::Set(notification_body.clone()),
                category: ActiveValue::Set(Some("fsp".to_string())),
                ..Default::default()
            };
            self.notifications_repo
                .create(notification_active_model)
                .await
                .map_err(|e| DomainError::UnexpectedError(e.to_string()))?
        };

        // 通知ユーザー関連付けの作成
        let notification_user: NotificationUser = {
            let notification_user_active_model = NotificationUserActiveModel {
                notification_id: ActiveValue::Set(notification.id),
                user: ActiveValue::Set(to_user),
                is_read: ActiveValue::Set(false),
                is_deleted: ActiveValue::Set(false),
                ..Default::default()
            };
            self.notification_user_repo
                .create(notification_user_active_model)
                .await
                .map_err(|e| DomainError::UnexpectedError(e.to_string()))?
        };
        info!("Successfully created notification: {:?}", notification_user);

        let push_notification_result = tokio::spawn({
            let push_notification_service = self.push_notification_service.clone();
            let title = notification_title.clone();
            let body = notification_body.clone();
            async move {
                if let Some(token) = fcm_token {
                    let push_notification = PushNotification { token, title, body };
                    push_notification_service
                        .send_push_notification(push_notification)
                        .await
                } else {
                    Ok(String::new())
                }
            }
        });

        let email_result = tokio::spawn({
            let email_service = self.email_service.clone();
            let title = notification_title;
            let body = notification_body;
            async move {
                let email_notification = Email {
                    from: "info@friendshipdao.xyz".to_string(),
                    to: email,
                    subject: format!("【FRIENDSHIP. DAO】{}", title),
                    body: format!(
                        "{}\n\nウェブサイトを開いて確認する: https://app.friendshipdao.xyz",
                        body
                    ),
                };
                email_service.send_email(email_notification).await
            }
        });

        // プッシュ通知とメールの完了を待機（エラーはログに記録）
        if let Err(e) = push_notification_result.await {
            tracing::error!("Push notification task failed: {}", e);
        }

        if let Err(e) = email_result.await {
            tracing::error!("Email task failed: {}", e);
        }

        Ok(())
    }
}
