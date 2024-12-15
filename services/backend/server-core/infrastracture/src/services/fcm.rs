use async_trait::async_trait;
use std::env;
use tempfile;

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
        // let service_account_json = env::var("FCM_SERVICE_ACCOUNT")?;
        // let temp_file = tempfile::NamedTempFile::new()?;
        // println!("temp_file: {:?}", temp_file);
        // std::fs::write(&temp_file, service_account_json)?;
        // let client = FcmClient::new(temp_file.path().to_str().unwrap()).await?;
        let service_account_path = "frienda-auth-test1-a490c287d01b.json";
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
