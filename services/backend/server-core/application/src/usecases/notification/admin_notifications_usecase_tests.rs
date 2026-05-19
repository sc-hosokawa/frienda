use crate::test_support::mocks::{
    notification_mock::MockMockNotificationsRepo, user_mock::MockMockUsersRepo,
};
use crate::usecases::notification::admin_notifications_usecase::{
    AdminNotificationsUsecase, AdminNotificationsUsecaseTrait,
};
use chrono::{NaiveDate, Utc};
use domain::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use domain::entities::users::Model as User;
use domain::repositories::notifications_repo::{
    AdminNotificationDetailRecord, AdminNotificationListRecord,
    AdminNotificationRecipientRecord,
};
use shared::error::domain_err::DomainError;
use std::sync::Arc;

fn user(id: &str, is_superadmin: Option<bool>) -> User {
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
        is_superadmin,
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

fn created_at() -> chrono::NaiveDateTime {
    NaiveDate::from_ymd_opt(2026, 1, 5)
        .expect("date")
        .and_hms_opt(10, 0, 0)
        .expect("time")
}

#[tokio::test]
async fn get_admin_notification_list_requires_superadmin() {
    let notifications_repo = MockMockNotificationsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| {
            assert_eq!(id, "regular-user");
            Ok(Some(user(&id, Some(false))))
        });

    let usecase =
        AdminNotificationsUsecase::new(Arc::new(notifications_repo), Arc::new(users_repo));

    let error = usecase
        .get_admin_notification_list("regular-user", 20, 0)
        .await
        .expect_err("regular user should be forbidden");

    assert!(matches!(error, DomainError::AuthorizationError(_)));
}

#[tokio::test]
async fn get_admin_notification_list_returns_paginated_admin_data() {
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, Some(true)))));

    notifications_repo
        .expect_mock_list_admin_notifications()
        .times(1)
        .returning(|limit, offset| {
            assert_eq!(limit, 2);
            assert_eq!(offset, 1);
            Ok(vec![AdminNotificationListRecord {
                id: 10,
                title: "Notice".to_string(),
                content: "Content".to_string(),
                category: Some("admin".to_string()),
                channels: vec!["MOBILE_PUSH".to_string(), "EMAIL".to_string()],
                recipient_count: 3,
                created_at: created_at(),
            }])
        });

    notifications_repo
        .expect_mock_count_admin_notifications()
        .times(1)
        .returning(|| Ok(4));

    let usecase =
        AdminNotificationsUsecase::new(Arc::new(notifications_repo), Arc::new(users_repo));

    let result = usecase
        .get_admin_notification_list("admin-user", 2, 1)
        .await
        .expect("admin list should succeed");

    assert_eq!(result.total_count, 4);
    assert!(result.has_next_page);
    assert_eq!(result.notifications[0].id, 10);
    assert_eq!(result.notifications[0].recipient_count, 3);
    assert_eq!(
        result.notifications[0].created_at,
        "2026-01-05T10:00:00+09:00"
    );
}

#[tokio::test]
async fn get_admin_notification_list_rejects_invalid_pagination_after_auth() {
    let notifications_repo = MockMockNotificationsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, Some(true)))));

    let usecase =
        AdminNotificationsUsecase::new(Arc::new(notifications_repo), Arc::new(users_repo));

    let error = usecase
        .get_admin_notification_list("admin-user", 0, 0)
        .await
        .expect_err("invalid limit should fail");

    assert!(matches!(error, DomainError::ValidationError(_)));
}

#[tokio::test]
async fn get_admin_notification_detail_returns_recipients_and_mobile_push_state() {
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, Some(true)))));

    notifications_repo
        .expect_mock_get_admin_notification_detail()
        .times(1)
        .returning(|notification_id| {
            assert_eq!(notification_id, 10);
            Ok(Some(AdminNotificationDetailRecord {
                id: 10,
                title: "Notice".to_string(),
                content: "Content".to_string(),
                category: Some("admin".to_string()),
                channels: vec!["MOBILE_PUSH".to_string()],
                recipients: vec![AdminNotificationRecipientRecord {
                    user_id: "recipient-1".to_string(),
                    username: "recipient".to_string(),
                    email: "recipient@example.com".to_string(),
                    mobile_push_is_read: Some(true),
                    mobile_push_is_deleted: Some(false),
                }],
                created_at: created_at(),
            }))
        });

    let usecase =
        AdminNotificationsUsecase::new(Arc::new(notifications_repo), Arc::new(users_repo));

    let result = usecase
        .get_admin_notification_detail("admin-user", 10)
        .await
        .expect("detail should succeed");

    assert_eq!(result.id, 10);
    assert_eq!(result.recipients[0].user_id, "recipient-1");
    assert_eq!(result.recipients[0].mobile_push_is_read, Some(true));
    assert_eq!(
        result.created_at,
        "2026-01-05T10:00:00+09:00"
    );
}

#[tokio::test]
async fn get_admin_notification_detail_returns_not_found_for_missing_notification() {
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, Some(true)))));

    notifications_repo
        .expect_mock_get_admin_notification_detail()
        .times(1)
        .returning(|_| Ok(None));

    let usecase =
        AdminNotificationsUsecase::new(Arc::new(notifications_repo), Arc::new(users_repo));

    let error = usecase
        .get_admin_notification_detail("admin-user", 999)
        .await
        .expect_err("missing notification should be not found");

    assert!(matches!(error, DomainError::NotFound));
}
