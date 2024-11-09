use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;

pub struct GetTrendingUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
}

pub struct GetTrendingUsecaseOutput {
    pub trending: Vec<TrendTrack>,
}
pub struct TrendTrack {
    pub isrc: String,
    pub track_title: Option<String>,
    pub upc_title: Option<String>,
    pub image_url: Option<String>, // img_url of UPC
    pub total_play_count: i32,
    pub weekly_play_count: i32,
}

#[async_trait]
pub trait GetTrendingUsecaseTrait: Send + Sync {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error>;
}

pub struct GetTrendingUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl GetTrendingUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            products_repo,
            tracks_repo,
            product_track_repo,
        }
    }
}

#[async_trait]
impl GetTrendingUsecaseTrait for GetTrendingUsecase {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error> {
        Ok(GetTrendingUsecaseOutput { trending: vec![] })
    }
}
