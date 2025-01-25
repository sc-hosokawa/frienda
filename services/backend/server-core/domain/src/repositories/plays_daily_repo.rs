use crate::entities::plays_daily::{ActiveModel as PlaysDailyActiveModel, Model as PlaysDaily};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PlaysDailyRepository: Send + Sync {
    async fn create(&self, plays_daily: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError>;
    async fn update(&self, plays_daily: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError>;
    async fn insert_many(&self, plays_daily: Vec<PlaysDailyActiveModel>)
        -> Result<(), DomainError>;

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_lastest_id(&self) -> Result<i32, DomainError>;
}
