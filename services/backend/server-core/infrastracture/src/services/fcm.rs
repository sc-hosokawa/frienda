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
    pub async fn new() -> Result<Self, anyhow::Error> {
        tracing::info!("Setting up FcmNotificationService...");
        let environment: String = std::env::var("ENVIRONMENT").unwrap_or_else(|_| "dev".to_string());
        
        let service_account_path = if environment == "prod" {
            "friendship-dao-firebase-adminsdk-a2w15-e1854b252a.json"
        } else {
            "frienda-auth-test1-a490c287d01b.json"
        };
        
        tracing::info!("Using FCM service account: {}", service_account_path);
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
