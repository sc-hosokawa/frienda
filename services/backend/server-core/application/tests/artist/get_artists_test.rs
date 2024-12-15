use domain::entities::artists::Model as Artist;
use std::sync::Arc;
use uuid::Uuid;

use crate::mocks::artist_mock::MockMockArtistsRepo;
use application::usecases::artist::get_artist_usecase::{
    GetArtistUsecase, GetArtistUsecaseInput, GetArtistUsecaseTrait,
};
use domain::entities::sea_orm_active_enums::ArtistStatus;

fn create_test_artist(artist_id: &str) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: "Test Artist".to_string(),
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
async fn test_get_artist_by_id_success() {
    let mut mock_repo = MockMockArtistsRepo::new();
    let test_id = "test_id_1";
    let expected_artist = create_test_artist(test_id);

    mock_repo
        .expect_mock_find_by_id()
        .with(mockall::predicate::eq(test_id.to_string()))
        .returning(move |_| Ok(Some(expected_artist.clone())));

    let usecase = GetArtistUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .get_artist_by_id(GetArtistUsecaseInput {
            artist_id: test_id.to_string(),
        })
        .await;

    assert!(result.is_ok());
    let artist = result.unwrap();
    assert_eq!(artist.artist_id, test_id);
}

#[tokio::test]
async fn test_get_artist_by_id_not_found() {
    let mut mock_repo = MockMockArtistsRepo::new();
    let test_id = "nonexistent_id";

    mock_repo
        .expect_mock_find_by_id()
        .with(mockall::predicate::eq(test_id.to_string()))
        .returning(|_| Ok(None));

    let usecase = GetArtistUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .get_artist_by_id(GetArtistUsecaseInput {
            artist_id: test_id.to_string(),
        })
        .await;

    assert!(result.is_err());
    assert_eq!(
        result.unwrap_err().to_string(),
        "Artist not found".to_string()
    );
}

#[tokio::test]
async fn test_get_artists_by_ids_success() {
    let mut mock_repo = MockMockArtistsRepo::new();
    let test_ids = vec!["id1", "id2"];
    let expected_artists = vec![create_test_artist("id1"), create_test_artist("id2")];

    mock_repo
        .expect_mock_find_by_ids()
        .with(mockall::predicate::eq(
            test_ids
                .iter()
                .map(|&s| s.to_string())
                .collect::<Vec<String>>(),
        ))
        .returning(move |_| Ok(expected_artists.clone()));

    let usecase = GetArtistUsecase::new(Arc::new(mock_repo));
    let result = usecase.get_artists_by_ids(test_ids).await;

    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.artists.len(), 2);
}

#[tokio::test]
async fn test_get_all_artists_success() {
    let mut mock_repo = MockMockArtistsRepo::new();
    let expected_artists = vec![
        create_test_artist("id1"),
        create_test_artist("id2"),
        create_test_artist("id3"),
    ];

    mock_repo
        .expect_mock_find_all()
        .returning(move || Ok(expected_artists.clone()));

    let usecase = GetArtistUsecase::new(Arc::new(mock_repo));
    let result = usecase.get_all_artists().await;

    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.artists.len(), 3);
}

#[tokio::test]
async fn test_get_artists_by_name_success() {
    let mut mock_repo = MockMockArtistsRepo::new();
    let test_name = "Test Artist";
    let expected_artists = vec![create_test_artist("id1"), create_test_artist("id2")];

    mock_repo
        .expect_mock_find_by_name()
        .with(mockall::predicate::eq(test_name.to_string()))
        .returning(move |_| Ok(expected_artists.clone()));

    let usecase = GetArtistUsecase::new(Arc::new(mock_repo));
    let result = usecase.get_artists_by_name(test_name).await;

    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.artists.len(), 2);
}
