use async_trait::async_trait;
use domain::entities::notifications::{
    ActiveModel as NotificationActiveModel, Model as Notification,
};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::notifications_repo::NotificationsRepository;

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
}
