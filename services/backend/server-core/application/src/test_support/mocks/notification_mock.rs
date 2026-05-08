use async_trait::async_trait;
use domain::entities::notifications::{
    ActiveModel as NotificationActiveModel, Model as Notification,
};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::notifications_repo::{
    NotificationListRecord, NotificationsRepository,
};

#[automock]
#[async_trait]
pub trait MockNotificationsRepo {
    async fn mock_create(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError>;

    async fn mock_update(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError>;

    async fn mock_get_by_id(&self, id: i32) -> Result<Option<Notification>, DomainError>;

    async fn mock_get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Notification>, DomainError>;

    async fn mock_get_by_category(&self, category: &str) -> Result<Vec<Notification>, DomainError>;

    async fn mock_list_mobile_push_by_user(
        &self,
        user_id: String,
        limit: u64,
        offset: u64,
    ) -> Result<Vec<NotificationListRecord>, DomainError>;

    async fn mock_count_mobile_push_by_user(&self, user_id: String) -> Result<i64, DomainError>;

    async fn mock_count_unread_mobile_push_by_user(
        &self,
        user_id: String,
    ) -> Result<i64, DomainError>;

    async fn mock_get_mobile_push_notification_user_ids(
        &self,
        user_id: String,
    ) -> Result<Vec<i32>, DomainError>;
}

#[async_trait]
impl NotificationsRepository for MockMockNotificationsRepo {
    async fn create(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError> {
        self.mock_create(notification).await
    }

    async fn update(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError> {
        self.mock_update(notification).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Notification>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Notification>, DomainError> {
        self.mock_get_by_ids(ids).await
    }

    async fn get_by_category(&self, category: &str) -> Result<Vec<Notification>, DomainError> {
        self.mock_get_by_category(category).await
    }

    async fn list_mobile_push_by_user(
        &self,
        user_id: &str,
        limit: u64,
        offset: u64,
    ) -> Result<Vec<NotificationListRecord>, DomainError> {
        self.mock_list_mobile_push_by_user(user_id.to_string(), limit, offset)
            .await
    }

    async fn count_mobile_push_by_user(&self, user_id: &str) -> Result<i64, DomainError> {
        self.mock_count_mobile_push_by_user(user_id.to_string())
            .await
    }

    async fn count_unread_mobile_push_by_user(&self, user_id: &str) -> Result<i64, DomainError> {
        self.mock_count_unread_mobile_push_by_user(user_id.to_string())
            .await
    }

    async fn get_mobile_push_notification_user_ids(
        &self,
        user_id: &str,
    ) -> Result<Vec<i32>, DomainError> {
        self.mock_get_mobile_push_notification_user_ids(user_id.to_string())
            .await
    }
}
