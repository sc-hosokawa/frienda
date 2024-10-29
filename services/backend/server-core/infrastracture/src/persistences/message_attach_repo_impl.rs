use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::message_attach::{
    ActiveModel as MessageAttachActiveModel, Column, Entity as MessageAttachEntity,
    Model as MessageAttach,
};
use domain::repositories::message_attach_repo::MessageAttachRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct MessageAttachRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl MessageAttachRepository for MessageAttachRepoImpl {
    async fn create(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError> {
        let res: InsertResult<MessageAttachActiveModel> =
            MessageAttachEntity::insert(message_attach)
                .exec(&self.db)
                .await?;

        let created_message_attach: Option<MessageAttach> =
            MessageAttachEntity::find_by_id(res.last_insert_id)
                .one(&self.db)
                .await?;

        Ok(created_message_attach.unwrap())
    }

    async fn update(
        &self,
        message_attach: MessageAttachActiveModel,
    ) -> Result<MessageAttach, DomainError> {
        let updated_message_attach: MessageAttach = message_attach.update(&self.db).await?;
        Ok(updated_message_attach)
    }

    async fn create_many(
        &self,
        message_attaches: Vec<MessageAttachActiveModel>,
    ) -> Result<Vec<MessageAttach>, DomainError> {
        let res = MessageAttachEntity::insert_many(message_attaches)
            .exec(&self.db)
            .await?;

        let created_message_attaches = MessageAttachEntity::find_by_id(res.last_insert_id)
            .all(&self.db)
            .await?;

        Ok(created_message_attaches)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res: DeleteResult = MessageAttachEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<MessageAttach>, DomainError> {
        let message_attach = MessageAttachEntity::find_by_id(id).one(&self.db).await?;
        Ok(message_attach)
    }

    async fn get_by_message_id(&self, message_id: Uuid) -> Result<Vec<MessageAttach>, DomainError> {
        let message_attaches = MessageAttachEntity::find()
            .filter(Column::MessageId.eq(message_id))
            .all(&self.db)
            .await?;
        Ok(message_attaches)
    }

    async fn get_by_sender_id(&self, sender_id: &str) -> Result<Vec<MessageAttach>, DomainError> {
        let message_attaches = MessageAttachEntity::find()
            .filter(Column::Sender.eq(sender_id))
            .all(&self.db)
            .await?;
        Ok(message_attaches)
    }

    async fn get_by_sender_and_message_id(
        &self,
        sender_id: &str,
        message_id: Uuid,
    ) -> Result<Option<MessageAttach>, DomainError> {
        let message_attach = MessageAttachEntity::find()
            .filter(Column::Sender.eq(sender_id))
            .filter(Column::MessageId.eq(message_id))
            .one(&self.db)
            .await?;
        Ok(message_attach)
    }
}
