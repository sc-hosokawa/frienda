use async_trait::async_trait;
use std::sync::Arc;

use domain::services::email::Email;

#[async_trait]
pub trait EmailServiceTrait: Send + Sync {
    async fn send_email(&self, email: Email) -> Result<(), anyhow::Error>;
}

pub struct EmailService {
    email_service: Arc<dyn EmailServiceTrait>,
}

impl EmailService {
    pub fn new(email_service: Arc<dyn EmailServiceTrait>) -> Self {
        Self { email_service }
    }
}

#[async_trait]
impl EmailServiceTrait for EmailService {
    async fn send_email(&self, email: Email) -> Result<(), anyhow::Error> {
        self.email_service.send_email(email).await
    }
}
