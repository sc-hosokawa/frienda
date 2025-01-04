use async_trait::async_trait;
use domain::entities::prizes::{ActiveModel as PrizeActiveModel, Model as Prize};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::prizes_repo::PrizesRepository;

#[automock]
#[async_trait]
pub trait MockPrizesRepo {
    async fn mock_create(&self, prize: PrizeActiveModel) -> Result<Prize, DomainError>;
    async fn mock_update(&self, prize: PrizeActiveModel) -> Result<Prize, DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<Prize>, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_list(&self, limit: u32, offset: u32) -> Result<Vec<Prize>, DomainError>;
    async fn mock_get_by_condition(&self, condition: String) -> Result<Vec<Prize>, DomainError>;
    async fn mock_get_available(&self) -> Result<Vec<Prize>, DomainError>;
}

#[async_trait]
impl PrizesRepository for MockMockPrizesRepo {
    async fn create(&self, prize: PrizeActiveModel) -> Result<Prize, DomainError> {
        self.mock_create(prize).await
    }

    async fn update(&self, prize: PrizeActiveModel) -> Result<Prize, DomainError> {
        self.mock_update(prize).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Prize>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Prize>, DomainError> {
        self.mock_list(limit, offset).await
    }

    async fn get_by_condition(&self, condition: &str) -> Result<Vec<Prize>, DomainError> {
        self.mock_get_by_condition(condition.to_string()).await
    }

    async fn get_available(&self) -> Result<Vec<Prize>, DomainError> {
        self.mock_get_available().await
    }
}
