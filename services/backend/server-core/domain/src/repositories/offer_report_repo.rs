use crate::entities::offer_report::{ActiveModel as OfferReportActiveModel, Model as OfferReport};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait OfferReportRepository: Send + Sync {
    async fn create(
        &self,
        offer_report: OfferReportActiveModel,
    ) -> Result<OfferReport, DomainError>;
    async fn update(
        &self,
        offer_report: OfferReportActiveModel,
    ) -> Result<OfferReport, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn get_all(&self) -> Result<Vec<OfferReport>, DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<OfferReport>, DomainError>;
    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<OfferReport>, DomainError>;
}
