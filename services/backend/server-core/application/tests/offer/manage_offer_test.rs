use crate::mocks::offer_mock::MockMockOffersRepo;
use crate::mocks::offer_user_mock::MockMockOfferUserRepo;
use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::offer::manage_users_in_offer_usecase::{
    ManageUsersInOfferUsecase, ManageUsersInOfferUsecaseTrait,
};
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{
    OfferCategory, OfferStatus, UserCategory, UserStatus,
};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;

// テストデータ生成用のヘルパー関数
fn create_test_offer(id: i32, owner: &str) -> Offer {
    Offer {
        id,
        owner: owner.to_string(),
        title: format!("Test Offer {}", id),
        description: "Test Description".to_string(),
        fee: 100,
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

fn create_test_offer_user(id: i32, offer_id: i32, user_id: &str, status: OfferStatus) -> OfferUser {
    OfferUser {
        id,
        offer_id,
        user_id: user_id.to_string(),
        status,
    }
}

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

#[tokio::test]
async fn test_get_users_in_offer_success() {
    // Arrange
    let mut offers_repo = MockMockOffersRepo::new();
    let mut offer_user_repo = MockMockOfferUserRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    let offer_id = 1;
    let owner_id = "owner123";
    let user1_id = "user123";
    let user2_id = "user456";

    let test_offer = create_test_offer(offer_id, owner_id);

    // OfferUserのデータを設定
    let offer_users = vec![
        create_test_offer_user(1, offer_id, user1_id, OfferStatus::Ongoing),
        create_test_offer_user(2, offer_id, user2_id, OfferStatus::Applied),
    ];

    offers_repo
        .expect_mock_get_by_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(Some(test_offer.clone())));

    offer_user_repo
        .expect_mock_get_by_offer_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(offer_users.clone()));

    // Userデータを設定
    let users = vec![
        create_test_user(user1_id, UserCategory::Musician),
        create_test_user(user2_id, UserCategory::Creator),
    ];

    users_repo
        .expect_mock_find_by_ids()
        .returning(move |_| Ok(users.clone()));

    let usecase = ManageUsersInOfferUsecase::new(
        Arc::new(offers_repo),
        Arc::new(users_repo),
        Arc::new(offer_user_repo),
    );

    // Act
    let result = usecase
        .get_users_in_offer(offer_id, owner_id.to_string())
        .await;

    // Assert
    assert!(result.is_ok());
    let users_output = result.unwrap();
    assert_eq!(users_output.len(), 2); // 期待値を2に変更

    // ステータスの検証
    assert_eq!(users_output[0].status_in_offer, OfferStatus::Ongoing);
    assert_eq!(users_output[1].status_in_offer, OfferStatus::Applied);
}

#[tokio::test]
async fn test_get_users_in_offer_unauthorized() {
    // Arrange
    let mut offers_repo = MockMockOffersRepo::new();
    let users_repo = MockMockUsersRepo::new();
    let offer_user_repo = MockMockOfferUserRepo::new();

    let offer_id = 1;
    let owner_id = "owner123";
    let unauthorized_user_id = "unauthorized123";
    let test_offer = create_test_offer(offer_id, owner_id);

    offers_repo
        .expect_mock_get_by_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(Some(test_offer.clone())));

    let usecase = ManageUsersInOfferUsecase::new(
        Arc::new(offers_repo),
        Arc::new(users_repo),
        Arc::new(offer_user_repo),
    );

    // Act
    let result = usecase
        .get_users_in_offer(offer_id, unauthorized_user_id.to_string())
        .await;

    // Assert
    assert!(result.is_err());
}
