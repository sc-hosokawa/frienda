use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::Model as Notification;
use domain::repositories::notification_user_repo::NotificationUserRepository;
use domain::repositories::notifications_repo::NotificationsRepository;
use shared::error::domain_err::DomainError;

pub struct GetNotificationsResponse {
    pub notifications: Vec<NotificationResponse>,
}

pub struct NotificationResponse {
    pub id: String,
    pub title: String,
    pub category: Option<String>,
    pub content: String,
    pub is_read: bool,
    pub created_at: String,
}

#[async_trait]
pub trait GetNotificationsUsecaseTrait: Send + Sync {
    async fn get_notifications(
        &self,
        user_id: &str,
    ) -> Result<GetNotificationsResponse, DomainError>;
}

pub struct GetNotificationsUsecase {
    notification_user_repo: Arc<dyn NotificationUserRepository>,
    notifications_repo: Arc<dyn NotificationsRepository>,
}

impl GetNotificationsUsecase {
    pub fn new(
        notification_user_repo: Arc<dyn NotificationUserRepository>,
        notifications_repo: Arc<dyn NotificationsRepository>,
    ) -> Self {
        Self {
            notification_user_repo,
            notifications_repo,
        }
    }
}

#[async_trait]
impl GetNotificationsUsecaseTrait for GetNotificationsUsecase {
    async fn get_notifications(
        &self,
        user_id: &str,
    ) -> Result<GetNotificationsResponse, DomainError> {
        let notification_users: Vec<NotificationUser> =
            self.notification_user_repo.get_by_user_id(user_id).await?;

        let notification_ids: Vec<i32> = notification_users
            .iter()
            .map(|nu| nu.notification_id)
            .collect();

        let notifications: Vec<Notification> =
            self.notifications_repo.get_by_ids(notification_ids).await?;

        let notifications_response: Vec<NotificationResponse> = notifications
            .iter()
            .map(|n| NotificationResponse {
                id: n.id.to_string(),
                title: n.title.clone(),
                category: n.category.clone(),
                content: n.content.clone(),
                is_read: notification_users
                    .iter()
                    .any(|nu| nu.notification_id == n.id),
                created_at: n.created_at.to_string(),
            })
            .collect();

        Ok(GetNotificationsResponse {
            notifications: notifications_response,
        })
    }
}
