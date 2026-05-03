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

#[tokio::test]
async fn test_get_products_groups_products_and_sorts_tracks() {
    // リリース一覧は product 種別で分け、track_no 順に track を並べる dashboard 契約を固定する。
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
        .expect_mock_find_by_artist_id()
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
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![
                product(
                    "S-OLD",
                    "Old Single",
                    Some("single"),
                    Some(NaiveDate::from_ymd_opt(2024, 1, 1).unwrap()),
                ),
                product(
                    "S-NEW",
                    "New Single",
                    Some("single"),
                    Some(NaiveDate::from_ymd_opt(2024, 6, 1).unwrap()),
                ),
                product("S-NONE", "Undated Single", Some("single"), None),
                product(
                    "OTHER",
                    "Other",
                    Some("compilation"),
                    Some(NaiveDate::from_ymd_opt(2025, 1, 1).unwrap()),
                ),
            ])
        });

    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                product_track(1, "S-NEW", "N-NULL", None),
                product_track(2, "S-NEW", "N-ONE", Some(1)),
                product_track(3, "S-OLD", "O-ONE", Some(1)),
                product_track(4, "S-NONE", "U-ONE", Some(1)),
                product_track(5, "OTHER", "X-ONE", Some(1)),
            ])
        });

    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .returning(|_| {
            Ok(vec![
                track("N-NULL", "No Number"),
                track("N-ONE", "First"),
                track("O-ONE", "Old"),
                track("U-ONE", "Undated"),
                track("X-ONE", "Ignored"),
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
async fn test_get_track_info_succeeds_when_track_has_no_products() {
    // track 自体が存在するなら、product 紐付けが未登録でも詳細画面を空 product 配列で表示できる。
    let mut products_repo = MockMockProductsRepo::new();
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
    products_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .with(mockall::predicate::eq(Vec::<String>::new()))
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
