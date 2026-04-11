use crate::test_support::mocks::{
    plays_daily_mock::MockMockPlaysDailyRepo, plays_monthly_mock::MockMockPlaysMonthlyRepo,
};
use crate::usecases::admin::all_track_playback_usecase::{
    AllTrackPlaybackHistoryUsecase, AllTrackPlaybackHistoryUsecaseInput,
    AllTrackPlaybackHistoryUsecaseTrait,
};
use chrono::NaiveDate;
use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use mockall::predicate::eq;
use std::sync::Arc;

fn plays_daily(
    id: i32,
    date: (i32, u32, u32),
    spotify: i32,
    apple: i32,
    line: i32,
    amazon: Option<i32>,
    youtube: Option<i32>,
) -> PlaysDaily {
    PlaysDaily {
        id,
        isrc: Some(format!("ISRC-{id}")),
        date: Some(NaiveDate::from_ymd_opt(date.0, date.1, date.2).unwrap()),
        spotify,
        apple,
        line,
        amazon,
        youtube,
        sum: None,
    }
}

fn plays_monthly(
    id: i32,
    month: (i32, u32, u32),
    spotify: i32,
    apple: i32,
    line: i32,
    amazon: i32,
    youtube: i32,
) -> PlaysMonthly {
    PlaysMonthly {
        id,
        isrc: Some(format!("ISRC-{id}")),
        month: Some(NaiveDate::from_ymd_opt(month.0, month.1, month.2).unwrap()),
        spotify,
        apple,
        line,
        amazon,
        youtube,
        sum: None,
    }
}

#[tokio::test]
async fn test_get_all_track_playback_history_aggregates_daily_rows_and_sorts() {
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let plays_monthly_repo = MockMockPlaysMonthlyRepo::new();

    plays_daily_repo
        .expect_mock_get_all_by_period()
        .with(eq(7))
        .times(1)
        .returning(|_| {
            Ok(vec![
                plays_daily(1, (2025, 4, 2), 10, 20, 30, Some(1), Some(2)),
                plays_daily(2, (2025, 4, 1), 5, 6, 7, None, Some(1)),
                plays_daily(3, (2025, 4, 2), 1, 2, 3, Some(4), None),
            ])
        });

    let usecase = AllTrackPlaybackHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(plays_monthly_repo),
    );

    let result = usecase
        .get_all_track_playback_history(AllTrackPlaybackHistoryUsecaseInput { period: 7 })
        .await
        .unwrap();

    assert_eq!(result.chart_data.len(), 2);
    assert_eq!(result.chart_data[0].date, "2025-04-01");
    assert_eq!(result.chart_data[0].spotify, 5);
    assert_eq!(result.chart_data[1].date, "2025-04-02");
    assert_eq!(result.chart_data[1].spotify, 11);
    assert_eq!(result.chart_data[1].amazon, 5);
    assert_eq!(result.chart_data[1].youtube, 2);
}

#[tokio::test]
async fn test_get_all_track_playback_history_aggregates_monthly_rows_for_full_history() {
    let plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut plays_monthly_repo = MockMockPlaysMonthlyRepo::new();

    plays_monthly_repo
        .expect_mock_get_all()
        .times(1)
        .returning(|| {
            Ok(vec![
                plays_monthly(1, (2025, 2, 1), 1, 2, 3, 4, 5),
                plays_monthly(2, (2025, 1, 1), 10, 20, 30, 40, 50),
                plays_monthly(3, (2025, 2, 1), 10, 10, 10, 10, 10),
            ])
        });

    let usecase = AllTrackPlaybackHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(plays_monthly_repo),
    );

    let result = usecase
        .get_all_track_playback_history(AllTrackPlaybackHistoryUsecaseInput { period: -1 })
        .await
        .unwrap();

    assert_eq!(result.chart_data.len(), 2);
    assert_eq!(result.chart_data[0].date, "2025-01");
    assert_eq!(result.chart_data[0].youtube, 50);
    assert_eq!(result.chart_data[1].date, "2025-02");
    assert_eq!(result.chart_data[1].spotify, 11);
    assert_eq!(result.chart_data[1].apple, 12);
}

#[tokio::test]
async fn test_get_all_track_playback_history_rejects_invalid_period() {
    let plays_daily_repo = MockMockPlaysDailyRepo::new();
    let plays_monthly_repo = MockMockPlaysMonthlyRepo::new();

    let usecase = AllTrackPlaybackHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(plays_monthly_repo),
    );

    let result = usecase
        .get_all_track_playback_history(AllTrackPlaybackHistoryUsecaseInput { period: 99 })
        .await;

    assert!(result.is_err());
    assert_eq!(result.err().unwrap().to_string(), "Invalid period");
}
