use crate::entities::offer_attach::{ActiveModel as OfferAttachActiveModel, Model as OfferAttach};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait OfferAttachRepository: Send + Sync {
    async fn create(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError>;
    async fn update(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError>;
    async fn create_many(
        &self,
        offer_attaches: Vec<OfferAttachActiveModel>,
    ) -> Result<(), DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<OfferAttach>, DomainError>;
    async fn get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError>;
}
