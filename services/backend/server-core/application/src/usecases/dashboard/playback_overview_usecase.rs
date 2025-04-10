use async_trait::async_trait;
use chrono::{Datelike, Duration, Local, TimeZone};
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
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
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl PlaybackOverviewUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            products_repo,
            product_track_repo,
        }
    }
}

#[async_trait]
impl PlaybackOverviewUsecaseTrait for PlaybackOverviewUsecase {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        let products: Vec<Product> = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let upcs: Vec<String> = products.iter().map(|p| p.upc.clone()).collect();
        let product_tracks: Vec<ProductTrack> = self.product_track_repo.get_by_upcs(upcs).await?;
        let isrcs: Vec<String> = product_tracks.iter().map(|p| p.isrc.clone()).collect();

        let plays_daily: Vec<PlaysDaily> =
            self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;
        let plays_monthly: Vec<PlaysMonthly> =
            self.plays_monthly_repo.find_by_isrcs(isrcs.clone()).await?;

        let all_month_play_count: i32 = plays_monthly.iter().map(|p| p.sum.unwrap_or(0)).sum();
        let current_month_day_play_count: i32 = {
            let today = Local::now().date_naive();
            let year = today.year();
            let month = today.month();

            let first_day_of_month = Local.ymd(year, month, 1).naive_local();

            let yesterday = today - Duration::days(1);

            isrcs
                .iter()
                .map(|isrc| {
                    plays_daily
                        .iter()
                        .filter(|p| {
                            if let Some(date) = p.date {
                                // 当月の1日から昨日までの日付かつISRCが一致するものをフィルタリング
                                date >= first_day_of_month
                                    && date <= yesterday
                                    && p.isrc.as_ref().unwrap() == isrc
                            } else {
                                false
                            }
                        })
                        .map(|p| p.sum.unwrap_or(0))
                        .sum::<i32>()
                })
                .sum()
        };
        let weekly_play_count: i32 = {
            let today = Local::now().date_naive();
            // 集計開始日（9日前）と終了日（2日前）を設定
            let start_date = today - Duration::days(9);
            let end_date = today - Duration::days(2);

            isrcs
                .iter()
                .map(|isrc| {
                    plays_daily
                        .iter()
                        .filter(|p| {
                            if let Some(date) = p.date {
                                // 日付が範囲内かつISRCが一致するものをフィルタリング
                                date >= start_date
                                    && date <= end_date
                                    && p.isrc.as_ref().unwrap() == isrc
                            } else {
                                false
                            }
                        })
                        .map(|p| p.sum.unwrap_or(0))
                        .sum::<i32>()
                })
                .sum()
        };

        Ok(PlaybackOverviewUsecaseOutput {
            total_play_count: all_month_play_count + current_month_day_play_count,
            weekly_play_count,
        })
    }

    async fn get_playback_overview_by_upc(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        if let Some(upc) = input.upc {
            let product_track: Vec<ProductTrack> = self.product_track_repo.get_by_upc(&upc).await?;
            let isrcs: Vec<String> = product_track.iter().map(|p| p.isrc.clone()).collect();

            let plays_daily: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;
            let plays_monthly: Vec<PlaysMonthly> =
                self.plays_monthly_repo.find_by_isrcs(isrcs.clone()).await?;

            let all_month_play_count: i32 = plays_monthly.iter().map(|p| p.sum.unwrap_or(0)).sum();
            let current_month_day_play_count: i32 = {
                let today = Local::now().date_naive();
                let first_day_of_month = Local.ymd(today.year(), today.month(), 1).naive_local();
                let yesterday = today - Duration::days(1);

                isrcs
                    .iter()
                    .map(|isrc| {
                        plays_daily
                            .iter()
                            .filter(|p| {
                                if let Some(date) = p.date {
                                    // 当月の1日から昨日までの日付かつISRCが一致するものをフィルタリング
                                    date >= first_day_of_month
                                        && date <= yesterday
                                        && p.isrc.as_ref().unwrap() == isrc
                                } else {
                                    false
                                }
                            })
                            .map(|p| p.sum.unwrap_or(0))
                            .sum::<i32>()
                    })
                    .sum()
            };
            let weekly_play_count: i32 = {
                let today = Local::now().date_naive();
                // 集計開始日（9日前）と終了日（2日前）を設定
                let start_date = today - Duration::days(9);
                let end_date = today - Duration::days(2);

                isrcs
                    .iter()
                    .map(|isrc| {
                        plays_daily
                            .iter()
                            .filter(|p| {
                                if let Some(date) = p.date {
                                    // 日付が範囲内かつISRCが一致するものをフィルタリング
                                    date >= start_date
                                        && date <= end_date
                                        && p.isrc.as_ref().unwrap() == isrc
                                } else {
                                    false
                                }
                            })
                            .map(|p| p.sum.unwrap_or(0))
                            .sum::<i32>()
                    })
                    .sum()
            };

            Ok(PlaybackOverviewUsecaseOutput {
                total_play_count: all_month_play_count + current_month_day_play_count,
                weekly_play_count,
            })
        } else {
            Err(anyhow::anyhow!("UPC is required"))
        }
    }
}
