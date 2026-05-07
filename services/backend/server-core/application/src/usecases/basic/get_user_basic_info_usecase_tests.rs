use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, user_artist_mock::MockMockUserArtistRepo,
    user_mock::MockMockUsersRepo,
};
use crate::usecases::basic::get_user_basic_info_usecase::{
    GetUserBasicInfoInput, GetUserBasicInfoUsecase, GetUserBasicInfoUsecaseTrait,
};
use chrono::Utc;
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use mockall::predicate::eq;
use std::sync::Arc;
use uuid::Uuid;

fn user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("{user_id}@example.com"),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: None,
        username: format!("User {user_id}"),
        realname: "Real Name".to_string(),
        img_url: Some("https://cdn.example.com/user.png".to_string()),
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 10,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: Some(OfferCategory::Creation),
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: Some(Utc::now().naive_utc()),
    }
}

fn artist(artist_id: &str, name: &str) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: name.to_string(),
        display_name_en: name.to_string(),
        display_name_kana: None,
        img_url: Some("https://cdn.example.com/artist.png".to_string()),
        fsp: 99,
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

fn user_artist(user_id: &str, artist_id: &str, is_admin: bool) -> UserArtist {
    user_artist_with_details(
        user_id,
        artist_id,
        is_admin,
        UserArtistStatus::Check,
        None,
        false,
    )
}

fn user_artist_with_details(
    user_id: &str,
    artist_id: &str,
    is_admin: bool,
    status: UserArtistStatus,
    request_message: Option<String>,
    is_default: bool,
) -> UserArtist {
    UserArtist {
        id: 1,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin,
        status,
        request_message,
        is_default,
    }
}

#[tokio::test]
async fn test_get_user_basic_info_returns_user_and_artist_memberships() {
    let user_id = "user-1";

    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(move |_| Ok(Some(user(user_id))));
    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(move |_| Ok(vec![user_artist(user_id, "artist-1", true)]));
    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec!["artist-1".to_string()]))
        .times(1)
        .returning(|_| Ok(vec![artist("artist-1", "Band One")]));

    let usecase = GetUserBasicInfoUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_user_basic_info(GetUserBasicInfoInput {
            user_id: user_id.to_string(),
        })
        .await
        .unwrap();

    assert_eq!(result.user.id, user_id);
    assert_eq!(result.belongs_to_artists.len(), 1);
    assert_eq!(result.belongs_to_artists[0].artist_id, "artist-1");
    assert_eq!(result.belongs_to_artists[0].name, "Band One");
    assert!(result.belongs_to_artists[0].is_admin);
    assert_eq!(result.belongs_to_artists[0].request_message, None);
    assert!(!result.belongs_to_artists[0].is_default);
}

#[tokio::test]
async fn test_get_user_basic_info_preserves_artist_request_message_and_default() {
    let user_id = "user-1";

    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(move |_| Ok(Some(user(user_id))));
    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(move |_| {
            Ok(vec![user_artist_with_details(
                user_id,
                "artist-1",
                true,
                UserArtistStatus::Accept,
                Some("所属申請をお願いします。".to_string()),
                true,
            )])
        });
    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec!["artist-1".to_string()]))
        .times(1)
        .returning(|_| Ok(vec![artist("artist-1", "Band One")]));

    let usecase = GetUserBasicInfoUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_user_basic_info(GetUserBasicInfoInput {
            user_id: user_id.to_string(),
        })
        .await
        .unwrap();

    let artist = &result.belongs_to_artists[0];
    assert_eq!(
        artist.request_message,
        Some("所属申請をお願いします。".to_string())
    );
    assert!(artist.is_default);
    assert_eq!(artist.status, UserArtistStatus::Accept);
}

#[tokio::test]
async fn test_get_user_basic_info_returns_not_found_when_user_is_missing() {
    let user_id = "user-1";

    let mut users_repo = MockMockUsersRepo::new();
    let user_artist_repo = MockMockUserArtistRepo::new();
    let artists_repo = MockMockArtistsRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(|_| Ok(None));

    let usecase = GetUserBasicInfoUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_user_basic_info(GetUserBasicInfoInput {
            user_id: user_id.to_string(),
        })
        .await;

    assert!(result.is_err());
    let err = result.err().unwrap();
    assert_eq!(err.to_string(), "User not found");
}

#[tokio::test]
async fn test_get_belongs_to_artists_returns_empty_when_user_has_no_memberships() {
    let user_id = "user-1";

    let users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(|_| Ok(vec![]));
    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(Vec::<String>::new()))
        .times(1)
        .returning(|_| Ok(vec![]));

    let usecase = GetUserBasicInfoUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_belongs_to_artists(user_id.to_string())
        .await
        .unwrap();

    assert!(result.is_empty());
}

#[tokio::test]
async fn test_get_belongs_to_artists_returns_request_message_default_and_canceled_status() {
    let user_id = "user-1";

    let users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(move |_| {
            Ok(vec![user_artist_with_details(
                user_id,
                "artist-1",
                false,
                UserArtistStatus::Canceled,
                Some("キャンセル前の申請メッセージ".to_string()),
                true,
            )])
        });
    artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec!["artist-1".to_string()]))
        .times(1)
        .returning(|_| Ok(vec![artist("artist-1", "Band One")]));

    let usecase = GetUserBasicInfoUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_belongs_to_artists(user_id.to_string())
        .await
        .unwrap();

    assert_eq!(result.len(), 1);
    assert_eq!(result[0].status, UserArtistStatus::Canceled);
    assert_eq!(
        result[0].request_message,
        Some("キャンセル前の申請メッセージ".to_string())
    );
    assert!(result[0].is_default);
}
