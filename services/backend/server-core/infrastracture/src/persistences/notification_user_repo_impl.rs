use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Column, Entity as NotificationUserEntity,
    Model as NotificationUser,
};
use domain::repositories::notification_user_repo::NotificationUserRepository;
use shared::error::domain_err::DomainError;

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
        Ok(res.rows_affected as i32)
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
}
