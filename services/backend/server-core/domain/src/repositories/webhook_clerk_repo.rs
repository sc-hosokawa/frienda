use crate::entities::webhook_clerk::Entity as WebhookClerk;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait WebhookClerkRepository {
    async fn create(&self, webhook_clerk: WebhookClerk) -> Result<WebhookClerk, DomainError>;
    async fn find_by_id(&self, id: i32) -> Result<Option<WebhookClerk>, DomainError>;
    async fn find_all(&self) -> Result<Vec<WebhookClerk>, DomainError>;
    async fn update(&self, webhook_clerk: WebhookClerk) -> Result<WebhookClerk, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn count(&self) -> Result<i64, DomainError>;
    async fn find_by_status(&self, status: bool) -> Result<Vec<WebhookClerk>, DomainError>;
}
