use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, user_artist_mock::MockMockUserArtistRepo,
};
use crate::usecases::artist::set_default_belonged_artist_usecase::{
    SetDefaultBelongedArtistError, SetDefaultBelongedArtistUsecase,
    SetDefaultBelongedArtistUsecaseInput, SetDefaultBelongedArtistUsecaseTrait,
};
use chrono::Utc;
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::{ArtistStatus, UserArtistStatus};
use domain::entities::user_artist::Model as UserArtist;
use mockall::predicate::eq;
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
    is_default: bool,
) -> UserArtist {
    UserArtist {
        id,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin,
        status,
        request_message: Some("所属申請メッセージ".to_string()),
        is_default,
        requested_at: Some(Utc::now().naive_utc()),
    }
}

fn usecase(
    user_artist_repo: MockMockUserArtistRepo,
    artists_repo: MockMockArtistsRepo,
) -> SetDefaultBelongedArtistUsecase {
    SetDefaultBelongedArtistUsecase::new(Arc::new(user_artist_repo), Arc::new(artists_repo))
}

fn input() -> SetDefaultBelongedArtistUsecaseInput {
    SetDefaultBelongedArtistUsecaseInput {
        user_id: "user-1".to_string(),
        artist_id: "artist-2".to_string(),
    }
}

#[tokio::test]
async fn accepted_mapping_can_be_set_as_default() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .with(eq("artist-2".to_string()), eq("user-1".to_string()))
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                20,
                "user-1",
                "artist-2",
                UserArtistStatus::Accept,
                true,
                false,
            )))
        });

    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec!["artist-2".to_string()]))
        .times(1)
        .returning(|_| Ok(vec![artist("artist-2")]));

    user_artist_repo
        .expect_mock_set_default_for_user()
        .with(eq("user-1".to_string()), eq("artist-2".to_string()))
        .times(1)
        .returning(|user_id, artist_id| {
            Ok(user_artist(
                20,
                &user_id,
                &artist_id,
                UserArtistStatus::Accept,
                true,
                true,
            ))
        });

    let output = usecase(user_artist_repo, artists_repo)
        .set_default_belonged_artist(input())
        .await
        .expect("accepted mapping can be set as default");

    assert_eq!(output.default_artist.artist_id, "artist-2");
    assert_eq!(output.default_artist.status, UserArtistStatus::Accept);
    assert!(output.default_artist.is_admin);
    assert!(output.default_artist.is_default);
    assert_eq!(
        output.default_artist.request_message,
        Some("所属申請メッセージ".to_string())
    );
}

#[tokio::test]
async fn missing_mapping_returns_not_found_without_update() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| Ok(None));
    user_artist_repo.expect_mock_set_default_for_user().times(0);

    let error = usecase(user_artist_repo, MockMockArtistsRepo::new())
        .set_default_belonged_artist(input())
        .await
        .expect_err("missing mapping should fail");

    assert!(matches!(error, SetDefaultBelongedArtistError::NotFound));
}

#[tokio::test]
async fn missing_artist_returns_not_found_without_update() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                20,
                "user-1",
                "artist-2",
                UserArtistStatus::Accept,
                false,
                false,
            )))
        });
    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|_| Ok(vec![]));
    user_artist_repo.expect_mock_set_default_for_user().times(0);

    let error = usecase(user_artist_repo, artists_repo)
        .set_default_belonged_artist(input())
        .await
        .expect_err("missing artist should fail");

    assert!(matches!(error, SetDefaultBelongedArtistError::NotFound));
}

#[tokio::test]
async fn non_accept_mapping_returns_invalid_state_without_update() {
    for status in [
        UserArtistStatus::Check,
        UserArtistStatus::Reject,
        UserArtistStatus::Canceled,
    ] {
        let mut user_artist_repo = MockMockUserArtistRepo::new();

        user_artist_repo
            .expect_mock_find_by_artist_id_and_user_id()
            .times(1)
            .returning(move |_, _| {
                Ok(Some(user_artist(
                    20,
                    "user-1",
                    "artist-2",
                    status.clone(),
                    false,
                    false,
                )))
            });
        user_artist_repo.expect_mock_set_default_for_user().times(0);

        let error = usecase(user_artist_repo, MockMockArtistsRepo::new())
            .set_default_belonged_artist(input())
            .await
            .expect_err("non-accept mapping should fail");

        assert!(matches!(
            error,
            SetDefaultBelongedArtistError::InvalidState(_)
        ));
    }
}
