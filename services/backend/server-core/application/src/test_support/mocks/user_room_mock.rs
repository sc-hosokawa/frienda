use async_trait::async_trait;
use domain::entities::room_user::{ActiveModel as RoomUserActiveModel, Model as RoomUser};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::room_user_repo::RoomUserRepository;

#[automock]
#[async_trait]
pub trait MockRoomUserRepo {
    async fn mock_create(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError>;
    async fn mock_create_many(
        &self,
        room_users: Vec<RoomUserActiveModel>,
    ) -> Result<(), DomainError>;
    async fn mock_update(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_by_room_id(&self, room_id: Uuid) -> Result<Vec<RoomUser>, DomainError>;
    async fn mock_get_by_room_ids(&self, room_ids: Vec<Uuid>)
        -> Result<Vec<RoomUser>, DomainError>;
    async fn mock_get_by_user_id(&self, user_id: String) -> Result<Vec<RoomUser>, DomainError>;
    async fn mock_get_by_room_id_and_user_id(
        &self,
        room_id: Uuid,
        user_id: String,
    ) -> Result<Option<RoomUser>, DomainError>;
    async fn mock_find_by_user_ids(
        &self,
        user_ids: Vec<String>,
    ) -> Result<Vec<RoomUser>, DomainError>;
}

#[async_trait]
impl RoomUserRepository for MockMockRoomUserRepo {
    async fn create(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError> {
        self.mock_create(room_user).await
    }

    async fn create_many(&self, room_users: Vec<RoomUserActiveModel>) -> Result<(), DomainError> {
        self.mock_create_many(room_users).await
    }

    async fn update(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError> {
        self.mock_update(room_user).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_room_id(&self, room_id: Uuid) -> Result<Vec<RoomUser>, DomainError> {
        self.mock_get_by_room_id(room_id).await
    }

    async fn get_by_room_ids(&self, room_ids: Vec<Uuid>) -> Result<Vec<RoomUser>, DomainError> {
        self.mock_get_by_room_ids(room_ids).await
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<RoomUser>, DomainError> {
        self.mock_get_by_user_id(user_id.to_string()).await
    }

    async fn get_by_room_id_and_user_id(
        &self,
        room_id: Uuid,
        user_id: &str,
    ) -> Result<Option<RoomUser>, DomainError> {
        self.mock_get_by_room_id_and_user_id(room_id, user_id.to_string())
            .await
    }

    async fn find_by_user_ids(&self, user_ids: &[String]) -> Result<Vec<RoomUser>, DomainError> {
        self.mock_find_by_user_ids(user_ids.to_vec()).await
    }
}
