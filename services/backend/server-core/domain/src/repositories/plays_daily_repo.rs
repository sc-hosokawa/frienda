use crate::entities::plays_daily::{ActiveModel as PlaysDailyActiveModel, Model as PlaysDaily};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PlaysDailyRepository {
    async fn create(&self, plays_daily: &PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError>;
    async fn update(&self, plays_daily: &PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError>;
}
