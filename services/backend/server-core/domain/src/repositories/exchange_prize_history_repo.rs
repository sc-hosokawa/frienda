use crate::entities::exchange_prize_history::Entity as ExchangePrizeHistory;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ExchangePrizeHistoryRepository {
    async fn create(
        &self,
        history: ExchangePrizeHistory,
    ) -> Result<ExchangePrizeHistory, DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<ExchangePrizeHistory>, DomainError>;
    async fn update(
        &self,
        history: ExchangePrizeHistory,
    ) -> Result<ExchangePrizeHistory, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn get_by_user_id(&self, user_id: i32) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn get_by_prize_id(
        &self,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn get_recent(&self, limit: i32) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
}
