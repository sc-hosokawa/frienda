use async_trait::async_trait;
use chrono::{Datelike, Months, NaiveDate, Utc};
use serde::Serialize;
use std::collections::HashMap;
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::product_track::Model as ProductTrack;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;

pub struct GetAllHistroyUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
    pub period: i32,
}
pub struct GetAllHistoryUsecaseOutput {
    pub chart_data: Vec<ChartDataByDSP>,
}

pub struct GetUPCHistoryUsecaseInput {
    pub upc: String,
    pub period: i32,
}
pub struct GetUPCHistoryUsecaseOutput {
    pub chart_data: Vec<ChartDataByISRC>,
}

pub struct GetISRCHistoryUsecaseInput {
    pub isrc: String,
    pub period: i32,
}
pub struct GetISRCHistoryUsecaseOutput {
    pub chart_data: Vec<ChartDataByDSP>,
}
pub struct ChartDataByDSP {
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}

#[derive(Debug, Serialize)]
pub struct ChartDataByISRC {
    pub date: String,
    #[serde(flatten)]
    pub track_count: HashMap<String, i32>,
}

#[async_trait]
pub trait GetPlayCountHistoryUsecaseTrait: Send + Sync {
    async fn get_play_count_by_artist(
        &self,
        input: GetAllHistroyUsecaseInput,
    ) -> Result<GetAllHistoryUsecaseOutput, anyhow::Error>;
    async fn get_play_count_by_upc(
        &self,
        input: GetUPCHistoryUsecaseInput,
    ) -> Result<GetUPCHistoryUsecaseOutput, anyhow::Error>;
    async fn get_play_count_by_isrc(
        &self,
        input: GetISRCHistoryUsecaseInput,
    ) -> Result<GetISRCHistoryUsecaseOutput, anyhow::Error>;
}

pub struct GetPlayCountHistoryUsecase {
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
}

impl GetPlayCountHistoryUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
    ) -> Self {
        Self {
            plays_daily_repo,
            products_repo,
            product_track_repo,
            tracks_repo,
        }
    }

    fn monthly_range(period: i32) -> Result<(NaiveDate, NaiveDate), anyhow::Error> {
        if period <= 0 {
            return Err(anyhow::anyhow!("Invalid period"));
        }

        let today = Utc::now().date_naive();
        let first_day_this_month = NaiveDate::from_ymd_opt(today.year(), today.month(), 1)
            .ok_or_else(|| {
                anyhow::anyhow!("Failed to compute the first day of the current month")
            })?;
        let latest_month_start = first_day_this_month
            .checked_sub_months(Months::new(1))
            .ok_or_else(|| anyhow::anyhow!("Invalid date calculation"))?;
        let start_month = latest_month_start
            .checked_sub_months(Months::new((period - 1) as u32))
            .ok_or_else(|| anyhow::anyhow!("Invalid date calculation"))?;
        let end_date = first_day_this_month
            .pred_opt()
            .ok_or_else(|| anyhow::anyhow!("Invalid date calculation"))?;

        Ok((start_month, end_date))
    }

    fn validate_period(period: i32) -> Result<(), anyhow::Error> {
        match period {
            7 | 30 | 12 | 36 | -1 => Ok(()),
            _ => Err(anyhow::anyhow!("Invalid period")),
        }
    }

    fn aggregate_daily_by_month(
        plays: Vec<PlaysDaily>,
        start: Option<NaiveDate>,
        end: Option<NaiveDate>,
    ) -> Vec<ChartDataByDSP> {
        let mut aggregated_data: HashMap<String, ChartDataByDSP> = HashMap::new();

        for play in plays.into_iter() {
            if play.isrc.is_none() {
                continue;
            }

            let date = match play.date {
                Some(date) => date,
                None => continue,
            };

            if let Some(start_date) = start {
                if date < start_date {
                    continue;
                }
            }
            if let Some(end_date) = end {
                if date > end_date {
                    continue;
                }
            }

            let month_key = date.format("%Y-%m").to_string();
            aggregated_data
                .entry(month_key.clone())
                .and_modify(|e| {
                    e.spotify += play.spotify;
                    e.apple += play.apple;
                    e.line += play.line;
                    e.amazon += play.amazon.unwrap_or(0);
                    e.youtube += play.youtube.unwrap_or(0);
                })
                .or_insert(ChartDataByDSP {
                    date: month_key,
                    spotify: play.spotify,
                    apple: play.apple,
                    line: play.line,
                    amazon: play.amazon.unwrap_or(0),
                    youtube: play.youtube.unwrap_or(0),
                });
        }

        let mut chart_data = aggregated_data
            .into_values()
            .collect::<Vec<ChartDataByDSP>>();
        chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        chart_data
    }

    fn aggregate_daily_sum_by_month(
        plays: Vec<PlaysDaily>,
        start: Option<NaiveDate>,
        end: Option<NaiveDate>,
        isrc_to_title: &HashMap<String, String>,
    ) -> Vec<ChartDataByISRC> {
        let mut aggregated: HashMap<String, HashMap<String, i32>> = HashMap::new();

        for play in plays.into_iter() {
            let date = match play.date {
                Some(date) => date,
                None => continue,
            };

            if let Some(start_date) = start {
                if date < start_date {
                    continue;
                }
            }
            if let Some(end_date) = end {
                if date > end_date {
                    continue;
                }
            }

            let isrc = match play.isrc {
                Some(isrc) => isrc,
                None => continue,
            };

            let title = match isrc_to_title.get(&isrc) {
                Some(title) => title.clone(),
                None => continue,
            };

            let month_key = date.format("%Y-%m").to_string();
            let total = play.sum.unwrap_or(0);

            aggregated
                .entry(month_key)
                .and_modify(|entry| {
                    *entry.entry(title.clone()).or_insert(0) += total;
                })
                .or_insert_with(|| {
                    let mut map = HashMap::new();
                    map.insert(title, total);
                    map
                });
        }

        let mut chart_data = aggregated
            .into_iter()
            .map(|(date, track_count)| ChartDataByISRC { date, track_count })
            .collect::<Vec<ChartDataByISRC>>();
        chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        chart_data
    }
}

#[async_trait]
impl GetPlayCountHistoryUsecaseTrait for GetPlayCountHistoryUsecase {
    async fn get_play_count_by_artist(
        &self,
        input: GetAllHistroyUsecaseInput,
    ) -> Result<GetAllHistoryUsecaseOutput, anyhow::Error> {
        Self::validate_period(input.period)?;

        let products_by_artist = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let upcs: Vec<String> = products_by_artist
            .iter()
            .map(|p| p.upc.clone())
            .collect::<Vec<String>>();

        let product_tracks_by_upcs = self.product_track_repo.get_by_upcs(upcs).await?;
        let isrcs: Vec<String> = product_tracks_by_upcs
            .iter()
            .map(|p| p.isrc.clone())
            .collect::<Vec<String>>();

        let mut chart_data: Vec<ChartDataByDSP> = vec![];
        if input.period == 7 || input.period == 30 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrcs_and_period(isrcs, input.period)
                .await?;

            let mut aggregated_data: HashMap<String, ChartDataByDSP> = HashMap::new();

            for play in plays_daily_by_isrcs.iter() {
                if play.isrc.is_none() {
                    continue;
                }
                let Some(date) = play.date else {
                    continue;
                };
                let date = date.format("%Y-%m-%d").to_string();
                aggregated_data
                    .entry(date.clone())
                    .and_modify(|e| {
                        e.spotify += play.spotify;
                        e.apple += play.apple;
                        e.line += play.line;
                        e.amazon += play.amazon.unwrap_or(0);
                        e.youtube += play.youtube.unwrap_or(0);
                    })
                    .or_insert(ChartDataByDSP {
                        date,
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon.unwrap_or(0),
                        youtube: play.youtube.unwrap_or(0),
                    });
            }

            chart_data = aggregated_data
                .into_values()
                .collect::<Vec<ChartDataByDSP>>();

            // Sort by date in ascending order
            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else if input.period == 12 || input.period == 36 {
            let (start, end) = Self::monthly_range(input.period)?;
            let plays_daily_by_isrcs: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrcs(isrcs).await?;

            chart_data =
                Self::aggregate_daily_by_month(plays_daily_by_isrcs, Some(start), Some(end));
        } else if input.period == -1 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrcs(isrcs).await?;

            chart_data = Self::aggregate_daily_by_month(plays_daily_by_isrcs, None, None);
        }

        Ok(GetAllHistoryUsecaseOutput { chart_data })
    }
    async fn get_play_count_by_upc(
        &self,
        input: GetUPCHistoryUsecaseInput,
    ) -> Result<GetUPCHistoryUsecaseOutput, anyhow::Error> {
        Self::validate_period(input.period)?;

        let product_track: Vec<ProductTrack> =
            self.product_track_repo.get_by_upc(&input.upc).await?;
        let isrcs: Vec<String> = product_track
            .iter()
            .map(|p| p.isrc.clone())
            .collect::<Vec<String>>();

        // ISRCからトラックタイトルへのマッピングを取得
        let tracks = self.tracks_repo.get_by_isrcs(isrcs.clone()).await?;
        let isrc_to_title: HashMap<String, String> = tracks
            .into_iter()
            .map(|track| (track.isrc, track.title))
            .collect();

        let mut chart_data: Vec<ChartDataByISRC> = vec![];

        if input.period == 7 || input.period == 30 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrcs_and_period(isrcs.clone(), input.period)
                .await?;
            chart_data = plays_daily_by_isrcs
                .iter()
                .filter_map(|p| {
                    let isrc = p.isrc.clone()?;
                    let date = p.date?;
                    let title = isrc_to_title.get(&isrc)?.clone();

                    let mut title_count: HashMap<String, i32> = HashMap::new();
                    title_count.insert(title, p.sum.unwrap_or(0));

                    Some(ChartDataByISRC {
                        date: date.format("%Y-%m-%d").to_string(),
                        track_count: title_count,
                    })
                })
                .collect::<Vec<ChartDataByISRC>>();

            let mut merged_data: HashMap<String, HashMap<String, i32>> = HashMap::new();
            for data in chart_data {
                merged_data
                    .entry(data.date)
                    .and_modify(|e| {
                        for (title, count) in data.track_count.iter() {
                            *e.entry(title.clone()).or_insert(0) += count;
                        }
                    })
                    .or_insert(data.track_count.clone());
            }

            chart_data = merged_data
                .into_iter()
                .map(|(date, track_count)| ChartDataByISRC { date, track_count })
                .collect();

            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else if input.period == 12 || input.period == 36 {
            let (start, end) = Self::monthly_range(input.period)?;
            let plays_daily_by_isrcs: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;

            chart_data = Self::aggregate_daily_sum_by_month(
                plays_daily_by_isrcs,
                Some(start),
                Some(end),
                &isrc_to_title,
            );
        } else if input.period == -1 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;

            chart_data = Self::aggregate_daily_sum_by_month(
                plays_daily_by_isrcs,
                None,
                None,
                &isrc_to_title,
            );
        }

        Ok(GetUPCHistoryUsecaseOutput { chart_data })
    }

    async fn get_play_count_by_isrc(
        &self,
        input: GetISRCHistoryUsecaseInput,
    ) -> Result<GetISRCHistoryUsecaseOutput, anyhow::Error> {
        Self::validate_period(input.period)?;

        let chart_data = if input.period == 7 || input.period == 30 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrc_and_period(&input.isrc, input.period)
                .await?;
            let mut chart_data = plays_daily_by_isrcs
                .iter()
                .filter_map(|p| {
                    p.isrc.as_ref()?;
                    let date = p.date?;
                    Some(ChartDataByDSP {
                        date: date.format("%Y-%m-%d").to_string(),
                        spotify: p.spotify,
                        apple: p.apple,
                        line: p.line,
                        amazon: p.amazon.unwrap_or(0),
                        youtube: p.youtube.unwrap_or(0),
                    })
                })
                .collect::<Vec<ChartDataByDSP>>();
            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
            chart_data
        } else if input.period == 12 || input.period == 36 {
            let (start, end) = Self::monthly_range(input.period)?;
            let plays_daily_by_isrcs: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrc(&input.isrc).await?;

            Self::aggregate_daily_by_month(plays_daily_by_isrcs, Some(start), Some(end))
        } else {
            let plays_daily_by_isrcs: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrc(&input.isrc).await?;

            Self::aggregate_daily_by_month(plays_daily_by_isrcs, None, None)
        };

        Ok(GetISRCHistoryUsecaseOutput { chart_data })
    }
}

#[cfg(test)]
#[path = "get_play_count_history_usecase_tests.rs"]
mod tests;
