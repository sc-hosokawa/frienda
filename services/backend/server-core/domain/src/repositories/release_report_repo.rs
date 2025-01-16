use crate::entities::release_report::{
    ActiveModel as ReleaseReportActiveModel, Model as ReleaseReport,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ReleaseReportRepository: Send + Sync {
    async fn create(
        &self,
        release_report: ReleaseReportActiveModel,
    ) -> Result<ReleaseReport, DomainError>;
    async fn update(
        &self,
        release_report: ReleaseReportActiveModel,
    ) -> Result<ReleaseReport, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn get_all(&self) -> Result<Vec<ReleaseReport>, DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<ReleaseReport>, DomainError>;
    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<ReleaseReport>, DomainError>;
}
