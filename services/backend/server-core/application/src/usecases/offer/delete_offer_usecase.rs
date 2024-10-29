use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct DeleteOfferInput {
    pub id: i32,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait DeleteOfferUsecaseTrait: Send + Sync {
    async fn delete(&self, input: DeleteOfferInput) -> Result<(), anyhow::Error>;
}

//
// Implement the usecase
//
pub struct DeleteOfferUsecase {
    offers_repo: Arc<dyn OffersRepository>,
}

impl DeleteOfferUsecase {
    pub fn new(offers_repo: Arc<dyn OffersRepository>) -> Self {
        Self { offers_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl DeleteOfferUsecaseTrait for DeleteOfferUsecase {
    async fn delete(&self, input: DeleteOfferInput) -> Result<(), anyhow::Error> {
        self.offers_repo.delete(input.id).await?;
        Ok(())
    }
}
