use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;

pub struct GetAllHistroyUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
    pub period: i32,
}
pub struct GetAllHistoryUsecaseOutput {
    pub play_count: i32,
}

pub struct GetUPCHistoryUsecaseInput {
    pub upc: String,
    pub period: i32,
}
pub struct GetUPCHistoryUsecaseOutput {
    pub play_count: i32,
}

#[async_trait]
pub trait GetPlayCountUsecaseTrait: Send + Sync {
    async fn get_play_count_by_artist(
        &self,
        input: GetAllHistroyUsecaseInput,
    ) -> Result<GetAllHistoryUsecaseOutput, anyhow::Error>;
    async fn get_play_count_by_upc(
        &self,
        input: GetUPCHistoryUsecaseInput,
    ) -> Result<GetUPCHistoryUsecaseOutput, anyhow::Error>;
}

pub struct GetPlayCountUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>,
}

impl GetPlayCountUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            gender_gen_playback_repo,
        }
    }
}

#[async_trait]
impl GetPlayCountUsecaseTrait for GetPlayCountUsecase {
    async fn get_play_count_by_artist(
        &self,
        input: GetAllHistroyUsecaseInput,
    ) -> Result<GetAllHistoryUsecaseOutput, anyhow::Error> {
        Ok(GetAllHistoryUsecaseOutput { play_count: 0 })
    }
    async fn get_play_count_by_upc(
        &self,
        input: GetUPCHistoryUsecaseInput,
    ) -> Result<GetUPCHistoryUsecaseOutput, anyhow::Error> {
        Ok(GetUPCHistoryUsecaseOutput { play_count: 0 })
    }
}
