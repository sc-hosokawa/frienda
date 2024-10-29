use async_trait::async_trait;
use futures::stream::{self, StreamExt, TryStreamExt};
use std::sync::Arc;

use domain::entities::room_user::Model as RoomUser;
use domain::entities::sea_orm_active_enums::MessageRoomType;
use domain::repositories::room_user_repo::RoomUserRepository;
use domain::repositories::rooms_repo::RoomsRepository;

//
// Define the input for the usecase
//
pub struct GetRoomListInput {
    pub user_id: String,
}

pub struct GetRoomListOutput {
    pub rooms: Vec<RoomData>,
    pub count_of_messages_rooms: i32,
}

#[derive(Clone)]
pub struct RoomData {
    pub id: String, // uuid
    pub category: Option<MessageRoomType>,
    pub latest_message: Option<String>,
    pub latest_sent_at: Option<chrono::DateTime<chrono::Utc>>, // datetime
    pub is_read: bool,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetRoomListUsecaseTrait: Send + Sync {
    async fn get_room_list(
        &self,
        input: GetRoomListInput,
    ) -> Result<GetRoomListOutput, anyhow::Error>;
    async fn get_active_rooms(&self, user_id: String) -> Result<GetRoomListOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetRoomListUsecase {
    room_user_repo: Arc<dyn RoomUserRepository>,
    rooms_repo: Arc<dyn RoomsRepository>,
}

impl GetRoomListUsecase {
    pub fn new(
        room_user_repo: Arc<dyn RoomUserRepository>,
        rooms_repo: Arc<dyn RoomsRepository>,
    ) -> Self {
        Self {
            room_user_repo,
            rooms_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetRoomListUsecaseTrait for GetRoomListUsecase {
    async fn get_room_list(
        &self,
        input: GetRoomListInput,
    ) -> Result<GetRoomListOutput, anyhow::Error> {
        // ユーザーが参加しているルーム一覧を取得
        let rooms: Vec<RoomUser> = self.room_user_repo.get_by_user_id(&input.user_id).await?;

        let room_data: Vec<RoomData> = stream::iter(rooms)
            .map(|room| async move {
                let room_id = room.room_id;
                let room_info = self
                    .rooms_repo
                    .get_by_id(room_id)
                    .await?
                    .ok_or_else(|| anyhow::anyhow!("Room not found"))?;

                // RoomDataを構築
                Ok::<RoomData, anyhow::Error>(RoomData {
                    id: room_id.to_string(),
                    category: Some(room_info.r#type),
                    latest_message: room_info.latest_message,
                    latest_sent_at: room_info.latest_sent_at.map(|dt| dt.and_utc()),
                    is_read: match (room.last_read_message_id, room_info.latest_message_id) {
                        (None, None) => true,     // 両方メッセージIDがない場合は既読
                        (None, Some(_)) => false, // 未読メッセージがある場合は未読
                        (Some(last_read), Some(latest)) => last_read == latest, // 両方ある場合は比較
                        (Some(_), None) => true, // 最新メッセージがない場合は既読
                    },
                })
            })
            .buffer_unordered(10)
            .try_collect()
            .await?;

        let count_of_messages_rooms: i32 = room_data.len() as i32;

        Ok(GetRoomListOutput {
            rooms: room_data,
            count_of_messages_rooms,
        })
    }
    async fn get_active_rooms(&self, user_id: String) -> Result<GetRoomListOutput, anyhow::Error> {
        let rooms: Vec<RoomUser> = self.room_user_repo.get_by_user_id(&user_id).await?;
        println!("rooms: {:?}", rooms);

        // 各ルームの最新メッセージと未読状態を取得
        let mut room_data: Vec<RoomData> = stream::iter(rooms)
            .map(|room| async move {
                let room_id = room.room_id;
                let room_info = self
                    .rooms_repo
                    .get_by_id(room_id)
                    .await?
                    .ok_or_else(|| anyhow::anyhow!("Room not found"))?;

                let is_read = match (room.last_read_message_id, room_info.latest_message_id) {
                    (None, None) => true,     // 両方メッセージIDがない場合は既読
                    (None, Some(_)) => false, // 未読メッセージがある場合は未読
                    (Some(last_read), Some(latest)) => last_read == latest, // 両方ある場合は比較
                    (Some(_), None) => true,  // 最新メッセージがない場合は既読
                };

                Ok::<RoomData, anyhow::Error>(RoomData {
                    id: room_id.to_string(),
                    category: Some(room_info.r#type),
                    latest_message: room_info.latest_message,
                    latest_sent_at: room_info.latest_sent_at.map(|dt| dt.and_utc()),
                    is_read,
                })
            })
            .buffer_unordered(10)
            .try_collect::<Vec<RoomData>>()
            .await?;

        // 未読メッセージを優先し、その後に最新のメッセージで並べ替え
        room_data.sort_by(|a, b| {
            (!a.is_read, a.latest_sent_at)
                .cmp(&(!b.is_read, b.latest_sent_at))
                .reverse()
        });

        // 最大5件に制限
        room_data.truncate(5);

        let count_of_messages_rooms = room_data.len() as i32;

        Ok(GetRoomListOutput {
            rooms: room_data,
            count_of_messages_rooms,
        })
    }
}
