use crate::test_support::mocks::notification_user_mock::MockMockNotificationUserRepo;
use crate::usecases::notification::mark_notification_as_read_usecase::{
    MarkNotificationAsReadUsecase, MarkNotificationAsReadUsecaseTrait,
};
use domain::entities::notification_user::Model as NotificationUser;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

#[tokio::test]
async fn test_mark_notification_as_read_updates_existing_record() {
    let mut notification_user_repo = MockMockNotificationUserRepo::new();

    notification_user_repo
        .expect_mock_get_by_user_id_and_notification_id()
        .times(1)
        .returning(|user_id, notification_id| {
            assert_eq!(user_id, "user-1");
            assert_eq!(notification_id, 10);
            Ok(Some(NotificationUser {
                id: 5,
                notification_id,
                user: user_id,
                is_read: false,
                is_deleted: false,
            }))
        });

    notification_user_repo
        .expect_mock_update()
        .times(1)
        .returning(|active| {
            assert!(matches!(active.id, ActiveValue::Set(5)));
            assert!(matches!(active.is_read, ActiveValue::Set(true)));
            Ok(NotificationUser {
                id: 5,
                notification_id: 10,
                user: "user-1".to_string(),
                is_read: true,
                is_deleted: false,
            })
        });

    let usecase = MarkNotificationAsReadUsecase::new(Arc::new(notification_user_repo));
    let id = usecase
        .mark_notification_as_read(10, "user-1")
        .await
        .expect("mark read succeeds");

    assert_eq!(id, 5);
}

#[tokio::test]
async fn test_mark_notification_as_read_returns_not_found_when_missing() {
    let mut notification_user_repo = MockMockNotificationUserRepo::new();
    notification_user_repo
        .expect_mock_get_by_user_id_and_notification_id()
        .times(1)
        .returning(|_, _| Ok(None));

    let usecase = MarkNotificationAsReadUsecase::new(Arc::new(notification_user_repo));
    let error = usecase
        .mark_notification_as_read(10, "user-1")
        .await
        .expect_err("missing notification user should fail");

    assert!(matches!(error, DomainError::NotFound));
}
