use crate::entities::room_user::{ActiveModel as RoomUserActiveModel, Model as RoomUser};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait RoomUserRepository: Send + Sync {
    async fn create(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError>;
    async fn create_many(&self, room_users: Vec<RoomUserActiveModel>) -> Result<(), DomainError>;
    async fn update(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_room_id(&self, room_id: Uuid) -> Result<Vec<RoomUser>, DomainError>;
    async fn get_by_room_ids(&self, room_ids: Vec<Uuid>) -> Result<Vec<RoomUser>, DomainError>;
    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<RoomUser>, DomainError>;
    async fn get_by_room_id_and_user_id(
        &self,
        room_id: Uuid,
        user_id: &str,
    ) -> Result<Option<RoomUser>, DomainError>;
    async fn find_by_user_ids(&self, user_ids: &[String]) -> Result<Vec<RoomUser>, DomainError>;
}
