use async_graphql::{InputObject, SimpleObject};

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
