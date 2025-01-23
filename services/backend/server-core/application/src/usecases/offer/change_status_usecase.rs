use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use tokio::try_join;
use tracing::{info, instrument};

use domain::entities::offer_user::ActiveModel as OfferUserActiveModel;
use domain::entities::offers::ActiveModel as OfferActiveModel;
use domain::entities::sea_orm_active_enums::OfferStatus;
use domain::entities::txs_fsp::ActiveModel as TxsFspActiveModel;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

use crate::services::push_notification::PushNotificationServiceTrait;
use crate::services::send_email::EmailServiceTrait;
use domain::entities::notification_user::ActiveModel as NotificationUserActiveModel;
use domain::entities::notifications::ActiveModel as NotificationActiveModel;
use domain::repositories::notification_user_repo::NotificationUserRepository;
use domain::repositories::notifications_repo::NotificationsRepository;
use domain::services::email::Email;
use domain::services::notification::PushNotification;
use shared::error::domain_err::DomainError;

//
// Define the input for the usecase
//
#[derive(Debug)]
pub struct ChangeStatusInput {
    pub id: i32,
    pub user_id: String,
    pub status: OfferStatus,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait ChangeStatusUsecaseTrait: Send + Sync {
    async fn apply(&self, input: ChangeStatusInput) -> Result<(i32, i32), anyhow::Error>;
    async fn change_status(&self, input: ChangeStatusInput) -> Result<(i32, i32), anyhow::Error>;
    async fn complete(&self, input: ChangeStatusInput) -> Result<(i32, i32), anyhow::Error>;
    async fn _send_notifications(
        &self,
        user_id: String,
        title: String,
        body: String,
    ) -> Result<(), DomainError>;
}

//
// Implement the usecase
//
pub struct ChangeStatusUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    users_repo: Arc<dyn UsersRepository>,
    notifications_repo: Arc<dyn NotificationsRepository>,
    notification_user_repo: Arc<dyn NotificationUserRepository>,
    push_notification_service: Arc<dyn PushNotificationServiceTrait>,
    email_service: Arc<dyn EmailServiceTrait>,
}

impl ChangeStatusUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        users_repo: Arc<dyn UsersRepository>,
        notifications_repo: Arc<dyn NotificationsRepository>,
        notification_user_repo: Arc<dyn NotificationUserRepository>,
        push_notification_service: Arc<dyn PushNotificationServiceTrait>,
        email_service: Arc<dyn EmailServiceTrait>,
    ) -> Self {
        Self {
            offers_repo,
            offer_user_repo,
            txs_fsp_repo,
            users_repo,
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
impl ChangeStatusUsecaseTrait for ChangeStatusUsecase {
    #[instrument(skip(self), fields(offer_id = input.id, user_id = %input.user_id))]
    async fn apply(&self, input: ChangeStatusInput) -> Result<(i32, i32), anyhow::Error> {
        info!("Applying for offer");
        let new_status: OfferUserActiveModel = OfferUserActiveModel {
            offer_id: ActiveValue::Set(input.id),
            user_id: ActiveValue::Set(input.user_id),
            status: ActiveValue::Set(OfferStatus::Applied),
            ..Default::default()
        };

        let res = self.offer_user_repo.create(new_status).await?;
        info!("Successfully applied for offer");

        let offer = self.offers_repo.get_by_id(input.id).await?.unwrap();
        self._send_notifications(
            offer.owner,
            "オファーへの申し込みがありました".to_string(),
            format!("オファーへの申し込みがありました"),
        )
        .await?;

        Ok((res.id, res.offer_id))
    }

    #[instrument(skip(self), fields(offer_id = input.id, user_id = %input.user_id, status = ?input.status))]
    async fn change_status(&self, input: ChangeStatusInput) -> Result<(i32, i32), anyhow::Error> {
        info!("Changing offer status");
        match input.status {
            OfferStatus::Rejected | OfferStatus::Ongoing | OfferStatus::Canceled => {}
            _ => {
                return Err(anyhow::anyhow!(
                    "Invalid status. Only Rejected, Ongoing, or Canceled are allowed."
                ))
            }
        }

        if input.status == OfferStatus::Ongoing {
            info!("Canceling other users' applications for the same offer");
            self.offer_user_repo
                .cancel_other_applications(input.id, &input.user_id)
                .await?;
            info!("Change Public Status to false");
            self.offers_repo
                .update(OfferActiveModel {
                    id: ActiveValue::Set(input.id),
                    publicity: ActiveValue::Set(false),
                    ..Default::default()
                })
                .await?;
        }

        let offer_user_mapping = self
            .offer_user_repo
            .get_by_user_id_and_offer_id(&input.user_id, input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Offer user mapping not found"))?;

        let mut updated_offer_user: OfferUserActiveModel = offer_user_mapping.into();
        updated_offer_user.status = ActiveValue::Set(input.status);

        let res = self.offer_user_repo.update(updated_offer_user).await?;

        self._send_notifications(
            input.user_id,
            "オファーのステータスが変更されました".to_string(),
            format!("オファーのステータスが変更されました"),
        )
        .await?;

        Ok((res.id, res.offer_id))
    }

    #[instrument(skip(self), fields(offer_id = input.id, user_id = %input.user_id))]
    async fn complete(&self, input: ChangeStatusInput) -> Result<(i32, i32), anyhow::Error> {
        info!("Completing offer");
        match input.status {
            OfferStatus::Finished => {}
            _ => {
                return Err(anyhow::anyhow!(
                    "Invalid status. Only Finished are allowed."
                ))
            }
        }

        let offer_user_mapping = self
            .offer_user_repo
            .get_by_user_id_and_offer_id(&input.user_id, input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Offer user mapping not found"))?;

        if offer_user_mapping.status != OfferStatus::Ongoing {
            return Err(anyhow::anyhow!(
                "Offer user mapping is not in Ongoing status"
            ));
        }

        let offer = self
            .offers_repo
            .get_by_id(input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Offer not found"))?;

        let user_id = offer_user_mapping.user_id.clone();

        // Update user's FSP balances
        self.users_repo.update_fsp(&user_id, offer.fee).await?;
        self.users_repo.update_fsp(&offer.owner, -offer.fee).await?;

        let (updated_offer_user, updated_offer, txs_fsp) = (
            OfferUserActiveModel {
                status: ActiveValue::Set(OfferStatus::Finished),
                ..offer_user_mapping.into()
            },
            OfferActiveModel {
                publicity: ActiveValue::Set(false),
                ..offer.clone().into()
            },
            TxsFspActiveModel {
                from: ActiveValue::Set(Some(offer.owner)),
                to: ActiveValue::Set(user_id.clone()),
                amount: ActiveValue::Set(offer.fee),
                notes: ActiveValue::Set(Some(format!("[Offer] {} completed", offer.title))),
                ..Default::default()
            },
        );

        let (offer_user_result, offer_result, txs_fsp_result) = try_join!(
            self.offer_user_repo.update(updated_offer_user),
            self.offers_repo.update(updated_offer),
            self.txs_fsp_repo.create(txs_fsp)
        )?;

        self._send_notifications(
            user_id,
            "オファーが完了しました".to_string(),
            "オファーが完了し、ポイントを受け取りました".to_string(),
        )
        .await?;

        info!("Successfully completed offer");
        info!("FSP tx id: {}", txs_fsp_result.id);
        Ok((offer_user_result.id, offer_result.id))
    }

    async fn _send_notifications(
        &self,
        user_id: String,
        title: String,
        body: String,
    ) -> Result<(), DomainError> {
        let user = self.users_repo.find_by_id(&user_id).await?.unwrap();

        // データベースへの通知保存タスク
        let db_task = async {
            let notification_active_model = NotificationActiveModel {
                title: ActiveValue::Set(title.clone()),
                content: ActiveValue::Set(body.clone()),
                category: ActiveValue::Set(Some("offer".to_string())),
                ..Default::default()
            };
            let new_notification = self
                .notifications_repo
                .create(notification_active_model)
                .await?;

            let notification_user_active_model = NotificationUserActiveModel {
                notification_id: ActiveValue::Set(new_notification.id),
                user: ActiveValue::Set(user.id.clone()),
                is_read: ActiveValue::Set(false),
                is_deleted: ActiveValue::Set(false),
                ..Default::default()
            };
            self.notification_user_repo
                .create(notification_user_active_model)
                .await
        };

        // プッシュ通知タスク
        let push_notification_task = user.fcm_token.map(|token| {
            let push_notification = PushNotification {
                token,
                title: title.clone(),
                body: body.clone(),
            };
            self.push_notification_service
                .send_push_notification(push_notification)
        });

        // メール通知タスク
        let email_task = {
            let email: String = user.email.clone();
            let title_clone: String = title.clone();
            let body_clone: String = body.clone();
            let email_service: Arc<dyn EmailServiceTrait> = self.email_service.clone();
            tokio::spawn(async move {
                let email_notification = Email {
                    from: "info@friendshipdao.xyz".to_string(),
                    to: email,
                    subject: format!("【FRIENDSHIP. DAO】{}", title_clone),
                    body: format!(
                        "{}\n\nウェブサイトを開いて確認する: https://app.friendshipdao.xyz",
                        body_clone
                    ),
                };
                if let Err(e) = email_service.send_email(email_notification).await {
                    tracing::warn!("Failed to send email notification: {}", e);
                }
            })
        };

        let (db_result, _, _) = tokio::join!(
            db_task,
            async {
                if let Some(task) = push_notification_task {
                    match task.await {
                        Ok(result) => {
                            tracing::debug!("Push notification sent successfully: {}", result)
                        }
                        Err(e) => tracing::error!("Failed to send push notification: {}", e),
                    }
                }
            },
            email_task
        );

        db_result.map(|_| ())
    }
}
