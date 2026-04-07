use async_trait::async_trait;
use domain::entities::release_report::{
    ActiveModel as ReleaseReportActiveModel, Model as ReleaseReport,
};
use domain::repositories::release_report_repo::ReleaseReportRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockReleaseReportRepo {
    async fn mock_create(
        &self,
        release_report: ReleaseReportActiveModel,
    ) -> Result<ReleaseReport, DomainError>;
    async fn mock_update(
        &self,
        release_report: ReleaseReportActiveModel,
    ) -> Result<ReleaseReport, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_all(&self) -> Result<Vec<ReleaseReport>, DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<ReleaseReport>, DomainError>;
    async fn mock_get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<ReleaseReport>, DomainError>;
}

#[async_trait]
impl ReleaseReportRepository for MockMockReleaseReportRepo {
    async fn create(
        &self,
        release_report: ReleaseReportActiveModel,
    ) -> Result<ReleaseReport, DomainError> {
        self.mock_create(release_report).await
    }

    async fn update(
        &self,
        release_report: ReleaseReportActiveModel,
    ) -> Result<ReleaseReport, DomainError> {
        self.mock_update(release_report).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_all(&self) -> Result<Vec<ReleaseReport>, DomainError> {
        self.mock_get_all().await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<ReleaseReport>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<ReleaseReport>, DomainError> {
        self.mock_get_by_ids(ids).await
    }
}
