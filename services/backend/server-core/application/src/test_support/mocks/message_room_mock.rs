use async_trait::async_trait;
use domain::entities::rooms::{ActiveModel as RoomActiveModel, Model as Room};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::rooms_repo::RoomsRepository;

#[automock]
#[async_trait]
pub trait MockRoomsRepo {
    async fn mock_create(&self, room: RoomActiveModel) -> Result<Room, DomainError>;
    async fn mock_delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn mock_update(&self, room: RoomActiveModel) -> Result<Room, DomainError>;
    async fn mock_get_by_id(&self, id: Uuid) -> Result<Option<Room>, DomainError>;
    async fn mock_get_by_ids(&self, ids: Vec<Uuid>) -> Result<Vec<Room>, DomainError>;
}

#[async_trait]
impl RoomsRepository for MockMockRoomsRepo {
    async fn create(&self, room: RoomActiveModel) -> Result<Room, DomainError> {
        self.mock_create(room).await
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn update(&self, room: RoomActiveModel) -> Result<Room, DomainError> {
        self.mock_update(room).await
    }

    async fn get_by_id(&self, id: Uuid) -> Result<Option<Room>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_ids(&self, ids: Vec<Uuid>) -> Result<Vec<Room>, DomainError> {
        self.mock_get_by_ids(ids).await
    }
}
