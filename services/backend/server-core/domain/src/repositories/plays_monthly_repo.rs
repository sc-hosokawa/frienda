use crate::entities::plays_monthly::{
    ActiveModel as PlaysMonthlyActiveModel, Model as PlaysMonthly,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PlaysMonthlyRepository {
    async fn create(
        &self,
        plays_monthly: &PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError>;
    async fn update(
        &self,
        plays_monthly: &PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError>;
}
