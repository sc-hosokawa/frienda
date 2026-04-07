// services/backend/server-core/application/tests/mocks/messages_mock.rs

use async_trait::async_trait;
use domain::entities::messages::{ActiveModel as MessageActiveModel, Model as Message};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::messages_repo::MessagesRepository;

#[automock]
#[async_trait]
pub trait MockMessagesRepo {
    async fn mock_create(&self, message: MessageActiveModel) -> Result<Message, DomainError>;
    async fn mock_update(&self, message: MessageActiveModel) -> Result<Message, DomainError>;
    async fn mock_get_by_id(&self, id: Uuid) -> Result<Option<Message>, DomainError>;
    async fn mock_get_by_room_id(&self, room_id: Uuid) -> Result<Vec<Message>, DomainError>;
    async fn mock_get_latest_by_room_id(
        &self,
        room_id: Uuid,
        limit: u32,
    ) -> Result<Vec<Message>, DomainError>;
}

#[async_trait]
impl MessagesRepository for MockMockMessagesRepo {
    async fn create(&self, message: MessageActiveModel) -> Result<Message, DomainError> {
        self.mock_create(message).await
    }

    async fn update(&self, message: MessageActiveModel) -> Result<Message, DomainError> {
        self.mock_update(message).await
    }

    async fn get_by_id(&self, id: Uuid) -> Result<Option<Message>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_room_id(&self, room_id: Uuid) -> Result<Vec<Message>, DomainError> {
        self.mock_get_by_room_id(room_id).await
    }

    async fn get_latest_by_room_id(
        &self,
        room_id: Uuid,
        limit: u32,
    ) -> Result<Vec<Message>, DomainError> {
        self.mock_get_latest_by_room_id(room_id, limit).await
    }
}
