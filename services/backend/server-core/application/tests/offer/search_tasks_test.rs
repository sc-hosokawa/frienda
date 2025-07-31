use crate::mocks::offer_mock::MockMockOffersRepo;
use application::usecases::offer::search_tasks_usecase::{
    SearchInput, SearchTasksUsecase, SearchTasksUsecaseTrait, SearchUsecaseOptions,
};
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_offer(id: i32) -> Offer {
    Offer {
        id,
        owner: format!("user{}", id),
        title: format!("Offer {}", id),
        description: format!("Description for offer {}", id),
        category: Some(OfferCategory::Creation),
        target_role: Some(UserCategory::Creator),
        place: "Tokyo".to_string(),
        fee: 1000,
        attention: Some("Test attention".to_string()),
        required_skill: Some("Test skill".to_string()),
        img_url: Some("http://example.com/image.jpg".to_string()),
        publicity: true,
        raid_id: None,
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        deadline: Some(chrono::Utc::now().naive_utc().to_string()),
    }
}

// 基本的な検索テスト
#[tokio::test]
async fn test_search_offers_with_empty_query() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions::default()),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions::default(),
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap().len(), 1);
}

// カテゴリーによる検索テスト
#[tokio::test]
async fn test_search_offers_by_category() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions {
                category: Some(OfferCategory::Creation),
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions {
                category: Some(OfferCategory::Creation),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap()[0].category, Some(OfferCategory::Creation));
}

// 価格範囲による検索テスト
#[tokio::test]
async fn test_search_offers_by_price_range() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions {
                min_price: Some(500),
                max_price: Some(1500),
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions {
                min_price: Some(500),
                max_price: Some(1500),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
}

// 場所による検索テスト
#[tokio::test]
async fn test_search_offers_by_place() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions {
                place: Some("Tokyo".to_string()),
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions {
                place: Some("Tokyo".to_string()),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap()[0].place, "Tokyo".to_string());
}

// ターゲットロールによる検索テスト
#[tokio::test]
async fn test_search_offers_by_target_role() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions {
                target_role: Some(UserCategory::Creator),
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions {
                target_role: Some(UserCategory::Creator),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap()[0].target_role, Some(UserCategory::Creator));
}

// ソート順による検索テスト
#[tokio::test]
async fn test_search_offers_with_sorting() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1), create_test_offer(2)];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions {
                sort_by: Some("created_at".to_string()),
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions {
                sort_by: Some("created_at".to_string()),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
}

// 検索結果が空の場合のテスト
#[tokio::test]
async fn test_search_offers_with_no_results() {
    let mut mock_repo = MockMockOffersRepo::new();
    mock_repo.expect_mock_search().returning(|_, _| Ok(vec![]));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "nonexistent".to_string(),
            options: SearchUsecaseOptions::default(),
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap().len(), 0);
}

// 複数の検索条件を組み合わせたテスト
#[tokio::test]
async fn test_search_offers_with_multiple_conditions() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq("test"),
            eq(domain::repositories::offers_repo::SearchOptions {
                category: Some(OfferCategory::Creation),
                target_role: Some(UserCategory::Creator),
                place: Some("Tokyo".to_string()),
                min_price: Some(500),
                max_price: Some(1500),
                sort_by: Some("created_at".to_string()),
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "test".to_string(),
            options: SearchUsecaseOptions {
                category: Some(OfferCategory::Creation),
                target_role: Some(UserCategory::Creator),
                place: Some("Tokyo".to_string()),
                min_price: Some(500),
                max_price: Some(1500),
                sort_by: Some("created_at".to_string()),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
}

// エラーケースのテスト
#[tokio::test]
async fn test_search_offers_with_invalid_price_range() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![];

    mock_repo
        .expect_mock_search()
        .with(
            eq(""),
            eq(domain::repositories::offers_repo::SearchOptions {
                min_price: Some(1500),
                max_price: Some(500), // 最小価格が最大価格より大きい
                ..Default::default()
            }),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "".to_string(),
            options: SearchUsecaseOptions {
                min_price: Some(1500),
                max_price: Some(500),
                ..Default::default()
            },
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap().len(), 0);
}

// 特殊文字を含むクエリのテスト
#[tokio::test]
async fn test_search_offers_with_special_characters() {
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![create_test_offer(1)];

    mock_repo
        .expect_mock_search()
        .with(
            eq("test!@#$%^&*()"),
            eq(domain::repositories::offers_repo::SearchOptions::default()),
        )
        .returning(move |_, _| Ok(expected_offers.clone()));

    let usecase = SearchTasksUsecase::new(Arc::new(mock_repo));
    let result = usecase
        .search_offers(SearchInput {
            query: "test!@#$%^&*()".to_string(),
            options: SearchUsecaseOptions::default(),
        })
        .await;

    assert!(result.is_ok());
}
