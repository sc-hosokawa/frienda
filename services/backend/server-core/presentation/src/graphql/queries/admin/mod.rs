use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

use domain::entities::sea_orm_active_enums::UserCategory;

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
            mobile_app_users_count: result.mobile_app_users_count,
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

    async fn get_all_users_for_admin(&self, ctx: &Context<'_>) -> Result<Vec<models::admin::User>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_system_overview.get_all_users().await?;
        Ok(result
            .into_iter()
            .map(|user| models::admin::User {
                id: user.id,
                realname: user.realname,
                username: user.username,
                image_url: user.img_url,
                email: user.email,
                role: match user.category {
                    UserCategory::Musician => "Musician".to_string(),
                    UserCategory::Creator => "Creator".to_string(),
                    UserCategory::Supporter => "Supporter".to_string(),
                    UserCategory::Curator => "Curator".to_string(),
                },
                primary_role: match user.primary_category {
                    UserCategory::Musician => "Musician".to_string(),
                    UserCategory::Creator => "Creator".to_string(),
                    UserCategory::Supporter => "Supporter".to_string(),
                    UserCategory::Curator => "Curator".to_string(),
                },
                created_at: user.created_at.to_string(),
            })
            .collect())
    }

    async fn get_all_track_playback_history_for_admin(
        &self,
        ctx: &Context<'_>,
        period: i32,
    ) -> Result<models::admin::ChartDataForAdmin> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result: application::usecases::admin::all_track_playback_usecase::AllTrackPlaybackHistoryUsecaseOutput = usecases
            .all_track_playback
            .get_all_track_playback_history(
                application::usecases::admin::all_track_playback_usecase::AllTrackPlaybackHistoryUsecaseInput {
                    period,
                },
            )
            .await?;
        Ok(models::admin::ChartDataForAdmin {
            line_chart_data: result
                .chart_data
                .into_iter()
                .map(|chart| models::admin::LineChartDataForAdmin {
                    date: chart.date,
                    spotify: chart.spotify,
                    apple: chart.apple,
                    line: chart.line,
                    amazon: chart.amazon,
                    youtube: chart.youtube,
                })
                .collect(),
        })
    }
}
