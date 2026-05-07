use crate::entities::offers::{ActiveModel as OfferActiveModel, Model as Offer};
use crate::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[derive(Default, Debug, PartialEq)]
pub struct SearchOptions {
    pub owner: Option<String>, // varchar(28)
    pub category: Option<OfferCategory>,
    pub target_role: Option<UserCategory>,
    pub place: Option<String>,
    pub min_price: Option<i32>,
    pub max_price: Option<i32>,
    pub sort_by: Option<String>,
}

#[async_trait]
pub trait OffersRepository: Send + Sync {
    async fn create(&self, offer: OfferActiveModel) -> Result<Offer, DomainError>;
    async fn update(&self, offer: OfferActiveModel) -> Result<Offer, DomainError>;

    async fn get_by_id(&self, id: i32) -> Result<Option<Offer>, DomainError>;
    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Offer>, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Offer>, DomainError>;
    async fn get_active_offers(&self) -> Result<Vec<Offer>, DomainError>;
    async fn get_offers_by_user(&self, user_id: &str) -> Result<Vec<Offer>, DomainError>;
    async fn get_offers_by_category(&self, category_id: &str) -> Result<Vec<Offer>, DomainError>;
    async fn search(&self, query: &str, options: SearchOptions) -> Result<Vec<Offer>, DomainError>;
}
