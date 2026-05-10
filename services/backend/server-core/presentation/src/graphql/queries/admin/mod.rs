use crate::graphql::{context::AuthenticatedUser, models};
use async_graphql::{Context, Error, ErrorExtensions, Object, Result};
use shared::error::domain_err::DomainError;
use registry::Usecases;
use std::sync::Arc;

use domain::entities::sea_orm_active_enums::UserCategory;

#[derive(Default)]
pub struct AdminQuery;

fn graphql_error(message: impl Into<String>, code: &'static str) -> Error {
    Error::new(message).extend_with(|_, extensions| {
        extensions.set("code", code);
    })
}

fn map_admin_notification_error(error: DomainError) -> Error {
    match error {
        DomainError::ValidationError(message) | DomainError::InvalidParameter(message) => {
            graphql_error(message, "BAD_USER_INPUT")
        }
        DomainError::AuthorizationError(message) => graphql_error(message, "FORBIDDEN"),
        DomainError::NotFound => graphql_error("Notification not found", "NOT_FOUND"),
        other => graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR"),
    }
}

fn authenticated_user_id(ctx: &Context<'_>) -> Result<String> {
    ctx.data_opt::<AuthenticatedUser>()
        .map(|user| user.user_id.clone())
        .ok_or_else(|| graphql_error("Forbidden", "FORBIDDEN"))
}

fn into_notification_channels(
    channels: Vec<String>,
) -> Result<Vec<models::notifications::NotificationChannel>> {
    channels
        .iter()
        .map(|channel| {
            models::notifications::NotificationChannel::try_from(channel.as_str())
                .map_err(|message| graphql_error(message, "INTERNAL_SERVER_ERROR"))
        })
        .collect()
}

#[Object]
impl AdminQuery {
    async fn get_admin_notification_list(
        &self,
        ctx: &Context<'_>,
        #[graphql(default = 20)] limit: i32,
        #[graphql(default = 0)] offset: i32,
    ) -> Result<models::notifications::AdminNotificationListData> {
        let authenticated_user_id = authenticated_user_id(ctx)?;
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .admin_notifications
            .get_admin_notification_list(&authenticated_user_id, limit, offset)
            .await
            .map_err(map_admin_notification_error)?;

        Ok(models::notifications::AdminNotificationListData {
            notifications: result
                .notifications
                .into_iter()
                .map(|notification| {
                    Ok(models::notifications::AdminNotificationListItem {
                        id: notification.id,
                        title: notification.title,
                        content: notification.content,
                        category: notification.category,
                        channels: into_notification_channels(notification.channels)?,
                        recipient_count: notification.recipient_count,
                        created_at: notification.created_at,
                    })
                })
                .collect::<Result<Vec<_>>>()?,
            total_count: result.total_count,
            has_next_page: result.has_next_page,
        })
    }

    async fn get_admin_notification_detail(
        &self,
        ctx: &Context<'_>,
        notification_id: i32,
    ) -> Result<models::notifications::AdminNotificationDetail> {
        let authenticated_user_id = authenticated_user_id(ctx)?;
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .admin_notifications
            .get_admin_notification_detail(&authenticated_user_id, notification_id)
            .await
            .map_err(map_admin_notification_error)?;

        Ok(models::notifications::AdminNotificationDetail {
            id: result.id,
            title: result.title,
            content: result.content,
            category: result.category,
            channels: into_notification_channels(result.channels)?,
            recipients: result
                .recipients
                .into_iter()
                .map(|recipient| models::notifications::AdminNotificationRecipient {
                    user_id: recipient.user_id,
                    username: recipient.username,
                    email: recipient.email,
                    mobile_push_is_read: recipient.mobile_push_is_read,
                    mobile_push_is_deleted: recipient.mobile_push_is_deleted,
                })
                .collect(),
            created_at: result.created_at,
        })
    }

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

    async fn get_all_user_reports(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::admin::UserReport>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.report.get_all_user_reports().await?;
        Ok(result
            .into_iter()
            .map(|report| models::admin::UserReport {
                id: report.id,
                reported_user_id: report.reported_user_id,
                reporter_user_id: report.reporter_user_id,
                report_content: report.report_content,
                created_at: report.created_at.to_string(),
            })
            .collect())
    }

    async fn get_all_offer_reports(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::admin::OfferReport>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.report.get_all_offer_reports().await?;
        Ok(result
            .into_iter()
            .map(|report| models::admin::OfferReport {
                id: report.id,
                offer_id: report.offer_id,
                reporter_user_id: report.reporter_user_id,
                report_content: report.report_content,
                created_at: report.created_at.to_string(),
            })
            .collect())
    }

    async fn get_all_release_reports(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::admin::ReleaseReport>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.report.get_all_release_reports().await?;
        Ok(result
            .into_iter()
            .map(|report| models::admin::ReleaseReport {
                id: report.id,
                release: report.release,
                reporter_user_id: report.reporter_user_id,
                report_content: report.report_content,
                created_at: report.created_at.to_string(),
            })
            .collect())
    }

    async fn get_all_block_data(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::users::BlockUserDataResponse>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.user_blocks.get_all_block_data().await?;
        Ok(result
            .into_iter()
            .map(|block| models::users::BlockUserDataResponse {
                id: block.id,
                blocked_user_id: block.blocked_user_id,
                blocker_user_id: block.blocker_user_id,
                is_solved: block.is_solved,
            })
            .collect())
    }

    async fn search_tracks(
        &self,
        ctx: &Context<'_>,
        input: models::admin::SearchTracksQuery,
    ) -> Result<Vec<models::admin::TrackData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .manage_tracks
            .search_tracks(
                application::usecases::admin::manage_tracks_usecase::SearchTracksInput {
                    isrc: input.isrc,
                    track_title: input.track_title,
                    artist_id: input.artist_id,
                },
            )
            .await?;
        Ok(result
            .into_iter()
            .map(|track| models::admin::TrackData {
                isrc: track.isrc,
                track_title: track.title,
                artist_id: track.artist_id,
                artist_name: track.artist_name_ja,
                product_title: track.product_title,
            })
            .collect())
    }

    async fn search_products(
        &self,
        ctx: &Context<'_>,
        input: models::admin::SearchProductsQuery,
    ) -> Result<Vec<models::admin::ProductData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .manage_tracks
            .search_products(
                application::usecases::admin::manage_tracks_usecase::SearchProductsInput {
                    upc: input.upc,
                    product_title: input.product_title,
                    artist_id: input.artist_id,
                    product_type: input.product_type,
                },
            )
            .await?;
        Ok(result
            .into_iter()
            .map(|product| models::admin::ProductData {
                upc: product.upc,
                title: product.title,
                img_url: product.img_url,
                product_type: product.product_type,
                distributed_at: product.distributed_at.map(|d| d.to_string()),
                artist_id: product.artist_id,
                artist_name_ja: product.artist_name_ja,
                number_of_tracks: product.number_of_tracks,
            })
            .collect())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn error_code(error: &async_graphql::Error) -> Option<String> {
        error.extensions.as_ref().and_then(|extensions| {
            extensions
                .get("code")
                .map(|value| value.to_string().trim_matches('"').to_string())
        })
    }

    #[test]
    fn admin_notification_error_mapping_uses_expected_codes() {
        let bad_input = map_admin_notification_error(DomainError::ValidationError(
            "bad".to_string(),
        ));
        assert_eq!(error_code(&bad_input), Some("BAD_USER_INPUT".to_string()));

        let forbidden = map_admin_notification_error(DomainError::AuthorizationError(
            "forbidden".to_string(),
        ));
        assert_eq!(error_code(&forbidden), Some("FORBIDDEN".to_string()));

        let not_found = map_admin_notification_error(DomainError::NotFound);
        assert_eq!(error_code(&not_found), Some("NOT_FOUND".to_string()));
    }

    #[test]
    fn admin_notification_channels_map_known_database_values() {
        let channels = into_notification_channels(vec![
            "MOBILE_PUSH".to_string(),
            "EMAIL".to_string(),
            "HOME".to_string(),
        ])
        .expect("known channels should map");

        assert_eq!(channels.len(), 3);

        let error = into_notification_channels(vec!["SMS".to_string()])
            .expect_err("unknown channel should be internal error");
        assert_eq!(error_code(&error), Some("INTERNAL_SERVER_ERROR".to_string()));
    }
}
