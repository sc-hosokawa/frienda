use crate::entities::message_attach::{
    ActiveModel as MessageAttachActiveModel, Model as MessageAttach,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait MessageAttachRepository: Send + Sync {
    async fn create(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError>;
    async fn update(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError>;
    async fn create_many(
        &self,
        message_attaches: Vec<MessageAttachActiveModel>,
    ) -> Result<Vec<MessageAttach>, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<MessageAttach>, DomainError>;
    async fn get_by_message_id(&self, message_id: Uuid) -> Result<Vec<MessageAttach>, DomainError>;
    async fn get_by_message_ids(
        &self,
        message_ids: Vec<Uuid>,
    ) -> Result<Vec<MessageAttach>, DomainError>;
    async fn get_by_sender_id(&self, sender_id: &str) -> Result<Vec<MessageAttach>, DomainError>;
    async fn get_by_sender_and_message_id(
        &self,
        sender_id: &str,
        message_id: Uuid,
    ) -> Result<Option<MessageAttach>, DomainError>;
}
