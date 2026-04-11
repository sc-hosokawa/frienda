use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::offer_attach_repo::OfferAttachRepository;
use domain::repositories::offer_user_repo::OfferUserRepository;
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
    async fn delete(&self, input: DeleteOfferInput) -> Result<i32, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct DeleteOfferUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_attach_repo: Arc<dyn OfferAttachRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
}

impl DeleteOfferUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        offer_attach_repo: Arc<dyn OfferAttachRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
    ) -> Self {
        Self {
            offers_repo,
            offer_attach_repo,
            offer_user_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl DeleteOfferUsecaseTrait for DeleteOfferUsecase {
    async fn delete(&self, input: DeleteOfferInput) -> Result<i32, anyhow::Error> {
        self.offer_attach_repo.delete_by_offer_id(input.id).await?;
        self.offer_user_repo.delete_by_offer_id(input.id).await?;

        self.offers_repo.delete(input.id).await?;
        Ok(input.id)
    }
}

#[cfg(test)]
#[path = "delete_offer_usecase_tests.rs"]
mod tests;
