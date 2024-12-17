use application::services::send_email::EmailServiceTrait;
use async_trait::async_trait;
use domain::services::email::Email;
use lettre::{transport::smtp::authentication::Credentials, Message, SmtpTransport, Transport};
use std::env;

pub struct SendGridService {
    mailer: SmtpTransport,
}

impl SendGridService {
    pub fn new() -> Result<Self, anyhow::Error> {
        tracing::info!("Setting up SendGridService...");
        let api_key: String = env::var("SENDGRID_API_KEY")?;
        let creds: Credentials = Credentials::new("apikey".to_string(), api_key.clone());
        let mailer: SmtpTransport = SmtpTransport::relay("smtp.sendgrid.net")?
            .credentials(creds.clone())
            .build();

        tracing::info!("SendGridApiKey: {}", api_key);
        tracing::info!("SendGridCreds: {:?}", creds);
        tracing::info!("SendGridMailer: {:?}", mailer);

        /*
        // テストメールの送信
        let test_email: Message = Message::builder()
            .from("info@friendshipdao.xyz".parse()?)
            .to("naoki@fracton.ventures".parse()?)
            .subject("SendGrid Test Email")
            .body(String::from(
                "SendGrid service has been initialized successfully.",
            ))?;

        mailer.send(&test_email)?;
        tracing::info!("Test email sent successfully");
        */

        Ok(Self { mailer })
    }
}

#[async_trait]
impl EmailServiceTrait for SendGridService {
    async fn send_email(&self, email: Email) -> Result<(), anyhow::Error> {
        let email_message: Message = Message::builder()
            .from(email.from.parse()?)
            .to(email.to.parse()?)
            .subject(email.subject)
            .body(email.body)?;

        self.mailer.send(&email_message)?;

        Ok(())
    }
}
