use async_graphql::{InputObject, SimpleObject};

// ===== Query =====

#[derive(SimpleObject)]
pub struct NotificationsData {
    pub id: String,
    pub title: String,
    pub content: String,
    pub created_at: String,
    pub updated_at: String,
}

// ===== Mutation =====

#[derive(InputObject)]
pub struct CreateNewNotificationInput {
    pub title: String,
    pub content: String,
}

#[derive(InputObject)]
pub struct UpdateNotificationInput {
    pub id: String,
    pub title: String,
    pub content: String,
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
