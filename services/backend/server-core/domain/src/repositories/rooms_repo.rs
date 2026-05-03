use crate::entities::rooms::{ActiveModel as RoomActiveModel, Model as Room};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait RoomsRepository: Send + Sync {
    async fn create(&self, room: RoomActiveModel) -> Result<Room, DomainError>;
    async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn update(&self, room: RoomActiveModel) -> Result<Room, DomainError>;

    async fn get_by_id(&self, id: Uuid) -> Result<Option<Room>, DomainError>;
    async fn get_by_ids(&self, ids: Vec<Uuid>) -> Result<Vec<Room>, DomainError>;
}
