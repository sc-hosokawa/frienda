use async_trait::async_trait;
use std::sync::Arc;

use crate::usecases::dashboard::date_window::recent_data_excluded_window;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use shared::numeric::checked_i64_to_i32;

pub struct PlaybackOverviewUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
    pub upc: Option<String>,
}

pub struct PlaybackOverviewUsecaseOutput {
    pub total_play_count: i32,
    pub weekly_play_count: i32,
}

#[async_trait]
pub trait PlaybackOverviewUsecaseTrait: Send + Sync {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error>;
    async fn get_playback_overview_by_upc(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error>;
}

pub struct PlaybackOverviewUsecase {
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
}

impl PlaybackOverviewUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        _products_repo: Arc<dyn ProductsRepository>,
        _product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self { plays_daily_repo }
    }

    fn count_to_i32(value: i64, field: &str) -> Result<i32, anyhow::Error> {
        checked_i64_to_i32(value, field).map_err(anyhow::Error::msg)
    }
}

#[async_trait]
impl PlaybackOverviewUsecaseTrait for PlaybackOverviewUsecase {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        let (weekly_start_date, end_date) = recent_data_excluded_window();
        let aggregate = self
            .plays_daily_repo
            .aggregate_overview_by_artist_id(&input.artist_id, weekly_start_date, end_date)
            .await?;

        Ok(PlaybackOverviewUsecaseOutput {
            total_play_count: Self::count_to_i32(aggregate.total, "total_play_count")?,
            weekly_play_count: Self::count_to_i32(aggregate.weekly, "weekly_play_count")?,
        })
    }

    async fn get_playback_overview_by_upc(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        if let Some(upc) = input.upc {
            let (weekly_start_date, end_date) = recent_data_excluded_window();
            let aggregate = self
                .plays_daily_repo
                .aggregate_overview_by_upc(&upc, weekly_start_date, end_date)
                .await?;

            Ok(PlaybackOverviewUsecaseOutput {
                total_play_count: Self::count_to_i32(aggregate.total, "total_play_count")?,
                weekly_play_count: Self::count_to_i32(aggregate.weekly, "weekly_play_count")?,
            })
        } else {
            Err(anyhow::anyhow!("UPC is required"))
        }
    }
}

#[cfg(test)]
#[path = "playback_overview_usecase_tests.rs"]
mod tests;
