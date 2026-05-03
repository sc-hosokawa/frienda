use async_trait::async_trait;
use chrono::{Duration, FixedOffset, Utc};
use std::sync::Arc;

use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;

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

    fn today_jst() -> chrono::NaiveDate {
        let jst = FixedOffset::east_opt(9 * 3600).unwrap();
        Utc::now().with_timezone(&jst).date_naive()
    }
}

#[async_trait]
impl PlaybackOverviewUsecaseTrait for PlaybackOverviewUsecase {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        let today_jst = Self::today_jst();
        let weekly_start_date = today_jst - Duration::days(9);
        let end_date = today_jst - Duration::days(3);
        let aggregate = self
            .plays_daily_repo
            .aggregate_overview_by_artist_id(&input.artist_id, weekly_start_date, end_date)
            .await?;

        Ok(PlaybackOverviewUsecaseOutput {
            total_play_count: aggregate.total as i32,
            weekly_play_count: aggregate.weekly as i32,
        })
    }

    async fn get_playback_overview_by_upc(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        if let Some(upc) = input.upc {
            let today_jst = Self::today_jst();
            let weekly_start_date = today_jst - Duration::days(9);
            let end_date = today_jst - Duration::days(3);
            let aggregate = self
                .plays_daily_repo
                .aggregate_overview_by_upc(&upc, weekly_start_date, end_date)
                .await?;

            Ok(PlaybackOverviewUsecaseOutput {
                total_play_count: aggregate.total as i32,
                weekly_play_count: aggregate.weekly as i32,
            })
        } else {
            Err(anyhow::anyhow!("UPC is required"))
        }
    }
}

#[cfg(test)]
#[path = "playback_overview_usecase_tests.rs"]
mod tests;
