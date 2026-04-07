use async_trait::async_trait;
use domain::entities::exchange_prize_history::{
    ActiveModel as ExchangePrizeHistoryActiveModel, Model as ExchangePrizeHistory,
};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::exchange_prize_history_repo::ExchangePrizeHistoryRepository;

#[automock]
#[async_trait]
pub trait MockExchangePrizeHistoryRepo {
    async fn mock_create(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError>;
    async fn mock_update(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<ExchangePrizeHistory>, DomainError>;
    async fn mock_get_by_user_id(
        &self,
        user_id: String,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn mock_get_by_prize_id(
        &self,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn mock_get_recent(&self, limit: i32) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
    async fn mock_get_by_user_id_and_prize_id(
        &self,
        user_id: &str,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError>;
}

#[async_trait]
impl ExchangePrizeHistoryRepository for MockMockExchangePrizeHistoryRepo {
    async fn create(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError> {
        self.mock_create(history).await
    }

    async fn update(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError> {
        self.mock_update(history).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<ExchangePrizeHistory>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_user_id(
        &self,
        user_id: &str,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        self.mock_get_by_user_id(user_id.to_string()).await
    }

    async fn get_by_prize_id(
        &self,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        self.mock_get_by_prize_id(prize_id).await
    }

    async fn get_recent(&self, limit: i32) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        self.mock_get_recent(limit).await
    }

    async fn get_by_user_id_and_prize_id(
        &self,
        user_id: &str,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        self.mock_get_by_user_id_and_prize_id(user_id, prize_id)
            .await
    }
}
