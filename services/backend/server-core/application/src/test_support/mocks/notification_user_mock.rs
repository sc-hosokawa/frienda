use async_trait::async_trait;
use domain::entities::notification_user::{
    ActiveModel as NotificationUserActiveModel, Model as NotificationUser,
};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::notification_user_repo::NotificationUserRepository;

#[automock]
#[async_trait]
pub trait MockNotificationUserRepo {
    async fn mock_create(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError>;

    async fn mock_update(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError>;

    async fn mock_delete(&self, id: i32) -> Result<i32, DomainError>;

    async fn mock_get_by_id(&self, id: i32) -> Result<Option<NotificationUser>, DomainError>;

    async fn mock_get_by_user_id(
        &self,
        user_id: String,
    ) -> Result<Vec<NotificationUser>, DomainError>;

    async fn mock_get_by_user_id_and_status(
        &self,
        user_id: String,
        is_read: bool,
    ) -> Result<Vec<NotificationUser>, DomainError>;

    async fn mock_get_by_notification_id(
        &self,
        notification_id: i32,
    ) -> Result<Vec<NotificationUser>, DomainError>;

    async fn mock_get_by_user_id_and_notification_id(
        &self,
        user_id: String,
        notification_id: i32,
    ) -> Result<Option<NotificationUser>, DomainError>;
}

#[async_trait]
impl NotificationUserRepository for MockMockNotificationUserRepo {
    async fn create(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError> {
        self.mock_create(notification_user).await
    }

    async fn update(
        &self,
        notification_user: NotificationUserActiveModel,
    ) -> Result<NotificationUser, DomainError> {
        self.mock_update(notification_user).await
    }

    async fn delete(&self, id: i32) -> Result<i32, DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<NotificationUser>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<NotificationUser>, DomainError> {
        self.mock_get_by_user_id(user_id.to_string()).await
    }

    async fn get_by_user_id_and_status(
        &self,
        user_id: &str,
        is_read: bool,
    ) -> Result<Vec<NotificationUser>, DomainError> {
        self.mock_get_by_user_id_and_status(user_id.to_string(), is_read)
            .await
    }

    async fn get_by_notification_id(
        &self,
        notification_id: i32,
    ) -> Result<Vec<NotificationUser>, DomainError> {
        self.mock_get_by_notification_id(notification_id).await
    }

    async fn get_by_user_id_and_notification_id(
        &self,
        user_id: &str,
        notification_id: i32,
    ) -> Result<Option<NotificationUser>, DomainError> {
        self.mock_get_by_user_id_and_notification_id(user_id.to_string(), notification_id)
            .await
    }
}
