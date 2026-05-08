use crate::test_support::mocks::{
    notification_mock::MockMockNotificationsRepo,
    notification_user_mock::MockMockNotificationUserRepo,
    user_mock::MockMockUsersRepo,
};
use crate::usecases::notification::get_notifications_usecase::{
    GetNotificationsUsecase, GetNotificationsUsecaseTrait,
};
use chrono::Utc;
use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use domain::entities::users::Model as User;
use domain::repositories::notifications_repo::NotificationListRecord;
use shared::error::domain_err::DomainError;
use domain::entities::notifications::Model as Notification;
use std::sync::Arc;

fn user(id: &str) -> User {
    let now = Utc::now().naive_utc();
    User {
        id: id.to_string(),
        id_token: None,
        fcm_token: None,
        username: id.to_string(),
        realname: id.to_string(),
        email: format!("{id}@example.com"),
        img_url: None,
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Supporter,
        primary_category: UserCategory::Supporter,
        is_superadmin: None,
        publicity: true,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: None,
        created_at: now,
        updated_at: now,
        last_login_at: None,
    }
}

#[tokio::test]
async fn test_get_notifications_uses_read_state_from_notification_user() {
    let mut notification_user_repo = MockMockNotificationUserRepo::new();
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let users_repo = MockMockUsersRepo::new();

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
        Arc::new(users_repo),
    );

    let result = usecase
        .get_notifications("user-1")
        .await
        .expect("notifications succeed");

    assert_eq!(result.notifications.len(), 2);
    assert!(!result.notifications[0].is_read);
    assert!(result.notifications[1].is_read);
}

#[tokio::test]
async fn test_get_notification_list_returns_pre_mark_state_and_marks_mobile_push_as_read() {
    let created_at = Utc::now().naive_utc();
    let mut users_repo = MockMockUsersRepo::new();
    let mut notification_user_repo = MockMockNotificationUserRepo::new();
    let mut notifications_repo = MockMockNotificationsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|user_id| {
            assert_eq!(user_id, "user-1");
            Ok(Some(user(&user_id)))
        });

    notifications_repo
        .expect_mock_list_mobile_push_by_user()
        .times(1)
        .returning(move |user_id, limit, offset| {
            assert_eq!(user_id, "user-1");
            assert_eq!(limit, 2);
            assert_eq!(offset, 0);
            Ok(vec![
                NotificationListRecord {
                    notification_id: 30,
                    notification_user_id: 300,
                    title: "Newest".to_string(),
                    content: "Unread content".to_string(),
                    is_read: false,
                    created_at,
                },
                NotificationListRecord {
                    notification_id: 20,
                    notification_user_id: 200,
                    title: "Older".to_string(),
                    content: "Read content".to_string(),
                    is_read: true,
                    created_at,
                },
            ])
        });

    notifications_repo
        .expect_mock_count_mobile_push_by_user()
        .times(1)
        .returning(|user_id| {
            assert_eq!(user_id, "user-1");
            Ok(3)
        });

    notifications_repo
        .expect_mock_count_unread_mobile_push_by_user()
        .times(1)
        .returning(|user_id| {
            assert_eq!(user_id, "user-1");
            Ok(2)
        });

    notifications_repo
        .expect_mock_get_mobile_push_notification_user_ids()
        .times(1)
        .returning(|user_id| {
            assert_eq!(user_id, "user-1");
            Ok(vec![300, 200, 100])
        });

    notification_user_repo
        .expect_mock_mark_as_read_by_ids()
        .times(1)
        .returning(|user_id, ids| {
            assert_eq!(user_id, "user-1");
            assert_eq!(ids, vec![300, 200, 100]);
            Ok(2)
        });

    let usecase = GetNotificationsUsecase::new(
        Arc::new(notification_user_repo),
        Arc::new(notifications_repo),
        Arc::new(users_repo),
    );

    let result = usecase
        .get_notification_list("user-1", 2, 0)
        .await
        .expect("notification list succeeds");

    assert_eq!(result.notifications.len(), 2);
    assert_eq!(result.unread_count, 2);
    assert!(result.has_next_page);
    assert_eq!(result.notifications[0].id, 30);
    assert!(!result.notifications[0].is_read);
    assert!(result.notifications[1].is_read);
}

#[tokio::test]
async fn test_get_notification_list_rejects_invalid_pagination_before_repo_access() {
    for (limit, offset) in [(0, 0), (101, 0), (20, -1)] {
        let usecase = GetNotificationsUsecase::new(
            Arc::new(MockMockNotificationUserRepo::new()),
            Arc::new(MockMockNotificationsRepo::new()),
            Arc::new(MockMockUsersRepo::new()),
        );

        let error = usecase
            .get_notification_list("user-1", limit, offset)
            .await
            .expect_err("invalid pagination should fail");

        assert!(matches!(error, DomainError::ValidationError(_)));
    }
}

#[tokio::test]
async fn test_get_notification_list_returns_not_found_when_user_missing() {
    let mut users_repo = MockMockUsersRepo::new();
    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|user_id| {
            assert_eq!(user_id, "missing-user");
            Ok(None)
        });

    let usecase = GetNotificationsUsecase::new(
        Arc::new(MockMockNotificationUserRepo::new()),
        Arc::new(MockMockNotificationsRepo::new()),
        Arc::new(users_repo),
    );

    let error = usecase
        .get_notification_list("missing-user", 20, 0)
        .await
        .expect_err("missing user should fail");

    assert!(matches!(error, DomainError::NotFound));
}
