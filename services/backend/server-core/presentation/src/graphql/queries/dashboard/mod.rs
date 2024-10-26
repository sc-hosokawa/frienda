use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct DashboardQuery;

#[Object]
impl DashboardQuery {
    async fn get_overview_data(
        &self,
        ctx: &Context<'_>,
        artist_id: Option<String>,
    ) -> Result<models::dashboard::TotalOverviewData> {
        todo!()
    }

    // TODO: artist_id, isrc, dsp, periodでフィルタリング
    async fn get_trending_data(
        &self,
        ctx: &Context<'_>,
        artist_id: Option<String>,
    ) -> Result<models::dashboard::TrendingData> {
        todo!()
    }

    async fn get_line_chart_data(
        &self,
        ctx: &Context<'_>,
        artist_id: Option<String>,
        isrc: Option<String>,
        dsp: Option<String>,
        period: Option<String>,
    ) -> Result<models::dashboard::ChartData> {
        todo!()
    }

    async fn get_playbacks_by_gender_data(
        &self,
        ctx: &Context<'_>,
        artist_id: Option<String>,
        isrc: Option<String>,
        dsp: Option<String>,
        period: Option<String>,
    ) -> Result<models::dashboard::PlaybacksByGenderData> {
        todo!()
    }

    async fn get_playbacks_by_generation_data(
        &self,
        ctx: &Context<'_>,
        artist_id: Option<String>,
        isrc: Option<String>,
        dsp: Option<String>,
        period: Option<String>,
    ) -> Result<models::dashboard::PlaybacksByGenerationData> {
        todo!()
    }
}
