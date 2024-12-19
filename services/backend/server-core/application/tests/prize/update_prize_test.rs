use crate::mocks::prize_mock::MockMockPrizesRepo;
use application::usecases::prize::update_prize_usecase::{
    UpdatePrizeInput, UpdatePrizeUsecase, UpdatePrizeUsecaseTrait,
};
use domain::entities::prizes::Model as Prize;
use mockall::predicate::*;
use std::sync::Arc;

// テストデータ生成用のヘルパー関数
fn create_test_prize(id: i32) -> Prize {
    Prize {
        id,
        name: format!("Prize {}", id),
        point: 100,
        description: format!("Description for prize {}", id),
        representation: "test_representation".to_string(),
        condition: Some(format!("Condition {}", id)),
        img_url: Some(format!("http://example.com/prize{}.jpg", id)),
        publicity: true,
    }
}

#[tokio::test]
async fn test_update_prize_success() {
    // Arrange
    let mut prizes_repo = MockMockPrizesRepo::new();
    let prize_id = 1;

    let input = UpdatePrizeInput {
        id: prize_id,
        name: Some("Updated Prize".to_string()),
        point: Some(200),
        description: Some("Updated Description".to_string()),
        representation: Some("updated_representation".to_string()),
        condition: Some("Updated Condition".to_string()),
        img_url: Some("http://example.com/updated.jpg".to_string()),
        publicity: Some(false),
    };

    let initial_prize = create_test_prize(prize_id);
    let mut updated_prize = initial_prize.clone();
    updated_prize.name = "Updated Prize".to_string();
    updated_prize.point = 200;
    updated_prize.description = "Updated Description".to_string();
    updated_prize.representation = "updated_representation".to_string();
    updated_prize.condition = Some("Updated Condition".to_string());
    updated_prize.img_url = Some("http://example.com/updated.jpg".to_string());
    updated_prize.publicity = false;

    let initial_prize_for_mock = initial_prize.clone();
    let updated_prize_for_mock = updated_prize.clone();

    prizes_repo
        .expect_mock_get_by_id()
        .with(eq(prize_id))
        .returning(move |_| Ok(Some(initial_prize_for_mock.clone())));

    prizes_repo
        .expect_mock_update()
        .returning(move |_| Ok(updated_prize_for_mock.clone()));

    let usecase = UpdatePrizeUsecase::new(Arc::new(prizes_repo));

    // Act
    let result = usecase.update(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), prize_id);
}

#[tokio::test]
async fn test_update_prize_not_found() {
    // Arrange
    let mut prizes_repo = MockMockPrizesRepo::new();
    let prize_id = 999;

    let input = UpdatePrizeInput {
        id: prize_id,
        name: Some("Updated Prize".to_string()),
        point: None,
        description: None,
        representation: None,
        condition: None,
        img_url: None,
        publicity: None,
    };

    prizes_repo
        .expect_mock_get_by_id()
        .with(eq(prize_id))
        .returning(|_| Ok(None));

    let usecase = UpdatePrizeUsecase::new(Arc::new(prizes_repo));

    // Act
    let result = usecase.update(input).await;

    // Assert
    assert!(result.is_err());
    assert_eq!(result.unwrap_err().to_string(), "Prize not found");
}

#[tokio::test]
async fn test_update_prize_partial_update() {
    // Arrange
    let mut prizes_repo = MockMockPrizesRepo::new();
    let prize_id = 1;

    let input = UpdatePrizeInput {
        id: prize_id,
        name: Some("Updated Prize".to_string()),
        point: None,
        description: None,
        representation: None,
        condition: None,
        img_url: None,
        publicity: None,
    };

    let initial_prize = create_test_prize(prize_id);
    let mut updated_prize = initial_prize.clone();
    updated_prize.name = "Updated Prize".to_string();

    let initial_prize_for_mock = initial_prize.clone();
    let updated_prize_for_mock = updated_prize.clone();

    prizes_repo
        .expect_mock_get_by_id()
        .with(eq(prize_id))
        .returning(move |_| Ok(Some(initial_prize_for_mock.clone())));

    prizes_repo
        .expect_mock_update()
        .returning(move |_| Ok(updated_prize_for_mock.clone()));

    let usecase = UpdatePrizeUsecase::new(Arc::new(prizes_repo));

    // Act
    let result = usecase.update(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), prize_id);
}
