use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct AdminQuery;

#[Object]
impl AdminQuery {
    async fn get_system_overview(&self, ctx: &Context<'_>) -> Result<models::admin::OverviewData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_system_overview.get_system_overview().await?;
        Ok(models::admin::OverviewData {
            total_users: result.total_users,
            total_artists: result.total_artists,
            total_fsp: result.total_fsp,
            total_revenue: result.total_revenue,
            total_play_count: result.total_play_count,
        })
    }

    async fn get_fsp_history_for_admin(
        &self,
        ctx: &Context<'_>,
        count: i32,
    ) -> Result<Vec<models::admin::FspHistory>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_system_overview.get_fsp_history(count).await?;
        Ok(result
            .into_iter()
            .map(|fsp| models::admin::FspHistory {
                date: fsp.date,
                from: fsp.from,
                to: fsp.to,
                amount: fsp.amount,
                notes: fsp.notes,
            })
            .collect())
    }

    async fn get_track_credits_history_for_admin(
        &self,
        ctx: &Context<'_>,
        count: i32,
    ) -> Result<Vec<models::admin::Credit>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_system_overview.get_all_credits(count).await?;
        Ok(result
            .into_iter()
            .map(|credit| models::admin::Credit {
                date: credit.date,
                title: credit.title,
                isrc: credit.isrc,
                user: credit.user,
                role: credit.role,
                name: credit.name,
                email: credit.email,
            })
            .collect())
    }
}
