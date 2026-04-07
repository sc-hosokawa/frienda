use crate::test_support::mocks::{
    notification_mock::MockMockNotificationsRepo,
    notification_user_mock::MockMockNotificationUserRepo,
};
use crate::usecases::notification::get_notifications_usecase::{
    GetNotificationsUsecase, GetNotificationsUsecaseTrait,
};
use chrono::Utc;
use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::Model as Notification;
use std::sync::Arc;

#[tokio::test]
async fn test_get_notifications_uses_read_state_from_notification_user() {
    let mut notification_user_repo = MockMockNotificationUserRepo::new();
    let mut notifications_repo = MockMockNotificationsRepo::new();

    notification_user_repo
        .expect_mock_get_by_user_id()
        .times(1)
        .returning(|_| {
            Ok(vec![
                NotificationUser {
                    id: 1,
                    notification_id: 10,
                    user: "user-1".to_string(),
                    is_read: false,
                    is_deleted: false,
                },
                NotificationUser {
                    id: 2,
                    notification_id: 20,
                    user: "user-1".to_string(),
                    is_read: true,
                    is_deleted: false,
                },
            ])
        });

    notifications_repo
        .expect_mock_get_by_ids()
        .times(1)
        .returning(|ids| {
            assert_eq!(ids, vec![10, 20]);
            Ok(vec![
                Notification {
                    id: 10,
                    title: "Unread".to_string(),
                    content: "content".to_string(),
                    category: Some("message".to_string()),
                    created_at: Utc::now().naive_utc(),
                },
                Notification {
                    id: 20,
                    title: "Read".to_string(),
                    content: "content".to_string(),
                    category: Some("message".to_string()),
                    created_at: Utc::now().naive_utc(),
                },
            ])
        });

    let usecase = GetNotificationsUsecase::new(
        Arc::new(notification_user_repo),
        Arc::new(notifications_repo),
    );

    let result = usecase
        .get_notifications("user-1")
        .await
        .expect("notifications succeed");

    assert_eq!(result.notifications.len(), 2);
    assert!(!result.notifications[0].is_read);
    assert!(result.notifications[1].is_read);
}
