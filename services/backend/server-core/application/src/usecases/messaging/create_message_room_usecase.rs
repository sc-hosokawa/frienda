use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::room_user::ActiveModel as RoomUserActiveModel;
use domain::entities::rooms::ActiveModel as RoomActiveModel;
use domain::entities::sea_orm_active_enums::MessageRoomType;
use domain::repositories::room_user_repo::RoomUserRepository;
use domain::repositories::rooms_repo::RoomsRepository;

//
// Define the input for the usecase
//
pub struct CreateMessageRoomInput {
    pub category: MessageRoomType,
    pub created_by: String,     // varchar(28)
    pub user_list: Vec<String>, // varchar(28)[]
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait CreateMessageRoomUsecaseTrait: Send + Sync {
    async fn create(&self, input: CreateMessageRoomInput) -> Result<Uuid, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct CreateMessageRoomUsecase {
    rooms_repo: Arc<dyn RoomsRepository>,
    room_user_repo: Arc<dyn RoomUserRepository>,
}

impl CreateMessageRoomUsecase {
    pub fn new(
        rooms_repo: Arc<dyn RoomsRepository>,
        room_user_repo: Arc<dyn RoomUserRepository>,
    ) -> Self {
        Self {
            rooms_repo,
            room_user_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl CreateMessageRoomUsecaseTrait for CreateMessageRoomUsecase {
    async fn create(&self, input: CreateMessageRoomInput) -> Result<Uuid, anyhow::Error> {
        // Create the room
        let room = RoomActiveModel {
            r#type: ActiveValue::Set(input.category),
            ..Default::default()
        };
        let created_room = self.rooms_repo.create(room).await?;

        // Filter out creator from user_list to avoid duplication
        let unique_users: Vec<String> = input
            .user_list
            .into_iter()
            .filter(|user_id| *user_id != input.created_by)
            .collect();

        // Prepare room users (creator + filtered participants)
        let mut room_users = Vec::with_capacity(unique_users.len() + 1);

        // Add creator and other participants in one loop
        room_users.extend(
            std::iter::once(input.created_by)
                .chain(unique_users)
                .map(|user_id| RoomUserActiveModel {
                    room_id: ActiveValue::Set(created_room.id),
                    user_id: ActiveValue::Set(user_id),
                    ..Default::default()
                }),
        );

        // Create all room users
        self.room_user_repo.create_many(room_users).await?;

        Ok(created_room.id)
    }
}
