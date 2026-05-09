use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, user_artist_mock::MockMockUserArtistRepo,
    user_mock::MockMockUsersRepo,
};
use crate::usecases::artist::leave_belonged_artist_usecase::{
    LeaveBelongedArtistError, LeaveBelongedArtistUsecase, LeaveBelongedArtistUsecaseInput,
    LeaveBelongedArtistUsecaseTrait,
};
use chrono::Utc;
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use mockall::predicate::eq;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

fn user(user_id: &str, is_superadmin: bool) -> User {
    User {
        id: user_id.to_string(),
        id_token: Some(user_id.to_string()),
        fcm_token: None,
        username: format!("User {user_id}"),
        realname: String::new(),
        email: format!("{user_id}@example.com"),
        img_url: None,
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        is_superadmin: Some(is_superadmin),
        publicity: true,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: Some(OfferCategory::Creation),
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: None,
    }
}

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
        request_message: Some("所属時の申請".to_string()),
        is_default,
        requested_at: Some(Utc::now().naive_utc()),
    }
}

fn usecase(
    users_repo: MockMockUsersRepo,
    user_artist_repo: MockMockUserArtistRepo,
    artists_repo: MockMockArtistsRepo,
) -> LeaveBelongedArtistUsecase {
    LeaveBelongedArtistUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    )
}

fn input(operator_user_id: &str) -> LeaveBelongedArtistUsecaseInput {
    LeaveBelongedArtistUsecaseInput {
        operator_user_id: operator_user_id.to_string(),
        user_id: "target-1".to_string(),
        artist_id: "artist-1".to_string(),
    }
}

#[tokio::test]
async fn superadmin_can_leave_accepted_artist() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .with(eq("operator-1".to_string()))
        .times(1)
        .returning(|id| Ok(Some(user(&id, true))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .with(eq("artist-1".to_string()), eq("target-1".to_string()))
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                10,
                "target-1",
                "artist-1",
                UserArtistStatus::Accept,
                true,
                true,
            )))
        });

    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec!["artist-1".to_string()]))
        .times(1)
        .returning(|_| Ok(vec![artist("artist-1")]));

    user_artist_repo
        .expect_mock_update()
        .times(1)
        .returning(|active| {
            assert!(matches!(active.id, ActiveValue::Set(10)));
            assert!(matches!(
                active.status,
                ActiveValue::Set(UserArtistStatus::Reject)
            ));
            assert!(matches!(active.is_admin, ActiveValue::Set(false)));
            assert!(matches!(active.is_default, ActiveValue::Set(false)));
            assert!(matches!(active.request_message, ActiveValue::NotSet));
            assert!(matches!(active.requested_at, ActiveValue::NotSet));

            Ok(user_artist(
                10,
                "target-1",
                "artist-1",
                UserArtistStatus::Reject,
                false,
                false,
            ))
        });

    let output = usecase(users_repo, user_artist_repo, artists_repo)
        .leave_belonged_artist(input("operator-1"))
        .await
        .expect("superadmin can leave artist");

    assert_eq!(output.left_artist.artist_id, "artist-1");
    assert_eq!(output.left_artist.status, UserArtistStatus::Reject);
    assert!(!output.left_artist.is_admin);
    assert!(!output.left_artist.is_default);
    assert_eq!(
        output.left_artist.request_message,
        Some("所属時の申請".to_string())
    );
}

#[tokio::test]
async fn artist_admin_can_leave_accepted_artist() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, false))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .with(eq("artist-1".to_string()), eq("operator-1".to_string()))
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                1,
                "operator-1",
                "artist-1",
                UserArtistStatus::Accept,
                true,
                false,
            )))
        });

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .with(eq("artist-1".to_string()), eq("target-1".to_string()))
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                10,
                "target-1",
                "artist-1",
                UserArtistStatus::Accept,
                false,
                false,
            )))
        });

    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|_| Ok(vec![artist("artist-1")]));

    user_artist_repo
        .expect_mock_update()
        .times(1)
        .returning(|_| {
            Ok(user_artist(
                10,
                "target-1",
                "artist-1",
                UserArtistStatus::Reject,
                false,
                false,
            ))
        });

    let output = usecase(users_repo, user_artist_repo, artists_repo)
        .leave_belonged_artist(input("operator-1"))
        .await
        .expect("artist admin can leave artist");

    assert_eq!(output.left_artist.status, UserArtistStatus::Reject);
}

#[tokio::test]
async fn non_admin_operator_returns_forbidden() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, false))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|artist_id, user_id| {
            Ok(Some(user_artist(
                1,
                &user_id,
                &artist_id,
                UserArtistStatus::Accept,
                false,
                false,
            )))
        });
    user_artist_repo.expect_mock_update().times(0);

    let error = usecase(users_repo, user_artist_repo, MockMockArtistsRepo::new())
        .leave_belonged_artist(input("operator-1"))
        .await
        .expect_err("non-admin operator should fail");

    assert!(matches!(error, LeaveBelongedArtistError::Forbidden(_)));
}

#[tokio::test]
async fn operator_without_artist_membership_returns_forbidden() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, false))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| Ok(None));
    user_artist_repo.expect_mock_update().times(0);

    let error = usecase(users_repo, user_artist_repo, MockMockArtistsRepo::new())
        .leave_belonged_artist(input("operator-1"))
        .await
        .expect_err("operator without artist membership should fail");

    assert!(matches!(error, LeaveBelongedArtistError::Forbidden(_)));
}

#[tokio::test]
async fn missing_operator_returns_not_found() {
    let mut users_repo = MockMockUsersRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|_| Ok(None));

    let error = usecase(
        users_repo,
        MockMockUserArtistRepo::new(),
        MockMockArtistsRepo::new(),
    )
    .leave_belonged_artist(input("operator-1"))
    .await
    .expect_err("missing operator should fail");

    assert!(matches!(error, LeaveBelongedArtistError::NotFound));
}

#[tokio::test]
async fn missing_target_mapping_returns_not_found() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, true))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| Ok(None));
    user_artist_repo.expect_mock_update().times(0);

    let error = usecase(users_repo, user_artist_repo, MockMockArtistsRepo::new())
        .leave_belonged_artist(input("operator-1"))
        .await
        .expect_err("missing target mapping should fail");

    assert!(matches!(error, LeaveBelongedArtistError::NotFound));
}

#[tokio::test]
async fn missing_artist_returns_not_found_without_update() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id, true))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .times(1)
        .returning(|_, _| {
            Ok(Some(user_artist(
                10,
                "target-1",
                "artist-1",
                UserArtistStatus::Accept,
                false,
                false,
            )))
        });
    user_artist_repo.expect_mock_update().times(0);

    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|_| Ok(vec![]));

    let error = usecase(users_repo, user_artist_repo, artists_repo)
        .leave_belonged_artist(input("operator-1"))
        .await
        .expect_err("missing artist should fail");

    assert!(matches!(error, LeaveBelongedArtistError::NotFound));
}

#[tokio::test]
async fn non_accept_target_status_returns_invalid_state_without_update() {
    for status in [
        UserArtistStatus::Check,
        UserArtistStatus::Reject,
        UserArtistStatus::Canceled,
    ] {
        let mut users_repo = MockMockUsersRepo::new();
        let mut user_artist_repo = MockMockUserArtistRepo::new();

        users_repo
            .expect_mock_find_by_id()
            .times(1)
            .returning(|id| Ok(Some(user(&id, true))));

        user_artist_repo
            .expect_mock_find_by_artist_id_and_user_id()
            .times(1)
            .returning(move |artist_id, user_id| {
                Ok(Some(user_artist(
                    10,
                    &user_id,
                    &artist_id,
                    status.clone(),
                    false,
                    false,
                )))
            });
        user_artist_repo.expect_mock_update().times(0);

        let error = usecase(users_repo, user_artist_repo, MockMockArtistsRepo::new())
            .leave_belonged_artist(input("operator-1"))
            .await
            .expect_err("non-accept target status should fail");

        assert!(matches!(error, LeaveBelongedArtistError::InvalidState(_)));
    }
}
