use async_trait::async_trait;
use std::sync::Arc;
use uuid::Uuid;

use domain::repositories::message_attach_repo::MessageAttachRepository;
use domain::repositories::messages_repo::MessagesRepository;
use domain::repositories::room_user_repo::RoomUserRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct GetMessagesInput {
    pub user_id: String,
    pub room_id: Uuid,
}
pub struct GetMessagesOutput {
    pub id: String,
    pub user: SimpleUser,
    pub message_list: Vec<MessageData>,
}
pub struct MessageData {
    pub id: String,
    pub content: String,
    pub sent_by: String,
    pub sent_at: chrono::DateTime<chrono::Utc>,
    pub attached_file_url: Option<String>,
    pub attached_img_url: Option<String>,
}
pub struct SimpleUser {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetMessagesUsecaseTrait: Send + Sync {
    async fn get_messages_on_dm(
        &self,
        input: GetMessagesInput,
    ) -> Result<GetMessagesOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetMessagesUsecase {
    messages_repo: Arc<dyn MessagesRepository>,
    user_repo: Arc<dyn UsersRepository>,
    room_user_repo: Arc<dyn RoomUserRepository>,
    message_attach_repo: Arc<dyn MessageAttachRepository>,
}

impl GetMessagesUsecase {
    pub fn new(
        messages_repo: Arc<dyn MessagesRepository>,
        user_repo: Arc<dyn UsersRepository>,
        room_user_repo: Arc<dyn RoomUserRepository>,
        message_attach_repo: Arc<dyn MessageAttachRepository>,
    ) -> Self {
        Self {
            messages_repo,
            user_repo,
            room_user_repo,
            message_attach_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetMessagesUsecaseTrait for GetMessagesUsecase {
    async fn get_messages_on_dm(
        &self,
        input: GetMessagesInput,
    ) -> Result<GetMessagesOutput, anyhow::Error> {
        // 最新の10件のメッセージを取得
        let messages: Vec<domain::entities::messages::Model> = self
            .messages_repo
            .get_latest_by_room_id(input.room_id, 100)
            .await?;

        // メッセージに紐づく添付ファイルを取得
        let message_attaches: Vec<domain::entities::message_attach::Model> = self
            .message_attach_repo
            .get_by_message_ids(messages.iter().map(|m| m.id).collect())
            .await?;

        // メッセージをMessageData形式に変換
        let message_list: Vec<MessageData> = messages
            .into_iter()
            .map(|msg| MessageData {
                id: msg.id.to_string(),
                content: msg.message,
                sent_by: msg.send_by,
                sent_at: msg.created_at.and_utc(),
                attached_file_url: message_attaches
                    .iter()
                    .find(|ma| ma.message_id == Some(msg.id) && ma.attached_file_url.is_some())
                    .map(|ma| ma.attached_file_url.clone().unwrap_or_default()),
                attached_img_url: message_attaches
                    .iter()
                    .find(|ma| ma.message_id == Some(msg.id) && ma.attached_img_url.is_some())
                    .map(|ma| ma.attached_img_url.clone().unwrap_or_default()),
            })
            .collect();

        // ルーム情報を取得
        let rooms: Vec<domain::entities::room_user::Model> =
            self.room_user_repo.get_by_room_id(input.room_id).await?;

        // 相手のユーザー情報を取得
        let other_user_room = rooms
            .into_iter()
            .find(|room| room.user_id != input.user_id)
            .ok_or_else(|| anyhow::anyhow!("Other user not found in the room"))?;

        let other_user = self
            .user_repo
            .find_by_id(&other_user_room.user_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Other user not found"))?;

        Ok(GetMessagesOutput {
            id: input.room_id.to_string(),
            user: SimpleUser {
                id: other_user.id.to_string(),
                name: other_user.username,
                image_url: other_user.img_url,
            },
            message_list,
        })
    }
}

#[cfg(test)]
#[path = "get_messages_usecase_tests.rs"]
mod tests;
