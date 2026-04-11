use async_trait::async_trait;
use domain::entities::plays_monthly::{
    ActiveModel as PlaysMonthlyActiveModel, Model as PlaysMonthly,
};
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockPlaysMonthlyRepo {
    async fn mock_create(
        &self,
        plays_monthly: PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError>;
    async fn mock_update(
        &self,
        plays_monthly: PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError>;
    async fn mock_update_many(
        &self,
        plays_monthly: Vec<PlaysMonthlyActiveModel>,
    ) -> Result<(), DomainError>;
    async fn mock_find_by_isrc(&self, isrc: String) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_find_by_isrcs(
        &self,
        isrcs: Vec<String>,
    ) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_find_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_find_by_isrc_and_period(
        &self,
        isrc: String,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_get_total_play_count_all(&self) -> Result<i64, DomainError>;
    async fn mock_get_all(&self) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_get_all_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError>;
    async fn mock_find_lastest_id(&self) -> Result<i32, DomainError>;
    async fn mock_delete_by_isrc(&self, isrc: String) -> Result<(), DomainError>;
}

#[async_trait]
impl PlaysMonthlyRepository for MockMockPlaysMonthlyRepo {
    async fn create(
        &self,
        plays_monthly: PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError> {
        self.mock_create(plays_monthly).await
    }

    async fn update(
        &self,
        plays_monthly: PlaysMonthlyActiveModel,
    ) -> Result<PlaysMonthly, DomainError> {
        self.mock_update(plays_monthly).await
    }

    async fn update_many(
        &self,
        plays_monthly: Vec<PlaysMonthlyActiveModel>,
    ) -> Result<(), DomainError> {
        self.mock_update_many(plays_monthly).await
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_find_by_isrc(isrc.to_string()).await
    }

    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_find_by_isrcs(isrcs).await
    }

    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_find_by_period(period).await
    }

    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_find_by_isrc_and_period(isrc.to_string(), period)
            .await
    }

    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_find_by_isrcs_and_period(isrcs, period).await
    }

    async fn get_total_play_count_all(&self) -> Result<i64, DomainError> {
        self.mock_get_total_play_count_all().await
    }

    async fn get_all(&self) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_get_all().await
    }

    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError> {
        self.mock_get_all_by_period(period).await
    }

    async fn find_lastest_id(&self) -> Result<i32, DomainError> {
        self.mock_find_lastest_id().await
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        self.mock_delete_by_isrc(isrc.to_string()).await
    }
}
