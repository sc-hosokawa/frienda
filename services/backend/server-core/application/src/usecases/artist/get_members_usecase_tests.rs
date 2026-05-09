use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, user_artist_mock::MockMockUserArtistRepo,
    user_mock::MockMockUsersRepo,
};
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::UserArtistStatus;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use std::sync::Arc;
use uuid::Uuid;

use crate::usecases::artist::get_members_usecase::{
    GetMembersUsecase, GetMembersUsecaseInput, GetMembersUsecaseTrait,
};
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, UserCategory, UserStatus,
};

// テストヘルパー関数
fn create_test_user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("user{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("".to_string()),
        evm_addr: Some("".to_string()),
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: Some("".to_string()),
        skill: Some("".to_string()),
        x_handle: Some("".to_string()),
        instagram_handle: Some("".to_string()),
        fb_handle: Some("".to_string()),
        interest_offer: Some(OfferCategory::Creation),
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}

fn create_test_user_artist(user_id: &str, artist_id: &str, is_admin: bool) -> UserArtist {
    UserArtist {
        id: 1,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin,
        status: UserArtistStatus::Check,
        request_message: None,
        is_default: false,
        requested_at: None,
    }
}

fn _create_test_artist(artist_id: &str) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: format!("Artist {}", artist_id),
        display_name_en: format!("Artist {}", artist_id),
        display_name_kana: Some(format!("Artist {}", artist_id)),
        img_url: Some("".to_string()),
        fsp: 0,
        status: ArtistStatus::Visible,
        since: Some(chrono::Utc::now().naive_utc().date()),
        universal_id: Some("".to_string()),
        apple_key: Some("".to_string()),
        spotify_key: Some("".to_string()),
        line_key: Some("".to_string()),
        amazon_key: Some("".to_string()),
        youtube_key: Some("".to_string()),
    }
}

#[tokio::test]
async fn test_get_members_belonged_to_artist_success() {
    let mut mock_user_artist_repo = MockMockUserArtistRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mock_artists_repo = MockMockArtistsRepo::new();

    let artist_id = "artist1";
    let admin_user_id = "admin1";
    let member_user_id = "member1";

    // Setup admin user artist relationship
    mock_user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .with(
            mockall::predicate::eq(artist_id.to_string()),
            mockall::predicate::eq(admin_user_id.to_string()),
        )
        .returning(move |_, _| {
            Ok(Some(create_test_user_artist(
                admin_user_id,
                artist_id,
                true,
            )))
        });

    // Setup members
    mock_user_artist_repo
        .expect_mock_find_by_artist_id()
        .with(mockall::predicate::eq(artist_id.to_string()))
        .returning(move |_| {
            Ok(vec![create_test_user_artist(
                member_user_id,
                artist_id,
                false,
            )])
        });

    // Setup users response
    mock_users_repo
        .expect_mock_find_by_ids()
        .with(mockall::predicate::eq(vec![member_user_id.to_string()]))
        .returning(move |_| Ok(vec![create_test_user(member_user_id)]));

    let usecase = GetMembersUsecase::new(
        Arc::new(mock_user_artist_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
    );

    let result = usecase
        .get_members_belonged_to_artist(GetMembersUsecaseInput {
            artist_id: artist_id.to_string(),
            user_id: Some(admin_user_id.to_string()),
        })
        .await;

    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.members.len(), 1);
    assert_eq!(output.members[0].id, member_user_id);
}

#[tokio::test]
async fn test_get_all_pending_members_batches_users_and_artists() {
    let mut mock_user_artist_repo = MockMockUserArtistRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();

    let admin_id = "admin1";
    let member_id = "member1";
    let artist_id = "artist1";

    mock_users_repo
        .expect_mock_find_by_id()
        .returning(move |_| {
            let mut user = create_test_user(admin_id);
            user.is_superadmin = Some(true);
            Ok(Some(user))
        });

    mock_user_artist_repo
        .expect_mock_find_by_status()
        .times(1)
        .with(mockall::predicate::eq(UserArtistStatus::Check))
        .returning(move |_| Ok(vec![create_test_user_artist(member_id, artist_id, false)]));

    mock_users_repo
        .expect_mock_find_by_ids()
        .times(1)
        .with(mockall::predicate::eq(vec![member_id.to_string()]))
        .returning(move |_| Ok(vec![create_test_user(member_id)]));

    mock_artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .with(mockall::predicate::eq(vec![artist_id.to_string()]))
        .returning(move |_| Ok(vec![_create_test_artist(artist_id)]));

    let usecase = GetMembersUsecase::new(
        Arc::new(mock_user_artist_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
    );

    let output = usecase
        .get_all_pending_members(admin_id.to_string())
        .await
        .expect("pending members should be returned");

    assert_eq!(output.members.len(), 1);
    assert_eq!(output.members[0].member.id, member_id);
    assert_eq!(output.members[0].artist_id, artist_id);
    assert_eq!(
        output.members[0].artist_name,
        format!("Artist {}", artist_id)
    );
}
