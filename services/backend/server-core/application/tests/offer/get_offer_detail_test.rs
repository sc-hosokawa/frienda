use crate::mocks::offer_mock::MockMockOffersRepo;
use crate::mocks::offer_user_mock::MockMockOfferUserRepo;
use application::usecases::offer::get_offer_stats_usecase::{
    GetOfferStatsInput, GetOfferStatsUsecase, GetOfferStatsUsecaseTrait,
};
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::OfferStatus;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_offer_user(id: i32, user_id: &str, offer_id: i32, status: OfferStatus) -> OfferUser {
    OfferUser {
        id,
        user_id: user_id.to_string(),
        offer_id,
        status,
    }
}

fn create_test_offer(id: i32, fee: i32) -> Offer {
    Offer {
        id,
        owner: "owner".to_string(),
        title: format!("Test Offer {}", id),
        description: "Test Description".to_string(),
        fee,
        place: "Test Place".to_string(),
        attention: None,
        required_skill: None,
        target_role: None,
        img_url: None,
        publicity: true,
        raid_id: None,
        category: None,
        deadline: None,
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_get_offer_stats_success() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();

    let user_id = "user123";
    let offer_users = vec![
        create_test_offer_user(1, user_id, 1, OfferStatus::Ongoing),
        create_test_offer_user(2, user_id, 2, OfferStatus::Applied),
        create_test_offer_user(3, user_id, 3, OfferStatus::Finished),
    ];

    mock_offer_user_repo
        .expect_mock_get_by_user_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(offer_users.clone()));

    mock_offers_repo
        .expect_mock_get_by_id()
        .with(eq(3))
        .returning(|_| Ok(Some(create_test_offer(3, 1000))));

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
        .expect_mock_get_by_user_id()
        .returning(|_| Ok(vec![]));

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
