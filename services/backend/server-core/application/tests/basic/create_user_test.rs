use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::basic::create_user_usecase::{
    CreateUserInput, CreateUserUsecase, CreateUserUsecaseTrait,
};
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("user{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("".to_string()),
        evm_addr: Some("".to_string()),
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: Some("".to_string()),
        skill: Some("".to_string()),
        x_handle: Some("".to_string()),
        instagram_handle: Some("".to_string()),
        fb_handle: Some("".to_string()),
        interest_offer: Some(OfferCategory::Creation),
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}

#[tokio::test]
async fn test_create_user_success() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let input = CreateUserInput {
        id: "user123".to_string(),
        fcm_token: Some("token123".to_string()),
        email: "test@example.com".to_string(),
        name: "testuser".to_string(),
        realname: "Test User".to_string(),
        image_url: Some("http://example.com/image.png".to_string()),
        invited_by: Some("inviter123".to_string()),
        category: UserCategory::Creator,
        primary_category: UserCategory::Creator,
    };

    let expected_user = create_test_user("user123");

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
