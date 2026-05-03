use crate::test_support::mocks::{
    plays_daily_mock::MockMockPlaysDailyRepo, product_track_mock::MockMockProductTrackRepo,
    products_mock::MockMockProductsRepo, tracks_mock::MockMockTracksRepo,
};
use crate::usecases::dashboard::get_play_count_history_usecase::{
    GetAllHistroyUsecaseInput, GetISRCHistoryUsecaseInput, GetPlayCountHistoryUsecase,
    GetPlayCountHistoryUsecaseTrait, GetUPCHistoryUsecaseInput,
};
use chrono::{Datelike, Months, NaiveDate, Utc};
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::repositories::plays_daily_repo::{
    PlayCountDspHistoryAggregate, PlayCountTrackHistoryAggregate,
};
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

fn dsp_history(date: &str, spotify: i64, apple: i64, line: i64) -> PlayCountDspHistoryAggregate {
    PlayCountDspHistoryAggregate {
        date: date.to_string(),
        spotify,
        apple,
        line,
        amazon: 0,
        youtube: 0,
    }
}

fn track_history(date: &str, track_title: &str, total: i64) -> PlayCountTrackHistoryAggregate {
    PlayCountTrackHistoryAggregate {
        date: date.to_string(),
        track_title: track_title.to_string(),
        total,
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
        .expect_mock_aggregate_monthly_dsp_history_by_isrcs()
        .times(1)
        .returning(|isrcs, start, end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string()]);
            assert!(start.is_none());
            assert!(end.is_none());
            Ok(vec![
                dsp_history("2025-03", 12, 8, 0),
                dsp_history("2025-04", 1, 1, 1),
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
    let tracks_repo = MockMockTracksRepo::new();

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

    plays_daily_repo
        .expect_mock_aggregate_daily_track_history_by_isrcs()
        .times(1)
        .returning(|isrcs, start, end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string(), "ISRC2".to_string()]);
            assert!(start <= end);
            Ok(vec![
                track_history("2025-04-01", "First", 1),
                track_history("2025-04-01", "Second", 2),
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
        .expect_mock_aggregate_daily_dsp_history_by_isrcs()
        .times(1)
        .returning(|isrcs, start, end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string(), "ISRC2".to_string()]);
            assert!(start <= end);
            Ok(vec![
                dsp_history("2025-04-01", 1, 1, 1),
                dsp_history("2025-04-02", 10, 3, 3),
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
async fn test_get_play_count_by_upc_daily_adds_duplicate_track_aggregate_rows() {
    // repository 集計後に同日同一 track が重複しても、上書きではなく合算する防御を固定する。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let tracks_repo = MockMockTracksRepo::new();

    product_track_repo
        .expect_mock_get_by_upc()
        .times(1)
        .returning(|_| Ok(vec![product_track(1, "UPC1", "ISRC1", 1)]));
    plays_daily_repo
        .expect_mock_aggregate_daily_track_history_by_isrcs()
        .times(1)
        .returning(|isrcs, start, end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string()]);
            assert!(start <= end);
            Ok(vec![
                track_history("2025-04-01", "First", 4),
                track_history("2025-04-01", "First", 6),
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
async fn test_get_play_count_by_upc_monthly_uses_track_history_aggregate() {
    // UPC の月次 history も全日次行を取得せず、DB 側で月/track title 単位に集計した結果をそのまま返す。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let (start, end) = monthly_window(12);

    product_track_repo
        .expect_mock_get_by_upc()
        .times(1)
        .returning(|_| {
            Ok(vec![
                product_track(1, "UPC1", "ISRC1", 1),
                product_track(2, "UPC1", "ISRC2", 2),
            ])
        });
    plays_daily_repo
        .expect_mock_aggregate_monthly_track_history_by_isrcs()
        .times(1)
        .returning(move |isrcs, actual_start, actual_end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string(), "ISRC2".to_string()]);
            assert_eq!(actual_start, Some(start));
            assert_eq!(actual_end, Some(end));
            Ok(vec![
                track_history("2026-01", "First", 10),
                track_history("2026-01", "Second", 20),
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
            period: 12,
        })
        .await
        .expect("upc monthly history succeeds");

    assert_eq!(result.chart_data.len(), 1);
    assert_eq!(result.chart_data[0].date, "2026-01");
    assert_eq!(
        result.chart_data[0].track_count.get("First").copied(),
        Some(10)
    );
    assert_eq!(
        result.chart_data[0].track_count.get("Second").copied(),
        Some(20)
    );
}

#[tokio::test]
async fn test_get_play_count_by_isrc_daily_skips_null_dates_and_sorts_ascending() {
    // ISRC 単体表示でも DB の返却順や NULL date に依存せず、安定した日付昇順を守る。
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();

    plays_daily_repo
        .expect_mock_aggregate_daily_dsp_history_by_isrcs()
        .times(1)
        .returning(|isrcs, start, end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string()]);
            assert!(start <= end);
            Ok(vec![
                dsp_history("2025-04-01", 1, 0, 0),
                dsp_history("2025-04-03", 3, 0, 0),
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

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| Ok(vec![product("UPC1", "single")]));
    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|_| Ok(vec![product_track(1, "UPC1", "ISRC1", 1)]));
    plays_daily_repo
        .expect_mock_aggregate_monthly_dsp_history_by_isrcs()
        .times(1)
        .returning(move |isrcs, actual_start, actual_end| {
            assert_eq!(isrcs, vec!["ISRC1".to_string()]);
            assert_eq!(actual_start, Some(start));
            assert_eq!(actual_end, Some(end));
            Ok(vec![
                dsp_history(&start.format("%Y-%m").to_string(), 1, 0, 0),
                dsp_history(&end.format("%Y-%m").to_string(), 2, 0, 0),
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
