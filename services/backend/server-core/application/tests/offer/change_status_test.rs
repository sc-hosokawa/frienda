use crate::mocks::email_mock::MockMockEmailService;
use crate::mocks::notification_mock::MockMockNotificationsRepo;
use crate::mocks::notification_user_mock::MockMockNotificationUserRepo;
use crate::mocks::offer_mock::MockMockOffersRepo;
use crate::mocks::offer_user_mock::MockMockOfferUserRepo;
use crate::mocks::push_notification_mock::MockMockPushNotificationService;
use crate::mocks::txs_fsp_mock::MockMockTxsFspRepo;
use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::offer::change_status_usecase::{
    ChangeStatusInput, ChangeStatusUsecase, ChangeStatusUsecaseTrait,
};
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, OfferStatus};
use mockall::predicate::*;
use std::sync::Arc;
use uuid::Uuid;

fn create_test_offer(id: i32, owner: &str, fee: i32) -> Offer {
    Offer {
        id,
        owner: owner.to_string(),
        title: format!("Test Offer {}", id),
        description: "Test Description".to_string(),
        fee,
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

fn create_test_txs_fsp(id: Uuid) -> domain::entities::txs_fsp::Model {
    domain::entities::txs_fsp::Model {
        id,
        from: Some("owner123".to_string()),
        to: "user123".to_string(),
        amount: 100,
        notes: Some("Test Transaction".to_string()),
        tx_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_apply_success() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();
    let mut mock_txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_notifications_repo = MockMockNotificationsRepo::new();
    let mut mock_notification_user_repo = MockMockNotificationUserRepo::new();
    let mut mock_push_notification_service = MockMockPushNotificationService::new();
    let mut mock_email_service = MockMockEmailService::new();

    let expected_offer_user = create_test_offer_user(1, 1, "user123", OfferStatus::Applied);

    mock_offer_user_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_offer_user.clone()));

    let test_offer = create_test_offer(1, "owner123", 100);

    mock_offers_repo
        .expect_mock_get_by_id()
        .with(eq(1))
        .returning(move |_| Ok(Some(test_offer.clone())));

    let test_owner = create_test_user("owner123");
    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("owner123".to_string()))
        .returning(move |_| Ok(Some(test_owner.clone())));

    mock_notifications_repo.expect_mock_create().returning(|_| {
        Ok(domain::entities::notifications::Model {
            id: 1,
            title: "オファーへの申し込みがありました".to_string(),
            content: "オファーへの申し込みがありました".to_string(),
            category: Some("message".to_string()),
            created_at: chrono::Utc::now().naive_utc(),
        })
    });

    mock_notification_user_repo
        .expect_mock_create()
        .returning(|_| {
            Ok(domain::entities::notification_user::Model {
                id: 1,
                notification_id: 1,
                user: "owner123".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    mock_push_notification_service
        .expect_mock_send_push_notification()
        .returning(|_| Ok("notification sent".to_string()));

    let usecase = ChangeStatusUsecase::new(
        Arc::new(mock_offers_repo),
        Arc::new(mock_offer_user_repo),
        Arc::new(mock_txs_fsp_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_notifications_repo),
        Arc::new(mock_notification_user_repo),
        Arc::new(mock_push_notification_service),
        Arc::new(mock_email_service),
    );

    let input = ChangeStatusInput {
        id: 1,
        user_id: "user123".to_string(),
        status: OfferStatus::Applied,
    };

    // Act
    let result = usecase.apply(input).await;

    // Assert
    assert!(result.is_ok());
    let (id, offer_id) = result.unwrap();
    assert_eq!(id, 1);
    assert_eq!(offer_id, 1);
}

#[tokio::test]
async fn test_change_status_success() {
    // Arrange
    let mut offers_repo = MockMockOffersRepo::new();
    let mut offer_user_repo = MockMockOfferUserRepo::new();
    let mut txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut users_repo = MockMockUsersRepo::new();
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut notification_user_repo = MockMockNotificationUserRepo::new();
    let mut push_notification_service = MockMockPushNotificationService::new();
    let mut email_service = MockMockEmailService::new();

    let offer_id = 1;
    let owner_id = "owner123";
    let user_id = "user123";
    let test_offer = create_test_offer(offer_id, owner_id, 100);
    let test_offer_clone = test_offer.clone();
    let test_offer_user = create_test_offer_user(1, offer_id, user_id, OfferStatus::Applied);
    let new_status = OfferStatus::Ongoing;

    // Mock設定
    offers_repo
        .expect_mock_get_by_id()
        .with(eq(offer_id))
        .returning(move |_| Ok(Some(test_offer_clone.clone())));

    let test_offer_user_clone = test_offer_user.clone();
    offer_user_repo
        .expect_mock_get_by_user_id_and_offer_id()
        .with(eq(user_id.to_string()), eq(offer_id))
        .returning(move |_, _| Ok(Some(test_offer_user_clone.clone())));

    let test_offer_user_clone2 = test_offer_user.clone();
    offer_user_repo
        .expect_mock_update()
        .returning(move |offer_user| {
            Ok(OfferUser {
                status: offer_user.status.unwrap(),
                ..test_offer_user_clone2.clone()
            })
        });

    offer_user_repo
        .expect_mock_cancel_other_applications()
        .with(eq(offer_id), eq(user_id))
        .times(1)
        .returning(|_, _| Ok(()));

    let test_user = create_test_user(user_id);
    users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    notifications_repo.expect_mock_create().returning(|_| {
        Ok(domain::entities::notifications::Model {
            id: 1,
            title: "オファーのステータスが変更されました".to_string(),
            content: "オファーのステータスが変更されました".to_string(),
            category: Some("message".to_string()),
            created_at: chrono::Utc::now().naive_utc(),
        })
    });

    notification_user_repo.expect_mock_create().returning(|_| {
        Ok(domain::entities::notification_user::Model {
            id: 1,
            notification_id: 1,
            user: "user123".to_string(),
            is_read: false,
            is_deleted: false,
        })
    });

    push_notification_service
        .expect_mock_send_push_notification()
        .returning(|_| Ok("notification sent".to_string()));

    // Add mock for offers_repo.mock_update
    offers_repo.expect_mock_update().returning(move |offer| {
        Ok(Offer {
            publicity: offer.publicity.unwrap(),
            ..test_offer.clone()
        })
    });

    let usecase = ChangeStatusUsecase::new(
        Arc::new(offers_repo),
        Arc::new(offer_user_repo),
        Arc::new(txs_fsp_repo),
        Arc::new(users_repo),
        Arc::new(notifications_repo),
        Arc::new(notification_user_repo),
        Arc::new(push_notification_service),
        Arc::new(email_service),
    );

    // Act
    let result = usecase
        .change_status(ChangeStatusInput {
            id: offer_id,
            user_id: user_id.to_string(),
            status: new_status,
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let (id, offer_id) = result.unwrap();
    assert_eq!(id, 1);
    assert_eq!(offer_id, 1);
}

#[tokio::test]
async fn test_complete_success() {
    // Arrange
    let mut mock_offers_repo = MockMockOffersRepo::new();
    let mut mock_offer_user_repo = MockMockOfferUserRepo::new();
    let mut mock_txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_notifications_repo = MockMockNotificationsRepo::new();
    let mut mock_notification_user_repo = MockMockNotificationUserRepo::new();
    let mut mock_push_notification_service = MockMockPushNotificationService::new();
    let mut mock_email_service = MockMockEmailService::new();

    let offer = create_test_offer(1, "owner123", 100);
    let offer_clone = offer.clone();
    let offer_user = create_test_offer_user(1, 1, "user123", OfferStatus::Ongoing);
    let updated_offer_user = create_test_offer_user(1, 1, "user123", OfferStatus::Finished);

    mock_offer_user_repo
        .expect_mock_get_by_user_id_and_offer_id()
        .returning(move |_, _| Ok(Some(offer_user.clone())));

    mock_offers_repo
        .expect_mock_get_by_id()
        .returning(move |_| Ok(Some(offer.clone())));

    mock_users_repo
        .expect_mock_update_fsp()
        .returning(|_, _| Ok(create_test_user("user123")));

    mock_offer_user_repo
        .expect_mock_update()
        .returning(move |_| Ok(updated_offer_user.clone()));

    mock_offers_repo
        .expect_mock_update()
        .returning(move |_| Ok(offer_clone.clone()));

    mock_txs_fsp_repo
        .expect_mock_create()
        .returning(|_| Ok(create_test_txs_fsp(Uuid::new_v4())));

    let test_user = create_test_user("user123");
    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("user123".to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    mock_notifications_repo.expect_mock_create().returning(|_| {
        Ok(domain::entities::notifications::Model {
            id: 1,
            title: "オファーが完了しました".to_string(),
            content: "オファーが完了し、ポイントを受け取りました".to_string(),
            category: Some("message".to_string()),
            created_at: chrono::Utc::now().naive_utc(),
        })
    });

    mock_notification_user_repo
        .expect_mock_create()
        .returning(|_| {
            Ok(domain::entities::notification_user::Model {
                id: 1,
                notification_id: 1,
                user: "user123".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    mock_push_notification_service
        .expect_mock_send_push_notification()
        .returning(|_| Ok("notification sent".to_string()));

    let usecase = ChangeStatusUsecase::new(
        Arc::new(mock_offers_repo),
        Arc::new(mock_offer_user_repo),
        Arc::new(mock_txs_fsp_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_notifications_repo),
        Arc::new(mock_notification_user_repo),
        Arc::new(mock_push_notification_service),
        Arc::new(mock_email_service),
    );

    let input = ChangeStatusInput {
        id: 1,
        user_id: "user123".to_string(),
        status: OfferStatus::Finished,
    };

    // Act
    let result = usecase.complete(input).await;

    // Assert
    assert!(result.is_ok());
    let (id, offer_id) = result.unwrap();
    assert_eq!(id, 1);
    assert_eq!(offer_id, 1);
}

// テストヘルパー関数
fn create_test_user(user_id: &str) -> domain::entities::users::Model {
    domain::entities::users::Model {
        id: user_id.to_string(),
        email: format!("{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("".to_string()),
        evm_addr: Some("".to_string()),
        status: domain::entities::sea_orm_active_enums::UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: domain::entities::sea_orm_active_enums::UserCategory::Musician,
        primary_category: domain::entities::sea_orm_active_enums::UserCategory::Musician,
        publicity: true,
        greeting: Some("".to_string()),
        skill: Some("".to_string()),
        x_handle: Some("".to_string()),
        instagram_handle: Some("".to_string()),
        fb_handle: Some("".to_string()),
        interest_offer: Some(domain::entities::sea_orm_active_enums::OfferCategory::Creation),
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}
