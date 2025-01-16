use crate::entities::user_report::{ActiveModel as UserReportActiveModel, Model as UserReport};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait UserReportRepository: Send + Sync {
    async fn create(&self, user_report: UserReportActiveModel) -> Result<UserReport, DomainError>;
    async fn update(&self, user_report: UserReportActiveModel) -> Result<UserReport, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn get_all(&self) -> Result<Vec<UserReport>, DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<UserReport>, DomainError>;
    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<UserReport>, DomainError>;
}
