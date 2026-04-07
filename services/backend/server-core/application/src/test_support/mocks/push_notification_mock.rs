use crate::services::push_notification::PushNotificationServiceTrait;
use async_trait::async_trait;
use domain::services::notification::PushNotification;
use mockall::automock;

#[automock]
#[async_trait]
pub trait MockPushNotificationService {
    async fn mock_send_push_notification(
        &self,
        notification: PushNotification,
    ) -> Result<String, anyhow::Error>;
}

#[async_trait]
impl PushNotificationServiceTrait for MockMockPushNotificationService {
    async fn send_push_notification(
        &self,
        notification: PushNotification,
    ) -> Result<String, anyhow::Error> {
        self.mock_send_push_notification(notification).await
    }
}
