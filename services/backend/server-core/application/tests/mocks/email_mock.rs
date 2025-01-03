use application::services::send_email::EmailServiceTrait;
use async_trait::async_trait;
use domain::services::email::Email;
use mockall::automock;

#[automock]
#[async_trait]
pub trait MockEmailService {
    async fn mock_send_email(&self, email: Email) -> Result<(), anyhow::Error>;
}

#[async_trait]
impl EmailServiceTrait for MockMockEmailService {
    async fn send_email(&self, email: Email) -> Result<(), anyhow::Error> {
        self.mock_send_email(email).await
    }
}
