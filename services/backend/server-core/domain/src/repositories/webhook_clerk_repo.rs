use crate::entities::webhook_clerk::{
    ActiveModel as WebhookClerkActiveModel, Model as WebhookClerk,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait WebhookClerkRepository {
    async fn create(
        &self,
        webhook_clerk: &WebhookClerkActiveModel,
    ) -> Result<WebhookClerk, DomainError>;
    async fn update(
        &self,
        webhook_clerk: &WebhookClerkActiveModel,
    ) -> Result<WebhookClerk, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn find_by_id(&self, id: i32) -> Result<Option<WebhookClerk>, DomainError>;
    async fn find_all(&self) -> Result<Vec<WebhookClerk>, DomainError>;
    async fn count(&self) -> Result<i64, DomainError>;
    async fn find_by_processed(&self, processed: bool) -> Result<Vec<WebhookClerk>, DomainError>;
}
