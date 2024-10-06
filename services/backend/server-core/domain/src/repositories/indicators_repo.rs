use crate::entities::indicators::{ActiveModel as IndicatorActiveModel, Model as Indicator};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait IndicatorsRepository {
    async fn create(&self, indicator: &IndicatorActiveModel) -> Result<Indicator, DomainError>;
    async fn update(&self, indicator: &IndicatorActiveModel) -> Result<Indicator, DomainError>;
}
