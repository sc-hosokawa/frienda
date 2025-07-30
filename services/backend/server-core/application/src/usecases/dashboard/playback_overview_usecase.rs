use async_trait::async_trait;
use chrono::{Datelike, Duration, FixedOffset, TimeZone, Utc};
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

        // 日本時間基準での現在時刻を取得
        let jst = FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = Utc::now().with_timezone(&jst).date_naive();
        let day = today_jst.day();

        // データ更新タイミングを考慮した月次データの選択
        let effective_monthly_data = if day < 4 {
            // 4日未満の場合、前月までの月次データのみ使用
            let last_month = if today_jst.month() == 1 {
                12
            } else {
                today_jst.month() - 1
            };
            let last_month_year = if today_jst.month() == 1 {
                today_jst.year() - 1
            } else {
                today_jst.year()
            };

            plays_monthly
                .iter()
                .filter(|p| {
                    if let Some(month_date) = p.month {
                        month_date.year() < last_month_year
                            || (month_date.year() == last_month_year
                                && month_date.month() <= last_month)
                    } else {
                        false
                    }
                })
                .collect::<Vec<_>>()
        } else {
            // 4日以降の場合、全月次データを使用
            plays_monthly.iter().collect::<Vec<_>>()
        };

        let all_month_play_count: i32 = effective_monthly_data
            .iter()
            .map(|p| p.sum.unwrap_or(0))
            .sum();

        // データ更新タイミングを考慮した日次データの集計
        let current_month_day_play_count: i32 = {
            let year = today_jst.year();
            let month = today_jst.month();
            let first_day_of_month = jst.ymd(year, month, 1).naive_local();

            if day < 4 {
                // 4日未満の場合: 前月分の日次データ + 当月分の日次データ
                let last_month = if month == 1 { 12 } else { month - 1 };
                let last_month_year = if month == 1 { year - 1 } else { year };
                let first_day_of_last_month = jst.ymd(last_month_year, last_month, 1).naive_local();
                let last_day_of_last_month = jst
                    .ymd(last_month_year, last_month, 1)
                    .naive_local()
                    .with_month(last_month)
                    .unwrap()
                    .with_day(if last_month == 2 {
                        if last_month_year % 4 == 0
                            && (last_month_year % 100 != 0 || last_month_year % 400 == 0)
                        {
                            29
                        } else {
                            28
                        }
                    } else if [4, 6, 9, 11].contains(&last_month) {
                        30
                    } else {
                        31
                    })
                    .unwrap();

                // 前月分の日次データ
                let last_month_daily_count: i32 = isrcs
                    .iter()
                    .map(|isrc| {
                        plays_daily
                            .iter()
                            .filter(|p| {
                                if let Some(date) = p.date {
                                    date >= first_day_of_last_month
                                        && date <= last_day_of_last_month
                                        && p.isrc.as_ref().unwrap() == isrc
                                } else {
                                    false
                                }
                            })
                            .map(|p| p.sum.unwrap_or(0))
                            .sum::<i32>()
                    })
                    .sum();

                // 当月分の日次データ（昨日まで）
                let current_month_daily_count: i32 = isrcs
                    .iter()
                    .map(|isrc| {
                        plays_daily
                            .iter()
                            .filter(|p| {
                                if let Some(date) = p.date {
                                    date >= first_day_of_month
                                        && date <= today_jst - Duration::days(1)
                                        && p.isrc.as_ref().unwrap() == isrc
                                } else {
                                    false
                                }
                            })
                            .map(|p| p.sum.unwrap_or(0))
                            .sum::<i32>()
                    })
                    .sum();

                last_month_daily_count + current_month_daily_count
            } else {
                // 4日以降の場合: 当月分の日次データのみ（昨日まで）
                isrcs
                    .iter()
                    .map(|isrc| {
                        plays_daily
                            .iter()
                            .filter(|p| {
                                if let Some(date) = p.date {
                                    date >= first_day_of_month
                                        && date <= today_jst - Duration::days(1)
                                        && p.isrc.as_ref().unwrap() == isrc
                                } else {
                                    false
                                }
                            })
                            .map(|p| p.sum.unwrap_or(0))
                            .sum::<i32>()
                    })
                    .sum()
            }
        };

        let weekly_play_count: i32 = {
            let jst = FixedOffset::east_opt(9 * 3600).unwrap();
            let today_jst = Utc::now().with_timezone(&jst).date_naive();
            let start_date = today_jst - Duration::days(9);
            let end_date = today_jst - Duration::days(3);

            // 日本時間基準でフィルタリング
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

            // 日本時間基準での現在時刻を取得
            let jst = FixedOffset::east_opt(9 * 3600).unwrap();
            let today_jst = Utc::now().with_timezone(&jst).date_naive();
            let day = today_jst.day();

            // データ更新タイミングを考慮した月次データの選択
            let effective_monthly_data = if day < 4 {
                // 4日未満の場合、前月までの月次データのみ使用
                let last_month = if today_jst.month() == 1 {
                    12
                } else {
                    today_jst.month() - 1
                };
                let last_month_year = if today_jst.month() == 1 {
                    today_jst.year() - 1
                } else {
                    today_jst.year()
                };

                plays_monthly
                    .iter()
                    .filter(|p| {
                        if let Some(month_date) = p.month {
                            month_date.year() < last_month_year
                                || (month_date.year() == last_month_year
                                    && month_date.month() <= last_month)
                        } else {
                            false
                        }
                    })
                    .collect::<Vec<_>>()
            } else {
                // 4日以降の場合、全月次データを使用
                plays_monthly.iter().collect::<Vec<_>>()
            };

            let all_month_play_count: i32 = effective_monthly_data
                .iter()
                .map(|p| p.sum.unwrap_or(0))
                .sum();

            // データ更新タイミングを考慮した日次データの集計
            let current_month_day_play_count: i32 = {
                let year = today_jst.year();
                let month = today_jst.month();
                let first_day_of_month = jst.ymd(year, month, 1).naive_local();

                if day < 4 {
                    // 4日未満の場合: 前月分の日次データ + 当月分の日次データ
                    let last_month = if month == 1 { 12 } else { month - 1 };
                    let last_month_year = if month == 1 { year - 1 } else { year };
                    let first_day_of_last_month =
                        jst.ymd(last_month_year, last_month, 1).naive_local();
                    let last_day_of_last_month = jst
                        .ymd(last_month_year, last_month, 1)
                        .naive_local()
                        .with_month(last_month)
                        .unwrap()
                        .with_day(if last_month == 2 {
                            if last_month_year % 4 == 0
                                && (last_month_year % 100 != 0 || last_month_year % 400 == 0)
                            {
                                29
                            } else {
                                28
                            }
                        } else if [4, 6, 9, 11].contains(&last_month) {
                            30
                        } else {
                            31
                        })
                        .unwrap();

                    // 前月分の日次データ
                    let last_month_daily_count: i32 = isrcs
                        .iter()
                        .map(|isrc| {
                            plays_daily
                                .iter()
                                .filter(|p| {
                                    if let Some(date) = p.date {
                                        date >= first_day_of_last_month
                                            && date <= last_day_of_last_month
                                            && p.isrc.as_ref().unwrap() == isrc
                                    } else {
                                        false
                                    }
                                })
                                .map(|p| p.sum.unwrap_or(0))
                                .sum::<i32>()
                        })
                        .sum();

                    // 当月分の日次データ（昨日まで）
                    let current_month_daily_count: i32 = isrcs
                        .iter()
                        .map(|isrc| {
                            plays_daily
                                .iter()
                                .filter(|p| {
                                    if let Some(date) = p.date {
                                        date >= first_day_of_month
                                            && date <= today_jst - Duration::days(1)
                                            && p.isrc.as_ref().unwrap() == isrc
                                    } else {
                                        false
                                    }
                                })
                                .map(|p| p.sum.unwrap_or(0))
                                .sum::<i32>()
                        })
                        .sum();

                    last_month_daily_count + current_month_daily_count
                } else {
                    // 4日以降の場合: 当月分の日次データのみ（昨日まで）
                    isrcs
                        .iter()
                        .map(|isrc| {
                            plays_daily
                                .iter()
                                .filter(|p| {
                                    if let Some(date) = p.date {
                                        date >= first_day_of_month
                                            && date <= today_jst - Duration::days(1)
                                            && p.isrc.as_ref().unwrap() == isrc
                                    } else {
                                        false
                                    }
                                })
                                .map(|p| p.sum.unwrap_or(0))
                                .sum::<i32>()
                        })
                        .sum()
                }
            };

            let weekly_play_count: i32 = {
                let jst = FixedOffset::east_opt(9 * 3600).unwrap();
                let today_jst = Utc::now().with_timezone(&jst).date_naive();
                let start_date = today_jst - Duration::days(9);
                let end_date = today_jst - Duration::days(3);

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
