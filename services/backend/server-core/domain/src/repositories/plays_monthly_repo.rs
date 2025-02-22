use crate::entities::plays_monthly::{
    ActiveModel as PlaysMonthlyActiveModel, Model as PlaysMonthly,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PlaysMonthlyRepository: Send + Sync {
    async fn create(
        &self,
        plays_monthly: PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError>;
    async fn update(
        &self,
        plays_monthly: PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError>;
    async fn update_many(
        &self,
        plays_monthly: Vec<PlaysMonthlyActiveModel>,
    ) -> Result<(), DomainError>;

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn get_total_play_count_all(&self) -> Result<i64, DomainError>;
    async fn get_all(&self) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn find_lastest_id(&self) -> Result<i32, DomainError>;
    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError>;
}
