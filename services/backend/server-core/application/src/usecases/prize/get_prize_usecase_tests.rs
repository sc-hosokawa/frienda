// services/backend/server-core/application/tests/prize/get_prize_test.rs

use crate::test_support::mocks::prize_mock::MockMockPrizesRepo;
use crate::usecases::prize::get_prize_usecase::{
    GetPrizeInput, GetPrizeUsecase, GetPrizeUsecaseTrait,
};
use domain::entities::prizes::Model as Prize;
use mockall::predicate::*;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

// テストデータ作成用のヘルパー関数
fn create_test_prize(id: i32) -> Prize {
    Prize {
        id,
        name: format!("Prize {}", id),
        description: format!("Description for prize {}", id),
        img_url: Some(format!("http://example.com/prize{}.jpg", id)),
        point: 100,
        representation: "".to_string(),
        condition: None,
        publicity: false,
    }
}

#[tokio::test]
async fn test_get_prize_success() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let prize_id = 1;
    let expected_prize = create_test_prize(prize_id);

    mock_repo
        .expect_mock_get_by_id()
        .with(eq(prize_id))
        .returning(move |_| Ok(Some(expected_prize.clone())));

    let usecase = GetPrizeUsecase::new(Arc::new(mock_repo));
    let input = GetPrizeInput { id: prize_id };

    // Act
    let result = usecase.get_prize(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.prize.id, prize_id);
    assert_eq!(output.prize.name, format!("Prize {}", prize_id));
}

#[tokio::test]
async fn test_get_prize_not_found() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let prize_id = 999;

    mock_repo
        .expect_mock_get_by_id()
        .with(eq(prize_id))
        .returning(|_| Ok(None));

    let usecase = GetPrizeUsecase::new(Arc::new(mock_repo));
    let input = GetPrizeInput { id: prize_id };

    // Act
    let result = usecase.get_prize(input).await;

    // Assert
    assert!(result.is_err());
}

#[tokio::test]
async fn test_get_prize_repository_error() {
    // Arrange
    let mut mock_repo = MockMockPrizesRepo::new();
    let prize_id = 1;

    mock_repo
        .expect_mock_get_by_id()
        .with(eq(prize_id))
        .returning(|_| Err(DomainError::DatabaseError("Database error".to_string())));

    let usecase = GetPrizeUsecase::new(Arc::new(mock_repo));
    let input = GetPrizeInput { id: prize_id };

    // Act
    let result = usecase.get_prize(input).await;

    // Assert
    assert!(result.is_err());
}
