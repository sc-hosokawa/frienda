use crate::entities::webhook_stripe::{
    ActiveModel as WebhookStripeActiveModel, Model as WebhookStripe,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait WebhookStripeRepository {
    async fn create(
        &self,
        webhook_stripe: &WebhookStripeActiveModel,
    ) -> Result<WebhookStripe, DomainError>;
    async fn update(
        &self,
        webhook_stripe: &WebhookStripeActiveModel,
    ) -> Result<WebhookStripe, DomainError>;

    async fn find_by_id(&self, id: i32) -> Result<Option<WebhookStripe>, DomainError>;
    async fn find_all(&self) -> Result<Vec<WebhookStripe>, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn count(&self) -> Result<i64, DomainError>;
    async fn find_by_status(&self, status: bool) -> Result<Vec<WebhookStripe>, DomainError>;
}
