use async_trait::async_trait;
use std::{collections::HashMap, sync::Arc};

use domain::entities::sea_orm_active_enums::OfferStatus;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct GetOfferStatsInput {
    pub user_id: String,
}

pub struct GetOfferStatsOutput {
    pub total_offers: i32,
    pub ongoing_offers: i32,
    pub applied_offers: i32,
    pub completed_offers: i32,
    pub total_earnings: i32,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetOfferStatsUsecaseTrait: Send + Sync {
    async fn get_stats(
        &self,
        input: GetOfferStatsInput,
    ) -> Result<GetOfferStatsOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetOfferStatsUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
}

impl GetOfferStatsUsecase {
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
impl GetOfferStatsUsecaseTrait for GetOfferStatsUsecase {
    async fn get_stats(
        &self,
        input: GetOfferStatsInput,
    ) -> Result<GetOfferStatsOutput, anyhow::Error> {
        let offers = self.offer_user_repo.get_by_user_id(&input.user_id).await?;

        let total_offers = offers.len() as i32;
        let mut ongoing_offers = 0;
        let mut applied_offers = 0;
        let mut completed_offers = 0;
        let mut completed_offer_ids = Vec::new();

        for offer_user in &offers {
            match offer_user.status {
                OfferStatus::Ongoing => ongoing_offers += 1,
                OfferStatus::Applied => applied_offers += 1,
                OfferStatus::Finished => {
                    completed_offers += 1;
                    completed_offer_ids.push(offer_user.offer_id);
                }
                _ => {}
            }
        }
        let offers_by_id: HashMap<i32, domain::entities::offers::Model> =
            if completed_offer_ids.is_empty() {
                HashMap::new()
            } else {
                self.offers_repo
                    .get_by_ids(completed_offer_ids.clone())
                    .await?
                    .into_iter()
                    .map(|offer| (offer.id, offer))
                    .collect()
            };
        let mut total_earnings = 0;
        for offer_id in completed_offer_ids {
            total_earnings += offers_by_id
                .get(&offer_id)
                .ok_or_else(|| anyhow::anyhow!("Offer not found"))?
                .fee;
        }

        Ok(GetOfferStatsOutput {
            total_offers,
            ongoing_offers,
            applied_offers,
            completed_offers,
            total_earnings,
        })
    }
}
