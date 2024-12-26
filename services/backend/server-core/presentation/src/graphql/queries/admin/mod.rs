use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct AdminQuery;

#[Object]
impl AdminQuery {
    async fn get_overview(&self, ctx: &Context<'_>) -> Result<models::admin::OverviewData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_overview.get_overview().await?;
        Ok(models::admin::OverviewData {
            total_users: result.total_users,
            total_artists: result.total_artists,
            total_fsp: result.total_fsp,
            total_revenue: result.total_revenue,
            total_play_count: result.total_play_count,
        })
    }
}
