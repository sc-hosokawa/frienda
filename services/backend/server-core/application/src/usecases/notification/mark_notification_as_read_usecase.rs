use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Model as NotificationUser,
};
use domain::repositories::notification_user_repo::NotificationUserRepository;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait MarkNotificationAsReadUsecaseTrait: Send + Sync {
    async fn mark_notification_as_read(
        &self,
        notification_id: i32,
        user_id: &str,
    ) -> Result<i32, DomainError>;
}

pub struct MarkNotificationAsReadUsecase {
    notification_user_repo: Arc<dyn NotificationUserRepository>,
}

impl MarkNotificationAsReadUsecase {
    pub fn new(notification_user_repo: Arc<dyn NotificationUserRepository>) -> Self {
        Self {
            notification_user_repo,
        }
    }
}

#[async_trait]
impl MarkNotificationAsReadUsecaseTrait for MarkNotificationAsReadUsecase {
    async fn mark_notification_as_read(
        &self,
        notification_id: i32,
        user_id: &str,
    ) -> Result<i32, DomainError> {
        let read_notification_user: NotificationUser = self
            .notification_user_repo
            .get_by_user_id_and_notification_id(user_id, notification_id)
            .await?
            .unwrap();

        let marked_notification_user = NotificationUserActiveModel {
            id: ActiveValue::Set(read_notification_user.id),
            is_read: ActiveValue::Set(true),
            ..Default::default()
        };

        let updated_notification_user: NotificationUser = self
            .notification_user_repo
            .update(marked_notification_user)
            .await?;

        Ok(updated_notification_user.id)
    }
}
