use async_graphql::{InputObject, SimpleObject};

// ===== for query =====
#[derive(SimpleObject)]
pub struct MessageData {
    pub id: String,
    pub title: String,
    pub content: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(SimpleObject)]
pub struct MessagesByMessageRoomIdData {
    pub id: String,
    pub title: String,
    pub content: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: メッセージルーム内のメッセージの配列を取得する

// ===== for mutation =====

#[derive(InputObject)]
pub struct CreateNewMessageRoomInput {
    pub title: String,
    pub content: String,
}

#[derive(SimpleObject)]
pub struct CreateNewMessageRoomResponse {
    pub id: String,
}

#[derive(InputObject)]
pub struct SendMessageInput {
    pub title: String,
    pub content: String,
}

#[derive(SimpleObject)]
pub struct SendMessageResponse {
    pub id: String,
}
