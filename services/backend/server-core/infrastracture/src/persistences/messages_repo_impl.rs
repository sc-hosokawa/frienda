use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::messages::{
    ActiveModel as MessageActiveModel, Column, Entity as MessageEntity, Model as Message,
};
use domain::repositories::messages_repo::MessagesRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct MessagesRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl MessagesRepository for MessagesRepoImpl {
    async fn create(&self, message: MessageActiveModel) -> Result<Message, DomainError> {
        let res: InsertResult<MessageActiveModel> =
            MessageEntity::insert(message).exec(&self.db).await?;

        let created_message: Option<Message> = MessageEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(created_message.unwrap())
    }

    async fn update(&self, message: MessageActiveModel) -> Result<Message, DomainError> {
        let updated_message: Message = message.update(&self.db).await?;
        Ok(updated_message)
    }

    async fn get_by_id(&self, id: Uuid) -> Result<Option<Message>, DomainError> {
        let message = MessageEntity::find_by_id(id).one(&self.db).await?;
        Ok(message)
    }

    async fn get_by_room_id(&self, room_id: Uuid) -> Result<Vec<Message>, DomainError> {
        let messages = MessageEntity::find()
            .filter(Column::RoomId.eq(room_id))
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;
        Ok(messages)
    }

    async fn get_latest_by_room_id(
        &self,
        room_id: Uuid,
        limit: u32,
    ) -> Result<Vec<Message>, DomainError> {
        let messages = MessageEntity::find()
            .filter(Column::RoomId.eq(room_id))
            .order_by_desc(Column::CreatedAt)
            .limit(limit as u64)
            .all(&self.db)
            .await?;
        Ok(messages)
    }
}
