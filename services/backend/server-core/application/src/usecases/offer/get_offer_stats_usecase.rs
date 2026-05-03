use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use shared::numeric::checked_i64_to_i32;

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

    fn stat_to_i32(value: i64, field: &str) -> Result<i32, anyhow::Error> {
        checked_i64_to_i32(value, field).map_err(anyhow::Error::msg)
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
            total_offers: Self::stat_to_i32(aggregate.total_offers, "total_offers")?,
            ongoing_offers: Self::stat_to_i32(aggregate.ongoing_offers, "ongoing_offers")?,
            applied_offers: Self::stat_to_i32(aggregate.applied_offers, "applied_offers")?,
            completed_offers: Self::stat_to_i32(aggregate.completed_offers, "completed_offers")?,
            total_earnings: Self::stat_to_i32(aggregate.total_earnings, "total_earnings")?,
        })
    }
}
