use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::OfferStatus;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct GetOfferByStatusInput {
    pub user_id: String,
}

pub struct GetOfferByStatusOutput {
    pub inprogress_offers: Vec<Offer>,
    pub applied_offers: Vec<Offer>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetOfferByStatusUsecaseTrait: Send + Sync {
    async fn get_by_status(
        &self,
        input: GetOfferByStatusInput,
    ) -> Result<GetOfferByStatusOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetOfferByStatusUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
}

impl GetOfferByStatusUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
    ) -> Self {
        Self {
            offers_repo,
            offer_user_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetOfferByStatusUsecaseTrait for GetOfferByStatusUsecase {
    async fn get_by_status(
        &self,
        input: GetOfferByStatusInput,
    ) -> Result<GetOfferByStatusOutput, anyhow::Error> {
        // Get all offers associated with the user
        let user_offers: Vec<domain::entities::offer_user::Model> =
            self.offer_user_repo.get_by_user_id(&input.user_id).await?;

        // Initialize vectors for inprogress and applied offers
        let mut inprogress_offers = Vec::new();
        let mut applied_offers = Vec::new();

        // Iterate through user offers and categorize them
        for mapping in user_offers {
            let offer = self
                .offers_repo
                .get_by_id(mapping.offer_id)
                .await?
                .ok_or_else(|| anyhow::anyhow!("Offer not found"))?;
            let status = mapping.status;

            match status {
                OfferStatus::Ongoing => inprogress_offers.push(offer),
                OfferStatus::Applied => applied_offers.push(offer),
                _ => {} // Ignore other statuses
            }
        }

        Ok(GetOfferByStatusOutput {
            inprogress_offers,
            applied_offers,
        })
    }
}
