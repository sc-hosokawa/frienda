use crate::entities::rooms::{ActiveModel as RoomActiveModel, Model as Room};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait RoomsRepository {
    async fn create(&self, room: &RoomActiveModel) -> Result<Room, DomainError>;
    async fn update(&self, room: &RoomActiveModel) -> Result<Room, DomainError>;
}
