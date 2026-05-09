use crate::graphql::{context::AuthenticatedUser, models};
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
        DomainError::AuthorizationError(message) => graphql_error(message, "FORBIDDEN"),
        DomainError::NotFound => graphql_error("User not found", "NOT_FOUND"),
        other => graphql_error(other.to_string(), "INTERNAL_SERVER_ERROR"),
    }
}

fn authorize_notification_list_user(
    authenticated_user: Option<&AuthenticatedUser>,
    requested_user_id: &str,
) -> Result<()> {
    match authenticated_user {
        Some(authenticated_user) if authenticated_user.user_id == requested_user_id => Ok(()),
        _ => Err(graphql_error("Forbidden", "FORBIDDEN")),
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
        authorize_notification_list_user(ctx.data_opt::<AuthenticatedUser>(), &user_id)?;

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

        let forbidden = map_get_notification_list_error(DomainError::AuthorizationError(
            "no permission".to_string(),
        ));
        assert_eq!(error_code(&forbidden), Some("FORBIDDEN".to_string()));
    }

    #[test]
    fn authorize_notification_list_user_requires_matching_authenticated_user() {
        let missing = authorize_notification_list_user(None, "user-1")
            .expect_err("missing authenticated user should be forbidden");
        assert_eq!(error_code(&missing), Some("FORBIDDEN".to_string()));

        let other = AuthenticatedUser {
            user_id: "other-user".to_string(),
        };
        let mismatch = authorize_notification_list_user(Some(&other), "user-1")
            .expect_err("different authenticated user should be forbidden");
        assert_eq!(error_code(&mismatch), Some("FORBIDDEN".to_string()));

        let matched = AuthenticatedUser {
            user_id: "user-1".to_string(),
        };
        authorize_notification_list_user(Some(&matched), "user-1")
            .expect("matching authenticated user should be allowed");
    }
}
