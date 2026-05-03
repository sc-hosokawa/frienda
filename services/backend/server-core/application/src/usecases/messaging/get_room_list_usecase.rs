use async_trait::async_trait;
use std::{
    collections::{HashMap, HashSet},
    sync::Arc,
};
use uuid::Uuid;

use domain::entities::room_user::Model as RoomUser;
use domain::entities::rooms::Model as Room;
use domain::entities::sea_orm_active_enums::MessageRoomType;
use domain::entities::users::Model as User;
use domain::repositories::room_user_repo::RoomUserRepository;
use domain::repositories::rooms_repo::RoomsRepository;
use domain::repositories::users_repo::UsersRepository;
use shared::numeric::checked_usize_to_i32;

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
    pub users: Vec<SimpleUser>,
    pub latest_message_id: Option<Uuid>,
    pub latest_message: Option<String>,
    pub latest_sent_at: Option<chrono::DateTime<chrono::Utc>>, // datetime
    pub is_read: bool,
}

#[derive(Clone)]
pub struct SimpleUser {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
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
    users_repo: Arc<dyn UsersRepository>,
}

impl GetRoomListUsecase {
    pub fn new(
        room_user_repo: Arc<dyn RoomUserRepository>,
        rooms_repo: Arc<dyn RoomsRepository>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            room_user_repo,
            rooms_repo,
            users_repo,
        }
    }

    fn room_count_to_i32(value: usize) -> Result<i32, anyhow::Error> {
        checked_usize_to_i32(value, "count_of_messages_rooms").map_err(anyhow::Error::msg)
    }

    async fn build_room_data(
        &self,
        user_rooms: Vec<RoomUser>,
        viewer_user_id: &str,
    ) -> Result<Vec<RoomData>, anyhow::Error> {
        if user_rooms.is_empty() {
            return Ok(vec![]);
        }

        let room_ids: Vec<Uuid> = user_rooms.iter().map(|room| room.room_id).collect();
        let rooms_by_id: HashMap<Uuid, Room> = self
            .rooms_repo
            .get_by_ids(room_ids.clone())
            .await?
            .into_iter()
            .map(|room| (room.id, room))
            .collect();

        let room_users = self.room_user_repo.get_by_room_ids(room_ids).await?;
        let mut seen_counter_party_user_ids = HashSet::new();
        let counter_party_user_ids: Vec<String> = room_users
            .iter()
            .filter(|room_user| room_user.user_id != viewer_user_id)
            .map(|room_user| room_user.user_id.clone())
            .filter(|user_id| seen_counter_party_user_ids.insert(user_id.clone()))
            .collect();
        let users_by_id: HashMap<String, User> = if counter_party_user_ids.is_empty() {
            HashMap::new()
        } else {
            self.users_repo
                .find_by_ids(counter_party_user_ids.iter().map(String::as_str).collect())
                .await?
                .into_iter()
                .map(|user| (user.id.clone(), user))
                .collect()
        };

        let mut room_users_by_room_id: HashMap<Uuid, Vec<RoomUser>> = HashMap::new();
        for room_user in room_users {
            room_users_by_room_id
                .entry(room_user.room_id)
                .or_default()
                .push(room_user);
        }

        user_rooms
            .into_iter()
            .map(|room| {
                let room_id = room.room_id;
                let room_info = rooms_by_id
                    .get(&room_id)
                    .ok_or_else(|| anyhow::anyhow!("Room not found"))?;
                let users = room_users_by_room_id
                    .get(&room_id)
                    .map(|room_users| {
                        room_users
                            .iter()
                            .filter(|room_user| room_user.user_id != viewer_user_id)
                            .map(|room_user| {
                                let user_data = users_by_id
                                    .get(&room_user.user_id)
                                    .ok_or_else(|| anyhow::anyhow!("User not found"))?;
                                Ok::<SimpleUser, anyhow::Error>(SimpleUser {
                                    id: user_data.id.clone(),
                                    name: user_data.username.clone(),
                                    image_url: user_data.img_url.clone(),
                                })
                            })
                            .collect::<Result<Vec<SimpleUser>, anyhow::Error>>()
                    })
                    .transpose()?
                    .unwrap_or_default();

                Ok(RoomData {
                    id: room_id.to_string(),
                    category: Some(room_info.r#type.clone()),
                    latest_message: room_info.latest_message.clone(),
                    latest_message_id: room_info.latest_message_id,
                    latest_sent_at: room_info.latest_sent_at.map(|dt| dt.and_utc()),
                    is_read: match (room.last_read_message_id, room_info.latest_message_id) {
                        (None, None) => true,
                        (None, Some(_)) => false,
                        (Some(last_read), Some(latest)) => last_read == latest,
                        (Some(_), None) => true,
                    },
                    users,
                })
            })
            .collect()
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
        let rooms: Vec<RoomUser> = self.room_user_repo.get_by_user_id(&input.user_id).await?;
        let room_data = self.build_room_data(rooms, &input.user_id).await?;

        let count_of_messages_rooms: i32 = Self::room_count_to_i32(room_data.len())?;

        Ok(GetRoomListOutput {
            rooms: room_data,
            count_of_messages_rooms,
        })
    }
    async fn get_active_rooms(&self, user_id: String) -> Result<GetRoomListOutput, anyhow::Error> {
        let rooms: Vec<RoomUser> = self.room_user_repo.get_by_user_id(&user_id).await?;
        let mut room_data = self.build_room_data(rooms, &user_id).await?;

        // 未読メッセージを優先し、その後に最新のメッセージで並べ替え
        room_data.sort_by(|a, b| {
            (!a.is_read, a.latest_sent_at)
                .cmp(&(!b.is_read, b.latest_sent_at))
                .reverse()
        });

        // 最大5件に制限
        room_data.truncate(5);

        let count_of_messages_rooms = Self::room_count_to_i32(room_data.len())?;

        Ok(GetRoomListOutput {
            rooms: room_data,
            count_of_messages_rooms,
        })
    }
}

#[cfg(test)]
#[path = "get_room_list_usecase_tests.rs"]
mod tests;
