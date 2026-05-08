use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, notification_mock::MockMockNotificationsRepo,
    notification_user_mock::MockMockNotificationUserRepo, user_artist_mock::MockMockUserArtistRepo,
};
use crate::usecases::artist::resend_request_to_access_usecase::{
    ResendRequestToAccessError, ResendRequestToAccessUsecase, ResendRequestToAccessUsecaseInput,
    ResendRequestToAccessUsecaseTrait,
};
use chrono::Utc;
use domain::entities::artists::Model as Artist;
use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::Model as Notification;
use domain::entities::sea_orm_active_enums::{ArtistStatus, UserArtistStatus};
use domain::entities::user_artist::Model as UserArtist;
use mockall::predicate::eq;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

fn artist(artist_id: &str) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: "Artist One".to_string(),
        display_name_en: "Artist One".to_string(),
        display_name_kana: None,
        img_url: Some("https://example.com/artist.png".to_string()),
        fsp: 10,
        status: ArtistStatus::Visible,
        since: None,
        universal_id: None,
        apple_key: None,
        spotify_key: None,
        line_key: None,
        amazon_key: None,
        youtube_key: None,
    }
}

fn user_artist(
    id: i32,
    user_id: &str,
    artist_id: &str,
    status: UserArtistStatus,
    is_admin: bool,
) -> UserArtist {
    UserArtist {
        id,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin,
        status,
        request_message: None,
        is_default: false,
        requested_at: None,
    }
}

fn usecase(
    user_artist_repo: MockMockUserArtistRepo,
    artists_repo: MockMockArtistsRepo,
    notifications_repo: MockMockNotificationsRepo,
    notification_user_repo: MockMockNotificationUserRepo,
) -> ResendRequestToAccessUsecase {
    ResendRequestToAccessUsecase::new(
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
        Arc::new(notifications_repo),
        Arc::new(notification_user_repo),
    )
}

#[tokio::test]
async fn resend_rejected_request_updates_mapping_and_notifies_artist_admins() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut notification_user_repo = MockMockNotificationUserRepo::new();

    let user_id = "user-1";
    let artist_id = "artist-1";
    let message = "内容を更新して再申請します。";
    let artist = artist(artist_id);

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .with(eq(artist_id.to_string()), eq(user_id.to_string()))
        .times(1)
        .returning(move |_, _| {
            Ok(Some(user_artist(
                1,
                user_id,
                artist_id,
                UserArtistStatus::Reject,
                false,
            )))
        });

    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec![artist_id.to_string()]))
        .times(1)
        .returning(move |_| Ok(vec![artist.clone()]));

    user_artist_repo
        .expect_mock_update()
        .times(1)
        .returning(move |active| {
            assert!(matches!(active.id, ActiveValue::Set(1)));
            assert!(matches!(
                active.status,
                ActiveValue::Set(UserArtistStatus::Check)
            ));
            assert_eq!(
                active.request_message,
                ActiveValue::Set(Some(message.to_string()))
            );
            assert!(matches!(active.requested_at, ActiveValue::Set(Some(_))));

            let mut updated = user_artist(1, user_id, artist_id, UserArtistStatus::Check, false);
            updated.request_message = Some(message.to_string());
            updated.requested_at = Some(Utc::now().naive_utc());
            Ok(updated)
        });

    user_artist_repo
        .expect_mock_find_by_artist_id()
        .with(eq(artist_id.to_string()))
        .times(1)
        .returning(move |_| {
            Ok(vec![
                user_artist(2, "admin-1", artist_id, UserArtistStatus::Accept, true),
                user_artist(3, "admin-1", artist_id, UserArtistStatus::Accept, true),
                user_artist(4, "admin-2", artist_id, UserArtistStatus::Accept, true),
                user_artist(5, "member-1", artist_id, UserArtistStatus::Accept, false),
                user_artist(6, "pending-admin", artist_id, UserArtistStatus::Check, true),
            ])
        });

    notifications_repo
        .expect_mock_create()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.category,
                ActiveValue::Set(Some(ref value)) if value == "artist_request"
            ));
            Ok(Notification {
                id: 10,
                title: "アーティスト所属申請が再送されました".to_string(),
                content: "Artist Oneへの所属申請が再送されました".to_string(),
                category: Some("artist_request".to_string()),
                created_at: Utc::now().naive_utc(),
            })
        });

    notification_user_repo
        .expect_mock_create()
        .times(2)
        .returning(|active| {
            assert!(matches!(active.notification_id, ActiveValue::Set(10)));
            assert!(matches!(
                active.user,
                ActiveValue::Set(ref value) if value == "admin-1" || value == "admin-2"
            ));
            assert!(matches!(active.is_read, ActiveValue::Set(false)));
            assert!(matches!(active.is_deleted, ActiveValue::Set(false)));
            Ok(NotificationUser {
                id: 20,
                notification_id: 10,
                user: "admin-1".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    let output = usecase(
        user_artist_repo,
        artists_repo,
        notifications_repo,
        notification_user_repo,
    )
    .resend_request_to_access(ResendRequestToAccessUsecaseInput {
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        message: Some(message.to_string()),
    })
    .await
    .expect("resend should succeed");

    assert_eq!(output.updated_mapping.mapping_id, 1);
    assert_eq!(output.updated_mapping.artist_id, artist_id);
    assert_eq!(output.updated_mapping.status, UserArtistStatus::Check);
    assert_eq!(
        output.updated_mapping.request_message,
        Some(message.to_string())
    );
}

#[tokio::test]
async fn resend_canceled_and_check_requests_are_allowed_without_admin_notifications() {
    for status in [UserArtistStatus::Canceled, UserArtistStatus::Check] {
        let mut user_artist_repo = MockMockUserArtistRepo::new();
        let mut artists_repo = MockMockArtistsRepo::new();
        let mut notifications_repo = MockMockNotificationsRepo::new();
        let mut notification_user_repo = MockMockNotificationUserRepo::new();

        user_artist_repo
            .expect_mock_find_by_artist_id_and_user_id()
            .times(1)
            .returning(move |artist_id, user_id| {
                Ok(Some(user_artist(
                    1,
                    &user_id,
                    &artist_id,
                    status.clone(),
                    false,
                )))
            });

        artists_repo
            .expect_mock_find_by_ids()
            .times(1)
            .returning(|ids| Ok(vec![artist(&ids[0])]));

        user_artist_repo
            .expect_mock_update()
            .times(1)
            .returning(|active| {
                assert!(matches!(
                    active.status,
                    ActiveValue::Set(UserArtistStatus::Check)
                ));
                Ok(user_artist(
                    1,
                    "user-1",
                    "artist-1",
                    UserArtistStatus::Check,
                    false,
                ))
            });

        user_artist_repo
            .expect_mock_find_by_artist_id()
            .times(1)
            .returning(|_| Ok(vec![]));
        notifications_repo.expect_mock_create().times(0);
        notification_user_repo.expect_mock_create().times(0);

        let result = usecase(
            user_artist_repo,
            artists_repo,
            notifications_repo,
            notification_user_repo,
        )
        .resend_request_to_access(ResendRequestToAccessUsecaseInput {
            user_id: "user-1".to_string(),
            artist_id: "artist-1".to_string(),
            message: None,
        })
        .await;

        assert!(result.is_ok());
    }
}

#[tokio::test]
async fn resend_accepted_request_returns_invalid_state_without_update() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                1,
                "user-1",
                "artist-1",
                UserArtistStatus::Accept,
                false,
            )))
        });
    user_artist_repo.expect_mock_update().times(0);

    let error = usecase(
        user_artist_repo,
        MockMockArtistsRepo::new(),
        MockMockNotificationsRepo::new(),
        MockMockNotificationUserRepo::new(),
    )
    .resend_request_to_access(ResendRequestToAccessUsecaseInput {
        user_id: "user-1".to_string(),
        artist_id: "artist-1".to_string(),
        message: None,
    })
    .await
    .expect_err("accepted request cannot be resent");

    assert!(matches!(error, ResendRequestToAccessError::InvalidState(_)));
}

#[tokio::test]
async fn resend_missing_mapping_returns_not_found() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| Ok(None));
    user_artist_repo.expect_mock_update().times(0);

    let error = usecase(
        user_artist_repo,
        MockMockArtistsRepo::new(),
        MockMockNotificationsRepo::new(),
        MockMockNotificationUserRepo::new(),
    )
    .resend_request_to_access(ResendRequestToAccessUsecaseInput {
        user_id: "user-1".to_string(),
        artist_id: "artist-1".to_string(),
        message: None,
    })
    .await
    .expect_err("missing mapping should fail");

    assert!(matches!(error, ResendRequestToAccessError::NotFound));
}

#[tokio::test]
async fn resend_missing_artist_returns_not_found_without_update() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                1,
                "user-1",
                "artist-1",
                UserArtistStatus::Reject,
                false,
            )))
        });
    user_artist_repo.expect_mock_update().times(0);

    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|_| Ok(vec![]));

    let error = usecase(
        user_artist_repo,
        artists_repo,
        MockMockNotificationsRepo::new(),
        MockMockNotificationUserRepo::new(),
    )
    .resend_request_to_access(ResendRequestToAccessUsecaseInput {
        user_id: "user-1".to_string(),
        artist_id: "artist-1".to_string(),
        message: None,
    })
    .await
    .expect_err("missing artist should fail");

    assert!(matches!(error, ResendRequestToAccessError::NotFound));
}

#[tokio::test]
async fn resend_rejects_empty_and_overlong_message_before_repo_access() {
    for message in [String::new(), "あ".repeat(201)] {
        let error = usecase(
            MockMockUserArtistRepo::new(),
            MockMockArtistsRepo::new(),
            MockMockNotificationsRepo::new(),
            MockMockNotificationUserRepo::new(),
        )
        .resend_request_to_access(ResendRequestToAccessUsecaseInput {
            user_id: "user-1".to_string(),
            artist_id: "artist-1".to_string(),
            message: Some(message),
        })
        .await
        .expect_err("invalid message should fail");

        assert!(matches!(error, ResendRequestToAccessError::BadUserInput(_)));
    }
}
