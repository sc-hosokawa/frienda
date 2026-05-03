use async_trait::async_trait;
use chrono::{Datelike, Duration, Months, NaiveDate, Utc};
use serde::Serialize;
use std::collections::{BTreeMap, HashMap};
use std::sync::Arc;

use domain::entities::product_track::Model as ProductTrack;
use domain::repositories::plays_daily_repo::{
    PlayCountDspHistoryAggregate, PlayCountTrackHistoryAggregate, PlaysDailyRepository,
};
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
}

impl GetPlayCountHistoryUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        _tracks_repo: Arc<dyn TracksRepository>,
    ) -> Self {
        Self {
            plays_daily_repo,
            products_repo,
            product_track_repo,
        }
    }

    fn daily_range(period: i32) -> Result<(NaiveDate, NaiveDate), anyhow::Error> {
        if period <= 0 {
            return Err(anyhow::anyhow!("Invalid period"));
        }

        let end_date = (Utc::now() - Duration::days(2)).date_naive();
        let start_date = end_date - Duration::days(period as i64);
        Ok((start_date, end_date))
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

    fn chart_data_by_dsp(aggregates: Vec<PlayCountDspHistoryAggregate>) -> Vec<ChartDataByDSP> {
        aggregates
            .into_iter()
            .map(|aggregate| ChartDataByDSP {
                date: aggregate.date,
                spotify: aggregate.spotify as i32,
                apple: aggregate.apple as i32,
                line: aggregate.line as i32,
                amazon: aggregate.amazon as i32,
                youtube: aggregate.youtube as i32,
            })
            .collect()
    }

    fn chart_data_by_track(
        aggregates: Vec<PlayCountTrackHistoryAggregate>,
    ) -> Vec<ChartDataByISRC> {
        let mut merged: BTreeMap<String, HashMap<String, i32>> = BTreeMap::new();
        for aggregate in aggregates {
            *merged
                .entry(aggregate.date)
                .or_default()
                .entry(aggregate.track_title)
                .or_insert(0) += aggregate.total as i32;
        }

        merged
            .into_iter()
            .map(|(date, track_count)| ChartDataByISRC { date, track_count })
            .collect()
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

        let chart_data = if input.period == 7 || input.period == 30 {
            let (start, end) = Self::daily_range(input.period)?;
            let aggregates = self
                .plays_daily_repo
                .aggregate_daily_dsp_history_by_isrcs(isrcs, start, end)
                .await?;
            Self::chart_data_by_dsp(aggregates)
        } else if input.period == 12 || input.period == 36 {
            let (start, end) = Self::monthly_range(input.period)?;
            let aggregates = self
                .plays_daily_repo
                .aggregate_monthly_dsp_history_by_isrcs(isrcs, Some(start), Some(end))
                .await?;
            Self::chart_data_by_dsp(aggregates)
        } else {
            let aggregates = self
                .plays_daily_repo
                .aggregate_monthly_dsp_history_by_isrcs(isrcs, None, None)
                .await?;
            Self::chart_data_by_dsp(aggregates)
        };

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

        let chart_data = if input.period == 7 || input.period == 30 {
            let (start, end) = Self::daily_range(input.period)?;
            let aggregates = self
                .plays_daily_repo
                .aggregate_daily_track_history_by_isrcs(isrcs, start, end)
                .await?;
            Self::chart_data_by_track(aggregates)
        } else if input.period == 12 || input.period == 36 {
            let (start, end) = Self::monthly_range(input.period)?;
            let aggregates = self
                .plays_daily_repo
                .aggregate_monthly_track_history_by_isrcs(isrcs, Some(start), Some(end))
                .await?;
            Self::chart_data_by_track(aggregates)
        } else {
            let aggregates = self
                .plays_daily_repo
                .aggregate_monthly_track_history_by_isrcs(isrcs, None, None)
                .await?;
            Self::chart_data_by_track(aggregates)
        };

        Ok(GetUPCHistoryUsecaseOutput { chart_data })
    }

    async fn get_play_count_by_isrc(
        &self,
        input: GetISRCHistoryUsecaseInput,
    ) -> Result<GetISRCHistoryUsecaseOutput, anyhow::Error> {
        Self::validate_period(input.period)?;

        let isrcs = vec![input.isrc];
        let chart_data = if input.period == 7 || input.period == 30 {
            let (start, end) = Self::daily_range(input.period)?;
            let aggregates = self
                .plays_daily_repo
                .aggregate_daily_dsp_history_by_isrcs(isrcs, start, end)
                .await?;
            Self::chart_data_by_dsp(aggregates)
        } else if input.period == 12 || input.period == 36 {
            let (start, end) = Self::monthly_range(input.period)?;
            let aggregates = self
                .plays_daily_repo
                .aggregate_monthly_dsp_history_by_isrcs(isrcs, Some(start), Some(end))
                .await?;
            Self::chart_data_by_dsp(aggregates)
        } else {
            let aggregates = self
                .plays_daily_repo
                .aggregate_monthly_dsp_history_by_isrcs(isrcs, None, None)
                .await?;
            Self::chart_data_by_dsp(aggregates)
        };

        Ok(GetISRCHistoryUsecaseOutput { chart_data })
    }
}

#[cfg(test)]
#[path = "get_play_count_history_usecase_tests.rs"]
mod tests;
