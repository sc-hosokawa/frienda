use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use domain::repositories::offers_repo::{OffersRepository, SearchOptions};

pub struct SearchInput {
    pub query: String,
    pub options: SearchUsecaseOptions,
}

#[derive(Default)]
pub struct SearchUsecaseOptions {
    pub owner: Option<String>,
    pub category: Option<OfferCategory>,
    pub target_role: Option<UserCategory>,
    pub place: Option<String>,
    pub min_price: Option<i32>,
    pub max_price: Option<i32>,
    pub sort_by: Option<String>,
}

#[async_trait]
pub trait SearchTasksUsecaseTrait: Send + Sync {
    async fn search_offers(&self, input: SearchInput) -> Result<Vec<Offer>, anyhow::Error>;
}

pub struct SearchTasksUsecase {
    offers_repo: Arc<dyn OffersRepository>,
}

impl SearchTasksUsecase {
    pub fn new(offers_repo: Arc<dyn OffersRepository>) -> Self {
        Self { offers_repo }
    }
}

#[async_trait]
impl SearchTasksUsecaseTrait for SearchTasksUsecase {
    async fn search_offers(&self, input: SearchInput) -> Result<Vec<Offer>, anyhow::Error> {
        self.offers_repo
            .search(&input.query, input.options.into())
            .await
            .map_err(|e| anyhow::anyhow!("Failed to search tasks: {}", e))
    }
}

impl From<SearchUsecaseOptions> for SearchOptions {
    fn from(input: SearchUsecaseOptions) -> Self {
        SearchOptions {
            owner: input.owner,
            category: input.category,
            target_role: input.target_role,
            place: input.place,
            min_price: input.min_price,
            max_price: input.max_price,
            sort_by: input.sort_by,
        }
    }
}
