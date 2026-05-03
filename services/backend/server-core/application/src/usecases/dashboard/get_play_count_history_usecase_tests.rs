use crate::test_support::mocks::{
    plays_daily_mock::MockMockPlaysDailyRepo, product_track_mock::MockMockProductTrackRepo,
    products_mock::MockMockProductsRepo, tracks_mock::MockMockTracksRepo,
};
use crate::usecases::dashboard::get_play_count_history_usecase::{
    GetAllHistroyUsecaseInput, GetISRCHistoryUsecaseInput, GetPlayCountHistoryUsecase,
    GetPlayCountHistoryUsecaseTrait, GetUPCHistoryUsecaseInput,
};
use chrono::{Datelike, Months, NaiveDate, Utc};
use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::tracks::Model as Track;
use std::collections::HashMap;
use std::sync::Arc;

fn product(upc: &str, product_type: &str) -> Product {
    Product {
        upc: upc.to_string(),
        title: format!("Release {upc}"),
        img_url: None,
        r#type: Some(product_type.to_string()),
        distributed_at: Some(NaiveDate::from_ymd_opt(2024, 1, 1).unwrap()),
        artist_id: Some("artist-1".to_string()),
    }
}

fn product_track(id: i32, upc: &str, isrc: &str, track_no: i32) -> ProductTrack {
    ProductTrack {
        id,
        upc: upc.to_string(),
        isrc: isrc.to_string(),
        track_no: Some(track_no),
    }
}

fn track(isrc: &str, title: &str) -> Track {
    Track {
        isrc: isrc.to_string(),
        img_url: None,
        title: title.to_string(),
        artist_id: Some("artist-1".to_string()),
    }
}

fn play(
    id: i32,
    isrc: Option<&str>,
    date: Option<NaiveDate>,
    spotify: i32,
    apple: i32,
    line: i32,
    sum: Option<i32>,
) -> PlaysDaily {
    PlaysDaily {
        id,
        isrc: isrc.map(str::to_string),
        date,
        spotify,
        apple,
        line,
        amazon: Some(0),
        youtube: Some(0),
        sum,
    }
}

fn monthly_window(period: i32) -> (NaiveDate, NaiveDate) {
    let today = Utc::now().date_naive();
    let first_day_this_month = NaiveDate::from_ymd_opt(today.year(), today.month(), 1).unwrap();
    let latest_month_start = first_day_this_month
        .checked_sub_months(Months::new(1))
        .unwrap();
    let start_month = latest_month_start
        .checked_sub_months(Months::new((period - 1) as u32))
        .unwrap();
    let end_date = first_day_this_month.pred_opt().unwrap();
    (start_month, end_date)
}

#[tokio::test]
async fn test_get_play_count_by_artist_aggregates_monthly_history() {
    // 全期間の月次表示では、日次行を月単位に合算し、月昇順で返すことを固定する。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
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
    // UPC の日次表示は同じ日付に複数 track があるため、日付単位にまとめて返すことを固定する。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
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

#[tokio::test]
async fn test_get_play_count_by_artist_daily_sums_same_date_and_skips_null_dates() {
    // DB 由来の NULL date/isrc で dashboard API が panic しないよう、日次集計から除外することを固定する。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let tracks_repo = MockMockTracksRepo::new();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| Ok(vec![product("UPC1", "single")]));
    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                product_track(1, "UPC1", "ISRC1", 1),
                product_track(2, "UPC1", "ISRC2", 2),
            ])
        });
    plays_daily_repo
        .expect_mock_find_by_isrcs_and_period()
        .times(1)
        .returning(|_, period| {
            assert_eq!(period, 7);
            Ok(vec![
                play(
                    1,
                    Some("ISRC1"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 2).unwrap()),
                    4,
                    1,
                    0,
                    Some(5),
                ),
                play(
                    2,
                    Some("ISRC2"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 2).unwrap()),
                    6,
                    2,
                    3,
                    Some(11),
                ),
                play(3, Some("ISRC1"), None, 99, 99, 99, Some(297)),
                play(
                    5,
                    None,
                    Some(NaiveDate::from_ymd_opt(2025, 4, 2).unwrap()),
                    99,
                    99,
                    99,
                    Some(297),
                ),
                play(
                    4,
                    Some("ISRC1"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    1,
                    1,
                    1,
                    Some(3),
                ),
            ])
        });

    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(products_repo),
        Arc::new(product_track_repo),
        Arc::new(tracks_repo),
    );

    let result = usecase
        .get_play_count_by_artist(GetAllHistroyUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            period: 7,
        })
        .await
        .expect("artist daily history succeeds");

    assert_eq!(result.chart_data.len(), 2);
    assert_eq!(result.chart_data[0].date, "2025-04-01");
    assert_eq!(result.chart_data[0].spotify, 1);
    assert_eq!(result.chart_data[1].date, "2025-04-02");
    assert_eq!(result.chart_data[1].spotify, 10);
    assert_eq!(result.chart_data[1].apple, 3);
    assert_eq!(result.chart_data[1].line, 3);
}

#[tokio::test]
async fn test_get_play_count_by_upc_daily_adds_duplicate_track_rows_and_skips_unmapped_data() {
    // 同日同一 track の複数行は別ソース由来で発生し得るため、上書きではなく合算することを固定する。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();

    product_track_repo
        .expect_mock_get_by_upc()
        .times(1)
        .returning(|_| Ok(vec![product_track(1, "UPC1", "ISRC1", 1)]));
    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .returning(|_| Ok(vec![track("ISRC1", "First")]));
    plays_daily_repo
        .expect_mock_find_by_isrcs_and_period()
        .times(1)
        .returning(|_, _| {
            Ok(vec![
                play(
                    1,
                    Some("ISRC1"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    0,
                    0,
                    0,
                    Some(4),
                ),
                play(
                    2,
                    Some("ISRC1"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    0,
                    0,
                    0,
                    Some(6),
                ),
                play(
                    3,
                    Some("UNKNOWN"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    0,
                    0,
                    0,
                    Some(100),
                ),
                play(4, Some("ISRC1"), None, 0, 0, 0, Some(100)),
                play(
                    5,
                    None,
                    Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    0,
                    0,
                    0,
                    Some(100),
                ),
            ])
        });

    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(plays_daily_repo),
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
        .expect("upc daily history succeeds");

    assert_eq!(result.chart_data.len(), 1);
    assert_eq!(
        result.chart_data[0].track_count.get("First").copied(),
        Some(10)
    );
}

#[tokio::test]
async fn test_get_play_count_by_isrc_daily_skips_null_dates_and_sorts_ascending() {
    // ISRC 単体表示でも DB の返却順や NULL date に依存せず、安定した日付昇順を守る。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();

    plays_daily_repo
        .expect_mock_find_by_isrc_and_period()
        .times(1)
        .returning(|isrc, period| {
            assert_eq!(isrc, "ISRC1");
            assert_eq!(period, 30);
            Ok(vec![
                play(
                    1,
                    Some("ISRC1"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 3).unwrap()),
                    3,
                    0,
                    0,
                    Some(3),
                ),
                play(2, Some("ISRC1"), None, 99, 99, 99, Some(297)),
                play(
                    4,
                    None,
                    Some(NaiveDate::from_ymd_opt(2025, 4, 2).unwrap()),
                    99,
                    99,
                    99,
                    Some(297),
                ),
                play(
                    3,
                    Some("ISRC1"),
                    Some(NaiveDate::from_ymd_opt(2025, 4, 1).unwrap()),
                    1,
                    0,
                    0,
                    Some(1),
                ),
            ])
        });

    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(MockMockProductsRepo::new()),
        Arc::new(MockMockProductTrackRepo::new()),
        Arc::new(MockMockTracksRepo::new()),
    );

    let result = usecase
        .get_play_count_by_isrc(GetISRCHistoryUsecaseInput {
            isrc: "ISRC1".to_string(),
            period: 30,
        })
        .await
        .expect("isrc daily history succeeds");

    assert_eq!(result.chart_data.len(), 2);
    assert_eq!(result.chart_data[0].date, "2025-04-01");
    assert_eq!(result.chart_data[1].date, "2025-04-03");
}

#[tokio::test]
async fn test_get_play_count_by_artist_monthly_includes_boundaries_and_excludes_outside_range() {
    // 月次期間は UI の期間選択と一致する必要があるため、開始月初と終了月末を inclusive に扱う。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let (start, end) = monthly_window(12);
    let before_start = start.pred_opt().unwrap();
    let after_end = end.succ_opt().unwrap();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| Ok(vec![product("UPC1", "single")]));
    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|_| Ok(vec![product_track(1, "UPC1", "ISRC1", 1)]));
    plays_daily_repo
        .expect_mock_find_by_isrcs()
        .times(1)
        .returning(move |_| {
            Ok(vec![
                play(1, Some("ISRC1"), Some(before_start), 100, 0, 0, Some(100)),
                play(2, Some("ISRC1"), Some(start), 1, 0, 0, Some(1)),
                play(3, Some("ISRC1"), Some(end), 2, 0, 0, Some(2)),
                play(5, None, Some(end), 100, 0, 0, Some(100)),
                play(4, Some("ISRC1"), Some(after_end), 100, 0, 0, Some(100)),
            ])
        });

    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(plays_daily_repo),
        Arc::new(products_repo),
        Arc::new(product_track_repo),
        Arc::new(tracks_repo),
    );

    let result = usecase
        .get_play_count_by_artist(GetAllHistroyUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            period: 12,
        })
        .await
        .expect("monthly artist history succeeds");

    assert_eq!(result.chart_data.len(), 2);
    assert_eq!(result.chart_data[0].date, start.format("%Y-%m").to_string());
    assert_eq!(result.chart_data[0].spotify, 1);
    assert_eq!(result.chart_data[1].date, end.format("%Y-%m").to_string());
    assert_eq!(result.chart_data[1].spotify, 2);
}

#[tokio::test]
async fn test_get_play_count_by_artist_invalid_period_stops_before_repository_calls() {
    // 不正な period はデータアクセス前に拒否し、無駄な DB read と部分的な副作用を避ける。
    let usecase = GetPlayCountHistoryUsecase::new(
        Arc::new(MockMockPlaysDailyRepo::new()),
        Arc::new(MockMockProductsRepo::new()),
        Arc::new(MockMockProductTrackRepo::new()),
        Arc::new(MockMockTracksRepo::new()),
    );

    let error = match usecase
        .get_play_count_by_artist(GetAllHistroyUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            period: 999,
        })
        .await
    {
        Ok(_) => panic!("invalid period should fail"),
        Err(error) => error,
    };

    assert!(error.to_string().contains("Invalid period"));
}
