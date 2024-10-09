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
    ) -> Result<models::artists::ArtistPlaybackOverviewData> {
        todo!()
    }

    async fn get_trending_data(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::artists::ArtistPlaybackOverviewData> {
        todo!()
    }

    async fn get_line_chart_data(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::artists::ArtistPlaybackOverviewData> {
        todo!()
    }

    async fn get_segment_data(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::artists::ArtistPlaybackOverviewData> {
        todo!()
    }

    async fn get_available_indicators_data(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::indicators::IndicatorData> {
        todo!()
    }
}
