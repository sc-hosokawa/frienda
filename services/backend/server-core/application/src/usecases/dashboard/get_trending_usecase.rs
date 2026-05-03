use async_trait::async_trait;
use chrono::Duration;
use std::sync::Arc;

use domain::entities::products::Model as Products;

use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::plays_daily_repo::{PlaysDailyRepository, TrendingTrackAggregate};
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
    pub total_play_count_details: PlayCountDetails,
    pub weekly_play_count_details: PlayCountDetails,
}

pub struct GetTrendingByUpcUsecaseInput {
    pub user_id: String,
    pub upc: String,
}
pub struct GetTrendingByUpcUsecaseOutput {
    pub artist_name: String,
    pub product_img_url: Option<String>,
    pub product_title: String,
    pub trending: Vec<TrendTrack>,
}

#[derive(Clone)]
pub struct PlayCountDetails {
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}

#[async_trait]
pub trait GetTrendingUsecaseTrait: Send + Sync {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error>;
    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error>;
}

pub struct GetTrendingUsecase {
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetTrendingUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        _tracks_repo: Arc<dyn TracksRepository>,
        _product_track_repo: Arc<dyn ProductTrackRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            plays_daily_repo,
            products_repo,
            artists_repo,
        }
    }

    fn today_jst() -> chrono::NaiveDate {
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        chrono::Utc::now().with_timezone(&jst).date_naive()
    }

    fn trend_track_from_aggregate(aggregate: TrendingTrackAggregate) -> TrendTrack {
        TrendTrack {
            isrc: aggregate.isrc,
            track_title: aggregate.track_title,
            upc_title: aggregate.upc_title,
            image_url: aggregate.image_url,
            total_play_count: aggregate.total as i32,
            weekly_play_count: aggregate.weekly as i32,
            total_play_count_details: PlayCountDetails {
                spotify: aggregate.total_spotify as i32,
                apple: aggregate.total_apple as i32,
                line: aggregate.total_line as i32,
                amazon: aggregate.total_amazon as i32,
                youtube: aggregate.total_youtube as i32,
            },
            weekly_play_count_details: PlayCountDetails {
                spotify: aggregate.weekly_spotify as i32,
                apple: aggregate.weekly_apple as i32,
                line: aggregate.weekly_line as i32,
                amazon: aggregate.weekly_amazon as i32,
                youtube: aggregate.weekly_youtube as i32,
            },
        }
    }
}

#[async_trait]
impl GetTrendingUsecaseTrait for GetTrendingUsecase {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error> {
        let today_jst = Self::today_jst();
        let start_date = today_jst - Duration::days(9);
        let end_date = today_jst - Duration::days(3);
        let trending = self
            .plays_daily_repo
            .aggregate_trending_by_artist_id(&input.artist_id, start_date, end_date, 5)
            .await?
            .into_iter()
            .map(Self::trend_track_from_aggregate)
            .collect();

        Ok(GetTrendingUsecaseOutput { trending })
    }

    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error> {
        let product: Option<Products> = self.products_repo.get_by_upc(&input.upc).await?;
        let artist_id: String = product.clone().unwrap().artist_id.unwrap();
        let artist = self.artists_repo.find_by_id(&artist_id).await?;
        let artist_name: String = artist.unwrap().display_name_jp;
        let product_img_url: Option<String> = product.clone().unwrap().img_url;
        let product_title: String = product.clone().unwrap().title;

        let today_jst = Self::today_jst();
        let start_date = today_jst - Duration::days(9);
        let end_date = today_jst - Duration::days(3);
        let trending = self
            .plays_daily_repo
            .aggregate_trending_by_upc(&input.upc, start_date, end_date)
            .await?
            .into_iter()
            .map(Self::trend_track_from_aggregate)
            .collect();

        Ok(GetTrendingByUpcUsecaseOutput {
            artist_name,
            product_img_url,
            product_title,
            trending,
        })
    }
}

#[cfg(test)]
#[path = "get_trending_usecase_tests.rs"]
mod tests;
