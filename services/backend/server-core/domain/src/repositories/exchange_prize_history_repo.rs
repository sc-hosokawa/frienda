use crate::entities::exchange_prize_history::{
    ActiveModel as ExchangePrizeHistoryActiveModel, Model as ExchangePrizeHistory,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ExchangePrizeHistoryRepository: Send + Sync {
    async fn create(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError>;
    async fn update(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<ExchangePrizeHistory>, DomainError>;
    async fn get_by_user_id(&self, user_id: &str)
        -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn get_by_prize_id(
        &self,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn get_recent(&self, limit: i32) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn get_by_user_id_and_prize_id(
        &self,
        user_id: &str,
        prize_id: i32,
    ) -> Result<Option<ExchangePrizeHistory>, DomainError>;
}
