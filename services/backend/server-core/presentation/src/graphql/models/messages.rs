use crate::graphql::models::users::*;
use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====
#[derive(SimpleObject)]
pub struct MessageData {
    pub id: String, // uuid
    pub send_by: UserSimpleData,
    pub message: String,
    pub created_at: String,
    pub attached_file: Option<Vec<String>>, // ファイルのURL
    pub attached_img: Option<Vec<String>>,  // 画像のURL
}

// メッセージルーム本体データ
#[derive(SimpleObject)]
pub struct MessagesByRoomIdByUserData {
    pub id: String,
    pub to: UserSimpleData, // メッセージルームの相手ユーザー
    pub message_list: Vec<MessageData>,
}

// メッセージルームのメッセージ一覧データ
#[derive(SimpleObject)]
pub struct MessageRoomData {
    pub id: String, // uuid
    pub count_of_messages: Option<i32>,
    pub category: Option<String>,
    pub latest_message: Option<MessageData>,
    pub latest_sent_at: Option<String>, // datetime
    pub is_read: bool,                  // falseの場合は未読
}

// ユーザーが参加しているメッセージルーム一覧データ
#[derive(SimpleObject)]
pub struct MessageRoomsByUserData {
    pub message_room_list: Vec<MessageRoomData>,
    pub count_of_message_rooms: i32,
}

// ===== for Mutation =====
#[derive(InputObject)]
pub struct CreateNewMessageRoomInput {
    pub category: String,
}

#[derive(SimpleObject)]
pub struct CreateNewMessageRoomResponse {
    pub id: String, // uuid
}

#[derive(InputObject)]
pub struct SendMessageInput {
    pub room_id: String, // uuid
    pub sent_by: String, // varchar(28)
    pub message: String,
    pub attached_file: Option<Vec<String>>,
    pub attached_img: Option<Vec<String>>,
}

#[derive(SimpleObject)]
pub struct SendMessageResponse {
    pub id: String, // uuid
}
