use crate::graphql::models::users::*;
use anyhow::Error;
use application::usecases::messaging::{create_message_room_usecase, send_message_usecase};
use async_graphql::{InputObject, SimpleObject};
use uuid::Uuid;

use domain::entities::sea_orm_active_enums::MessageRoomType;

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

#[derive(SimpleObject)]
pub struct MessageTempData {
    pub id: String,
    pub content: String,
    pub sent_by: String,
    pub sent_at: String,
    pub attached_file: Option<String>,
    pub attached_img: Option<String>,
}

// メッセージルーム本体データ
#[derive(SimpleObject)]
pub struct MessagesByRoomIdByUserData {
    pub id: String,
    pub to: UserSimpleData, // メッセージルームの相手ユーザー
    pub message_list: Vec<MessageTempData>,
}

// メッセージルームのメッセージ一覧データ
#[derive(SimpleObject)]
pub struct MessageRoomData {
    pub id: String, // uuid
    pub category: Option<String>,
    pub latest_message: Option<String>,
    pub latest_message_id: Option<String>,
    pub latest_sent_at: Option<String>, // datetime
    pub is_read: bool,                  // falseの場合は未読
    pub users: Vec<UserSimpleData>,
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
    pub created_by: String,     // varchar(28)
    pub user_list: Vec<String>, // varchar(28)[]
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
    pub message: String,
    pub sent_at: String,
    pub attached_file: Option<Vec<String>>,
    pub attached_img: Option<Vec<String>>,
}

#[derive(InputObject)]
pub struct MarkAsReadInput {
    pub room_id: String,    // uuid
    pub user_id: String,    // varchar(28)
    pub message_id: String, // uuid
}

#[derive(SimpleObject)]
pub struct MarkAsReadResponse {
    pub is_success: bool,
}

// ===== Convert to usecase input =====
impl SendMessageInput {
    pub fn into_usecase_input(self) -> Result<send_message_usecase::SendMessageInput, Error> {
        Ok(send_message_usecase::SendMessageInput {
            room_id: Uuid::parse_str(&self.room_id)?,
            sent_by: self.sent_by,
            message: self.message,
            attached_file: self.attached_file,
            attached_img: self.attached_img,
        })
    }
}

impl CreateNewMessageRoomInput {
    pub fn into_usecase_input(
        self,
    ) -> Result<create_message_room_usecase::CreateMessageRoomInput, Error> {
        Ok(create_message_room_usecase::CreateMessageRoomInput {
            category: from_string_to_message_room_type(&self.category).map_err(Error::msg)?,
            created_by: self.created_by,
            user_list: self.user_list,
        })
    }
}

pub fn from_string_to_message_room_type(s: &str) -> Result<MessageRoomType, String> {
    match s {
        "dm" => Ok(MessageRoomType::Dm),
        "group" => Ok(MessageRoomType::Group),
        _ => Err(format!("Invalid MessageRoomType: {}", s)),
    }
}

// ===== Convert from usecase output =====
impl From<application::usecases::messaging::get_room_list_usecase::RoomData> for MessageRoomData {
    fn from(room: application::usecases::messaging::get_room_list_usecase::RoomData) -> Self {
        MessageRoomData {
            id: room.id,
            category: room.category.map(|c| match c {
                MessageRoomType::Dm => "dm".to_string(),
                MessageRoomType::Group => "group".to_string(),
            }),
            latest_message: room.latest_message,
            latest_message_id: room.latest_message_id.map(|id| id.to_string()),
            latest_sent_at: room.latest_sent_at.map(|dt| dt.to_rfc3339()),
            is_read: room.is_read,
            users: room.users.into_iter().map(|u| u.into()).collect(),
        }
    }
}

impl From<application::usecases::messaging::get_messages_usecase::GetMessagesOutput>
    for MessagesByRoomIdByUserData
{
    fn from(
        message: application::usecases::messaging::get_messages_usecase::GetMessagesOutput,
    ) -> Self {
        MessagesByRoomIdByUserData {
            id: message.id,
            to: message.user.into(),
            message_list: message.message_list.into_iter().map(|m| m.into()).collect(),
        }
    }
}
impl From<application::usecases::messaging::get_messages_usecase::SimpleUser> for UserSimpleData {
    fn from(user: application::usecases::messaging::get_messages_usecase::SimpleUser) -> Self {
        UserSimpleData {
            id: user.id,
            name: user.name,
            image_url: user.image_url,
        }
    }
}

impl From<application::usecases::messaging::get_room_list_usecase::SimpleUser> for UserSimpleData {
    fn from(user: application::usecases::messaging::get_room_list_usecase::SimpleUser) -> Self {
        UserSimpleData {
            id: user.id,
            name: user.name,
            image_url: user.image_url,
        }
    }
}

impl From<application::usecases::messaging::get_messages_usecase::MessageData> for MessageTempData {
    fn from(message: application::usecases::messaging::get_messages_usecase::MessageData) -> Self {
        MessageTempData {
            id: message.id,
            content: message.content,
            sent_by: message.sent_by,
            sent_at: message.sent_at.to_rfc3339(),
            attached_file: message.attached_file_url,
            attached_img: message.attached_img_url,
        }
    }
}
