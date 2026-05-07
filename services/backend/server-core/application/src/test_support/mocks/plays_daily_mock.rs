use async_trait::async_trait;
use domain::entities::plays_daily::{ActiveModel as PlaysDailyActiveModel, Model as PlaysDaily};
use domain::repositories::plays_daily_repo::{
    OverviewPlayCountAggregate, PlayCountAggregate, PlayCountDspHistoryAggregate,
    PlayCountTrackHistoryAggregate, PlaysDailyRepository, TrendingTrackAggregate,
};
use mockall::automock;
use sea_orm::prelude::Date;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockPlaysDailyRepo {
    async fn mock_create(
        &self,
        plays_daily: PlaysDailyActiveModel,
    ) -> Result<PlaysDaily, DomainError>;
    async fn mock_update(
        &self,
        plays_daily: PlaysDailyActiveModel,
    ) -> Result<PlaysDaily, DomainError>;
    async fn mock_update_many(
        &self,
        plays_daily: Vec<PlaysDailyActiveModel>,
    ) -> Result<(), DomainError>;
    async fn mock_insert_many(
        &self,
        plays_daily: Vec<PlaysDailyActiveModel>,
    ) -> Result<(), DomainError>;
    async fn mock_find_by_isrc(&self, isrc: String) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_find_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_find_by_isrc_and_period(
        &self,
        isrc: String,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_get_all_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_find_lastest_id(&self) -> Result<i32, DomainError>;
    async fn mock_delete_by_isrc(&self, isrc: String) -> Result<(), DomainError>;
    async fn mock_find_by_date(&self, date: String) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_find_between_start_and_end(
        &self,
        start_date: String,
        end_date: String,
    ) -> Result<Vec<PlaysDaily>, DomainError>;
    async fn mock_sum_by_isrcs_until(
        &self,
        isrcs: Vec<String>,
        end_date: Date,
    ) -> Result<i64, DomainError>;
    async fn mock_sum_by_isrcs_between(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<i64, DomainError>;
    async fn mock_aggregate_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
        limit: Option<u64>,
    ) -> Result<Vec<PlayCountAggregate>, DomainError>;
    async fn mock_aggregate_overview_by_artist_id(
        &self,
        artist_id: String,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError>;
    async fn mock_aggregate_overview_by_upc(
        &self,
        upc: String,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError>;
    async fn mock_aggregate_trending_by_artist_id(
        &self,
        artist_id: String,
        weekly_start_date: Date,
        end_date: Date,
        limit: u64,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError>;
    async fn mock_aggregate_trending_by_upc(
        &self,
        upc: String,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError>;
    async fn mock_aggregate_daily_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError>;
    async fn mock_aggregate_monthly_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError>;
    async fn mock_aggregate_daily_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError>;
    async fn mock_aggregate_monthly_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError>;
}

#[async_trait]
impl PlaysDailyRepository for MockMockPlaysDailyRepo {
    async fn create(&self, plays_daily: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError> {
        self.mock_create(plays_daily).await
    }

    async fn update(&self, plays_daily: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError> {
        self.mock_update(plays_daily).await
    }

    async fn update_many(
        &self,
        plays_daily: Vec<PlaysDailyActiveModel>,
    ) -> Result<(), DomainError> {
        self.mock_update_many(plays_daily).await
    }

    async fn insert_many(
        &self,
        plays_daily: Vec<PlaysDailyActiveModel>,
    ) -> Result<(), DomainError> {
        self.mock_insert_many(plays_daily).await
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_by_isrc(isrc.to_string()).await
    }

    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_by_isrcs(isrcs).await
    }

    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_by_period(period).await
    }

    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_by_isrc_and_period(isrc.to_string(), period)
            .await
    }

    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_by_isrcs_and_period(isrcs, period).await
    }

    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_get_all_by_period(period).await
    }

    async fn find_lastest_id(&self) -> Result<i32, DomainError> {
        self.mock_find_lastest_id().await
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        self.mock_delete_by_isrc(isrc.to_string()).await
    }

    async fn find_by_date(&self, date: &str) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_by_date(date.to_string()).await
    }

    async fn find_between_start_and_end(
        &self,
        start_date: &str,
        end_date: &str,
    ) -> Result<Vec<PlaysDaily>, DomainError> {
        self.mock_find_between_start_and_end(start_date.to_string(), end_date.to_string())
            .await
    }

    async fn sum_by_isrcs_until(
        &self,
        isrcs: Vec<String>,
        end_date: Date,
    ) -> Result<i64, DomainError> {
        self.mock_sum_by_isrcs_until(isrcs, end_date).await
    }

    async fn sum_by_isrcs_between(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<i64, DomainError> {
        self.mock_sum_by_isrcs_between(isrcs, start_date, end_date)
            .await
    }

    async fn aggregate_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
        limit: Option<u64>,
    ) -> Result<Vec<PlayCountAggregate>, DomainError> {
        self.mock_aggregate_by_isrcs(isrcs, start_date, end_date, limit)
            .await
    }

    async fn aggregate_overview_by_artist_id(
        &self,
        artist_id: &str,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError> {
        self.mock_aggregate_overview_by_artist_id(
            artist_id.to_string(),
            weekly_start_date,
            end_date,
        )
        .await
    }

    async fn aggregate_overview_by_upc(
        &self,
        upc: &str,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError> {
        self.mock_aggregate_overview_by_upc(upc.to_string(), weekly_start_date, end_date)
            .await
    }

    async fn aggregate_trending_by_artist_id(
        &self,
        artist_id: &str,
        weekly_start_date: Date,
        end_date: Date,
        limit: u64,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError> {
        self.mock_aggregate_trending_by_artist_id(
            artist_id.to_string(),
            weekly_start_date,
            end_date,
            limit,
        )
        .await
    }

    async fn aggregate_trending_by_upc(
        &self,
        upc: &str,
        weekly_start_date: Date,
        end_date: Date,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError> {
        self.mock_aggregate_trending_by_upc(upc.to_string(), weekly_start_date, end_date)
            .await
    }

    async fn aggregate_daily_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError> {
        self.mock_aggregate_daily_dsp_history_by_isrcs(isrcs, start_date, end_date)
            .await
    }

    async fn aggregate_monthly_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError> {
        self.mock_aggregate_monthly_dsp_history_by_isrcs(isrcs, start_date, end_date)
            .await
    }

    async fn aggregate_daily_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Date,
        end_date: Date,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError> {
        self.mock_aggregate_daily_track_history_by_isrcs(isrcs, start_date, end_date)
            .await
    }

    async fn aggregate_monthly_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<Date>,
        end_date: Option<Date>,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError> {
        self.mock_aggregate_monthly_track_history_by_isrcs(isrcs, start_date, end_date)
            .await
    }
}
