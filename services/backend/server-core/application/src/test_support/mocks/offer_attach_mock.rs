use async_trait::async_trait;
use domain::entities::offer_attach::{ActiveModel as OfferAttachActiveModel, Model as OfferAttach};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::offer_attach_repo::OfferAttachRepository;

#[automock]
#[async_trait]
pub trait MockOfferAttachRepo {
    async fn mock_create(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError>;
    async fn mock_update(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError>;
    async fn mock_create_many(
        &self,
        offer_attaches: Vec<OfferAttachActiveModel>,
    ) -> Result<(), DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_delete_by_offer_id(&self, offer_id: i32) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<OfferAttach>, DomainError>;
    async fn mock_get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError>;
    async fn mock_get_images_by_offer_id(
        &self,
        offer_id: i32,
    ) -> Result<Vec<OfferAttach>, DomainError>;
    async fn mock_get_files_by_offer_id(
        &self,
        offer_id: i32,
    ) -> Result<Vec<OfferAttach>, DomainError>;
}

#[async_trait]
impl OfferAttachRepository for MockMockOfferAttachRepo {
    async fn create(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError> {
        self.mock_create(offer_attach).await
    }

    async fn update(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError> {
        self.mock_update(offer_attach).await
    }

    async fn create_many(
        &self,
        offer_attaches: Vec<OfferAttachActiveModel>,
    ) -> Result<(), DomainError> {
        self.mock_create_many(offer_attaches).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn delete_by_offer_id(&self, offer_id: i32) -> Result<(), DomainError> {
        self.mock_delete_by_offer_id(offer_id).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<OfferAttach>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError> {
        self.mock_get_by_offer_id(offer_id).await
    }

    async fn get_images_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError> {
        self.mock_get_images_by_offer_id(offer_id).await
    }

    async fn get_files_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError> {
        self.mock_get_files_by_offer_id(offer_id).await
    }
}
