use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, plays_daily_mock::MockMockPlaysDailyRepo,
    product_track_mock::MockMockProductTrackRepo, products_mock::MockMockProductsRepo,
    tracks_mock::MockMockTracksRepo,
};
use crate::usecases::dashboard::get_trending_usecase::{
    GetTrendingByUpcUsecaseInput, GetTrendingUsecase, GetTrendingUsecaseInput,
    GetTrendingUsecaseTrait,
};
use chrono::{Duration, FixedOffset, NaiveDate, Utc};
use domain::entities::artists::Model as Artist;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::sea_orm_active_enums::ArtistStatus;
use domain::entities::tracks::Model as Track;
use domain::repositories::plays_daily_repo::PlayCountAggregate;
use std::sync::Arc;
use uuid::Uuid;

fn jst_today() -> NaiveDate {
    let jst = FixedOffset::east_opt(9 * 3600).unwrap();
    Utc::now().with_timezone(&jst).date_naive()
}

#[tokio::test]
async fn test_get_trending_aggregates_top_tracks() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let artists_repo = MockMockArtistsRepo::new();
    let today = jst_today();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(move |_| {
            Ok(vec![Product {
                upc: "UPC1".to_string(),
                title: "Release".to_string(),
                img_url: Some("cover.png".to_string()),
                r#type: Some("single".to_string()),
                distributed_at: Some(today),
                artist_id: Some("artist-1".to_string()),
            }])
        });

    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                ProductTrack {
                    id: 1,
                    upc: "UPC1".to_string(),
                    isrc: "ISRC1".to_string(),
                    track_no: Some(1),
                },
                ProductTrack {
                    id: 2,
                    upc: "UPC1".to_string(),
                    isrc: "ISRC2".to_string(),
                    track_no: Some(2),
                },
            ])
        });

    plays_daily_repo
        .expect_mock_aggregate_by_isrcs()
        .times(2)
        .returning(move |isrcs, start_date, end_date, limit| {
            if limit == Some(5) {
                assert_eq!(start_date, None);
                assert_eq!(end_date, Some(today - Duration::days(3)));
                assert_eq!(isrcs.len(), 2);
            } else {
                assert_eq!(start_date, Some(today - Duration::days(9)));
                assert_eq!(end_date, Some(today - Duration::days(3)));
                assert_eq!(isrcs, vec!["ISRC1".to_string(), "ISRC2".to_string()]);
            }

            Ok(vec![
                PlayCountAggregate {
                    isrc: "ISRC1".to_string(),
                    total: 60,
                    spotify: 30,
                    apple: 15,
                    line: 15,
                    amazon: 0,
                    youtube: 0,
                },
                PlayCountAggregate {
                    isrc: "ISRC2".to_string(),
                    total: 20,
                    spotify: 10,
                    apple: 0,
                    line: 0,
                    amazon: 5,
                    youtube: 5,
                },
            ])
        });

    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                Track {
                    isrc: "ISRC1".to_string(),
                    img_url: None,
                    title: "Track One".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
                Track {
                    isrc: "ISRC2".to_string(),
                    img_url: None,
                    title: "Track Two".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
            ])
        });

    let usecase = GetTrendingUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(products_repo),
        Arc::new(tracks_repo),
        Arc::new(product_track_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_trending(GetTrendingUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
        })
        .await
        .expect("trending succeeds");

    assert_eq!(result.trending.len(), 2);
    assert_eq!(result.trending[0].isrc, "ISRC1");
    assert_eq!(result.trending[0].total_play_count, 60);
    assert_eq!(result.trending[0].weekly_play_count, 60);
    assert_eq!(result.trending[0].total_play_count_details.spotify, 30);
    assert_eq!(result.trending[0].weekly_play_count_details.apple, 15);
    assert_eq!(result.trending[1].total_play_count, 20);
    assert_eq!(result.trending[1].weekly_play_count, 20);
    assert_eq!(result.trending[1].total_play_count_details.amazon, 5);
    assert_eq!(result.trending[1].weekly_play_count_details.youtube, 5);
}

#[tokio::test]
async fn test_get_trending_by_upc_preserves_track_number_order() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();
    let today = jst_today();

    products_repo
        .expect_mock_get_by_upc()
        .times(1)
        .returning(move |_| {
            Ok(Some(Product {
                upc: "UPC1".to_string(),
                title: "Release".to_string(),
                img_url: Some("cover.png".to_string()),
                r#type: Some("single".to_string()),
                distributed_at: Some(today),
                artist_id: Some("artist-1".to_string()),
            }))
        });

    artists_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|_| {
            Ok(Some(Artist {
                id: Uuid::new_v4(),
                artist_id: "artist-1".to_string(),
                display_name_jp: "Artist".to_string(),
                display_name_en: "Artist".to_string(),
                display_name_kana: None,
                img_url: None,
                fsp: 0,
                status: ArtistStatus::Visible,
                since: None,
                universal_id: None,
                apple_key: None,
                spotify_key: None,
                line_key: None,
                amazon_key: None,
                youtube_key: None,
            }))
        });

    product_track_repo
        .expect_mock_get_by_upc()
        .times(1)
        .returning(|_| {
            Ok(vec![
                ProductTrack {
                    id: 2,
                    upc: "UPC1".to_string(),
                    isrc: "ISRC2".to_string(),
                    track_no: Some(2),
                },
                ProductTrack {
                    id: 1,
                    upc: "UPC1".to_string(),
                    isrc: "ISRC1".to_string(),
                    track_no: Some(1),
                },
            ])
        });

    plays_daily_repo
        .expect_mock_aggregate_by_isrcs()
        .times(2)
        .returning(|_, _, _, _| Ok(vec![]));

    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                Track {
                    isrc: "ISRC2".to_string(),
                    img_url: None,
                    title: "Second".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
                Track {
                    isrc: "ISRC1".to_string(),
                    img_url: None,
                    title: "First".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
            ])
        });

    let usecase = GetTrendingUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(products_repo),
        Arc::new(tracks_repo),
        Arc::new(product_track_repo),
        Arc::new(artists_repo),
    );

    let result = usecase
        .get_trending_by_upc(GetTrendingByUpcUsecaseInput {
            user_id: "user-1".to_string(),
            upc: "UPC1".to_string(),
        })
        .await
        .expect("upc trending succeeds");

    assert_eq!(result.artist_name, "Artist");
    assert_eq!(result.trending.len(), 2);
    assert_eq!(result.trending[0].track_title.as_deref(), Some("First"));
    assert_eq!(result.trending[1].track_title.as_deref(), Some("Second"));
}
