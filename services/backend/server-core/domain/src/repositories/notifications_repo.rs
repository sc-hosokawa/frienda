use crate::entities::notifications::{
    ActiveModel as NotificationActiveModel, Model as Notification,
};
use async_trait::async_trait;
use sea_orm::entity::prelude::DateTime;
use shared::error::domain_err::DomainError;

#[derive(Clone, Debug, PartialEq)]
pub struct NotificationListRecord {
    pub notification_id: i32,
    pub notification_user_id: i32,
    pub title: String,
    pub content: String,
    pub is_read: bool,
    pub created_at: DateTime,
}

#[derive(Clone, Debug, PartialEq)]
pub struct AdminNotificationListRecord {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub category: Option<String>,
    pub channels: Vec<String>,
    pub recipient_count: i64,
    pub created_at: DateTime,
}

#[derive(Clone, Debug, PartialEq)]
pub struct AdminNotificationRecipientRecord {
    pub user_id: String,
    pub username: String,
    pub email: String,
    pub mobile_push_is_read: Option<bool>,
    pub mobile_push_is_deleted: Option<bool>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct AdminNotificationDetailRecord {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub category: Option<String>,
    pub channels: Vec<String>,
    pub recipients: Vec<AdminNotificationRecipientRecord>,
    pub created_at: DateTime,
}

#[async_trait]
pub trait NotificationsRepository: Send + Sync {
    async fn create(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError>;
    async fn update(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError>;

    async fn get_by_id(&self, id: i32) -> Result<Option<Notification>, DomainError>;
    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Notification>, DomainError>;
    async fn get_by_category(&self, category: &str) -> Result<Vec<Notification>, DomainError>;
    async fn list_mobile_push_by_user(
        &self,
        user_id: &str,
        limit: u64,
        offset: u64,
    ) -> Result<Vec<NotificationListRecord>, DomainError>;
    async fn count_mobile_push_by_user(&self, user_id: &str) -> Result<i64, DomainError>;
    async fn count_unread_mobile_push_by_user(&self, user_id: &str) -> Result<i64, DomainError>;
    async fn get_mobile_push_notification_user_ids(
        &self,
        user_id: &str,
    ) -> Result<Vec<i32>, DomainError>;
    async fn list_admin_notifications(
        &self,
        limit: u64,
        offset: u64,
    ) -> Result<Vec<AdminNotificationListRecord>, DomainError>;
    async fn count_admin_notifications(&self) -> Result<i64, DomainError>;
    async fn get_admin_notification_detail(
        &self,
        notification_id: i32,
    ) -> Result<Option<AdminNotificationDetailRecord>, DomainError>;
}
