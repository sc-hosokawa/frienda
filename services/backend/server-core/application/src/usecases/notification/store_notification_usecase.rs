use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Model as NotificationUser,
};
use domain::entities::notifications::{
    ActiveModel as NotificationActiveModel, Model as Notification,
};
use domain::repositories::notification_user_repo::NotificationUserRepository;
use domain::repositories::notifications_repo::NotificationsRepository;

pub struct StoreNotificationInput {
    pub title: String,
    pub content: String,
    pub user_id: String,
}

#[async_trait]
pub trait StoreNotificationUsecaseTrait: Send + Sync {
    async fn store_notification(&self, input: StoreNotificationInput) -> Result<(), anyhow::Error>;
}

pub struct StoreNotificationUsecase {
    notifications_repo: Arc<dyn NotificationsRepository>,
    notification_user_repo: Arc<dyn NotificationUserRepository>,
}

impl StoreNotificationUsecase {
    pub fn new(
        notifications_repo: Arc<dyn NotificationsRepository>,
        notification_user_repo: Arc<dyn NotificationUserRepository>,
    ) -> Self {
        Self {
            notifications_repo,
            notification_user_repo,
        }
    }

    async fn store_notification_internal(
        &self,
        title: String,
        content: String,
        user_id: String,
    ) -> Result<(Notification, NotificationUser), anyhow::Error> {
        let notification: NotificationActiveModel = NotificationActiveModel {
            id: ActiveValue::NotSet,
            title: ActiveValue::Set(title),
            content: ActiveValue::Set(content),
            ..Default::default()
        };
        let notification: Notification = self.notifications_repo.create(notification).await?;

        let notification_user: NotificationUserActiveModel = NotificationUserActiveModel {
            id: ActiveValue::NotSet,
            user: ActiveValue::Set(user_id),
            is_deleted: ActiveValue::Set(false),
            notification_id: ActiveValue::Set(notification.id),
            is_read: ActiveValue::Set(false),
        };
        let notification_user = self
            .notification_user_repo
            .create(notification_user)
            .await?;

        tracing::info!("Notification created: {:?}", notification);
        tracing::info!("NotificationUser created: {:?}", notification_user);

        Ok((notification, notification_user))
    }
}

#[async_trait]
impl StoreNotificationUsecaseTrait for StoreNotificationUsecase {
    async fn store_notification(&self, input: StoreNotificationInput) -> Result<(), anyhow::Error> {
        self.store_notification_internal(input.title, input.content, input.user_id)
            .await?;
        Ok(())
    }
}

#[cfg(test)]
#[path = "store_notification_usecase_tests.rs"]
mod tests;
