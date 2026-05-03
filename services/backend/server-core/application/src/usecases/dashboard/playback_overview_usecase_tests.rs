use crate::test_support::mocks::{
    plays_daily_mock::MockMockPlaysDailyRepo, product_track_mock::MockMockProductTrackRepo,
    products_mock::MockMockProductsRepo,
};
use crate::usecases::dashboard::playback_overview_usecase::{
    PlaybackOverviewUsecase, PlaybackOverviewUsecaseInput, PlaybackOverviewUsecaseTrait,
};
use chrono::{Duration, FixedOffset, NaiveDate, Utc};
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use std::sync::Arc;

fn jst_today() -> NaiveDate {
    let jst = FixedOffset::east_opt(9 * 3600).unwrap();
    Utc::now().with_timezone(&jst).date_naive()
}

#[tokio::test]
async fn test_get_playback_overview_excludes_recent_three_days() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let today = jst_today();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(move |_| {
            Ok(vec![Product {
                upc: "UPC1".to_string(),
                title: "Release".to_string(),
                img_url: None,
                r#type: Some("single".to_string()),
                distributed_at: Some(today),
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
        .expect_mock_sum_by_isrcs_until()
        .times(1)
        .withf(move |isrcs, end_date| {
            isrcs == &vec!["ISRC1".to_string()] && *end_date == today - Duration::days(3)
        })
        .returning(|_, _| Ok(70));
    plays_daily_repo
        .expect_mock_sum_by_isrcs_between()
        .times(1)
        .withf(move |isrcs, start_date, end_date| {
            isrcs == &vec!["ISRC1".to_string()]
                && *start_date == today - Duration::days(9)
                && *end_date == today - Duration::days(3)
        })
        .returning(|_, _, _| Ok(70));

    let usecase = PlaybackOverviewUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(products_repo),
        Arc::new(product_track_repo),
    );

    let result = usecase
        .get_playback_overview(PlaybackOverviewUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            upc: None,
        })
        .await
        .expect("overview succeeds");

    assert_eq!(result.total_play_count, 70);
    assert_eq!(result.weekly_play_count, 70);
}

#[tokio::test]
async fn test_get_playback_overview_by_upc_requires_upc() {
    let usecase = PlaybackOverviewUsecase::new(
        Arc::new(MockMockPlaysDailyRepo::new()),
        Arc::new(MockMockProductsRepo::new()),
        Arc::new(MockMockProductTrackRepo::new()),
    );

    let error = match usecase
        .get_playback_overview_by_upc(PlaybackOverviewUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            upc: None,
        })
        .await
    {
        Ok(_) => panic!("missing upc should fail"),
        Err(error) => error,
    };

    assert!(error.to_string().contains("UPC is required"));
}
