use crate::test_support::mocks::{
    product_track_mock::MockMockProductTrackRepo, products_mock::MockMockProductsRepo,
    tracks_mock::MockMockTracksRepo,
};
use crate::usecases::dashboard::get_products_usecase::{
    GetProductsUsecase, GetProductsUsecaseInput, GetProductsUsecaseTrait,
};
use chrono::NaiveDate;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::tracks::Model as Track;
use std::sync::Arc;

#[tokio::test]
async fn test_get_products_groups_products_and_sorts_tracks() {
    let mut products_repo = MockMockProductsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![
                Product {
                    upc: "ALBUM1".to_string(),
                    title: "Album".to_string(),
                    img_url: None,
                    r#type: Some("album".to_string()),
                    distributed_at: Some(NaiveDate::from_ymd_opt(2024, 2, 1).unwrap()),
                    artist_id: Some("artist-1".to_string()),
                },
                Product {
                    upc: "SINGLE1".to_string(),
                    title: "Single".to_string(),
                    img_url: None,
                    r#type: Some("single".to_string()),
                    distributed_at: Some(NaiveDate::from_ymd_opt(2024, 5, 1).unwrap()),
                    artist_id: Some("artist-1".to_string()),
                },
            ])
        });

    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .with(mockall::predicate::eq(vec![
            "SINGLE1".to_string(),
            "ALBUM1".to_string(),
        ]))
        .returning(|_| {
            Ok(vec![
                ProductTrack {
                id: 1,
                upc: "SINGLE1".to_string(),
                isrc: "S-1".to_string(),
                track_no: Some(1),
            },
                ProductTrack {
                    id: 3,
                    upc: "ALBUM1".to_string(),
                    isrc: "A-2".to_string(),
                    track_no: Some(2),
                },
                ProductTrack {
                    id: 2,
                    upc: "ALBUM1".to_string(),
                    isrc: "A-1".to_string(),
                    track_no: Some(1),
                },
            ])
        });

    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .with(mockall::predicate::eq(vec![
            "S-1".to_string(),
            "A-2".to_string(),
            "A-1".to_string(),
        ]))
        .returning(|_| {
            Ok(vec![
                Track {
                    isrc: "S-1".to_string(),
                    img_url: None,
                    title: "Single Track".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
                Track {
                    isrc: "A-2".to_string(),
                    img_url: None,
                    title: "Album Track 2".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
                Track {
                    isrc: "A-1".to_string(),
                    img_url: None,
                    title: "Album Track 1".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
            ])
        });

    let usecase = GetProductsUsecase::new(
        Arc::new(products_repo),
        Arc::new(tracks_repo),
        Arc::new(product_track_repo),
    );

    let result = usecase
        .get_products(GetProductsUsecaseInput {
            artist_id: "artist-1".to_string(),
        })
        .await
        .expect("get products succeeds");

    assert_eq!(result.single.len(), 1);
    assert_eq!(result.album.len(), 1);
    assert_eq!(result.single[0].product.upc, "SINGLE1");
    assert_eq!(result.album[0].tracks[0].title, "Album Track 1");
    assert_eq!(result.album[0].tracks[1].title, "Album Track 2");
}

#[tokio::test]
async fn test_get_track_info_returns_error_when_track_is_missing() {
    let products_repo = MockMockProductsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();

    tracks_repo
        .expect_mock_get_by_isrc()
        .times(1)
        .returning(|_| Ok(None));

    let usecase = GetProductsUsecase::new(
        Arc::new(products_repo),
        Arc::new(tracks_repo),
        Arc::new(product_track_repo),
    );

    let error = match usecase.get_track_info("MISSING".to_string()).await {
        Ok(_) => panic!("missing track should fail"),
        Err(error) => error,
    };

    assert!(error.to_string().contains("Track not found"));
}
