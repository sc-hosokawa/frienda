use crate::test_support::mocks::{
    gender_gen_playback_mock::MockMockGenderGenPlaybackRepo,
    plays_daily_mock::MockMockPlaysDailyRepo, product_track_mock::MockMockProductTrackRepo,
    products_mock::MockMockProductsRepo, tracks_mock::MockMockTracksRepo,
};
use crate::usecases::dashboard::get_play_count_history_usecase::{
    GetAllHistroyUsecaseInput, GetPlayCountHistoryUsecase, GetPlayCountHistoryUsecaseTrait,
    GetUPCHistoryUsecaseInput,
};
use chrono::NaiveDate;
use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::tracks::Model as Track;
use std::collections::HashMap;
use std::sync::Arc;

#[tokio::test]
async fn test_get_play_count_by_artist_aggregates_monthly_history() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let gender_gen_playback_repo = MockMockGenderGenPlaybackRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let tracks_repo = MockMockTracksRepo::new();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![Product {
                upc: "UPC1".to_string(),
                title: "Release".to_string(),
                img_url: None,
                r#type: Some("single".to_string()),
                distributed_at: Some(NaiveDate::from_ymd_opt(2024, 1, 1).unwrap()),
                artist_id: Some("artist-1".to_string()),
            }])
        });

    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|_| {
            Ok(vec![ProductTrack {
                id: 1,
                upc: "UPC1".to_string(),
                isrc: "ISRC1".to_string(),
                track_no: Some(1),
            }])
        });

    plays_daily_repo
        .expect_mock_find_by_isrcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                PlaysDaily {
                    id: 1,
                    isrc: Some("ISRC1".to_string()),
                    date: Some(NaiveDate::from_ymd_opt(2025, 3, 10).unwrap()),
                    spotify: 10,
                    apple: 5,
                    line: 0,
                    amazon: Some(0),
                    youtube: Some(0),
                    sum: Some(15),
                },
                PlaysDaily {
                    id: 2,
                    isrc: Some("ISRC1".to_string()),
                    date: Some(NaiveDate::from_ymd_opt(2025, 3, 20).unwrap()),
                    spotify: 2,
                    apple: 3,
                    line: 0,
                    amazon: Some(0),
                    youtube: Some(0),
                    sum: Some(5),
                },
                PlaysDaily {
                    id: 3,
                    isrc: Some("ISRC1".to_string()),
                    date: Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    spotify: 1,
                    apple: 1,
                    line: 1,
                    amazon: Some(1),
                    youtube: Some(1),
                    sum: Some(5),
                },
            ])
        });

    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(gender_gen_playback_repo),
        Arc::new(products_repo),
        Arc::new(product_track_repo),
        Arc::new(tracks_repo),
    );

    let result = usecase
        .get_play_count_by_artist(GetAllHistroyUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            period: -1,
        })
        .await
        .expect("artist history succeeds");

    assert_eq!(result.chart_data.len(), 2);
    assert_eq!(result.chart_data[0].date, "2025-03");
    assert_eq!(result.chart_data[0].spotify, 12);
    assert_eq!(result.chart_data[0].apple, 8);
    assert_eq!(result.chart_data[1].date, "2025-04");
}

#[tokio::test]
async fn test_get_play_count_by_upc_merges_rows_by_date() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let gender_gen_playback_repo = MockMockGenderGenPlaybackRepo::new();
    let products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();

    product_track_repo
        .expect_mock_get_by_upc()
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

    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                Track {
                    isrc: "ISRC1".to_string(),
                    img_url: None,
                    title: "First".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
                Track {
                    isrc: "ISRC2".to_string(),
                    img_url: None,
                    title: "Second".to_string(),
                    artist_id: Some("artist-1".to_string()),
                },
            ])
        });

    plays_daily_repo
        .expect_mock_find_by_isrcs_and_period()
        .times(1)
        .returning(|_, period| {
            assert_eq!(period, 7);
            Ok(vec![
                PlaysDaily {
                    id: 1,
                    isrc: Some("ISRC1".to_string()),
                    date: Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    spotify: 1,
                    apple: 0,
                    line: 0,
                    amazon: Some(0),
                    youtube: Some(0),
                    sum: Some(1),
                },
                PlaysDaily {
                    id: 2,
                    isrc: Some("ISRC2".to_string()),
                    date: Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    spotify: 2,
                    apple: 0,
                    line: 0,
                    amazon: Some(0),
                    youtube: Some(0),
                    sum: Some(2),
                },
            ])
        });

    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(gender_gen_playback_repo),
        Arc::new(products_repo),
        Arc::new(product_track_repo),
        Arc::new(tracks_repo),
    );

    let result = usecase
        .get_play_count_by_upc(GetUPCHistoryUsecaseInput {
            upc: "UPC1".to_string(),
            period: 7,
        })
        .await
        .expect("upc history succeeds");

    assert_eq!(result.chart_data.len(), 1);
    let row = &result.chart_data[0];
    assert_eq!(row.date, "2025-04-01");
    let expected: HashMap<String, i32> = [("First".to_string(), 1), ("Second".to_string(), 2)]
        .into_iter()
        .collect();
    assert_eq!(row.track_count, expected);
}
