use crate::entities::offer_user::{ActiveModel as OfferUserActiveModel, Model as OfferUser};
use crate::entities::sea_orm_active_enums::OfferStatus;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait OfferUserRepository {
    async fn create(&self, offer_user: &OfferUserActiveModel) -> Result<OfferUser, DomainError>;
    async fn update(&self, offer_user: &OfferUserActiveModel) -> Result<OfferUser, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<OfferUser>, DomainError>;
    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<OfferUser>, DomainError>;
    async fn get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferUser>, DomainError>;
    async fn get_by_user_id_and_offer_id(
        &self,
        user_id: &str,
        offer_id: i32,
    ) -> Result<Option<OfferUser>, DomainError>;
    async fn get_by_user_id_and_status(
        &self,
        user_id: &str,
        status: OfferStatus,
    ) -> Result<Vec<OfferUser>, DomainError>;
}
