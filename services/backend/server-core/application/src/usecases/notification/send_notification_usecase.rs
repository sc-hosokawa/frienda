use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Model as NotificationUser,
};
use domain::entities::notifications::{
    ActiveModel as NotificationActiveModel, Model as Notification,
};
use domain::repositories::notification_user_repo::NotificationUserRepository;
use domain::repositories::notifications_repo::NotificationsRepository;

#[async_trait]
pub trait SendNotificationUsecaseTrait: Send + Sync {
    async fn store_notification(&self, notification: Notification) -> Result<(), anyhow::Error>;
}

pub struct SendNotificationUsecase {
    notifications_repo: Arc<dyn NotificationsRepository>,
    notification_user_repo: Arc<dyn NotificationUserRepository>,
}

impl SendNotificationUsecase {
    pub fn new(
        notifications_repo: Arc<dyn NotificationsRepository>,
        notification_user_repo: Arc<dyn NotificationUserRepository>,
    ) -> Self {
        Self {
            notifications_repo,
            notification_user_repo,
        }
    }
}

#[async_trait]
impl SendNotificationUsecaseTrait for SendNotificationUsecase {
    async fn store_notification(&self, notification: Notification) -> Result<(), anyhow::Error> {
        unimplemented!()
    }
}
