use async_trait::async_trait;
use chrono::{Duration, FixedOffset, NaiveDate, Utc};
use sea_orm::ActiveValue;
use std::sync::Arc;

use crate::services::dsp_fetcher::{DspFetcherServiceTrait, DspsData, GenderGenData, SparseData};
use domain::entities::gender_gen_playback::ActiveModel as GenderGenPlaybackActiveModel;
use domain::entities::plays_daily::{ActiveModel as PlaysDailyActiveModel, Model as PlaysDaily};
use domain::entities::plays_monthly::ActiveModel as PlaysMonthlyActiveModel;
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::tracks_repo::TracksRepository;
use shared::numeric::checked_i64_to_i32;

#[async_trait]
pub trait DspsUsecaseTrait: Send + Sync {
    async fn add_daily_plays(&self) -> Result<(), anyhow::Error>;
    async fn add_monthly_plays(&self) -> Result<(), anyhow::Error>;
    async fn add_gender_gen_plays(&self) -> Result<(), anyhow::Error>;
    async fn add_sparse_data(&self, target_date: Option<String>) -> Result<(), anyhow::Error>;
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
        const START_OFFSET_DAYS: i64 = 3;
        const WINDOW_DAYS: i64 = 1;
        const BATCH_SIZE: usize = 5000;

        let isrcs: Vec<String> = self.tracks_repo.find_all_isrcs().await?;
        tracing::info!("PIPELINE::DSPsUsecase:: ISRCs: {}", isrcs.len());

        let lastest_id: i32 = self.plays_daily_repo.find_lastest_id().await?;
        let mut next_id: i32 = lastest_id + 1;
        tracing::info!("PIPELINE::DSPsUsecase:: Lastest ID: {}", lastest_id);

        let jst = FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = Utc::now().with_timezone(&jst).date_naive();
        let end_date: String = (today_jst - Duration::days(START_OFFSET_DAYS))
            .format("%Y%m%d")
            .to_string();
        let start_date: String = (today_jst - Duration::days(START_OFFSET_DAYS + WINDOW_DAYS))
            .format("%Y%m%d")
            .to_string();
        tracing::info!("PIPELINE::DSPsUsecase:: Start Date (JST): {}", start_date);
        tracing::info!("PIPELINE::DSPsUsecase:: End Date (JST): {}", end_date);

        let mut dsps_data: Vec<DspsData> = self
            .dsp_fetcher_service
            .fetch_dsps_data(Some(start_date.clone()), end_date.clone())
            .await?;
        tracing::info!("PIPELINE::DSPsUsecase:: DSPs Data: {}", dsps_data.len());

        dsps_data.retain(|data| isrcs.contains(&data.isrc));
        tracing::info!("PIPELINE::DSPsUsecase:: DSPs Data: {}", dsps_data.len());

        if !dsps_data.is_empty() {
            let (latest_date_vec, other_dates_vec): (Vec<DspsData>, Vec<DspsData>) =
                dsps_data.into_iter().partition(|d| d.date == end_date);

            tracing::info!(
                "PIPELINE::DSPsUsecase:: latest: {}, others: {}",
                latest_date_vec.len(),
                other_dates_vec.len()
            );

            let mut models: Vec<PlaysDailyActiveModel> = Vec::new();
            for data in latest_date_vec {
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
                    amazon: ActiveValue::Set(Some(data.amazon)),
                    youtube: ActiveValue::Set(Some(data.youtube)),
                    sum: ActiveValue::Set(Some(
                        data.spotify + data.apple + data.line + data.amazon + data.youtube,
                    )),
                });
                next_id += 1;
            }

            for chunk in models.chunks(BATCH_SIZE) {
                if let Err(e) = self.plays_daily_repo.insert_many(chunk.to_vec()).await {
                    tracing::error!("Failed to insert batch: {}", e);
                    return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
                }
            }
            tracing::info!("Successfully inserted {} total records", models.len());

            let mut updated_record: Vec<PlaysDailyActiveModel> = Vec::new();

            let update_end_date: String = (today_jst - Duration::days(START_OFFSET_DAYS + 1))
                .format("%Y%m%d")
                .to_string();

            let window_dsp_data: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_between_start_and_end(&start_date.clone(), &update_end_date)
                .await?;
            for records in window_dsp_data {
                let matched_record = match other_dates_vec.iter().find(|d: &&DspsData| {
                    records.isrc.as_ref() == Some(&d.isrc)
                        && NaiveDate::parse_from_str(&d.date, "%Y%m%d").ok() == records.date
                }) {
                    Some(r) => r,
                    None => {
                        tracing::warn!(
                            "No matching record found in fetched data for ISRC: {:?}, Date: {:?}. Skipping update.",
                            records.isrc,
                            records.date
                        );
                        continue;
                    }
                };

                let exist_daily_data: PlaysDailyActiveModel = PlaysDailyActiveModel {
                    id: ActiveValue::Set(records.id),
                    isrc: ActiveValue::Set(records.isrc),
                    date: ActiveValue::Set(records.date),
                    spotify: ActiveValue::Set(matched_record.spotify),
                    apple: ActiveValue::Set(matched_record.apple),
                    line: ActiveValue::Set(matched_record.line),
                    amazon: ActiveValue::Set(Some(matched_record.amazon)),
                    youtube: ActiveValue::Set(Some(matched_record.youtube)),
                    sum: ActiveValue::Set(Some(
                        matched_record.spotify
                            + matched_record.apple
                            + matched_record.line
                            + matched_record.amazon
                            + matched_record.youtube,
                    )),
                };
                updated_record.push(exist_daily_data);
            }

            tracing::info!(
                "PIPELINE::DSPsUsecase:: Updated Total Record: {}",
                updated_record.len()
            );

            for chunk in updated_record.chunks(BATCH_SIZE) {
                if let Err(e) = self.plays_daily_repo.update_many(chunk.to_vec()).await {
                    tracing::error!("Failed to update batch: {}", e);
                    return Err(anyhow::anyhow!("Failed to update batch: {}", e));
                }
            }
            tracing::info!(
                "Successfully updated {} total records",
                updated_record.len()
            );
        };

        tracing::info!("daily operation finished!");

        Ok(())
    }

    async fn add_monthly_plays(&self) -> Result<(), anyhow::Error> {
        let isrcs: Vec<String> = self.tracks_repo.find_all_isrcs().await?;
        tracing::info!("PIPELINE::DSPsUsecase:: ISRCs: {}", isrcs.len());

        let lastest_id: i32 = self.plays_monthly_repo.find_lastest_id().await?;
        let mut next_id: i32 = lastest_id + 1;
        tracing::info!("PIPELINE::DSPsUsecase:: Lastest ID: {}", lastest_id);

        // 日本時間基準で1ヶ月前の日付を計算
        let jst = FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = Utc::now().with_timezone(&jst).date_naive();
        let one_month_ago: String = (today_jst - Duration::days(30)).format("%Y%m").to_string();
        tracing::info!(
            "PIPELINE::DSPsUsecase:: One Month Ago (JST): {}",
            one_month_ago
        );

        let mut dsps_data: Vec<DspsData> = self
            .dsp_fetcher_service
            .fetch_dsps_data(None, one_month_ago)
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
                    NaiveDate::parse_from_str(&format!("{}01", data.date), "%Y%m%d").map_err(
                        |e| anyhow::anyhow!("Failed to parse month '{}': {}", data.date, e),
                    )?,
                )),
                spotify: ActiveValue::Set(data.spotify),
                apple: ActiveValue::Set(data.apple),
                line: ActiveValue::Set(data.line),
                amazon: ActiveValue::Set(data.amazon),
                youtube: ActiveValue::Set(data.youtube),
                sum: ActiveValue::Set(Some(
                    data.spotify + data.apple + data.line + data.amazon + data.youtube,
                )),
            });
            next_id += 1;
        }

        const BATCH_SIZE: usize = 1000;

        for chunk in models.chunks(BATCH_SIZE) {
            if let Err(e) = self.plays_monthly_repo.update_many(chunk.to_vec()).await {
                tracing::error!("Failed to insert batch: {}", e);
                return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
            }
        }
        tracing::info!(
            "Successfully processed {} total monthly records",
            models.len()
        );

        Ok(())
    }

    async fn add_gender_gen_plays(&self) -> Result<(), anyhow::Error> {
        let lastest_id: i32 = self.gender_gen_repo.find_lastest_id().await?;
        let mut next_id: i32 = lastest_id + 1;
        tracing::info!("PIPELINE::DSPsUsecase:: Lastest ID: {}", lastest_id);

        let isrcs: Vec<String> = self.tracks_repo.find_all_isrcs().await?;
        tracing::info!("PIPELINE::DSPsUsecase:: ISRCs: {}", isrcs.len());

        // 日本時間基準で2日前の日付を計算
        let jst = FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = Utc::now().with_timezone(&jst).date_naive();
        let target_date: String = (today_jst - Duration::days(2))
            .format("%Y/%m/%d")
            .to_string();
        tracing::info!("PIPELINE::DSPsUsecase:: Target Date (JST): {}", target_date);

        let mut gender_gen_data: Vec<GenderGenData> = self
            .dsp_fetcher_service
            .fetch_gender_gen_data(target_date)
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
                play_count: ActiveValue::Set(
                    checked_i64_to_i32(data.play_count, "gender_gen_play_count")
                        .map_err(anyhow::Error::msg)?,
                ),
            });
            next_id += 1;
        }

        const BATCH_SIZE: usize = 1000;

        for chunk in models.chunks(BATCH_SIZE) {
            if let Err(e) = self.gender_gen_repo.insert_many(chunk.to_vec()).await {
                tracing::error!("Failed to insert batch: {}", e);
                return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
            }
        }
        tracing::info!(
            "Successfully inserted {} total gender/gen records",
            models.len()
        );

        Ok(())
    }

    async fn add_sparse_data(&self, target_date: Option<String>) -> Result<(), anyhow::Error> {
        let target_date: String = match target_date {
            Some(date) => {
                if date.len() == 8 {
                    format!("{}/{}/{}", &date[0..4], &date[4..6], &date[6..8])
                } else {
                    date
                }
            }
            None => {
                // 日本時間基準で2日前の日付を計算
                let jst = FixedOffset::east_opt(9 * 3600).unwrap();
                let today_jst = Utc::now().with_timezone(&jst).date_naive();
                (today_jst - Duration::days(2))
                    .format("%Y/%m/%d")
                    .to_string()
            }
        };
        tracing::info!("PIPELINE::DSPsUsecase:: Target Date (JST): {}", target_date);

        let plays_on_target_date: Vec<PlaysDaily> =
            self.plays_daily_repo.find_by_date(&target_date).await?;
        tracing::info!(
            "PIPELINE::DSPsUsecase:: Plays on Target Date: {}",
            plays_on_target_date.len()
        );

        let mut sparse_data: Vec<SparseData> = self
            .dsp_fetcher_service
            .fetch_sparse_data(target_date)
            .await?;
        tracing::info!(
            "PIPELINE::DSPsUsecase:: Count of Sparse Data: {}",
            sparse_data.len()
        );
        tracing::info!("PIPELINE::DSPsUsecase:: Sparse Data: {:?}", sparse_data);

        sparse_data.retain(|data| {
            plays_on_target_date
                .iter()
                .any(|play| play.isrc == Some(data.isrc.clone()))
        });
        tracing::info!(
            "PIPELINE::DSPsUsecase:: Pruned Sparse Data: {}",
            sparse_data.len()
        );

        let mut models: Vec<PlaysDailyActiveModel> = Vec::new();
        for data in plays_on_target_date {
            let isrc_str = match data.isrc.as_ref() {
                Some(isrc) => isrc.as_str(),
                None => {
                    tracing::warn!("PlaysDaily record ID {} has no ISRC. Skipping.", data.id);
                    continue;
                }
            };

            let new_spotify_play_count: i32 = sparse_data
                .iter()
                .filter(|sparse| sparse.isrc == isrc_str)
                .filter_map(|sparse| sparse.spotify)
                .sum();
            models.push(PlaysDailyActiveModel {
                id: ActiveValue::Set(data.id),
                isrc: ActiveValue::Set(data.isrc),
                date: ActiveValue::Set(data.date),
                spotify: ActiveValue::Set(new_spotify_play_count),
                apple: ActiveValue::Set(data.apple),
                line: ActiveValue::Set(data.line),
                amazon: ActiveValue::Set(data.amazon),
                youtube: ActiveValue::Set(data.youtube),
                sum: ActiveValue::Set(Some(
                    new_spotify_play_count
                        + data.apple
                        + data.line
                        + data.amazon.unwrap_or(0)
                        + data.youtube.unwrap_or(0),
                )),
            });
        }

        const BATCH_SIZE: usize = 1000;

        for chunk in models.chunks(BATCH_SIZE) {
            if let Err(e) = self.plays_daily_repo.update_many(chunk.to_vec()).await {
                tracing::error!("Failed to insert batch: {}", e);
                return Err(anyhow::anyhow!("Failed to insert batch: {}", e));
            }
        }
        tracing::info!("Successfully updated {} total sparse records", models.len());

        Ok(())
    }
}
