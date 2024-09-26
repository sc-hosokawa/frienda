use crate::entities::maps::Entity as Map;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

// TODO: add id?

#[async_trait]
pub trait MapsRepository {
    async fn create(&self, map: Map) -> Result<Map, DomainError>;
    async fn update(&self, map: Map) -> Result<Map, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
}
