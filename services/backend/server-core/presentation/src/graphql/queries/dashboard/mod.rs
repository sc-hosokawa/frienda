use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use std::sync::Arc;

use registry::Usecases;

#[derive(Default)]
pub struct DashboardQuery;

#[Object]
impl DashboardQuery {
    async fn get_overview(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: String,
    ) -> Result<models::dashboard::TotalOverviewData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_playback_overview
            .get_playback_overview(application::usecases::dashboard::playback_overview_usecase::PlaybackOverviewUsecaseInput {
                artist_id,
                user_id,
                upc: None,
            })
            .await?;

        Ok(models::dashboard::TotalOverviewData {
            total_playbacks: result.total_play_count,
            weekly_playbacks: result.weekly_play_count,
        })
    }

    async fn get_overview_by_upc(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: String,
        upc: String,
    ) -> Result<models::dashboard::TotalOverviewData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_playback_overview.get_playback_overview_by_upc(application::usecases::dashboard::playback_overview_usecase::PlaybackOverviewUsecaseInput{
                artist_id,
                user_id,
                upc: Some(upc),
            })
            .await?;

        Ok(models::dashboard::TotalOverviewData {
            total_playbacks: result.total_play_count,
            weekly_playbacks: result.weekly_play_count,
        })
    }

    async fn get_trending(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: String,
    ) -> Result<models::dashboard::TrendingData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_trending
            .get_trending(
                application::usecases::dashboard::get_trending_usecase::GetTrendingUsecaseInput {
                    artist_id,
                    user_id,
                },
            )
            .await?;

        Ok(models::dashboard::TrendingData {
            trending_tracks: result.trending.into_iter().map(|t| t.into()).collect(),
        })
    }

    async fn get_play_count_history(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: String,
        period: i32,
    ) -> Result<models::dashboard::ChartData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_play_count_history
            .get_play_count_by_artist(
                application::usecases::dashboard::get_play_count_history_usecase::GetAllHistroyUsecaseInput {
                    artist_id,
                    user_id,
                    period,
                },
            )
            .await?;

        Ok(models::dashboard::ChartData {
            line_chart_data: result.chart_data.into_iter().map(|d| d.into()).collect(),
        })
    }

    async fn get_playcount_history_by_upc(
        &self,
        ctx: &Context<'_>,
        upc: String,
        period: i32,
    ) -> Result<models::dashboard::ChartDataByUPC> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_play_count_history.get_play_count_by_upc(application::usecases::dashboard::get_play_count_history_usecase::GetUPCHistoryUsecaseInput{
            upc,
            period,
        })
            .await?;

        Ok(models::dashboard::ChartDataByUPC {
            line_chart_data: result.chart_data.into_iter().map(|d| d.into()).collect(),
        })
    }

    async fn get_gender_gen_rate_by_artist(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: String,
    ) -> Result<models::dashboard::GenderGenRateData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_playback_gender_gen.get_playback_gender_gen(application::usecases::dashboard::get_playback_gender_gen_usecase::GetPlaybackGenderGenUsecaseInput{
            artist_id,
            user_id,
            isrc: None,
            upc: None,
        })
        .await?;

        Ok(models::dashboard::GenderGenRateData {
            gender_rate: result.gender_rate.into(),
            gen_rate: result.gen_rate.into(),
        })
    }

    async fn get_gender_gen_rate_by_upc(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: String,
        upc: String,
    ) -> Result<models::dashboard::GenderGenRateData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_playback_gender_gen.get_playback_gender_gen(application::usecases::dashboard::get_playback_gender_gen_usecase::GetPlaybackGenderGenUsecaseInput{
            artist_id: artist_id,
            user_id: user_id,
            isrc: None,
            upc: Some(upc),
        })
            .await?;

        Ok(models::dashboard::GenderGenRateData {
            gender_rate: result.gender_rate.into(),
            gen_rate: result.gen_rate.into(),
        })
    }
}
