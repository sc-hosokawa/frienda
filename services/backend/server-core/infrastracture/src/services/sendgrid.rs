use application::services::send_email::EmailServiceTrait;
use async_trait::async_trait;
use domain::services::email::Email;
use sendgrid::v3::*;
use std::env;

pub struct SendGridService {
    sender: Sender,
}

impl SendGridService {
    pub async fn new() -> Result<Self, anyhow::Error> {
        tracing::info!("Setting up SendGridService...");
        let mock_url = env::var("SENDGRID_API_URL").ok();

        // モック使用時のみAPIキー未設定を許容
        let api_key: String = if mock_url.is_some() {
            env::var("SENDGRID_API_KEY").unwrap_or_else(|_| "dummy-api-key".to_string())
        } else {
            env::var("SENDGRID_API_KEY")?
        };
        let mut sender: Sender = Sender::new(api_key, None);

        // ローカル開発: SENDGRID_API_URL が設定されている場合はモックサーバーを使用
        if let Some(base_url) = mock_url {
            tracing::info!("Using SendGrid mock at: {}", base_url);
            sender.set_host(base_url);
        } else {
            tracing::info!("SendGrid API Key configured");
        }

        Ok(Self { sender })
    }
}

#[async_trait]
impl EmailServiceTrait for SendGridService {
    async fn send_email(&self, email: Email) -> Result<(), anyhow::Error> {
        let p: Personalization = Personalization::new(sendgrid::v3::Email::new(&email.to));

        let message: Message = Message::new(sendgrid::v3::Email::new(&email.from))
            .set_subject(&email.subject)
            .add_content(
                Content::new()
                    .set_content_type("text/plain")
                    .set_value(&email.body),
            )
            .add_personalization(p);

        let result = self.sender.send(&message).await?;
        tracing::info!("Email sent successfully: {:?}", result);

        Ok(())
    }
}
