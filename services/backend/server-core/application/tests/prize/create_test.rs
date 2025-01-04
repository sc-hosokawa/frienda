use crate::mocks::prize_mock::MockMockPrizesRepo;
use application::usecases::prize::create_prize_usecase::{
    CreatePrizeInput, CreatePrizeUsecase, CreatePrizeUsecaseTrait,
};
use domain::entities::prizes::Model as Prize;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

fn create_test_prize(id: i32) -> Prize {
    Prize {
        id,
        name: format!("Prize {}", id),
        point: 100,
        description: format!("Description for prize {}", id),
        representation: format!("Representation {}", id),
        condition: Some(format!("Condition {}", id)),
        img_url: Some(format!("http://example.com/prize{}.jpg", id)),
        publicity: true,
    }
}

#[tokio::test]
async fn test_create_prize_success() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let input = CreatePrizeInput {
        name: "Test Prize".to_string(),
        point: 100,
        description: "Test Description".to_string(),
        representation: "Test Representation".to_string(),
        condition: Some("Test Condition".to_string()),
        img_url: Some("http://example.com/test.jpg".to_string()),
    };

    let expected_prize = create_test_prize(1);

    mock_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_prize.clone()));

    let usecase = CreatePrizeUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_ok());
    // assert_eq!(result.unwrap(), expected_prize.id);
}

#[tokio::test]
async fn test_create_prize_without_optional_fields() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let input = CreatePrizeInput {
        name: "Test Prize".to_string(),
        point: 100,
        description: "Test Description".to_string(),
        representation: "Test Representation".to_string(),
        condition: None,
        img_url: None,
    };

    let expected_prize = Prize {
        id: 1,
        name: "Test Prize".to_string(),
        point: 100,
        description: "Test Description".to_string(),
        representation: "Test Representation".to_string(),
        condition: None,
        img_url: None,
        publicity: true,
    };

    mock_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_prize.clone()));

    let usecase = CreatePrizeUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_ok());
    // assert_eq!(result.unwrap(), expected_prize.id);
}

#[tokio::test]
async fn test_create_prize_repository_error() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let input = CreatePrizeInput {
        name: "Test Prize".to_string(),
        point: 100,
        description: "Test Description".to_string(),
        representation: "Test Representation".to_string(),
        condition: None,
        img_url: None,
    };

    mock_repo
        .expect_mock_create()
        .returning(|_| Err(DomainError::DatabaseError("Database error".to_string())));

    let usecase = CreatePrizeUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_err());
}
