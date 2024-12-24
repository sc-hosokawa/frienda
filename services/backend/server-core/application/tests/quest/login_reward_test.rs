use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::quest::login_reward_usecase::{
    LoginRewardUsecase, LoginRewardUsecaseTrait,
};
use chrono::{Duration, NaiveDateTime, Utc};
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_user(user_id: &str, fsp: i32, last_login_at: Option<NaiveDateTime>) -> User {
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
        last_login_at,
    }
}

#[tokio::test]
async fn test_login_reward_first_login() {
    // Arrange
    let mut users_repo = MockMockUsersRepo::new();
    let user_id = "user123";
    let initial_fsp = 10;

    let test_user = create_test_user(user_id, initial_fsp, None);
    let updated_user = create_test_user(user_id, initial_fsp, Some(Utc::now().naive_utc()));

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    users_repo
        .expect_mock_update()
        .returning(move |_| Ok(updated_user.clone()));

    let usecase = LoginRewardUsecase::new(Arc::new(users_repo));

    // Act
    let result = usecase.login_reward(user_id.to_string()).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), (initial_fsp, false));
}

#[tokio::test]
async fn test_login_reward_same_day() {
    // Arrange
    let mut users_repo = MockMockUsersRepo::new();
    let user_id = "user123";
    let initial_fsp = 10;
    let now = Utc::now().naive_utc();

    let test_user = create_test_user(user_id, initial_fsp, Some(now));
    let updated_user = create_test_user(user_id, initial_fsp, Some(now));

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    users_repo
        .expect_mock_update()
        .returning(move |_| Ok(updated_user.clone()));

    let usecase = LoginRewardUsecase::new(Arc::new(users_repo));

    // Act
    let result = usecase.login_reward(user_id.to_string()).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), (initial_fsp, false));
}

#[tokio::test]
async fn test_login_reward_next_day() {
    // Arrange
    let mut users_repo = MockMockUsersRepo::new();
    let user_id = "user123";
    let initial_fsp = 10;
    let yesterday = Utc::now().naive_utc() - Duration::days(1);

    let test_user = create_test_user(user_id, initial_fsp, Some(yesterday));
    let updated_user = create_test_user(user_id, initial_fsp + 1, Some(Utc::now().naive_utc()));

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    users_repo
        .expect_mock_update()
        .returning(move |_| Ok(updated_user.clone()));

    let usecase = LoginRewardUsecase::new(Arc::new(users_repo));

    // Act
    let result = usecase.login_reward(user_id.to_string()).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), (initial_fsp, true));
}

#[tokio::test]
async fn test_login_reward_user_not_found() {
    // Arrange
    let mut users_repo = MockMockUsersRepo::new();
    let user_id = "nonexistent_user";

    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(|_| Ok(None));

    let usecase = LoginRewardUsecase::new(Arc::new(users_repo));

    // Act
    let result = usecase.login_reward(user_id.to_string()).await;

    // Assert
    assert!(result.is_err());
    let err = result.unwrap_err();
    assert_eq!(err.to_string(), "User not found");
}
