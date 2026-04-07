use async_trait::async_trait;
use domain::entities::message_attach::{
    ActiveModel as MessageAttachActiveModel, Model as MessageAttach,
};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::message_attach_repo::MessageAttachRepository;

#[automock]
#[async_trait]
pub trait MockMessageAttachRepo {
    async fn mock_create(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError>;
    async fn mock_update(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError>;
    async fn mock_create_many(
        &self,
        message_attaches: Vec<MessageAttachActiveModel>,
    ) -> Result<Vec<MessageAttach>, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<MessageAttach>, DomainError>;
    async fn mock_get_by_message_id(
        &self,
        message_id: Uuid,
    ) -> Result<Vec<MessageAttach>, DomainError>;
    async fn mock_get_by_message_ids(
        &self,
        message_ids: Vec<Uuid>,
    ) -> Result<Vec<MessageAttach>, DomainError>;
    async fn mock_get_by_sender_id(
        &self,
        sender_id: String,
    ) -> Result<Vec<MessageAttach>, DomainError>;
    async fn mock_get_by_sender_and_message_id(
        &self,
        sender_id: String,
        message_id: Uuid,
    ) -> Result<Option<MessageAttach>, DomainError>;
}

#[async_trait]
impl MessageAttachRepository for MockMockMessageAttachRepo {
    async fn create(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError> {
        self.mock_create(message_attach).await
    }

    async fn update(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError> {
        self.mock_update(message_attach).await
    }

    async fn create_many(
        &self,
        message_attaches: Vec<MessageAttachActiveModel>,
    ) -> Result<Vec<MessageAttach>, DomainError> {
        self.mock_create_many(message_attaches).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<MessageAttach>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_message_id(&self, message_id: Uuid) -> Result<Vec<MessageAttach>, DomainError> {
        self.mock_get_by_message_id(message_id).await
    }

    async fn get_by_message_ids(
        &self,
        message_ids: Vec<Uuid>,
    ) -> Result<Vec<MessageAttach>, DomainError> {
        self.mock_get_by_message_ids(message_ids).await
    }

    async fn get_by_sender_id(&self, sender_id: &str) -> Result<Vec<MessageAttach>, DomainError> {
        self.mock_get_by_sender_id(sender_id.to_string()).await
    }

    async fn get_by_sender_and_message_id(
        &self,
        sender_id: &str,
        message_id: Uuid,
    ) -> Result<Option<MessageAttach>, DomainError> {
        self.mock_get_by_sender_and_message_id(sender_id.to_string(), message_id)
            .await
    }
}
