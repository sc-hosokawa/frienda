use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;

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
}

pub struct PlaybackOverviewUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
}

impl PlaybackOverviewUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
        }
    }
}

#[async_trait]
impl PlaybackOverviewUsecaseTrait for PlaybackOverviewUsecase {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        Ok(PlaybackOverviewUsecaseOutput {
            total_play_count: 0,
            weekly_play_count: 0,
        })
    }
}
