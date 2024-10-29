use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::offers::Model as Offer;
use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct GetOfferByOwnerInput {
    pub user_id: String,
}

pub struct GetOfferByOwnerOutput {
    pub offers: Vec<Offer>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetOfferByOwnerUsecaseTrait: Send + Sync {
    async fn get_by_owner(
        &self,
        input: GetOfferByOwnerInput,
    ) -> Result<GetOfferByOwnerOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetOfferByOwnerUsecase {
    offers_repo: Arc<dyn OffersRepository>,
}

impl GetOfferByOwnerUsecase {
    pub fn new(offers_repo: Arc<dyn OffersRepository>) -> Self {
        Self { offers_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetOfferByOwnerUsecaseTrait for GetOfferByOwnerUsecase {
    async fn get_by_owner(
        &self,
        input: GetOfferByOwnerInput,
    ) -> Result<GetOfferByOwnerOutput, anyhow::Error> {
        let offers = self.offers_repo.get_offers_by_user(&input.user_id).await?;

        Ok(GetOfferByOwnerOutput { offers })
    }
}
