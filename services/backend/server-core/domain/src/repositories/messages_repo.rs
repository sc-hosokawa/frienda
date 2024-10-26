use crate::entities::messages::{ActiveModel as MessageActiveModel, Model as Message};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait MessagesRepository {
    async fn create(&self, message: &MessageActiveModel) -> Result<Message, DomainError>;
    async fn update(&self, message: &MessageActiveModel) -> Result<Message, DomainError>;

    async fn get_by_id(&self, id: &Uuid) -> Result<Option<Message>, DomainError>;
}
