use async_trait::async_trait;
// use std::env;
// use tempfile;

use application::services::push_notification::PushNotificationServiceTrait;
use domain::services::notification::PushNotification;
use fcm_rs::{
    client::FcmClient,
    models::{Message, Notification},
};

pub struct FcmNotificationService {
    client: FcmClient,
}

impl FcmNotificationService {
    pub async fn new(service_account_path: &str) -> Result<Self, anyhow::Error> {
        tracing::info!(
            "Setting up FcmNotificationService with path: {}...",
            service_account_path
        );
        let client = FcmClient::new(service_account_path).await?;
        Ok(Self { client })
    }
}

#[async_trait]
impl PushNotificationServiceTrait for FcmNotificationService {
    async fn send_push_notification(
        &self,
        notification: PushNotification,
    ) -> Result<String, anyhow::Error> {
        let message = Message {
            token: Some(notification.token),
            notification: Some(Notification {
                title: Some(notification.title),
                body: Some(notification.body),
            }),
            data: None,
        };

        let response = self.client.send(message).await?;
        println!("FCM response: {:?}", response);

        Ok(response.name)
    }
}
