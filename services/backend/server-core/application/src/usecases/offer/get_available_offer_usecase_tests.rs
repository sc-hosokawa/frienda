use crate::test_support::mocks::offer_mock::MockMockOffersRepo;
use crate::usecases::offer::get_available_offer_usecase::{
    GetAvailableOfferUsecase, GetAvailableOfferUsecaseTrait,
};
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::OfferCategory;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_offer(id: i32, owner: &str, fee: i32) -> Offer {
    Offer {
        id,
        owner: owner.to_string(),
        title: format!("Test Offer {}", id),
        description: "Test Description".to_string(),
        fee,
        raid_id: None,
        deadline: None,
        place: "anywhere".to_string(),
        attention: None,
        required_skill: None,
        target_role: None,
        img_url: None,
        category: Some(OfferCategory::Creation),
        publicity: true,
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_get_available_offers_success() {
    // Arrange
    let mut mock_repo = MockMockOffersRepo::new();
    let expected_offers = vec![
        create_test_offer(1, "user1", 100),
        create_test_offer(2, "user2", 200),
        create_test_offer(3, "user3", 300),
    ];

    mock_repo
        .expect_mock_get_active_offers()
        .returning(move || Ok(expected_offers.clone()));

    let usecase = GetAvailableOfferUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.get_available_offers().await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.offers.len(), 3);
    assert_eq!(output.offers[0].id, 1);
    assert_eq!(output.offers[0].owner, "user1");
    assert_eq!(output.offers[0].fee, 100);
    assert_eq!(output.offers[1].id, 2);
    assert_eq!(output.offers[1].owner, "user2");
    assert_eq!(output.offers[1].fee, 200);
    assert_eq!(output.offers[2].id, 3);
    assert_eq!(output.offers[2].owner, "user3");
    assert_eq!(output.offers[2].fee, 300);
}

#[tokio::test]
async fn test_get_available_offers_empty() {
    // Arrange
    let mut mock_repo = MockMockOffersRepo::new();
    mock_repo
        .expect_mock_get_active_offers()
        .returning(move || Ok(vec![]));

    let usecase = GetAvailableOfferUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.get_available_offers().await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert!(output.offers.is_empty());
}

#[tokio::test]
async fn test_get_available_offers_error() {
    // Arrange
    let mut mock_repo = MockMockOffersRepo::new();
    mock_repo
        .expect_mock_get_active_offers()
        .returning(move || {
            Err(shared::error::domain_err::DomainError::DatabaseError(
                "Database error".to_string(),
            ))
        });

    let usecase = GetAvailableOfferUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.get_available_offers().await;

    // Assert
    assert!(result.is_err());
}
