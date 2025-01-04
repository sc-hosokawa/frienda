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
        let api_key: String = env::var("SENDGRID_API_KEY")?;
        let sender: Sender = Sender::new(api_key.clone(), None);
        tracing::info!("SendGrid API Key configured");
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
