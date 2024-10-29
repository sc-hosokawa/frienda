use async_trait::async_trait;
use std::sync::Arc;
use uuid::Uuid;

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
    pub sent_at: chrono::DateTime<chrono::Utc>,
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
}

impl GetMessagesUsecase {
    pub fn new(
        messages_repo: Arc<dyn MessagesRepository>,
        user_repo: Arc<dyn UsersRepository>,
        room_user_repo: Arc<dyn RoomUserRepository>,
    ) -> Self {
        Self {
            messages_repo,
            user_repo,
            room_user_repo,
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
        let messages = self
            .messages_repo
            .get_latest_by_room_id(input.room_id, 10)
            .await?;

        // メッセージをMessageData形式に変換
        let message_list: Vec<MessageData> = messages
            .into_iter()
            .map(|msg| MessageData {
                id: msg.id.to_string(),
                content: msg.message,
                sent_at: msg.created_at.and_utc(),
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
