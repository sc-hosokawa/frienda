use async_trait::async_trait;
use domain::entities::plays_yearly::{ActiveModel as PlaysYearlyActiveModel, Model as PlaysYearly};
use domain::repositories::plays_yearly_repo::PlaysYearlyRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockPlaysYearlyRepo {
    async fn mock_create(
        &self,
        plays_yearly: PlaysYearlyActiveModel,
    ) -> Result<PlaysYearly, DomainError>;
    async fn mock_update(
        &self,
        plays_yearly: PlaysYearlyActiveModel,
    ) -> Result<PlaysYearly, DomainError>;
    async fn mock_delete_by_isrc(&self, isrc: String) -> Result<(), DomainError>;
}

#[async_trait]
impl PlaysYearlyRepository for MockMockPlaysYearlyRepo {
    async fn create(
        &self,
        plays_yearly: PlaysYearlyActiveModel,
    ) -> Result<PlaysYearly, DomainError> {
        self.mock_create(plays_yearly).await
    }

    async fn update(
        &self,
        plays_yearly: PlaysYearlyActiveModel,
    ) -> Result<PlaysYearly, DomainError> {
        self.mock_update(plays_yearly).await
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        self.mock_delete_by_isrc(isrc.to_string()).await
    }
}
