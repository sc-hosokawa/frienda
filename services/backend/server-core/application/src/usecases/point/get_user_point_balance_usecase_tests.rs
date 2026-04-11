use crate::test_support::mocks::user_mock::MockMockUsersRepo;
use crate::usecases::point::get_user_point_balance_usecase::{
    GetUserPointBalanceInput, GetUserPointBalanceUsecase, GetUserPointBalanceUsecaseTrait,
};
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_user_with_balance(user_id: &str, fsp: i32, fsp_temp: i32, credential: i32) -> User {
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
        fsp,
        fsp_temp,
        credential,
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
async fn test_get_user_point_balance_success() {
    // Arrange
    let mut mock_users_repo = MockMockUsersRepo::new();
    let user_id = "user123";
    let expected_user = create_test_user_with_balance(user_id, 1000, 500, 100);

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(Some(expected_user.clone())));

    let usecase = GetUserPointBalanceUsecase::new(Arc::new(mock_users_repo));

    // Act
    let result = usecase
        .get_user_point_balance(GetUserPointBalanceInput {
            user_id: user_id.to_string(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let balance = result.unwrap();
    assert_eq!(balance.fsp_balance, 1000);
    assert_eq!(balance.fsp_balance_temp, 500);
    assert_eq!(balance.credential_balance, 100);
}

#[tokio::test]
async fn test_get_user_point_balance_user_not_found() {
    // Arrange
    let mut mock_users_repo = MockMockUsersRepo::new();
    let user_id = "nonexistent_user";

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(|_| Ok(None));

    let usecase = GetUserPointBalanceUsecase::new(Arc::new(mock_users_repo));

    // Act
    let result = usecase
        .get_user_point_balance(GetUserPointBalanceInput {
            user_id: user_id.to_string(),
        })
        .await;

    // Assert
    assert!(result.is_err());
}

#[tokio::test]
async fn test_get_user_point_balance_zero_balance() {
    // Arrange
    let mut mock_users_repo = MockMockUsersRepo::new();
    let user_id = "user123";
    let expected_user = create_test_user_with_balance(user_id, 0, 0, 0);

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(Some(expected_user.clone())));

    let usecase = GetUserPointBalanceUsecase::new(Arc::new(mock_users_repo));

    // Act
    let result = usecase
        .get_user_point_balance(GetUserPointBalanceInput {
            user_id: user_id.to_string(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let balance = result.unwrap();
    assert_eq!(balance.fsp_balance, 0);
    assert_eq!(balance.fsp_balance_temp, 0);
    assert_eq!(balance.credential_balance, 0);
}
