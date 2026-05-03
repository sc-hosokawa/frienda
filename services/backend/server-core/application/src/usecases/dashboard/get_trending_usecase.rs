use async_trait::async_trait;
use std::sync::Arc;

use crate::usecases::dashboard::date_window::recent_data_excluded_window;
use domain::entities::products::Model as Products;

use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::plays_daily_repo::{PlaysDailyRepository, TrendingTrackAggregate};
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;
use shared::numeric::checked_i64_to_i32;

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

    fn aggregate_count_to_i32(value: i64, field: &str) -> Result<i32, anyhow::Error> {
        checked_i64_to_i32(value, field).map_err(anyhow::Error::msg)
    }

    fn trend_track_from_aggregate(
        aggregate: TrendingTrackAggregate,
    ) -> Result<TrendTrack, anyhow::Error> {
        Ok(TrendTrack {
            isrc: aggregate.isrc,
            track_title: aggregate.track_title,
            upc_title: aggregate.upc_title,
            image_url: aggregate.image_url,
            total_play_count: Self::aggregate_count_to_i32(aggregate.total, "total_play_count")?,
            weekly_play_count: Self::aggregate_count_to_i32(aggregate.weekly, "weekly_play_count")?,
            total_play_count_details: PlayCountDetails {
                spotify: Self::aggregate_count_to_i32(
                    aggregate.total_spotify,
                    "total_play_count_details.spotify",
                )?,
                apple: Self::aggregate_count_to_i32(
                    aggregate.total_apple,
                    "total_play_count_details.apple",
                )?,
                line: Self::aggregate_count_to_i32(
                    aggregate.total_line,
                    "total_play_count_details.line",
                )?,
                amazon: Self::aggregate_count_to_i32(
                    aggregate.total_amazon,
                    "total_play_count_details.amazon",
                )?,
                youtube: Self::aggregate_count_to_i32(
                    aggregate.total_youtube,
                    "total_play_count_details.youtube",
                )?,
            },
            weekly_play_count_details: PlayCountDetails {
                spotify: Self::aggregate_count_to_i32(
                    aggregate.weekly_spotify,
                    "weekly_play_count_details.spotify",
                )?,
                apple: Self::aggregate_count_to_i32(
                    aggregate.weekly_apple,
                    "weekly_play_count_details.apple",
                )?,
                line: Self::aggregate_count_to_i32(
                    aggregate.weekly_line,
                    "weekly_play_count_details.line",
                )?,
                amazon: Self::aggregate_count_to_i32(
                    aggregate.weekly_amazon,
                    "weekly_play_count_details.amazon",
                )?,
                youtube: Self::aggregate_count_to_i32(
                    aggregate.weekly_youtube,
                    "weekly_play_count_details.youtube",
                )?,
            },
        })
    }
}

#[async_trait]
impl GetTrendingUsecaseTrait for GetTrendingUsecase {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error> {
        let (start_date, end_date) = recent_data_excluded_window();
        let trending = self
            .plays_daily_repo
            .aggregate_trending_by_artist_id(&input.artist_id, start_date, end_date, 5)
            .await?
            .into_iter()
            .map(Self::trend_track_from_aggregate)
            .collect::<Result<Vec<_>, _>>()?;

        Ok(GetTrendingUsecaseOutput { trending })
    }

    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error> {
        let product: Products = self
            .products_repo
            .get_by_upc(&input.upc)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Product not found"))?;
        let artist_id: String = product
            .artist_id
            .clone()
            .ok_or_else(|| anyhow::anyhow!("Product artist_id not found"))?;
        let artist = self.artists_repo.find_by_id(&artist_id).await?;
        let artist_name: String = artist
            .ok_or_else(|| anyhow::anyhow!("Artist not found"))?
            .display_name_jp;
        let product_img_url: Option<String> = product.img_url;
        let product_title: String = product.title;

        let (start_date, end_date) = recent_data_excluded_window();
        let trending = self
            .plays_daily_repo
            .aggregate_trending_by_upc(&input.upc, start_date, end_date)
            .await?
            .into_iter()
            .map(Self::trend_track_from_aggregate)
            .collect::<Result<Vec<_>, _>>()?;

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
