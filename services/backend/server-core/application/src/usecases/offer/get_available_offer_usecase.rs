use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::offers::Model as Offer;
use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct GetAvailableOfferOutput {
    pub offers: Vec<Offer>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetAvailableOfferUsecaseTrait: Send + Sync {
    async fn get_available_offers(&self) -> Result<GetAvailableOfferOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetAvailableOfferUsecase {
    offers_repo: Arc<dyn OffersRepository>,
}

impl GetAvailableOfferUsecase {
    pub fn new(offers_repo: Arc<dyn OffersRepository>) -> Self {
        Self { offers_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetAvailableOfferUsecaseTrait for GetAvailableOfferUsecase {
    async fn get_available_offers(&self) -> Result<GetAvailableOfferOutput, anyhow::Error> {
        let offers: Vec<Offer> = self.offers_repo.get_active_offers().await?;
        Ok(GetAvailableOfferOutput { offers })
    }
}
