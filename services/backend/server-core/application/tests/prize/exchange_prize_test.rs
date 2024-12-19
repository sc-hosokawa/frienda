use crate::mocks::exchange_prize_history_mock::MockMockExchangePrizeHistoryRepo;
use crate::mocks::prize_mock::MockMockPrizesRepo;
use crate::mocks::txs_fsp_mock::MockMockTxsFspRepo;
use crate::mocks::user_mock::MockMockUsersRepo;
use application::usecases::prize::exchange_prize_usecase::{
    ExchangePrizeInput, ExchangePrizeUsecase, ExchangePrizeUsecaseTrait,
};
use domain::entities::prizes::Model as Prize;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use mockall::predicate::*;
use std::sync::Arc;
use uuid::Uuid;

// テストデータ生成用のヘルパー関数
fn create_test_prize(id: i32) -> Prize {
    Prize {
        id,
        name: format!("Prize {}", id),
        point: 100,
        description: format!("Description for prize {}", id),
        representation: "test_representation".to_string(),
        condition: Some(format!("Condition {}", id)),
        img_url: Some(format!("http://example.com/prize{}.jpg", id)),
        publicity: true,
    }
}

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

#[tokio::test]
async fn test_exchange_prize_success() {
    // Arrange
    let mut prizes_repo = MockMockPrizesRepo::new();
    let mut exchange_history_repo = MockMockExchangePrizeHistoryRepo::new();
    let mut users_repo = MockMockUsersRepo::new();
    let mut txs_fsp_repo = MockMockTxsFspRepo::new();

    let input = ExchangePrizeInput {
        user_id: "user123".to_string(),
        prize_id: 1,
        amount: Some(1),
    };

    // テストデータを作成し、必要な箇所で事前にclone
    let test_prize = create_test_prize(1);
    let test_user = create_test_user("user123", 200);
    let test_representation_user = create_test_user("test_representation", 0);
    let tx_id = Uuid::new_v4();

    // 各モックの戻り値用にclone
    let prize_for_mock = test_prize.clone();
    let user_for_find = test_user.clone();
    let user_for_update = test_user.clone();
    let representation_for_update = test_representation_user.clone();
    let user_id_for_history = test_user.id.clone();
    let user_id_for_tx = test_user.id.clone();
    let representation_id_for_tx = test_representation_user.id.clone();

    // Prize repository mock
    prizes_repo
        .expect_mock_get_by_id()
        .with(eq(1))
        .returning(move |_| Ok(Some(prize_for_mock.clone())));

    // User repository mocks
    users_repo
        .expect_mock_find_by_id()
        .with(eq("user123".to_string()))
        .returning(move |_| Ok(Some(user_for_find.clone())));

    users_repo
        .expect_mock_update_fsp()
        .returning(move |_, _| Ok(user_for_update.clone()));

    users_repo
        .expect_mock_update_fsp()
        .returning(move |_, _| Ok(representation_for_update.clone()));

    // Exchange history repository mock
    exchange_history_repo
        .expect_mock_create()
        .returning(move |_| {
            Ok(domain::entities::exchange_prize_history::Model {
                id: 1,
                prize_id: 1,
                user: user_id_for_history.clone(),
                point_used: 100,
                amount: 1,
                exchanged_at: chrono::Utc::now().naive_utc(),
            })
        });

    // Transaction repository mock
    txs_fsp_repo.expect_mock_create().returning(move |_| {
        Ok(domain::entities::txs_fsp::Model {
            id: tx_id,
            from: Some(user_id_for_tx.clone()),
            to: representation_id_for_tx.clone(),
            amount: -100,
            tx_at: chrono::Utc::now().naive_utc(),
            notes: Some(format!("Exchange prize: {}", test_prize.name)),
        })
    });

    let usecase = ExchangePrizeUsecase::new(
        Arc::new(prizes_repo),
        Arc::new(exchange_history_repo),
        Arc::new(users_repo),
        Arc::new(txs_fsp_repo),
    );

    // Act
    let result = usecase.exchange(input).await;

    // Assert
    assert!(result.is_ok());
    let (history_id, transaction_id) = result.unwrap();
    assert_eq!(history_id, 1);
    assert_eq!(transaction_id, tx_id);
}

#[tokio::test]
async fn test_exchange_prize_insufficient_balance() {
    // Arrange
    let mut prizes_repo = MockMockPrizesRepo::new();
    let exchange_history_repo = MockMockExchangePrizeHistoryRepo::new();
    let mut users_repo = MockMockUsersRepo::new();
    let txs_fsp_repo = MockMockTxsFspRepo::new();

    let input = ExchangePrizeInput {
        user_id: "user123".to_string(),
        prize_id: 1,
        amount: Some(1),
    };

    let test_prize = create_test_prize(1);
    let test_user = create_test_user("user123", 50); // 残高不足

    prizes_repo
        .expect_mock_get_by_id()
        .with(eq(1))
        .returning(move |_| Ok(Some(test_prize.clone())));

    users_repo
        .expect_mock_find_by_id()
        .with(eq("user123".to_string()))
        .returning(move |_| Ok(Some(test_user.clone())));

    let usecase = ExchangePrizeUsecase::new(
        Arc::new(prizes_repo),
        Arc::new(exchange_history_repo),
        Arc::new(users_repo),
        Arc::new(txs_fsp_repo),
    );

    // Act
    let result = usecase.exchange(input).await;

    // Assert
    assert!(result.is_err());
    assert_eq!(
        result.unwrap_err().to_string(),
        "Insufficient balance".to_string()
    );
}

#[tokio::test]
async fn test_exchange_prize_not_found() {
    // Arrange
    let mut prizes_repo = MockMockPrizesRepo::new();
    let exchange_history_repo = MockMockExchangePrizeHistoryRepo::new();
    let users_repo = MockMockUsersRepo::new();
    let txs_fsp_repo = MockMockTxsFspRepo::new();

    let input = ExchangePrizeInput {
        user_id: "user123".to_string(),
        prize_id: 999,
        amount: Some(1),
    };

    prizes_repo
        .expect_mock_get_by_id()
        .with(eq(999))
        .returning(|_| Ok(None));

    let usecase = ExchangePrizeUsecase::new(
        Arc::new(prizes_repo),
        Arc::new(exchange_history_repo),
        Arc::new(users_repo),
        Arc::new(txs_fsp_repo),
    );

    // Act
    let result = usecase.exchange(input).await;

    // Assert
    assert!(result.is_err());
    assert_eq!(
        result.unwrap_err().to_string(),
        "Prize not found".to_string()
    );
}
