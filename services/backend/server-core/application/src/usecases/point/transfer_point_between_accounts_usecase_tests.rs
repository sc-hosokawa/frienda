use crate::test_support::mocks::artist_mock::MockMockArtistsRepo;
use crate::test_support::mocks::email_mock::MockMockEmailService;
use crate::test_support::mocks::notification_mock::MockMockNotificationsRepo;
use crate::test_support::mocks::notification_user_mock::MockMockNotificationUserRepo;
use crate::test_support::mocks::push_notification_mock::MockMockPushNotificationService;
use crate::test_support::mocks::txs_fsp_mock::MockMockTxsFspRepo;
use crate::test_support::mocks::user_mock::MockMockUsersRepo;

use crate::usecases::point::transfer_point_between_accounts_usecase::{
    TransferPointBetweenAccountsInput, TransferPointBetweenAccountsUsecase,
    TransferPointBetweenAccountsUsecaseTrait,
};
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, UserCategory, UserStatus,
};
use domain::entities::txs_fsp::Model as TxsFsp;
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;
use uuid::Uuid;

fn create_test_user(user_id: &str, fsp: i32) -> User {
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
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}

fn _create_test_artist(artist_id: &str, fsp: i32) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: "Test Artist".to_string(),
        display_name_en: "Test Artist".to_string(),
        display_name_kana: Some("Test Artist".to_string()),
        img_url: None,
        status: ArtistStatus::Visible,
        since: None,
        universal_id: None,
        apple_key: None,
        spotify_key: None,
        line_key: None,
        amazon_key: None,
        youtube_key: None,
        fsp,
    }
}

fn create_test_tx_fsp(id: Uuid, from: Option<String>, to: String, amount: i32) -> TxsFsp {
    TxsFsp {
        id,
        from,
        to,
        amount,
        notes: None,
        tx_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_transfer_between_users_success() {
    // Arrange
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();
    let mut mock_notifications_repo = MockMockNotificationsRepo::new();
    let mut mock_notification_user_repo = MockMockNotificationUserRepo::new();
    let mut mock_push_notification_service = MockMockPushNotificationService::new();
    let mut mock_email_service = MockMockEmailService::new();

    let from_user = create_test_user("user1", 1000);
    let to_user = create_test_user("user2", 0);
    let tx_id = Uuid::new_v4();

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("user1".to_string()))
        .returning(move |_| Ok(Some(from_user.clone())));

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("user2".to_string()))
        .returning(move |_| Ok(Some(to_user.clone())));

    mock_users_repo
        .expect_mock_update_fsp()
        .returning(|id, amount| Ok(create_test_user(&id, amount)));

    mock_txs_fsp_repo.expect_mock_create().returning(move |_| {
        Ok(create_test_tx_fsp(
            tx_id,
            Some("user1".to_string()),
            "user2".to_string(),
            500,
        ))
    });

    mock_notifications_repo.expect_mock_create().returning(|_| {
        Ok(domain::entities::notifications::Model {
            id: 1,
            title: "ポイントを受け取りました".to_string(),
            content: "500ポイント受け取りました".to_string(),
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
                user: "user2".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    mock_push_notification_service
        .expect_mock_send_push_notification()
        .returning(|_| Ok("notification sent".to_string()));

    let usecase = TransferPointBetweenAccountsUsecase::new(
        Arc::new(mock_txs_fsp_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
        Arc::new(mock_notifications_repo),
        Arc::new(mock_notification_user_repo),
        Arc::new(mock_push_notification_service),
        Arc::new(mock_email_service),
    );

    let input = TransferPointBetweenAccountsInput {
        from: Some("user1".to_string()),
        to: "user2".to_string(),
        amount: 500,
        notes: None,
    };

    // Act
    let result = usecase.transfer(input).await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), tx_id);
}

#[tokio::test]
async fn test_transfer_from_admin_success() {
    // Arrange
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();
    let mut mock_notifications_repo = MockMockNotificationsRepo::new();
    let mut mock_notification_user_repo = MockMockNotificationUserRepo::new();
    let mut mock_push_notification_service = MockMockPushNotificationService::new();
    let mut mock_email_service = MockMockEmailService::new();

    let to_user = create_test_user("user1", 0);
    let tx_id = Uuid::new_v4();

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("user1".to_string()))
        .returning(move |_| Ok(Some(to_user.clone())));

    mock_users_repo
        .expect_mock_update_fsp()
        .returning(|id, amount| Ok(create_test_user(&id, amount)));

    mock_txs_fsp_repo.expect_mock_create().returning(move |_| {
        Ok(create_test_tx_fsp(
            tx_id,
            Some("admin_0000000000000000000001".to_string()),
            "user1".to_string(),
            1000,
        ))
    });

    mock_notifications_repo.expect_mock_create().returning(|_| {
        Ok(domain::entities::notifications::Model {
            id: 1,
            title: "ポイントを受け取りました".to_string(),
            content: "1000ポイント受け取りました".to_string(),
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
                user: "user1".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    mock_push_notification_service
        .expect_mock_send_push_notification()
        .returning(|_| Ok("notification sent".to_string()));

    let usecase = TransferPointBetweenAccountsUsecase::new(
        Arc::new(mock_txs_fsp_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
        Arc::new(mock_notifications_repo),
        Arc::new(mock_notification_user_repo),
        Arc::new(mock_push_notification_service),
        Arc::new(mock_email_service),
    );

    let input = TransferPointBetweenAccountsInput {
        from: Some("admin_0000000000000000000001".to_string()),
        to: "user1".to_string(),
        amount: 1000,
        notes: None,
    };

    // Act
    let result = usecase.transfer(input).await;

    // Assert
    assert!(result.is_ok());
}

#[tokio::test]
async fn test_transfer_insufficient_balance() {
    // Arrange
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();
    let mut mock_notifications_repo = MockMockNotificationsRepo::new();
    let mut mock_notification_user_repo = MockMockNotificationUserRepo::new();
    let mut mock_push_notification_service = MockMockPushNotificationService::new();
    let mut mock_email_service = MockMockEmailService::new();

    let from_user = create_test_user("user1", 100);

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("user1".to_string()))
        .returning(move |_| Ok(Some(from_user.clone())));

    let usecase = TransferPointBetweenAccountsUsecase::new(
        Arc::new(mock_txs_fsp_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
        Arc::new(mock_notifications_repo),
        Arc::new(mock_notification_user_repo),
        Arc::new(mock_push_notification_service),
        Arc::new(mock_email_service),
    );

    let input = TransferPointBetweenAccountsInput {
        from: Some("user1".to_string()),
        to: "user2".to_string(),
        amount: 500,
        notes: None,
    };

    // Act
    let result = usecase.transfer(input).await;

    // Assert
    assert!(result.is_err());
    assert_eq!(result.unwrap_err().to_string(), "Insufficient balance");
}
