use async_graphql::{Enum, InputObject, SimpleObject};

// ===== Query =====

#[derive(SimpleObject)]
pub struct NotificationData {
    pub id: String,
    pub title: String,
    pub category: Option<String>,
    pub content: String,
    pub is_read: bool,
    pub created_at: String,
}

#[derive(SimpleObject)]
pub struct NotificationsData {
    pub notifications: Vec<NotificationData>,
}

#[derive(SimpleObject)]
pub struct NotificationListItem {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub is_read: bool,
    pub created_at: String,
}

#[derive(SimpleObject)]
pub struct NotificationListData {
    pub notifications: Vec<NotificationListItem>,
    pub unread_count: i32,
    pub has_next_page: bool,
}

#[derive(Enum, Copy, Clone, Debug, Eq, PartialEq)]
pub enum NotificationChannel {
    #[graphql(name = "MOBILE_PUSH")]
    MobilePush,
    #[graphql(name = "EMAIL")]
    Email,
    #[graphql(name = "HOME")]
    Home,
}

impl TryFrom<&str> for NotificationChannel {
    type Error = String;

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        match value {
            "MOBILE_PUSH" => Ok(Self::MobilePush),
            "EMAIL" => Ok(Self::Email),
            "HOME" => Ok(Self::Home),
            other => Err(format!("unknown notification channel: {other}")),
        }
    }
}

#[derive(SimpleObject)]
pub struct AdminNotificationListItem {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub category: Option<String>,
    pub channels: Vec<NotificationChannel>,
    pub recipient_count: i32,
    pub created_at: String,
}

#[derive(SimpleObject)]
pub struct AdminNotificationListData {
    pub notifications: Vec<AdminNotificationListItem>,
    pub total_count: i32,
    pub has_next_page: bool,
}

#[derive(SimpleObject)]
pub struct AdminNotificationRecipient {
    pub user_id: String,
    pub username: String,
    pub email: String,
    pub mobile_push_is_read: Option<bool>,
    pub mobile_push_is_deleted: Option<bool>,
}

#[derive(SimpleObject)]
pub struct AdminNotificationDetail {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub category: Option<String>,
    pub channels: Vec<NotificationChannel>,
    pub recipients: Vec<AdminNotificationRecipient>,
    pub created_at: String,
}

// ===== Mutation =====
#[derive(InputObject)]
pub struct CreateNewNotificationInput {
    pub title: String,
    pub content: String,
    pub target: Option<String>,
    pub user_id: Option<String>,
}

#[derive(InputObject)]
pub struct UpdateNotificationInput {
    pub id: String,
    pub title: Option<String>,
    pub content: Option<String>,
}

#[derive(InputObject)]
pub struct DeleteNotificationInput {
    pub id: String,
}

#[derive(SimpleObject)]
pub struct CreateNewNotificationResponse {
    pub id: String,
}

#[derive(SimpleObject)]
pub struct UpdateNotificationResponse {
    pub id: String,
}

#[derive(SimpleObject)]
pub struct DeleteNotificationResponse {
    pub id: String,
}
