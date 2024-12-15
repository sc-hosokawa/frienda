use crate::mocks::offer_attach_mock::MockMockOfferAttachRepo;
use crate::mocks::offer_mock::MockMockOffersRepo;
use crate::mocks::offer_user_mock::MockMockOfferUserRepo;
use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::offer::get_offer_details_usecase::{
    GetOfferDetailsUsecase, GetOfferDetailsUsecaseInput, GetOfferDetailsUsecaseTrait,
};
use domain::entities::offer_attach::Model as OfferAttach;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_offer(id: i32) -> Offer {
    Offer {
        id,
        owner: "owner123".to_string(),
        title: "Test Offer".to_string(),
        description: "Test Description".to_string(),
        fee: 1000,
        place: "Test Place".to_string(),
        attention: Some("Test Attention".to_string()),
        required_skill: Some("Test Skill".to_string()),
        target_role: Some(UserCategory::Musician),
        img_url: Some("http://example.com/image.jpg".to_string()),
        publicity: true,
        raid_id: None,
        category: Some(OfferCategory::Creation),
        deadline: Some("2024-12-31".to_string()),
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
    }
}

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

fn create_test_offer_attach(id: i32, offer_id: i32, is_image: bool) -> OfferAttach {
    OfferAttach {
        id,
        offer_id,
        file_uri: if is_image {
            None
        } else {
            Some("http://example.com/file.pdf".to_string())
        },
        image_uri: if is_image {
            Some("http://example.com/image.jpg".to_string())
        } else {
            None
        },
    }
}

#[tokio::test]
async fn test_get_offer_details_success() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_offer_attach_repo = MockMockOfferAttachRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();

    let offer_id = 1;
    let user_id = "user123";
    let owner_id = "owner123";

    let test_offer = create_test_offer(offer_id);
    let test_user = create_test_user(owner_id);
    let test_images = vec![create_test_offer_attach(1, offer_id, true)];
    let test_files = vec![create_test_offer_attach(2, offer_id, false)];

    mock_offers_repo
        .expect_mock_get_by_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(Some(test_offer.clone())));

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq(owner_id.to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    mock_offer_attach_repo
        .expect_mock_get_images_by_offer_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(test_images.clone()));

    mock_offer_attach_repo
        .expect_mock_get_files_by_offer_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(test_files.clone()));

    mock_offer_user_repo
        .expect_mock_get_by_user_id_and_offer_id()
        .with(eq(user_id.to_string()), eq(offer_id))
        .returning(|_, _| Ok(None));

    let usecase = GetOfferDetailsUsecase::new(
        Arc::new(mock_offers_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_offer_attach_repo),
        Arc::new(mock_offer_user_repo),
    );

    // Act
    let result = usecase
        .get_offer_details(GetOfferDetailsUsecaseInput {
            offer_id,
            user_id: user_id.to_string(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let details = result.unwrap();
    assert_eq!(details.id, offer_id);
    assert_eq!(details.title, "Test Offer");
    assert_eq!(details.fee, 1000);
    assert_eq!(details.attached_imgs.len(), 1);
    assert_eq!(details.attached_files.len(), 1);
}

#[tokio::test]
async fn test_get_offer_details_not_found() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mock_users_repo = MockMockUsersRepo::new();
    let mock_offer_attach_repo = MockMockOfferAttachRepo::new();
    let mock_offer_user_repo = MockMockOfferUserRepo::new();

    mock_offers_repo
        .expect_mock_get_by_id()
        .returning(|_| Ok(None));

    let usecase = GetOfferDetailsUsecase::new(
        Arc::new(mock_offers_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_offer_attach_repo),
        Arc::new(mock_offer_user_repo),
    );

    // Act
    let result = usecase
        .get_offer_details(GetOfferDetailsUsecaseInput {
            offer_id: 1,
            user_id: "user123".to_string(),
        })
        .await;

    // Assert
    assert!(result.is_err());
}
