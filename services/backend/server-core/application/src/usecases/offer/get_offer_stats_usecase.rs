use async_trait::async_trait;
use std::sync::Arc;

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
    _offers_repo: Arc<dyn OffersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
}

impl GetOfferStatsUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
    ) -> Self {
        Self {
            _offers_repo: offers_repo,
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
        let aggregate = self
            .offer_user_repo
            .aggregate_stats_by_user_id(&input.user_id)
            .await?;

        Ok(GetOfferStatsOutput {
            total_offers: aggregate.total_offers as i32,
            ongoing_offers: aggregate.ongoing_offers as i32,
            applied_offers: aggregate.applied_offers as i32,
            completed_offers: aggregate.completed_offers as i32,
            total_earnings: aggregate.total_earnings as i32,
        })
    }
}
