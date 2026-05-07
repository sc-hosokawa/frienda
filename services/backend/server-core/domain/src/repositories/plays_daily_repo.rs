use crate::entities::plays_daily::{ActiveModel as PlaysDailyActiveModel, Model as PlaysDaily};
use async_trait::async_trait;
use sea_orm::prelude::Date;
use shared::error::domain_err::DomainError;

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct PlayCountAggregate {
    pub isrc: String,
    pub total: i64,
    pub spotify: i64,
    pub apple: i64,
    pub line: i64,
    pub amazon: i64,
    pub youtube: i64,
}

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct OverviewPlayCountAggregate {
    pub total: i64,
    pub weekly: i64,
}

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct TrendingTrackAggregate {
    pub isrc: String,
    pub track_title: Option<String>,
    pub upc_title: Option<String>,
    pub image_url: Option<String>,
    pub total: i64,
    pub weekly: i64,
    pub total_spotify: i64,
    pub total_apple: i64,
    pub total_line: i64,
    pub total_amazon: i64,
    pub total_youtube: i64,
    pub weekly_spotify: i64,
    pub weekly_apple: i64,
    pub weekly_line: i64,
    pub weekly_amazon: i64,
    pub weekly_youtube: i64,
}

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct PlayCountDspHistoryAggregate {
    pub date: String,
    pub spotify: i64,
    pub apple: i64,
    pub line: i64,
    pub amazon: i64,
    pub youtube: i64,
}

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct PlayCountTrackHistoryAggregate {
    pub date: String,
    pub track_title: String,
    pub total: i64,
}

#[async_trait]
pub trait PlaysDailyRepository: Send + Sync {
    async fn create(&self, plays_daily: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError>;
    async fn update(&self, plays_daily: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError>;
    async fn update_many(&self, plays_daily: Vec<PlaysDailyActiveModel>)
        -> Result<(), DomainError>;
    async fn insert_many(&self, plays_daily: Vec<PlaysDailyActiveModel>)
        -> Result<(), DomainError>;

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_lastest_id(&self) -> Result<i32, DomainError>;
    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError>;
    async fn find_by_date(&self, date: &str) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn find_between_start_and_end(
        &self,
        start_date: &str,
        end_date: &str,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn sum_by_isrcs_until(
        &self,
        isrcs: Vec<String>,
        end_date: Date,
    ) -> Result<i64, DomainError>;
    async fn sum_by_isrcs_between(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<i64, DomainError>;
    async fn aggregate_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
        limit: Option<u64>,
    ) -> Result<Vec<PlayCountAggregate>, DomainError>;
    async fn aggregate_overview_by_artist_id(
        &self,
        artist_id: &str,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError>;
    async fn aggregate_overview_by_upc(
        &self,
        upc: &str,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError>;
    async fn aggregate_trending_by_artist_id(
        &self,
        artist_id: &str,
        weekly_start_date: Date,
        end_date: Date,
        limit: u64,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError>;
    async fn aggregate_trending_by_upc(
        &self,
        upc: &str,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError>;
    async fn aggregate_daily_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError>;
    async fn aggregate_monthly_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError>;
    async fn aggregate_daily_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError>;
    async fn aggregate_monthly_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError>;
}
