use async_trait::async_trait;

#[derive(Debug)]
pub struct PushNotification {
    pub token: String,
    pub title: String,
    pub body: String,
}

#[async_trait]
pub trait NotificationServiceTrait: Send + Sync {
    async fn send_notification(&self, notification: PushNotification) -> Result<String, anyhow::Error>;
}

pub struct NotificationServiceImpl {}

impl NotificationServiceTrait for NotificationServiceImpl {
    async fn send_notification(&self, notification: PushNotification) -> Result<String, anyhow::Error> {
        Ok(format!("Notification sent to token: {}", notification.token))
    }
}

impl NotificationServiceImpl {
    pub fn new() -> Self {
        Self {}
    }
}
