use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Column, Entity as NotificationUserEntity,
    Model as NotificationUser,
};
use domain::repositories::notification_user_repo::NotificationUserRepository;
use shared::error::domain_err::DomainError;
use shared::numeric::checked_u64_to_i32;

#[derive(new)]
pub struct NotificationUserRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl NotificationUserRepository for NotificationUserRepoImpl {
    async fn create(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError> {
        let res = NotificationUserEntity::insert(notification_user)
            .exec(&self.db)
            .await?;

        let inserted_notification_user = NotificationUserEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_notification_user.unwrap())
    }

    async fn update(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError> {
        let updated_notification_user: NotificationUser =
            notification_user.update(&self.db).await?;
        Ok(updated_notification_user)
    }

    async fn delete(&self, id: i32) -> Result<i32, DomainError> {
        let res = NotificationUserEntity::delete_by_id(id)
            .exec(&self.db)
            .await?;
        checked_u64_to_i32(res.rows_affected, "deleted_notification_users")
            .map_err(DomainError::UnexpectedError)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<NotificationUser>, DomainError> {
        let notification_user = NotificationUserEntity::find_by_id(id).one(&self.db).await?;
        Ok(notification_user)
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<NotificationUser>, DomainError> {
        let notification_users = NotificationUserEntity::find()
            .filter(Column::User.eq(user_id))
            .all(&self.db)
            .await?;
        Ok(notification_users)
    }

    async fn get_by_user_id_and_status(
        &self,
        user_id: &str,
        is_read: bool,
    ) -> Result<Vec<NotificationUser>, DomainError> {
        let notification_users = NotificationUserEntity::find()
            .filter(Column::User.eq(user_id))
            .filter(Column::IsRead.eq(is_read))
            .all(&self.db)
            .await?;
        Ok(notification_users)
    }

    async fn get_by_notification_id(
        &self,
        notification_id: i32,
    ) -> Result<Vec<NotificationUser>, DomainError> {
        let notification_users = NotificationUserEntity::find()
            .filter(Column::NotificationId.eq(notification_id))
            .all(&self.db)
            .await?;
        Ok(notification_users)
    }

    async fn get_by_user_id_and_notification_id(
        &self,
        user_id: &str,
        notification_id: i32,
    ) -> Result<Option<NotificationUser>, DomainError> {
        let notification_user = NotificationUserEntity::find()
            .filter(Column::User.eq(user_id))
            .filter(Column::NotificationId.eq(notification_id))
            .one(&self.db)
            .await?;
        Ok(notification_user)
    }

    async fn mark_as_read_by_ids(
        &self,
        user_id: &str,
        notification_user_ids: Vec<i32>,
    ) -> Result<i32, DomainError> {
        if notification_user_ids.is_empty() {
            return Ok(0);
        }

        let res = NotificationUserEntity::update_many()
            .col_expr(Column::IsRead, sea_orm::sea_query::Expr::value(true))
            .filter(Column::User.eq(user_id))
            .filter(Column::Id.is_in(notification_user_ids))
            .filter(Column::IsDeleted.eq(false))
            .filter(Column::IsRead.eq(false))
            .exec(&self.db)
            .await?;

        checked_u64_to_i32(res.rows_affected, "marked_notification_users")
            .map_err(DomainError::UnexpectedError)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::notification_user_repo::NotificationUserRepository;
    use sea_orm::{DbBackend, MockDatabase, MockExecResult};

    #[tokio::test]
    async fn mark_as_read_by_ids_updates_only_target_users_undeleted_unread_rows() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_exec_results([MockExecResult {
                last_insert_id: 0,
                rows_affected: 2,
            }])
            .into_connection();
        let repo = NotificationUserRepoImpl::new(db);

        let updated = repo
            .mark_as_read_by_ids("user-1", vec![10, 20, 30])
            .await
            .expect("bulk mark read succeeds");

        assert_eq!(updated, 2);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("UPDATE"), "{log}");
        assert!(log.contains("notification_user"), "{log}");
        assert!(log.contains("is_read"), "{log}");
        assert!(log.contains("user-1"), "{log}");
        assert!(log.contains("is_deleted"), "{log}");
        assert!(log.contains(" IN "), "{log}");
        assert!(log.contains("10"), "{log}");
        assert!(log.contains("20"), "{log}");
        assert!(log.contains("30"), "{log}");
    }
}
