use async_trait::async_trait;
use std::sync::Arc;

use domain::services::notification::PushNotification;

#[async_trait]
pub trait PushNotificationServiceTrait: Send + Sync {
    async fn send_push_notification(
        &self,
        notification: PushNotification,
    ) -> Result<String, anyhow::Error>;
}

pub struct PushNotificationService {
    notification_service: Arc<dyn PushNotificationServiceTrait>,
}

impl PushNotificationService {
    pub fn new(notification_service: Arc<dyn PushNotificationServiceTrait>) -> Self {
        Self {
            notification_service,
        }
    }
}

#[async_trait]
impl PushNotificationServiceTrait for PushNotificationService {
    async fn send_push_notification(
        &self,
        notification: PushNotification,
    ) -> Result<String, anyhow::Error> {
        let result = self
            .notification_service
            .send_push_notification(notification)
            .await;
        tracing::debug!("result: {:?}", result);
        result
    }
}
