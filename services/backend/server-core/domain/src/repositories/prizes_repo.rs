use crate::entities::prizes::{ActiveModel as PrizeActiveModel, Model as Prize};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PrizesRepository {
    async fn create(&self, prize: &PrizeActiveModel) -> Result<Prize, DomainError>;
    async fn update(&self, prize: &PrizeActiveModel) -> Result<Prize, DomainError>;

    async fn get_by_id(&self, id: &str) -> Result<Option<Prize>, DomainError>;
    async fn delete(&self, id: &str) -> Result<(), DomainError>;
    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Prize>, DomainError>;
    async fn get_by_condition(&self, category: &str) -> Result<Vec<Prize>, DomainError>;
    async fn get_available(&self) -> Result<Vec<Prize>, DomainError>;
}
