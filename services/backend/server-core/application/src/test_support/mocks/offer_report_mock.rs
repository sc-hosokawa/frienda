use async_trait::async_trait;
use domain::entities::offer_report::{ActiveModel as OfferReportActiveModel, Model as OfferReport};
use domain::repositories::offer_report_repo::OfferReportRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockOfferReportRepo {
    async fn mock_create(
        &self,
        offer_report: OfferReportActiveModel,
    ) -> Result<OfferReport, DomainError>;
    async fn mock_update(
        &self,
        offer_report: OfferReportActiveModel,
    ) -> Result<OfferReport, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_all(&self) -> Result<Vec<OfferReport>, DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<OfferReport>, DomainError>;
    async fn mock_get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<OfferReport>, DomainError>;
}

#[async_trait]
impl OfferReportRepository for MockMockOfferReportRepo {
    async fn create(
        &self,
        offer_report: OfferReportActiveModel,
    ) -> Result<OfferReport, DomainError> {
        self.mock_create(offer_report).await
    }

    async fn update(
        &self,
        offer_report: OfferReportActiveModel,
    ) -> Result<OfferReport, DomainError> {
        self.mock_update(offer_report).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_all(&self) -> Result<Vec<OfferReport>, DomainError> {
        self.mock_get_all().await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<OfferReport>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<OfferReport>, DomainError> {
        self.mock_get_by_ids(ids).await
    }
}
