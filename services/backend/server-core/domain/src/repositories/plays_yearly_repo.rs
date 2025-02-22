use crate::entities::plays_yearly::{ActiveModel as PlaysYearlyActiveModel, Model as PlaysYearly};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PlaysYearlyRepository: Send + Sync {
    async fn create(
        &self,
        plays_yearly: PlaysYearlyActiveModel,
    ) -> Result<PlaysYearly, DomainError>;
    async fn update(
        &self,
        plays_yearly: PlaysYearlyActiveModel,
    ) -> Result<PlaysYearly, DomainError>;
    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError>;
}
