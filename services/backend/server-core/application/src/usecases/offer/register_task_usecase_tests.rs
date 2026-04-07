use crate::test_support::mocks::offer_attach_mock::MockMockOfferAttachRepo;
use crate::test_support::mocks::offer_mock::MockMockOffersRepo;
use crate::usecases::offer::register_task_usecase::{
    RegisterTaskInput, RegisterTaskUsecase, RegisterTaskUsecaseTrait,
};
use domain::entities::offer_attach::Model as OfferAttach;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use mockall::predicate::*;
use std::sync::Arc;

// テストデータ作成用のヘルパー関数
fn create_test_offer(id: i32, owner: &str, title: &str, description: &str, fee: i32) -> Offer {
    Offer {
        id,
        owner: owner.to_string(),
        title: title.to_string(),
        description: description.to_string(),
        fee,
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

fn _create_test_offer_attach(id: i32, offer_id: i32, is_image: bool) -> OfferAttach {
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
async fn test_register_task_success_with_attachments() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_attach_repo = MockMockOfferAttachRepo::new();

    let input = RegisterTaskInput {
        owner: "user123".to_string(),
        title: "Test Task".to_string(),
        description: "Test Description".to_string(),
        place: "Test Place".to_string(),
        attention: Some("Test Attention".to_string()),
        required_skill: Some("Test Skill".to_string()),
        target_role: Some(UserCategory::Musician),
        fee: 100,
        deadline: Some("2024-12-31".to_string()),
        image_url: Some("http://example.com/image.jpg".to_string()),
        attached_imgs: Some(vec!["http://example.com/attach1.jpg".to_string()]),
        attached_files: Some(vec!["http://example.com/file1.pdf".to_string()]),
        raid_id: None,
        category: Some(OfferCategory::Creation),
        publicity: Some(true),
    };

    let expected_offer = create_test_offer(1, "user123", "Test Task", "Test Description", 100);

    mock_offers_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_offer.clone()));

    mock_offer_attach_repo
        .expect_mock_create_many()
        .returning(move |_| Ok(()));

    let usecase =
        RegisterTaskUsecase::new(Arc::new(mock_offers_repo), Arc::new(mock_offer_attach_repo));

    // Act
    let result = usecase.register_task(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);
}

#[tokio::test]
async fn test_register_task_success_without_attachments() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mock_offer_attach_repo = MockMockOfferAttachRepo::new();

    let input = RegisterTaskInput {
        owner: "user123".to_string(),
        title: "Test Task".to_string(),
        description: "Test Description".to_string(),
        place: "Test Place".to_string(),
        attention: None,
        required_skill: None,
        target_role: None,
        fee: 100,
        deadline: None,
        image_url: None,
        attached_imgs: None,
        attached_files: None,
        raid_id: None,
        category: None,
        publicity: None,
    };

    let expected_offer = create_test_offer(1, "user123", "Test Task", "Test Description", 100);

    mock_offers_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_offer.clone()));

    let usecase =
        RegisterTaskUsecase::new(Arc::new(mock_offers_repo), Arc::new(mock_offer_attach_repo));

    // Act
    let result = usecase.register_task(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);
}

#[tokio::test]
async fn test_register_task_error() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mock_offer_attach_repo = MockMockOfferAttachRepo::new();

    let input = RegisterTaskInput {
        owner: "user123".to_string(),
        title: "Test Task".to_string(),
        description: "Test Description".to_string(),
        place: "Test Place".to_string(),
        attention: None,
        required_skill: None,
        target_role: None,
        fee: 100,
        deadline: None,
        image_url: None,
        attached_imgs: None,
        attached_files: None,
        raid_id: None,
        category: None,
        publicity: None,
    };

    mock_offers_repo.expect_mock_create().returning(|_| {
        Err(shared::error::domain_err::DomainError::DatabaseError(
            "Database error".to_string(),
        ))
    });

    let usecase =
        RegisterTaskUsecase::new(Arc::new(mock_offers_repo), Arc::new(mock_offer_attach_repo));

    // Act
    let result = usecase.register_task(input).await;

    // Assert
    assert!(result.is_err());
}
