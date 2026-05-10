use crate::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Model as NotificationUser,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait NotificationUserRepository: Send + Sync {
    async fn create(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError>;
    async fn update(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError>;

    async fn delete(&self, id: i32) -> Result<i32, DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<NotificationUser>, DomainError>;
    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<NotificationUser>, DomainError>;
    async fn get_by_user_id_and_status(
        &self,
        user_id: &str,
        is_read: bool,
    ) -> Result<Vec<NotificationUser>, DomainError>;
    async fn get_by_notification_id(
        &self,
        notification_id: i32,
    ) -> Result<Vec<NotificationUser>, DomainError>;
    async fn get_by_user_id_and_notification_id(
        &self,
        user_id: &str,
        notification_id: i32,
    ) -> Result<Option<NotificationUser>, DomainError>;
    async fn mark_as_read_by_ids(
        &self,
        user_id: &str,
        notification_user_ids: Vec<i32>,
    ) -> Result<i32, DomainError>;
}
