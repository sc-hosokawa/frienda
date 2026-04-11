use crate::test_support::mocks::{
    notification_mock::MockMockNotificationsRepo,
    notification_user_mock::MockMockNotificationUserRepo,
};
use crate::usecases::notification::store_notification_usecase::{
    StoreNotificationInput, StoreNotificationUsecase, StoreNotificationUsecaseTrait,
};
use chrono::Utc;
use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::Model as Notification;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

#[tokio::test]
async fn test_store_notification_creates_notification_and_notification_user() {
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut notification_user_repo = MockMockNotificationUserRepo::new();

    notifications_repo
        .expect_mock_create()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.title,
                ActiveValue::Set(ref value) if value == "Welcome"
            ));
            assert!(matches!(
                active.content,
                ActiveValue::Set(ref value) if value == "Hello there"
            ));
            Ok(Notification {
                id: 10,
                title: "Welcome".to_string(),
                content: "Hello there".to_string(),
                category: None,
                created_at: Utc::now().naive_utc(),
            })
        });

    notification_user_repo
        .expect_mock_create()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.notification_id,
                ActiveValue::Set(value) if value == 10
            ));
            assert!(matches!(
                active.user,
                ActiveValue::Set(ref value) if value == "user-1"
            ));
            assert!(matches!(active.is_read, ActiveValue::Set(false)));
            assert!(matches!(active.is_deleted, ActiveValue::Set(false)));
            Ok(NotificationUser {
                id: 20,
                notification_id: 10,
                user: "user-1".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    let usecase = StoreNotificationUsecase::new(
        Arc::new(notifications_repo),
        Arc::new(notification_user_repo),
    );

    let result = usecase
        .store_notification(StoreNotificationInput {
            title: "Welcome".to_string(),
            content: "Hello there".to_string(),
            user_id: "user-1".to_string(),
        })
        .await;

    assert!(result.is_ok());
}

#[tokio::test]
async fn test_store_notification_does_not_create_notification_user_when_notification_create_fails()
{
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut notification_user_repo = MockMockNotificationUserRepo::new();

    notifications_repo
        .expect_mock_create()
        .times(1)
        .returning(|_| {
            Err(DomainError::DatabaseError(
                "notification insert failed".to_string(),
            ))
        });
    notification_user_repo.expect_mock_create().times(0);

    let usecase = StoreNotificationUsecase::new(
        Arc::new(notifications_repo),
        Arc::new(notification_user_repo),
    );

    let err = usecase
        .store_notification(StoreNotificationInput {
            title: "Welcome".to_string(),
            content: "Hello there".to_string(),
            user_id: "user-1".to_string(),
        })
        .await
        .unwrap_err();

    assert_eq!(
        err.to_string(),
        "Database error: notification insert failed"
    );
}
