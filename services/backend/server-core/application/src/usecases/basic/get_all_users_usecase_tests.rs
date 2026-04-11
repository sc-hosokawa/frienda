use crate::test_support::mocks::user_mock::MockMockUsersRepo;
use crate::usecases::basic::get_all_users_usecase::{GetAllUsersUsecase, GetAllUsersUsecaseTrait};
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

// テストデータ作成用のヘルパー関数
fn create_test_user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("user{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("https://example.com/image.jpg".to_string()),
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
async fn test_get_all_users_success() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let test_users = vec![
        create_test_user("1"),
        create_test_user("2"),
        create_test_user("3"),
    ];

    mock_repo
        .expect_mock_get_all_users()
        .returning(move || Ok(test_users.clone()));

    let usecase = GetAllUsersUsecase::new(Arc::new(mock_repo));

    // Act
    let users_data = usecase
        .get_all_users()
        .await
        .expect("listing all users should succeed");

    // Assert
    assert_eq!(users_data.users.len(), 3);
    assert_eq!(users_data.users[0].id, "1");
    assert_eq!(users_data.users[0].name, "User 1");
    assert_eq!(
        users_data.users[0].image_url,
        Some("https://example.com/image.jpg".to_string())
    );
}

#[tokio::test]
async fn test_get_all_users_except_me_success() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    let test_users = vec![
        create_test_user("1"),
        create_test_user("2"),
        create_test_user("3"),
    ];

    mock_repo
        .expect_mock_get_all_users()
        .returning(move || Ok(test_users.clone()));

    let usecase = GetAllUsersUsecase::new(Arc::new(mock_repo));

    // Act
    let users_data = usecase
        .get_all_users_except_me("1".to_string())
        .await
        .expect("listing users except caller should succeed");

    // Assert
    assert_eq!(users_data.users.len(), 2);
    assert_eq!(users_data.users[0].id, "2");
    assert_eq!(users_data.users[1].id, "3");
}

#[tokio::test]
async fn test_get_all_users_repository_error() {
    // Arrange
    let mut mock_repo = MockMockUsersRepo::new();
    mock_repo
        .expect_mock_get_all_users()
        .returning(|| Err(DomainError::DatabaseError("Database error".to_string())));

    let usecase = GetAllUsersUsecase::new(Arc::new(mock_repo));

    // Act
    let error = match usecase.get_all_users().await {
        Ok(_) => panic!("repository failure should be propagated"),
        Err(error) => error,
    };

    // Assert
    assert!(error.to_string().contains("Database error"));
}
