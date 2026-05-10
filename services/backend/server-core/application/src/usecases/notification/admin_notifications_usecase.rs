use async_trait::async_trait;
use chrono::{FixedOffset, NaiveDateTime, TimeZone};
use std::sync::Arc;

use domain::repositories::notifications_repo::{
    AdminNotificationDetailRecord, AdminNotificationListRecord,
    AdminNotificationRecipientRecord, NotificationsRepository,
};
use domain::repositories::users_repo::UsersRepository;
use shared::error::domain_err::DomainError;
use shared::numeric::checked_i64_to_i32;

#[derive(Debug)]
pub struct AdminNotificationListResponse {
    pub notifications: Vec<AdminNotificationListItemResponse>,
    pub total_count: i32,
    pub has_next_page: bool,
}

#[derive(Debug)]
pub struct AdminNotificationListItemResponse {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub category: Option<String>,
    pub channels: Vec<String>,
    pub recipient_count: i32,
    pub created_at: String,
}

#[derive(Debug)]
pub struct AdminNotificationRecipientResponse {
    pub user_id: String,
    pub username: String,
    pub email: String,
    pub mobile_push_is_read: Option<bool>,
    pub mobile_push_is_deleted: Option<bool>,
}

#[derive(Debug)]
pub struct AdminNotificationDetailResponse {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub category: Option<String>,
    pub channels: Vec<String>,
    pub recipients: Vec<AdminNotificationRecipientResponse>,
    pub created_at: String,
}

#[async_trait]
pub trait AdminNotificationsUsecaseTrait: Send + Sync {
    async fn get_admin_notification_list(
        &self,
        authenticated_user_id: &str,
        limit: i32,
        offset: i32,
    ) -> Result<AdminNotificationListResponse, DomainError>;

    async fn get_admin_notification_detail(
        &self,
        authenticated_user_id: &str,
        notification_id: i32,
    ) -> Result<AdminNotificationDetailResponse, DomainError>;
}

pub struct AdminNotificationsUsecase {
    notifications_repo: Arc<dyn NotificationsRepository>,
    users_repo: Arc<dyn UsersRepository>,
}

impl AdminNotificationsUsecase {
    pub fn new(
        notifications_repo: Arc<dyn NotificationsRepository>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            notifications_repo,
            users_repo,
        }
    }

    async fn authorize_admin(&self, authenticated_user_id: &str) -> Result<(), DomainError> {
        match self.users_repo.find_by_id(authenticated_user_id).await? {
            Some(user) if user.is_superadmin.unwrap_or(false) => Ok(()),
            _ => Err(DomainError::AuthorizationError("Forbidden".to_string())),
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

fn format_jst_rfc3339(created_at: NaiveDateTime) -> String {
    let jst = FixedOffset::east_opt(9 * 60 * 60).expect("JST offset should be valid");
    jst.from_local_datetime(&created_at)
        .single()
        .expect("fixed offset should map local datetime unambiguously")
        .to_rfc3339()
}

fn into_list_item(
    record: AdminNotificationListRecord,
) -> Result<AdminNotificationListItemResponse, DomainError> {
    Ok(AdminNotificationListItemResponse {
        id: record.id,
        title: record.title,
        content: record.content,
        category: record.category,
        channels: record.channels,
        recipient_count: checked_i64_to_i32(record.recipient_count, "recipient_count")
            .map_err(DomainError::UnexpectedError)?,
        created_at: format_jst_rfc3339(record.created_at),
    })
}

fn into_recipient(
    record: AdminNotificationRecipientRecord,
) -> AdminNotificationRecipientResponse {
    AdminNotificationRecipientResponse {
        user_id: record.user_id,
        username: record.username,
        email: record.email,
        mobile_push_is_read: record.mobile_push_is_read,
        mobile_push_is_deleted: record.mobile_push_is_deleted,
    }
}

fn into_detail(
    record: AdminNotificationDetailRecord,
) -> AdminNotificationDetailResponse {
    AdminNotificationDetailResponse {
        id: record.id,
        title: record.title,
        content: record.content,
        category: record.category,
        channels: record.channels,
        recipients: record.recipients.into_iter().map(into_recipient).collect(),
        created_at: format_jst_rfc3339(record.created_at),
    }
}

#[async_trait]
impl AdminNotificationsUsecaseTrait for AdminNotificationsUsecase {
    async fn get_admin_notification_list(
        &self,
        authenticated_user_id: &str,
        limit: i32,
        offset: i32,
    ) -> Result<AdminNotificationListResponse, DomainError> {
        self.authorize_admin(authenticated_user_id).await?;
        let (limit, offset) = validate_pagination(limit, offset)?;

        let notifications = self
            .notifications_repo
            .list_admin_notifications(limit, offset)
            .await?;
        let total_count = self.notifications_repo.count_admin_notifications().await?;
        let has_next_page = total_count > offset as i64 + notifications.len() as i64;

        Ok(AdminNotificationListResponse {
            notifications: notifications
                .into_iter()
                .map(into_list_item)
                .collect::<Result<Vec<_>, _>>()?,
            total_count: checked_i64_to_i32(total_count, "admin_notifications_total_count")
                .map_err(DomainError::UnexpectedError)?,
            has_next_page,
        })
    }

    async fn get_admin_notification_detail(
        &self,
        authenticated_user_id: &str,
        notification_id: i32,
    ) -> Result<AdminNotificationDetailResponse, DomainError> {
        self.authorize_admin(authenticated_user_id).await?;

        let detail = self
            .notifications_repo
            .get_admin_notification_detail(notification_id)
            .await?
            .ok_or(DomainError::NotFound)?;

        Ok(into_detail(detail))
    }
}

#[cfg(test)]
#[path = "admin_notifications_usecase_tests.rs"]
mod tests;
