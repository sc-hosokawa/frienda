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
        let txn = self.db.begin().await?;
        let res = MessageAttachEntity::insert_many(message_attaches)
            .exec(&txn)
            .await?;

        let created_message_attaches = MessageAttachEntity::find_by_id(res.last_insert_id)
            .all(&txn)
            .await?;
        txn.commit().await?;

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

    async fn get_by_message_ids(
        &self,
        message_ids: Vec<Uuid>,
    ) -> Result<Vec<MessageAttach>, DomainError> {
        let message_attaches = MessageAttachEntity::find()
            .filter(Column::MessageId.is_in(message_ids))
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

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::NaiveDate;
    use domain::repositories::message_attach_repo::MessageAttachRepository;
    use sea_orm::{ActiveValue::Set, DbBackend, MockDatabase, MockExecResult};

    fn created_at() -> chrono::NaiveDateTime {
        NaiveDate::from_ymd_opt(2026, 1, 1)
            .unwrap()
            .and_hms_opt(12, 0, 0)
            .unwrap()
    }

    fn message_id() -> Uuid {
        Uuid::from_u128(1)
    }

    fn model(id: i32) -> MessageAttach {
        MessageAttach {
            id,
            sender: Some("sender".to_string()),
            message_id: Some(message_id()),
            attached_img_url: Some(format!("img-{id}")),
            attached_file_url: None,
            created_at: created_at(),
            deleted_at: None,
        }
    }

    fn active_model(id: i32) -> MessageAttachActiveModel {
        MessageAttachActiveModel {
            id: Set(id),
            sender: Set(Some("sender".to_string())),
            message_id: Set(Some(message_id())),
            attached_img_url: Set(Some(format!("img-{id}"))),
            attached_file_url: Set(None),
            created_at: Set(created_at()),
            deleted_at: Set(None),
        }
    }

    #[tokio::test]
    async fn create_many_wraps_insert_and_select_in_one_transaction() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_exec_results([MockExecResult {
                last_insert_id: 1,
                rows_affected: 2,
            }])
            .append_query_results([[model(1)], [model(1)]])
            .into_connection();
        let repo = MessageAttachRepoImpl::new(db);

        let created = repo
            .create_many(vec![active_model(1), active_model(2)])
            .await
            .unwrap();

        assert_eq!(created, vec![model(1)]);
        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("BEGIN"), "{log}");
        assert!(log.contains("INSERT"), "{log}");
        assert!(log.contains("SELECT"), "{log}");
        assert!(log.contains("COMMIT"), "{log}");
        assert!(!log.contains("ROLLBACK"), "{log}");
    }
}
