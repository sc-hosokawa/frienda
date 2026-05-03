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
use domain::entities::products::Model as Product;
use domain::entities::sea_orm_active_enums::ArtistStatus;
use domain::repositories::plays_daily_repo::TrendingTrackAggregate;
use std::sync::Arc;
use uuid::Uuid;

fn jst_today() -> NaiveDate {
    let jst = FixedOffset::east_opt(9 * 3600).unwrap();
    Utc::now().with_timezone(&jst).date_naive()
}

#[tokio::test]
async fn test_get_trending_aggregates_top_tracks() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let products_repo = MockMockProductsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();
    let artists_repo = MockMockArtistsRepo::new();
    let today = jst_today();

    plays_daily_repo
        .expect_mock_aggregate_trending_by_artist_id()
        .times(1)
        .returning(move |artist_id, weekly_start_date, end_date, limit| {
            assert_eq!(artist_id, "artist-1");
            assert_eq!(weekly_start_date, today - Duration::days(9));
            assert_eq!(end_date, today - Duration::days(3));
            assert_eq!(limit, 5);
            Ok(vec![
                TrendingTrackAggregate {
                    isrc: "ISRC1".to_string(),
                    track_title: Some("Track One".to_string()),
                    upc_title: Some("Release".to_string()),
                    image_url: Some("cover.png".to_string()),
                    total: 60,
                    weekly: 40,
                    total_spotify: 30,
                    total_apple: 15,
                    total_line: 15,
                    total_amazon: 0,
                    total_youtube: 0,
                    weekly_spotify: 20,
                    weekly_apple: 10,
                    weekly_line: 10,
                    weekly_amazon: 0,
                    weekly_youtube: 0,
                },
                TrendingTrackAggregate {
                    isrc: "ISRC2".to_string(),
                    track_title: Some("Track Two".to_string()),
                    upc_title: Some("Release".to_string()),
                    image_url: Some("cover.png".to_string()),
                    total: 20,
                    weekly: 12,
                    total_spotify: 10,
                    total_apple: 0,
                    total_line: 0,
                    total_amazon: 5,
                    total_youtube: 5,
                    weekly_spotify: 6,
                    weekly_apple: 0,
                    weekly_line: 0,
                    weekly_amazon: 3,
                    weekly_youtube: 3,
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
    assert_eq!(result.trending[0].weekly_play_count, 40);
    assert_eq!(result.trending[0].upc_title.as_deref(), Some("Release"));
    assert_eq!(result.trending[0].image_url.as_deref(), Some("cover.png"));
    assert_eq!(result.trending[0].total_play_count_details.spotify, 30);
    assert_eq!(result.trending[0].weekly_play_count_details.apple, 10);
    assert_eq!(result.trending[1].total_play_count, 20);
    assert_eq!(result.trending[1].weekly_play_count, 12);
    assert_eq!(result.trending[1].total_play_count_details.amazon, 5);
    assert_eq!(result.trending[1].weekly_play_count_details.youtube, 3);
}

#[tokio::test]
async fn test_get_trending_by_upc_preserves_track_number_order() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();
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

    plays_daily_repo
        .expect_mock_aggregate_trending_by_upc()
        .times(1)
        .returning(move |upc, weekly_start_date, end_date| {
            assert_eq!(upc, "UPC1");
            assert_eq!(weekly_start_date, today - Duration::days(9));
            assert_eq!(end_date, today - Duration::days(3));
            Ok(vec![
                TrendingTrackAggregate {
                    isrc: "ISRC1".to_string(),
                    track_title: Some("First".to_string()),
                    total: 0,
                    weekly: 0,
                    ..Default::default()
                },
                TrendingTrackAggregate {
                    isrc: "ISRC2".to_string(),
                    track_title: Some("Second".to_string()),
                    total: 20,
                    weekly: 8,
                    total_amazon: 5,
                    weekly_youtube: 4,
                    ..Default::default()
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
    assert_eq!(result.trending[0].total_play_count, 0);
    assert_eq!(result.trending[1].total_play_count, 20);
    assert_eq!(result.trending[1].weekly_play_count_details.youtube, 4);
}
