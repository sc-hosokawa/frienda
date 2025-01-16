use async_trait::async_trait;
use std::sync::Arc;

use crate::services::send_email::EmailServiceTrait;
use domain::services::email::Email;

pub struct ContactToAdminInput {
    pub name: String,
    pub category: String,
    pub email: String,
    pub message: String,
}

#[async_trait]
pub trait ContactToAdminUsecaseTrait: Send + Sync {
    async fn contact_to_admin(&self, input: ContactToAdminInput) -> Result<(), anyhow::Error>;
}

pub struct ContactToAdminUsecase {
    email_service: Arc<dyn EmailServiceTrait>,
}

impl ContactToAdminUsecase {
    pub fn new(email_service: Arc<dyn EmailServiceTrait>) -> Self {
        Self { email_service }
    }
}

#[async_trait]
impl ContactToAdminUsecaseTrait for ContactToAdminUsecase {
    async fn contact_to_admin(&self, input: ContactToAdminInput) -> Result<(), anyhow::Error> {
        let email: Email = Email {
            from: "info@friendshipdao.xyz".to_string(),
            to: "naoki@fracton.ventures".to_string(),
            subject: "Contact from user".to_string(),
            body: format!(
                "Name: {}\nCategory: {}\nEmail: {}\nMessage: {}",
                input.name, input.category, input.email, input.message
            ),
        };
        self.email_service.send_email(email).await?;
        Ok(())
    }
}
