use crate::entities::messages::{ActiveModel as MessageActiveModel, Model as Message};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait MessagesRepository: Send + Sync {
    async fn create(&self, message: MessageActiveModel) -> Result<Message, DomainError>;
    async fn update(&self, message: MessageActiveModel) -> Result<Message, DomainError>;

    async fn get_by_id(&self, id: Uuid) -> Result<Option<Message>, DomainError>;
    async fn get_by_room_id(&self, room_id: Uuid) -> Result<Vec<Message>, DomainError>;
    async fn get_latest_by_room_id(
        &self,
        room_id: Uuid,
        limit: u32,
    ) -> Result<Vec<Message>, DomainError>;
}
