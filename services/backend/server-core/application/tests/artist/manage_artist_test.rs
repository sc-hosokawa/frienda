use crate::mocks::artist_mock::MockMockArtistsRepo;
use application::usecases::artist::manage_artists_usecase::{
    AddArtistInput, AddArtistsInput, ManageArtistsUsecase, ManageArtistsUsecaseTrait,
    UpdateArtistsInput,
};
use domain::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use domain::entities::sea_orm_active_enums::ArtistStatus;
use mockall::predicate::*;
use std::sync::Arc;
use tokio;
use uuid::Uuid;

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
async fn test_add_artists_success() {
    let mut mock_repo = MockMockArtistsRepo::new();
    mock_repo.expect_mock_find_latest().returning(|| Ok(None));
    mock_repo
        .expect_mock_create()
        .returning(|artist: ArtistActiveModel| {
            Ok(create_test_artist(
                &artist.artist_id.unwrap(),
                &artist.display_name_jp.unwrap(),
            ))
        });

    let usecase = ManageArtistsUsecase::new(Arc::new(mock_repo));

    let input = AddArtistsInput {
        artists: vec![AddArtistInput {
            display_name_jp: "Test Artist".to_string(),
            display_name_en: "Test Artist EN".to_string(),
            display_name_kana: None,
            img_url: None,
            fsp: 100,
            status: "visible".to_string(),
            universal_id: None,
            apple_key: None,
            spotify_key: None,
            line_key: None,
            amazon_key: None,
            youtube_key: None,
        }],
    };

    let result = usecase.add_artists(input).await;
    assert!(result.is_ok());
    let response = result.unwrap();
    assert_eq!(response.added_artists.len(), 1);
    assert_eq!(response.added_artists[0].display_name_jp, "Test Artist");
}

#[tokio::test]
async fn test_update_artists_success() {
    let mut mock_repo = MockMockArtistsRepo::new();
    mock_repo
        .expect_mock_find_by_id()
        .with(eq("artist_00_000000000000001".to_string()))
        .returning(|_| {
            Ok(Some(create_test_artist(
                "artist_00_000000000000001",
                "Old Name",
            )))
        });
    mock_repo
        .expect_mock_update()
        .returning(|artist: ArtistActiveModel| {
            Ok(create_test_artist(
                &artist.artist_id.unwrap(),
                &artist.display_name_jp.unwrap(),
            ))
        });

    let usecase = ManageArtistsUsecase::new(Arc::new(mock_repo));

    let input = UpdateArtistsInput {
        artist_id: "artist_00_000000000000001".to_string(),
        display_name_jp: Some("New Name".to_string()),
        display_name_en: None,
        display_name_kana: None,
        img_url: None,
        fsp: None,
        status: None,
        universal_id: None,
        apple_key: None,
        spotify_key: None,
        line_key: None,
        amazon_key: None,
        youtube_key: None,
    };

    let result = usecase.update_artists(input).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), "artist_00_000000000000001");
}
