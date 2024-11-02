use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::room_user::ActiveModel as RoomUserActiveModel;
use domain::repositories::room_user_repo::RoomUserRepository;

//
// Define the input for the usecase
//
pub struct MarkAsReadInput {
    pub message_room_id: Uuid,
    pub user_id: String,
    pub message_id: Uuid,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait MarkAsReadUsecaseTrait: Send + Sync {
    async fn mark_as_read(&self, input: MarkAsReadInput) -> Result<(), anyhow::Error>;
}

//
// Define the implementation for the usecase
//
pub struct MarkAsReadUsecase {
    room_user_repo: Arc<dyn RoomUserRepository>,
}

impl MarkAsReadUsecase {
    pub fn new(room_user_repo: Arc<dyn RoomUserRepository>) -> Self {
        Self { room_user_repo }
    }
}

//
// Implement the usecase
//
#[async_trait]
impl MarkAsReadUsecaseTrait for MarkAsReadUsecase {
    async fn mark_as_read(&self, input: MarkAsReadInput) -> Result<(), anyhow::Error> {
        let room_user = self
            .room_user_repo
            .get_by_room_id_and_user_id(input.message_room_id, &input.user_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Room user not found"))?;

        let mut updated_room_user: RoomUserActiveModel = room_user.into();
        updated_room_user.last_read_message_id = ActiveValue::Set(Some(input.message_id));

        let res = self.room_user_repo.update(updated_room_user).await?;
        tracing::info!("Mark as read: {:?}", res);

        Ok(())
    }
}
