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
use domain::repositories::products_repo::DashboardProductRow;
use std::sync::Arc;

fn product(
    upc: &str,
    title: &str,
    product_type: Option<&str>,
    distributed_at: Option<NaiveDate>,
) -> Product {
    Product {
        upc: upc.to_string(),
        title: title.to_string(),
        img_url: None,
        r#type: product_type.map(str::to_string),
        distributed_at,
        artist_id: Some("artist-1".to_string()),
    }
}

fn product_track(id: i32, upc: &str, isrc: &str, track_no: Option<i32>) -> ProductTrack {
    ProductTrack {
        id,
        upc: upc.to_string(),
        isrc: isrc.to_string(),
        track_no,
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

fn dashboard_row(product: Product, track: Option<Track>) -> DashboardProductRow {
    DashboardProductRow { product, track }
}

#[tokio::test]
async fn test_get_products_groups_products_and_sorts_tracks() {
    // リリース一覧は product 種別で分け、track_no 順に track を並べる dashboard 契約を固定する。
    let mut products_repo = MockMockProductsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();

    products_repo
        .expect_mock_find_dashboard_products_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![
                dashboard_row(
                    product(
                        "SINGLE1",
                        "Single",
                        Some("single"),
                        Some(NaiveDate::from_ymd_opt(2024, 5, 1).unwrap()),
                    ),
                    Some(track("S-1", "Single Track")),
                ),
                dashboard_row(
                    product(
                        "ALBUM1",
                        "Album",
                        Some("album"),
                        Some(NaiveDate::from_ymd_opt(2024, 2, 1).unwrap()),
                    ),
                    Some(track("A-1", "Album Track 1")),
                ),
                dashboard_row(
                    product(
                        "ALBUM1",
                        "Album",
                        Some("album"),
                        Some(NaiveDate::from_ymd_opt(2024, 2, 1).unwrap()),
                    ),
                    Some(track("A-2", "Album Track 2")),
                ),
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
    // track 詳細は存在しない ISRC を明確な not found として扱い、後続 repository を呼ばない。
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

#[tokio::test]
async fn test_get_products_empty_artist_short_circuits_related_repositories() {
    // artist に product がない場合は空カテゴリを返し、不要な product_track/tracks read を発生させない。
    let mut products_repo = MockMockProductsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();

    products_repo
        .expect_mock_find_dashboard_products_by_artist_id()
        .times(1)
        .returning(|_| Ok(vec![]));

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
        .expect("empty artist products succeeds");

    assert!(result.album.is_empty());
    assert!(result.single.is_empty());
    assert!(result.ep.is_empty());
}

#[tokio::test]
async fn test_get_products_sorts_products_by_distribution_date_and_keeps_unknown_type_out() {
    // 未分類 type は UI の既知カテゴリへ混ぜず、日付なし release は一覧末尾に回す。
    let mut products_repo = MockMockProductsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();

    products_repo
        .expect_mock_find_dashboard_products_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![
                dashboard_row(
                    product(
                        "S-NEW",
                        "New Single",
                        Some("single"),
                        Some(NaiveDate::from_ymd_opt(2024, 6, 1).unwrap()),
                    ),
                    Some(track("N-ONE", "First")),
                ),
                dashboard_row(
                    product(
                        "S-NEW",
                        "New Single",
                        Some("single"),
                        Some(NaiveDate::from_ymd_opt(2024, 6, 1).unwrap()),
                    ),
                    Some(track("N-NULL", "No Number")),
                ),
                dashboard_row(
                    product(
                        "S-OLD",
                        "Old Single",
                        Some("single"),
                        Some(NaiveDate::from_ymd_opt(2024, 1, 1).unwrap()),
                    ),
                    Some(track("O-ONE", "Old")),
                ),
                dashboard_row(
                    product("S-NONE", "Undated Single", Some("single"), None),
                    Some(track("U-ONE", "Undated")),
                ),
                dashboard_row(
                    product(
                        "OTHER",
                        "Other",
                        Some("compilation"),
                        Some(NaiveDate::from_ymd_opt(2025, 1, 1).unwrap()),
                    ),
                    Some(track("X-ONE", "Ignored")),
                ),
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

    assert_eq!(result.single.len(), 3);
    assert_eq!(result.single[0].product.upc, "S-NEW");
    assert_eq!(result.single[1].product.upc, "S-OLD");
    assert_eq!(result.single[2].product.upc, "S-NONE");
    assert_eq!(result.single[0].tracks[0].title, "First");
    assert_eq!(result.single[0].tracks[1].title, "No Number");
    assert!(result.album.is_empty());
    assert!(result.ep.is_empty());
}

#[tokio::test]
async fn test_get_products_keeps_product_without_track_rows() {
    // LEFT JOIN の read model では track 未登録の release も dashboard から消えないことを固定する。
    let mut products_repo = MockMockProductsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();

    products_repo
        .expect_mock_find_dashboard_products_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![dashboard_row(
                product(
                    "ALBUM-NO-TRACK",
                    "Album Without Tracks",
                    Some("album"),
                    Some(NaiveDate::from_ymd_opt(2024, 3, 1).unwrap()),
                ),
                None,
            )])
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

    assert_eq!(result.album.len(), 1);
    assert_eq!(result.album[0].product.upc, "ALBUM-NO-TRACK");
    assert!(result.album[0].tracks.is_empty());
}

#[tokio::test]
async fn test_get_track_info_succeeds_when_track_has_no_products() {
    // mapping がない track は product read を省略し、空配列で返すことで不要な DB call を防ぐ。
    let products_repo = MockMockProductsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();

    tracks_repo
        .expect_mock_get_by_isrc()
        .times(1)
        .returning(|_| Ok(Some(track("ISRC1", "Standalone"))));
    product_track_repo
        .expect_mock_get_by_isrc()
        .times(1)
        .returning(|_| Ok(vec![]));

    let usecase = GetProductsUsecase::new(
        Arc::new(products_repo),
        Arc::new(tracks_repo),
        Arc::new(product_track_repo),
    );

    let result = usecase
        .get_track_info("ISRC1".to_string())
        .await
        .expect("track info succeeds without products");

    assert_eq!(result.track.title, "Standalone");
    assert!(result.product.is_empty());
}

#[tokio::test]
async fn test_get_track_info_deduplicates_upcs_before_loading_products() {
    // 同一 ISRC が同じ UPC に重複して紐付いても、release read は順序を保った一意な UPC だけにする。
    let mut products_repo = MockMockProductsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();

    tracks_repo
        .expect_mock_get_by_isrc()
        .times(1)
        .returning(|_| Ok(Some(track("ISRC1", "Mapped Track"))));
    product_track_repo
        .expect_mock_get_by_isrc()
        .times(1)
        .returning(|_| {
            Ok(vec![
                product_track(1, "UPC1", "ISRC1", Some(1)),
                product_track(2, "UPC1", "ISRC1", Some(2)),
                product_track(3, "UPC2", "ISRC1", Some(3)),
            ])
        });
    products_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .with(mockall::predicate::eq(vec![
            "UPC1".to_string(),
            "UPC2".to_string(),
        ]))
        .returning(|_| {
            Ok(vec![
                product("UPC1", "Release 1", Some("single"), None),
                product("UPC2", "Release 2", Some("album"), None),
            ])
        });

    let usecase = GetProductsUsecase::new(
        Arc::new(products_repo),
        Arc::new(tracks_repo),
        Arc::new(product_track_repo),
    );

    let result = usecase
        .get_track_info("ISRC1".to_string())
        .await
        .expect("track info succeeds");

    assert_eq!(result.product.len(), 2);
    assert_eq!(result.product[0].upc, "UPC1");
    assert_eq!(result.product[1].upc, "UPC2");
}
