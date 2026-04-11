use crate::test_support::mocks::user_mock::MockMockUsersRepo;
use crate::usecases::basic::create_user_usecase::{
    CreateUserInput, CreateUserUsecase, CreateUserUsecaseTrait,
};
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;

// テストデータ作成用のヘルパー関数
fn create_test_user(user_id: &str, category: UserCategory) -> User {
    User {
        id: user_id.to_string(),
        email: format!("{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("test_token".to_string()),
        username: format!("User {}", user_id),
        realname: "Test User".to_string(),
        img_url: Some("http://example.com/image.jpg".to_string()),
        evm_addr: Some("0x123...".to_string()),
        status: UserStatus::Joined,
        invited_by: Some("inviter123".to_string()),
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: category.clone(),
        primary_category: category.clone(),
        publicity: true,
        greeting: Some("Hello!".to_string()),
        skill: Some("Testing".to_string()),
        x_handle: Some("@test".to_string()),
        instagram_handle: Some("@test".to_string()),
        fb_handle: Some("@test".to_string()),
        interest_offer: Some(OfferCategory::Creation),
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}

fn create_test_input(user_id: &str, category: UserCategory) -> CreateUserInput {
    CreateUserInput {
        id: user_id.to_string(),
        fcm_token: Some("test_token".to_string()),
        email: format!("{}@example.com", user_id),
        name: format!("User {}", user_id),
        realname: "Test User".to_string(),
        image_url: Some("http://example.com/image.jpg".to_string()),
        invited_by: Some("inviter123".to_string()),
        category: category.clone(),
        primary_category: category.clone(),
    }
}

#[tokio::test]
async fn test_create_user_musician() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let input = create_test_input("musician1", UserCategory::Musician);
    let expected_user = create_test_user("musician1", UserCategory::Musician);

    mock_repo.expect_mock_create().returning({
        let expected_user = expected_user.clone();
        move |_| Ok(expected_user.clone())
    });

    let usecase = CreateUserUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), expected_user);
}

#[tokio::test]
async fn test_create_user_creator() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let input = create_test_input("creator1", UserCategory::Creator);
    let expected_user = create_test_user("creator1", UserCategory::Creator);

    mock_repo.expect_mock_create().returning({
        let expected_user = expected_user.clone();
        move |_| Ok(expected_user.clone())
    });

    let usecase = CreateUserUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), expected_user);
}

#[tokio::test]
async fn test_create_user_error() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let input = create_test_input("error_user", UserCategory::Musician);

    mock_repo.expect_mock_create().returning(|_| {
        Err(shared::error::domain_err::DomainError::DatabaseError(
            "Database error".to_string(),
        ))
    });

    let usecase = CreateUserUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_err());
}
