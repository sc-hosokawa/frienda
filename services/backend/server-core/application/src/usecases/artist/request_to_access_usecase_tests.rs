use crate::test_support::mocks::artist_mock::MockMockArtistsRepo;
use crate::test_support::mocks::user_artist_mock::MockMockUserArtistRepo;
use crate::usecases::artist::request_to_access_usecase::{
    RequestToAccessUsecase, RequestToAccessUsecaseInput, RequestToAccessUsecaseTrait,
};
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::{ArtistStatus, UserArtistStatus};
use domain::entities::user_artist::Model as UserArtist;
use mockall::predicate::*;
use std::sync::Arc;
use uuid::Uuid;

// テストデータ作成用のヘルパー関数を修正
fn create_test_artist(artist_id: &str, display_name_jp: &str) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: display_name_jp.to_string(),
        display_name_en: "Test Artist".to_string(),
        display_name_kana: Some("Test Artist".to_string()),
        img_url: Some("https://example.com/image.jpg".to_string()),
        status: ArtistStatus::Visible,
        since: None,
        universal_id: None,
        apple_key: None,
        spotify_key: None,
        line_key: None,
        amazon_key: None,
        youtube_key: None,
        fsp: 100,
    }
}

fn create_test_user_artist(id: i32, user_id: &str, artist_id: &str) -> UserArtist {
    UserArtist {
        id,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        status: UserArtistStatus::Check,
        is_admin: false,
    }
}

#[tokio::test]
async fn test_request_to_access_success() {
    // Arrange
    let mut mock_user_artist_repo = MockMockUserArtistRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();

    let user_id = "user123";
    let artist_id = "artist123";
    let artist = create_test_artist(artist_id, "Test Artist");
    let user_artist = create_test_user_artist(1, user_id, artist_id);

    mock_user_artist_repo
        .expect_mock_find_by_user_id_and_artist_ids()
        .with(eq(user_id.to_string()), eq(vec![artist_id.to_string()]))
        .returning(|_, _| Ok(vec![]));

    mock_artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec![artist_id.to_string()]))
        .returning(move |_| Ok(vec![artist.clone()]));

    mock_user_artist_repo
        .expect_mock_create()
        .returning(move |_| Ok(user_artist.clone()));

    let usecase =
        RequestToAccessUsecase::new(Arc::new(mock_user_artist_repo), Arc::new(mock_artists_repo));

    let input = RequestToAccessUsecaseInput {
        user_id: user_id.to_string(),
        artist_ids: vec![artist_id.to_string()],
    };

    // Act
    let result = usecase.request_to_access(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.created_mappings.len(), 1);
    let mapping = &output.created_mappings[0];
    assert_eq!(mapping.mapping_id, 1);
    assert_eq!(mapping.artist_id, artist_id);
    assert_eq!(mapping.name, "Test Artist");
    assert_eq!(mapping.status, UserArtistStatus::Check);
    assert_eq!(mapping.is_admin, false);
    assert_eq!(mapping.fsp, 100);
    assert_eq!(
        mapping.img_url,
        Some("https://example.com/image.jpg".to_string())
    );
}

#[tokio::test]
async fn test_request_to_access_existing_mapping() {
    // Arrange
    let mut mock_user_artist_repo = MockMockUserArtistRepo::new();
    let mock_artists_repo = MockMockArtistsRepo::new();

    let user_id = "user123";
    let artist_id = "artist123";

    mock_user_artist_repo
        .expect_mock_find_by_user_id_and_artist_ids()
        .with(eq(user_id.to_string()), eq(vec![artist_id.to_string()]))
        .returning(move |_, _| Ok(vec![create_test_user_artist(1, user_id, artist_id)]));

    let usecase =
        RequestToAccessUsecase::new(Arc::new(mock_user_artist_repo), Arc::new(mock_artists_repo));

    let input = RequestToAccessUsecaseInput {
        user_id: user_id.to_string(),
        artist_ids: vec![artist_id.to_string()],
    };

    // Act
    let result = usecase.request_to_access(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.created_mappings.len(), 0); // No mappings should be created
}

#[tokio::test]
async fn test_request_to_access_artist_not_found() {
    // Arrange
    let mut mock_user_artist_repo = MockMockUserArtistRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();

    let user_id = "user123";
    let artist_id = "artist123";

    mock_user_artist_repo
        .expect_mock_find_by_user_id_and_artist_ids()
        .with(eq(user_id.to_string()), eq(vec![artist_id.to_string()]))
        .returning(|_, _| Ok(vec![]));

    mock_artists_repo
        .expect_mock_find_by_ids()
        .with(eq(vec![artist_id.to_string()]))
        .returning(|_| Ok(vec![]));

    let usecase =
        RequestToAccessUsecase::new(Arc::new(mock_user_artist_repo), Arc::new(mock_artists_repo));

    let input = RequestToAccessUsecaseInput {
        user_id: user_id.to_string(),
        artist_ids: vec![artist_id.to_string()],
    };

    // Act
    let result = usecase.request_to_access(input).await;

    // Assert
    assert!(result.is_err());
}

#[tokio::test]
async fn test_request_to_access_batches_existing_mappings_and_artists() {
    let mut mock_user_artist_repo = MockMockUserArtistRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();

    let user_id = "user123";
    let existing_artist_id = "artist_existing";
    let new_artist_id = "artist_new";
    let artist = create_test_artist(new_artist_id, "New Artist");
    let user_artist = create_test_user_artist(2, user_id, new_artist_id);

    mock_user_artist_repo
        .expect_mock_find_by_user_id_and_artist_ids()
        .times(1)
        .with(eq(user_id.to_string()), eq(vec![
            existing_artist_id.to_string(),
            new_artist_id.to_string(),
        ]))
        .returning(move |_, _| {
            Ok(vec![create_test_user_artist(
                1,
                user_id,
                existing_artist_id,
            )])
        });

    mock_artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .with(eq(vec![new_artist_id.to_string()]))
        .returning(move |_| Ok(vec![artist.clone()]));

    mock_user_artist_repo
        .expect_mock_create()
        .times(1)
        .returning(move |_| Ok(user_artist.clone()));

    let usecase =
        RequestToAccessUsecase::new(Arc::new(mock_user_artist_repo), Arc::new(mock_artists_repo));

    let output = usecase
        .request_to_access(RequestToAccessUsecaseInput {
            user_id: user_id.to_string(),
            artist_ids: vec![
                existing_artist_id.to_string(),
                new_artist_id.to_string(),
                new_artist_id.to_string(),
            ],
        })
        .await
        .expect("new mapping should be created");

    assert_eq!(output.created_mappings.len(), 1);
    assert_eq!(output.created_mappings[0].artist_id, new_artist_id);
    assert_eq!(output.created_mappings[0].name, "New Artist");
}
