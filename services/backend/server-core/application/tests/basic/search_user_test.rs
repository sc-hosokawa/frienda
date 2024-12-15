use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::basic::search_users_usecase::{
    SearchUsersInput, SearchUsersUsecase, SearchUsersUsecaseTrait,
};
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use shared::error::domain_err::DomainError;
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
async fn test_search_users_success() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let expected_users = vec![create_test_user("test_user")];
    mock_repo
        .expect_mock_search_users()
        .withf(|username| username == "test_user")
        .returning(move |_| Ok(expected_users.clone()));

    let usecase = SearchUsersUsecase::new(Arc::new(mock_repo));

    // Act
    let input = SearchUsersInput {
        username: "test_user".to_string(),
    };
    let result = usecase.search_users(input).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.users.len(), 1);
    // さらに詳細なアサーションを追加
}

#[tokio::test]
async fn test_search_users_failure() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    mock_repo
        .expect_mock_search_users()
        .withf(|username| username == "non_existent_user")
        .returning(|_| Err(DomainError::NotFound));

    let usecase = SearchUsersUsecase::new(Arc::new(mock_repo));

    // Act
    let input = SearchUsersInput {
        username: "non_existent_user".to_string(),
    };
    let result = usecase.search_users(input).await;

    // Assert
    assert!(result.is_err());
    // エラーの種類を確認するアサーションを追加
}
