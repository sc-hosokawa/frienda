use crate::entities::offers::{ActiveModel as OfferActiveModel, Model as Offer};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait OffersRepository {
    async fn create(&self, offer: &OfferActiveModel) -> Result<Offer, DomainError>;
    async fn update(&self, offer: &OfferActiveModel) -> Result<Offer, DomainError>;

    async fn get_by_id(&self, id: uuid::Uuid) -> Result<Option<Offer>, DomainError>;
    async fn delete(&self, id: uuid::Uuid) -> Result<(), DomainError>;
    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Offer>, DomainError>;
    async fn get_active_offers(&self) -> Result<Vec<Offer>, DomainError>;
    async fn get_offers_by_user(&self, user_id: uuid::Uuid) -> Result<Vec<Offer>, DomainError>;
    async fn get_offers_by_category(
        &self,
        category_id: uuid::Uuid,
    ) -> Result<Vec<Offer>, DomainError>;
}
