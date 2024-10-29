use crate::entities::notifications::{
    ActiveModel as NotificationActiveModel, Model as Notification,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait NotificationsRepository {
    async fn create(
        &self,
        notification: &NotificationActiveModel,
    ) -> Result<Notification, DomainError>;
    async fn update(
        &self,
        notification: &NotificationActiveModel,
    ) -> Result<Notification, DomainError>;

    async fn get_by_id(&self, id: i32) -> Result<Option<Notification>, DomainError>;
}
