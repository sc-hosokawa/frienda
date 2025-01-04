use async_trait::async_trait;
use domain::entities::offers::{ActiveModel as OfferActiveModel, Model as Offer};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::offers_repo::OffersRepository;

#[automock]
#[async_trait]
pub trait MockOffersRepo {
    async fn mock_create(&self, offer: OfferActiveModel) -> Result<Offer, DomainError>;
    async fn mock_update(&self, offer: OfferActiveModel) -> Result<Offer, DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<Offer>, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_list(&self, limit: u32, offset: u32) -> Result<Vec<Offer>, DomainError>;
    async fn mock_get_active_offers(&self) -> Result<Vec<Offer>, DomainError>;
    async fn mock_get_offers_by_user(&self, user_id: String) -> Result<Vec<Offer>, DomainError>;
    async fn mock_get_offers_by_category(
        &self,
        category_id: String,
    ) -> Result<Vec<Offer>, DomainError>;
}

#[async_trait]
impl OffersRepository for MockMockOffersRepo {
    async fn create(&self, offer: OfferActiveModel) -> Result<Offer, DomainError> {
        self.mock_create(offer).await
    }

    async fn update(&self, offer: OfferActiveModel) -> Result<Offer, DomainError> {
        self.mock_update(offer).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Offer>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Offer>, DomainError> {
        self.mock_list(limit, offset).await
    }

    async fn get_active_offers(&self) -> Result<Vec<Offer>, DomainError> {
        self.mock_get_active_offers().await
    }

    async fn get_offers_by_user(&self, user_id: &str) -> Result<Vec<Offer>, DomainError> {
        self.mock_get_offers_by_user(user_id.to_string()).await
    }

    async fn get_offers_by_category(&self, category_id: &str) -> Result<Vec<Offer>, DomainError> {
        self.mock_get_offers_by_category(category_id.to_string())
            .await
    }
}
