use async_trait::async_trait;
use chrono::{Duration, NaiveDate, Utc};
use sea_orm::ActiveValue;
use std::sync::Arc;

use crate::services::dsp_fetcher::{DspFetcherServiceTrait, DspsData, GenderGenData};
use domain::entities::gender_gen_playback::ActiveModel as GenderGenPlaybackActiveModel;
use domain::entities::plays_daily::ActiveModel as PlaysDailyActiveModel;
use domain::entities::plays_monthly::ActiveModel as PlaysMonthlyActiveModel;
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::tracks_repo::TracksRepository;

#[async_trait]
pub trait DspsUsecaseTrait: Send + Sync {
    async fn add_daily_plays(&self) -> Result<(), anyhow::Error>;
    async fn add_monthly_plays(&self) -> Result<(), anyhow::Error>;
    async fn add_gender_gen_plays(&self) -> Result<(), anyhow::Error>;
}

pub struct DspsUsecase {
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    gender_gen_repo: Arc<dyn GenderGenPlaybackRepository>,
    dsp_fetcher_service: Arc<dyn DspFetcherServiceTrait>,
}

impl DspsUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        gender_gen_repo: Arc<dyn GenderGenPlaybackRepository>,
        dsp_fetcher_service: Arc<dyn DspFetcherServiceTrait>,
    ) -> Self {
        Self {
            plays_daily_repo,
            plays_monthly_repo,
            tracks_repo,
            gender_gen_repo,
            dsp_fetcher_service,
        }
    }
}

#[async_trait]
impl DspsUsecaseTrait for DspsUsecase {
    async fn add_daily_plays(&self) -> Result<(), anyhow::Error> {
        let isrcs: Vec<String> = self.tracks_repo.find_all_isrcs().await?;
        tracing::info!("PIPELINE::DSPsUsecase:: ISRCs: {}", isrcs.len());

        let lastest_id: i32 = self.plays_daily_repo.find_lastest_id().await?;
        let mut next_id: i32 = lastest_id + 1;
        tracing::info!("PIPELINE::DSPsUsecase:: Lastest ID: {}", lastest_id);

        let two_days_ago: String = (Utc::now().date_naive() - Duration::days(2))
            .format("%Y%m%d")
            .to_string();
        tracing::info!("PIPELINE::DSPsUsecase:: Two Days Ago: {}", two_days_ago);

        let mut dsps_data: Vec<DspsData> = self
            .dsp_fetcher_service
            .fetch_dsps_data(two_days_ago)
            .await?;
        tracing::info!("PIPELINE::DSPsUsecase:: DSPs Data: {}", dsps_data.len());

        dsps_data.retain(|data| isrcs.contains(&data.isrc));
        tracing::info!("PIPELINE::DSPsUsecase:: DSPs Data: {}", dsps_data.len());

        let mut models: Vec<PlaysDailyActiveModel> = Vec::new();
        for data in dsps_data {
            models.push(PlaysDailyActiveModel {
                id: ActiveValue::Set(next_id),
                isrc: ActiveValue::Set(Some(data.isrc)),
                date: ActiveValue::Set(Some(
                    NaiveDate::parse_from_str(&data.date, "%Y%m%d").map_err(|e| {
                        anyhow::anyhow!("Failed to parse date '{}': {}", data.date, e)
                    })?,
                )),
                spotify: ActiveValue::Set(data.spotify),
                apple: ActiveValue::Set(data.apple),
                line: ActiveValue::Set(data.line),
                amazon: ActiveValue::Set(Some(0)),
                youtube: ActiveValue::Set(Some(0)),
                sum: ActiveValue::Set(Some(data.spotify + data.apple + data.line)),
            });
            next_id += 1;
        }

        const BATCH_SIZE: usize = 1000;

        for chunk in models.chunks(BATCH_SIZE) {
            match self.plays_daily_repo.insert_many(chunk.to_vec()).await {
                Ok(_) => {
                    tracing::info!("Successfully inserted {} records", chunk.len());
                }
                Err(e) => {
                    tracing::error!("Failed to insert batch: {}", e);
                    return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
                }
            }
        }

        Ok(())
    }

    async fn add_monthly_plays(&self) -> Result<(), anyhow::Error> {
        let isrcs: Vec<String> = self.tracks_repo.find_all_isrcs().await?;
        tracing::info!("PIPELINE::DSPsUsecase:: ISRCs: {}", isrcs.len());

        let lastest_id: i32 = self.plays_monthly_repo.find_lastest_id().await?;
        let mut next_id: i32 = lastest_id + 1;
        tracing::info!("PIPELINE::DSPsUsecase:: Lastest ID: {}", lastest_id);

        let one_month_ago: String = (Utc::now().date_naive() - Duration::days(30))
            .format("%Y%m")
            .to_string();
        tracing::info!("PIPELINE::DSPsUsecase:: One Month Ago: {}", one_month_ago);

        let mut dsps_data: Vec<DspsData> = self
            .dsp_fetcher_service
            .fetch_dsps_data(one_month_ago)
            .await?;
        tracing::info!("PIPELINE::DSPsUsecase:: DSPs Data: {}", dsps_data.len());

        dsps_data.retain(|data| isrcs.contains(&data.isrc));
        tracing::info!("PIPELINE::DSPsUsecase:: DSPs Data: {}", dsps_data.len());

        let mut models: Vec<PlaysMonthlyActiveModel> = Vec::new();
        for data in dsps_data {
            models.push(PlaysMonthlyActiveModel {
                id: ActiveValue::Set(next_id),
                isrc: ActiveValue::Set(Some(data.isrc)),
                month: ActiveValue::Set(Some(
                    NaiveDate::parse_from_str(&data.date, "%Y%m").map_err(|e| {
                        anyhow::anyhow!("Failed to parse date '{}': {}", data.date, e)
                    })?,
                )),
                spotify: ActiveValue::Set(data.spotify),
                apple: ActiveValue::Set(data.apple),
                line: ActiveValue::Set(data.line),
                amazon: ActiveValue::Set(data.amazon.unwrap_or(0)),
                youtube: ActiveValue::Set(data.youtube.unwrap_or(0)),
                sum: ActiveValue::Set(Some(
                    data.spotify
                        + data.apple
                        + data.line
                        + data.amazon.unwrap_or(0)
                        + data.youtube.unwrap_or(0),
                )),
            });
            next_id += 1;
        }

        const BATCH_SIZE: usize = 1000;

        for chunk in models.chunks(BATCH_SIZE) {
            match self.plays_monthly_repo.update_many(chunk.to_vec()).await {
                Ok(_) => {
                    tracing::info!("Successfully inserted {} records", chunk.len());
                }
                Err(e) => {
                    tracing::error!("Failed to insert batch: {}", e);
                    return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
                }
            }
        }

        Ok(())
    }

    async fn add_gender_gen_plays(&self) -> Result<(), anyhow::Error> {
        let lastest_id: i32 = self.gender_gen_repo.find_lastest_id().await?;
        let mut next_id: i32 = lastest_id + 1;
        tracing::info!("PIPELINE::DSPsUsecase:: Lastest ID: {}", lastest_id);

        let isrcs: Vec<String> = self.tracks_repo.find_all_isrcs().await?;
        tracing::info!("PIPELINE::DSPsUsecase:: ISRCs: {}", isrcs.len());

        let yesterday: String = (Utc::now().date_naive() - Duration::days(1))
            .format("%Y/%m/%d")
            .to_string();
        tracing::info!("PIPELINE::DSPsUsecase:: Yesterday: {}", yesterday);

        let mut gender_gen_data: Vec<GenderGenData> = self
            .dsp_fetcher_service
            .fetch_gender_gen_data(yesterday)
            .await?;
        tracing::info!(
            "PIPELINE::DSPsUsecase:: GenderGen Data: {}",
            gender_gen_data.len()
        );

        gender_gen_data.retain(|data| isrcs.contains(&data.isrc));
        tracing::info!(
            "PIPELINE::DSPsUsecase:: Pruned GenderGen Data: {}",
            gender_gen_data.len()
        );

        let mut models: Vec<GenderGenPlaybackActiveModel> = Vec::new();
        for data in gender_gen_data {
            models.push(GenderGenPlaybackActiveModel {
                id: ActiveValue::Set(next_id),
                isrc: ActiveValue::Set(data.isrc),
                date: ActiveValue::Set(
                    NaiveDate::parse_from_str(&data.date, "%Y-%m-%d").map_err(|e| {
                        anyhow::anyhow!("Failed to parse date '{}': {}", data.date, e)
                    })?,
                ),
                gender: ActiveValue::Set(Some(data.gender)),
                age: ActiveValue::Set(Some(data.age)),
                play_count: ActiveValue::Set(data.play_count as i32),
            });
            next_id += 1;
        }

        const BATCH_SIZE: usize = 1000;

        for chunk in models.chunks(BATCH_SIZE) {
            match self.gender_gen_repo.insert_many(chunk.to_vec()).await {
                Ok(_) => {
                    tracing::info!("Successfully inserted {} records", chunk.len());
                }
                Err(e) => {
                    tracing::error!("Failed to insert batch: {}", e);
                    return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
                }
            }
        }

        Ok(())
    }
}
