use crate::graphql::models;
use async_graphql::{Context, Error, ErrorExtensions, Object, Result};
use registry::Usecases;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

#[derive(Default)]
pub struct NotificationQuery;

fn graphql_error(message: impl Into<String>, code: &'static str) -> Error {
    Error::new(message).extend_with(|_, extensions| {
        extensions.set("code", code);
    })
}

fn map_get_notification_list_error(error: DomainError) -> Error {
    match error {
        DomainError::ValidationError(message) | DomainError::InvalidParameter(message) => {
            graphql_error(message, "BAD_USER_INPUT")
        }
        DomainError::NotFound => graphql_error("User not found", "NOT_FOUND"),
        other => graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR"),
    }
}

#[Object]
impl NotificationQuery {
    async fn get_notification_list(
        &self,
        ctx: &Context<'_>,
        user_id: String,
        #[graphql(default = 20)] limit: i32,
        #[graphql(default = 0)] offset: i32,
    ) -> Result<models::notifications::NotificationListData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_notifications
            .get_notification_list(&user_id, limit, offset)
            .await
            .map_err(map_get_notification_list_error)?;

        Ok(models::notifications::NotificationListData {
            notifications: result
                .notifications
                .into_iter()
                .map(|notification| models::notifications::NotificationListItem {
                    id: notification.id,
                    title: notification.title,
                    content: notification.content,
                    is_read: notification.is_read,
                    created_at: notification.created_at,
                })
                .collect(),
            unread_count: result.unread_count,
            has_next_page: result.has_next_page,
        })
    }

    async fn get_notifications(
        &self,
        ctx: &Context<'_>,
        count: i32,
        offset: i32,
    ) -> Result<models::notifications::NotificationsData> {
        let _ = (ctx, count, offset);
        todo!()
    }
    async fn get_all_notifications(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::notifications::NotificationsData> {
        let _ = ctx;
        todo!()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use shared::error::domain_err::DomainError;

    fn error_code(error: &async_graphql::Error) -> Option<String> {
        error.extensions.as_ref().and_then(|extensions| {
            extensions
                .get("code")
                .map(|value| value.to_string().trim_matches('"').to_string())
        })
    }

    #[test]
    fn map_get_notification_list_error_maps_bad_user_input_and_not_found_codes() {
        let bad_input =
            map_get_notification_list_error(DomainError::ValidationError("bad".to_string()));
        assert_eq!(error_code(&bad_input), Some("BAD_USER_INPUT".to_string()));

        let missing = map_get_notification_list_error(DomainError::NotFound);
        assert_eq!(error_code(&missing), Some("NOT_FOUND".to_string()));
    }
}
