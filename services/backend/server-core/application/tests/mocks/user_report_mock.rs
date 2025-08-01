use async_trait::async_trait;
use domain::entities::user_report::{ActiveModel as UserReportActiveModel, Model as UserReport};
use domain::repositories::user_report_repo::UserReportRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockUserReportRepo {
    async fn mock_create(
        &self,
        user_report: UserReportActiveModel,
    ) -> Result<UserReport, DomainError>;
    async fn mock_update(
        &self,
        user_report: UserReportActiveModel,
    ) -> Result<UserReport, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_all(&self) -> Result<Vec<UserReport>, DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<UserReport>, DomainError>;
    async fn mock_get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<UserReport>, DomainError>;
}

#[async_trait]
impl UserReportRepository for MockMockUserReportRepo {
    async fn create(&self, user_report: UserReportActiveModel) -> Result<UserReport, DomainError> {
        self.mock_create(user_report).await
    }

    async fn update(&self, user_report: UserReportActiveModel) -> Result<UserReport, DomainError> {
        self.mock_update(user_report).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_all(&self) -> Result<Vec<UserReport>, DomainError> {
        self.mock_get_all().await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<UserReport>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<UserReport>, DomainError> {
        self.mock_get_by_ids(ids).await
    }
}
