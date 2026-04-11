use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, user_artist_mock::MockMockUserArtistRepo,
    user_mock::MockMockUsersRepo,
};
use crate::usecases::basic::update_user_profile_usecase::{
    UpdateUserProfileInput, UpdateUserProfileUsecase, UpdateUserProfileUsecaseTrait,
};
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;
use tokio;
use uuid::Uuid;

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

fn create_test_artist(artist_id: &str, display_name_jp: &str) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: display_name_jp.to_string(),
        display_name_en: "Test Artist".to_string(),
        display_name_kana: Some("Test Artist".to_string()),
        img_url: None,
        status: ArtistStatus::Visible,
        since: None,
        universal_id: None,
        apple_key: None,
        spotify_key: None,
        line_key: None,
        amazon_key: None,
        youtube_key: None,
        fsp: 0,
    }
}

#[tokio::test]
async fn test_update_user_profile_success() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();

    // Mock the find_by_id method to return a user
    users_repo
        .expect_mock_find_by_id()
        .with(eq("user_id".to_string()))
        .returning(|_| Ok(Some(create_test_user("user_id"))));

    // Mock the update method to return the updated user
    users_repo.expect_mock_update().returning(|user| {
        let mut updated_user = create_test_user("user_id");
        updated_user.username = user.username.unwrap();
        Ok(updated_user)
    });

    // Mock the find_by_user_id method to return user artists
    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq("user_id".to_string()))
        .returning(|_| {
            Ok(vec![UserArtist {
                id: 1,
                user_id: "user_id".to_string(),
                artist_id: "artist_id".to_string(),
                is_admin: false,
                status: UserArtistStatus::Check,
                // ... other fields ...
            }])
        });

    // Mock the find_by_ids method to return artists
    artists_repo
        .expect_mock_find_by_ids()
        .returning(|_| Ok(vec![create_test_artist("artist_id", "Artist Name")]));

    let usecase = UpdateUserProfileUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
    );

    let input = UpdateUserProfileInput {
        id: "user_id".to_string(),
        name: Some("new_name".to_string()),
        email: Some("new_email@example.com".to_string()),
        image_url: Some("new_image_url".to_string()),
        primary_category: Some(UserCategory::Musician),
        evm_addr: Some("0x1234567890".to_string()),
        greeting: Some("Hello, world!".to_string()),
        skill: Some("Playing guitar".to_string()),
        x_handle: Some("x_handle".to_string()),
        instagram_handle: Some("instagram_handle".to_string()),
        fb_handle: Some("fb_handle".to_string()),
        fcm_token: Some("fcm_token".to_string()),
        interest_offer: Some(OfferCategory::Creation),
    };

    let result = usecase.update(input).await;

    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.updated_user.username, "new_name");
    // ... additional assertions ...
}
