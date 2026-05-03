use crate::test_support::mocks::{
    plays_daily_mock::MockMockPlaysDailyRepo, product_track_mock::MockMockProductTrackRepo,
    products_mock::MockMockProductsRepo,
};
use crate::usecases::dashboard::playback_overview_usecase::{
    PlaybackOverviewUsecase, PlaybackOverviewUsecaseInput, PlaybackOverviewUsecaseTrait,
};
use chrono::{Duration, FixedOffset, NaiveDate, Utc};
use domain::repositories::plays_daily_repo::OverviewPlayCountAggregate;
use std::sync::Arc;

fn jst_today() -> NaiveDate {
    let jst = FixedOffset::east_opt(9 * 3600).unwrap();
    Utc::now().with_timezone(&jst).date_naive()
}

#[tokio::test]
async fn test_get_playback_overview_excludes_recent_three_days() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let today = jst_today();

    plays_daily_repo
        .expect_mock_aggregate_overview_by_artist_id()
        .times(1)
        .withf(move |artist_id, start_date, end_date| {
            artist_id == "artist-1"
                && *start_date == today - Duration::days(9)
                && *end_date == today - Duration::days(3)
        })
        .returning(|_, _, _| {
            Ok(OverviewPlayCountAggregate {
                total: 100,
                weekly: 70,
            })
        });

    let usecase = PlaybackOverviewUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(MockMockProductsRepo::new()),
        Arc::new(MockMockProductTrackRepo::new()),
    );

    let result = usecase
        .get_playback_overview(PlaybackOverviewUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            upc: None,
        })
        .await
        .expect("overview succeeds");

    assert_eq!(result.total_play_count, 100);
    assert_eq!(result.weekly_play_count, 70);
}

#[tokio::test]
async fn test_get_playback_overview_by_upc_uses_single_aggregate_query() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let today = jst_today();

    plays_daily_repo
        .expect_mock_aggregate_overview_by_upc()
        .times(1)
        .withf(move |upc, start_date, end_date| {
            upc == "UPC1"
                && *start_date == today - Duration::days(9)
                && *end_date == today - Duration::days(3)
        })
        .returning(|_, _, _| {
            Ok(OverviewPlayCountAggregate {
                total: 250,
                weekly: 90,
            })
        });

    let usecase = PlaybackOverviewUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(MockMockProductsRepo::new()),
        Arc::new(MockMockProductTrackRepo::new()),
    );

    let result = usecase
        .get_playback_overview_by_upc(PlaybackOverviewUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            upc: Some("UPC1".to_string()),
        })
        .await
        .expect("overview succeeds");

    assert_eq!(result.total_play_count, 250);
    assert_eq!(result.weekly_play_count, 90);
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
