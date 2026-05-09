use async_trait::async_trait;
use chrono::{FixedOffset, NaiveDateTime, TimeZone};
use std::sync::Arc;

use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::Model as Notification;
use domain::repositories::notification_user_repo::NotificationUserRepository;
use domain::repositories::notifications_repo::{NotificationListRecord, NotificationsRepository};
use domain::repositories::users_repo::UsersRepository;
use shared::error::domain_err::DomainError;
use shared::numeric::checked_i64_to_i32;

pub struct GetNotificationsResponse {
    pub notifications: Vec<NotificationResponse>,
}

pub struct NotificationResponse {
    pub id: String,
    pub title: String,
    pub category: Option<String>,
    pub content: String,
    pub is_read: bool,
    pub created_at: String,
}

#[derive(Debug)]
pub struct GetNotificationListResponse {
    pub notifications: Vec<NotificationListItemResponse>,
    pub unread_count: i32,
    pub has_next_page: bool,
}

#[derive(Debug)]
pub struct NotificationListItemResponse {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub is_read: bool,
    pub created_at: String,
}

#[async_trait]
pub trait GetNotificationsUsecaseTrait: Send + Sync {
    async fn get_notifications(
        &self,
        user_id: &str,
    ) -> Result<GetNotificationsResponse, DomainError>;
    async fn get_notification_list(
        &self,
        user_id: &str,
        limit: i32,
        offset: i32,
    ) -> Result<GetNotificationListResponse, DomainError>;
}

pub struct GetNotificationsUsecase {
    notification_user_repo: Arc<dyn NotificationUserRepository>,
    notifications_repo: Arc<dyn NotificationsRepository>,
    users_repo: Arc<dyn UsersRepository>,
}

impl GetNotificationsUsecase {
    pub fn new(
        notification_user_repo: Arc<dyn NotificationUserRepository>,
        notifications_repo: Arc<dyn NotificationsRepository>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            notification_user_repo,
            notifications_repo,
            users_repo,
        }
    }
}

fn validate_pagination(limit: i32, offset: i32) -> Result<(u64, u64), DomainError> {
    if !(1..=100).contains(&limit) {
        return Err(DomainError::ValidationError(
            "limit must be between 1 and 100".to_string(),
        ));
    }

    if offset < 0 {
        return Err(DomainError::ValidationError(
            "offset must be greater than or equal to 0".to_string(),
        ));
    }

    Ok((limit as u64, offset as u64))
}

fn into_notification_list_item(record: NotificationListRecord) -> NotificationListItemResponse {
    NotificationListItemResponse {
        id: record.notification_id,
        title: record.title,
        content: record.content,
        is_read: record.is_read,
        created_at: format_jst_rfc3339(record.created_at),
    }
}

fn format_jst_rfc3339(created_at: NaiveDateTime) -> String {
    let jst = FixedOffset::east_opt(9 * 60 * 60).expect("JST offset should be valid");
    jst.from_local_datetime(&created_at)
        .single()
        .expect("fixed offset should map local datetime unambiguously")
        .to_rfc3339()
}

#[async_trait]
impl GetNotificationsUsecaseTrait for GetNotificationsUsecase {
    async fn get_notifications(
        &self,
        user_id: &str,
    ) -> Result<GetNotificationsResponse, DomainError> {
        let notification_users: Vec<NotificationUser> =
            self.notification_user_repo.get_by_user_id(user_id).await?;

        let notification_ids: Vec<i32> = notification_users
            .iter()
            .map(|nu| nu.notification_id)
            .collect();

        let notifications: Vec<Notification> =
            self.notifications_repo.get_by_ids(notification_ids).await?;

        let notifications_response: Vec<NotificationResponse> = notifications
            .iter()
            .map(|n| NotificationResponse {
                id: n.id.to_string(),
                title: n.title.clone(),
                category: n.category.clone(),
                content: n.content.clone(),
                is_read: notification_users
                    .iter()
                    .find(|nu| nu.notification_id == n.id)
                    .map(|nu| nu.is_read)
                    .unwrap_or(false),
                created_at: n.created_at.to_string(),
            })
            .collect();

        Ok(GetNotificationsResponse {
            notifications: notifications_response,
        })
    }

    async fn get_notification_list(
        &self,
        user_id: &str,
        limit: i32,
        offset: i32,
    ) -> Result<GetNotificationListResponse, DomainError> {
        let (limit, offset) = validate_pagination(limit, offset)?;

        if self.users_repo.find_by_id(user_id).await?.is_none() {
            return Err(DomainError::NotFound);
        }

        let notifications = self
            .notifications_repo
            .list_mobile_push_by_user(user_id, limit, offset)
            .await?;
        let total_count = self
            .notifications_repo
            .count_mobile_push_by_user(user_id)
            .await?;
        let unread_count = self
            .notifications_repo
            .count_unread_mobile_push_by_user(user_id)
            .await?;

        let has_next_page = total_count > offset as i64 + notifications.len() as i64;
        let notification_user_ids = self
            .notifications_repo
            .get_mobile_push_notification_user_ids(user_id)
            .await?;

        if !notification_user_ids.is_empty() {
            self.notification_user_repo
                .mark_as_read_by_ids(user_id, notification_user_ids)
                .await?;
        }

        Ok(GetNotificationListResponse {
            notifications: notifications
                .into_iter()
                .map(into_notification_list_item)
                .collect(),
            unread_count: checked_i64_to_i32(unread_count, "unread_notifications_count")
                .map_err(DomainError::UnexpectedError)?,
            has_next_page,
        })
    }
}

#[cfg(test)]
#[path = "get_notifications_usecase_tests.rs"]
mod tests;
