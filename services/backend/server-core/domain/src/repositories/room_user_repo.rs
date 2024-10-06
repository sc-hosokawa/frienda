use crate::entities::room_user::{ActiveModel as RoomUserActiveModel, Model as RoomUser};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait RoomUserRepository {
    async fn create(&self, room_user: &RoomUserActiveModel) -> Result<RoomUser, DomainError>;
    async fn update(&self, room_user: &RoomUserActiveModel) -> Result<RoomUser, DomainError>;
}
