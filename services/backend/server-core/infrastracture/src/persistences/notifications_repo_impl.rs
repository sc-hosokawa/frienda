use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::notifications::{
    ActiveModel as NotificationActiveModel, Column, Entity as NotificationEntity,
    Model as Notification,
};
use domain::repositories::notifications_repo::NotificationsRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct NotificationsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl NotificationsRepository for NotificationsRepoImpl {
    async fn create(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError> {
        let res = NotificationEntity::insert(notification)
            .exec(&self.db)
            .await?;

        let inserted_notification = NotificationEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_notification.unwrap())
    }

    async fn update(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError> {
        let updated_notification: Notification = notification.update(&self.db).await?;
        Ok(updated_notification)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Notification>, DomainError> {
        let notification = NotificationEntity::find_by_id(id).one(&self.db).await?;
        Ok(notification)
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Notification>, DomainError> {
        let notifications = NotificationEntity::find()
            .filter(Column::Id.is_in(ids))
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;
        Ok(notifications)
    }
}
