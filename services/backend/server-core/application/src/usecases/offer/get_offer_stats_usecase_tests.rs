use crate::test_support::mocks::offer_mock::MockMockOffersRepo;
use crate::test_support::mocks::offer_user_mock::MockMockOfferUserRepo;
use crate::usecases::offer::get_offer_stats_usecase::{
    GetOfferStatsInput, GetOfferStatsUsecase, GetOfferStatsUsecaseTrait,
};
use domain::repositories::offer_user_repo::OfferStatsAggregate;
use mockall::predicate::*;
use std::sync::Arc;

#[tokio::test]
async fn test_get_offer_stats_success() {
    // Arrange
    let mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();

    let user_id = "user123";

    mock_offer_user_repo
        .expect_mock_aggregate_stats_by_user_id()
        .with(eq(user_id.to_string()))
        .times(1)
        .returning(|_| {
            Ok(OfferStatsAggregate {
                total_offers: 3,
                ongoing_offers: 1,
                applied_offers: 1,
                completed_offers: 1,
                total_earnings: 1000,
            })
        });

    let usecase =
        GetOfferStatsUsecase::new(Arc::new(mock_offers_repo), Arc::new(mock_offer_user_repo));

    // Act
    let result = usecase
        .get_stats(GetOfferStatsInput {
            user_id: user_id.to_string(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let stats = result.unwrap();
    assert_eq!(stats.total_offers, 3);
    assert_eq!(stats.ongoing_offers, 1);
    assert_eq!(stats.applied_offers, 1);
    assert_eq!(stats.completed_offers, 1);
    assert_eq!(stats.total_earnings, 1000);
}

#[tokio::test]
async fn test_get_offer_stats_empty() {
    // Arrange
    let mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();

    mock_offer_user_repo
        .expect_mock_aggregate_stats_by_user_id()
        .times(1)
        .returning(|_| Ok(OfferStatsAggregate::default()));

    let usecase =
        GetOfferStatsUsecase::new(Arc::new(mock_offers_repo), Arc::new(mock_offer_user_repo));

    // Act
    let result = usecase
        .get_stats(GetOfferStatsInput {
            user_id: "user123".to_string(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let stats = result.unwrap();
    assert_eq!(stats.total_offers, 0);
    assert_eq!(stats.ongoing_offers, 0);
    assert_eq!(stats.applied_offers, 0);
    assert_eq!(stats.completed_offers, 0);
    assert_eq!(stats.total_earnings, 0);
}

#[tokio::test]
async fn test_get_offer_stats_returns_error_when_count_exceeds_i32() {
    // offer stats は UI DTO が i32 なので、aggregate count が範囲外なら truncate せず error にする。
    let mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();

    mock_offer_user_repo
        .expect_mock_aggregate_stats_by_user_id()
        .times(1)
        .returning(|_| {
            Ok(OfferStatsAggregate {
                total_offers: i64::from(i32::MAX) + 1,
                ..Default::default()
            })
        });

    let usecase =
        GetOfferStatsUsecase::new(Arc::new(mock_offers_repo), Arc::new(mock_offer_user_repo));

    let error = match usecase
        .get_stats(GetOfferStatsInput {
            user_id: "user123".to_string(),
        })
        .await
    {
        Ok(_) => panic!("overflow aggregate should fail"),
        Err(error) => error,
    };

    assert!(error.to_string().contains("total_offers"));
}
