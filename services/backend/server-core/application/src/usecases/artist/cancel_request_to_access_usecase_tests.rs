use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, user_artist_mock::MockMockUserArtistRepo,
};
use crate::usecases::artist::cancel_request_to_access_usecase::{
    CancelRequestToAccessError, CancelRequestToAccessUsecase, CancelRequestToAccessUsecaseInput,
    CancelRequestToAccessUsecaseTrait,
};
use chrono::Utc;
use domain::entities::artists::Model as Artist;
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

fn user_artist(id: i32, user_id: &str, artist_id: &str, status: UserArtistStatus) -> UserArtist {
    UserArtist {
        id,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin: false,
        status,
        request_message: Some("申請メッセージ".to_string()),
        is_default: false,
        requested_at: Some(Utc::now().naive_utc()),
    }
}

fn usecase(
    user_artist_repo: MockMockUserArtistRepo,
    artists_repo: MockMockArtistsRepo,
) -> CancelRequestToAccessUsecase {
    CancelRequestToAccessUsecase::new(Arc::new(user_artist_repo), Arc::new(artists_repo))
}

#[tokio::test]
async fn cancel_check_request_updates_status_and_preserves_request_fields() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    let user_id = "user-1";
    let artist_id = "artist-1";
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
                UserArtistStatus::Check,
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
                ActiveValue::Set(UserArtistStatus::Canceled)
            ));
            assert!(matches!(active.request_message, ActiveValue::NotSet));
            assert!(matches!(active.requested_at, ActiveValue::NotSet));
            assert!(matches!(active.is_default, ActiveValue::NotSet));

            let mut canceled = user_artist(1, user_id, artist_id, UserArtistStatus::Canceled);
            canceled.request_message = Some("申請メッセージ".to_string());
            Ok(canceled)
        });

    let output = usecase(user_artist_repo, artists_repo)
        .cancel_request_to_access(CancelRequestToAccessUsecaseInput {
            user_id: user_id.to_string(),
            artist_id: artist_id.to_string(),
        })
        .await
        .expect("cancel should succeed");

    assert_eq!(output.canceled_mapping.mapping_id, 1);
    assert_eq!(output.canceled_mapping.artist_id, artist_id);
    assert_eq!(output.canceled_mapping.status, UserArtistStatus::Canceled);
    assert_eq!(
        output.canceled_mapping.request_message,
        Some("申請メッセージ".to_string())
    );
}

#[tokio::test]
async fn cancel_non_check_status_returns_invalid_state_without_update() {
    for status in [
        UserArtistStatus::Accept,
        UserArtistStatus::Reject,
        UserArtistStatus::Canceled,
    ] {
        let mut user_artist_repo = MockMockUserArtistRepo::new();

        user_artist_repo
            .expect_mock_find_by_artist_id_and_user_id()
            .times(1)
            .returning(move |artist_id, user_id| {
                Ok(Some(user_artist(1, &user_id, &artist_id, status.clone())))
            });
        user_artist_repo.expect_mock_update().times(0);

        let error = usecase(user_artist_repo, MockMockArtistsRepo::new())
            .cancel_request_to_access(CancelRequestToAccessUsecaseInput {
                user_id: "user-1".to_string(),
                artist_id: "artist-1".to_string(),
            })
            .await
            .expect_err("non-check status cannot be canceled");

        assert!(matches!(error, CancelRequestToAccessError::InvalidState(_)));
    }
}

#[tokio::test]
async fn cancel_missing_mapping_returns_not_found() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| Ok(None));
    user_artist_repo.expect_mock_update().times(0);

    let error = usecase(user_artist_repo, MockMockArtistsRepo::new())
        .cancel_request_to_access(CancelRequestToAccessUsecaseInput {
            user_id: "user-1".to_string(),
            artist_id: "artist-1".to_string(),
        })
        .await
        .expect_err("missing mapping should fail");

    assert!(matches!(error, CancelRequestToAccessError::NotFound));
}

#[tokio::test]
async fn cancel_missing_artist_returns_not_found_without_update() {
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
                UserArtistStatus::Check,
            )))
        });
    user_artist_repo.expect_mock_update().times(0);

    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|_| Ok(vec![]));

    let error = usecase(user_artist_repo, artists_repo)
        .cancel_request_to_access(CancelRequestToAccessUsecaseInput {
            user_id: "user-1".to_string(),
            artist_id: "artist-1".to_string(),
        })
        .await
        .expect_err("missing artist should fail");

    assert!(matches!(error, CancelRequestToAccessError::NotFound));
}
