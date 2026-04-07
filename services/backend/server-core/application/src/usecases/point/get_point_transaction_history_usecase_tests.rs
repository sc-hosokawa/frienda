use crate::test_support::mocks::artist_mock::MockMockArtistsRepo;
use crate::test_support::mocks::txs_fsp_mock::MockMockTxsFspRepo;
use crate::test_support::mocks::user_mock::MockMockUsersRepo;
use crate::usecases::point::get_point_transaction_history_usecase::{
    GetPointTransactionHistoryInput, GetPointTransactionHistoryUsecase,
    GetPointTransactionHistoryUsecaseTrait,
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

fn create_test_transaction(id: Uuid, from: Option<String>, to: String, amount: i32) -> TxsFsp {
    TxsFsp {
        id,
        from,
        to,
        amount,
        notes: None,
        tx_at: chrono::Utc::now().naive_utc(),
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

fn create_test_artist(artist_id: &str, fsp: i32) -> Artist {
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

#[tokio::test]
async fn test_get_transaction_history_success() {
    // Arrange
    let mut mock_txs_repo = MockMockTxsFspRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mut mock_artists_repo = MockMockArtistsRepo::new();

    let user_id = "user123";
    let tx1_id = Uuid::new_v4();
    let tx2_id = Uuid::new_v4();

    let transactions = vec![
        create_test_transaction(
            tx1_id,
            Some("user456".to_string()),
            user_id.to_string(),
            100,
        ),
        create_test_transaction(
            tx2_id,
            Some(user_id.to_string()),
            "artist_789".to_string(),
            50,
        ),
    ];

    mock_txs_repo
        .expect_mock_get_by_user_id()
        .with(eq(user_id.to_string()), eq(10))
        .returning(move |_, _| Ok(transactions.clone()));

    mock_users_repo
        .expect_mock_find_by_id()
        .returning(|id| Ok(Some(create_test_user(&id))));

    mock_artists_repo.expect_mock_find_by_id().returning(|id| {
        let artist_id = id.replace("artist_", "");
        Ok(Some(create_test_artist(&artist_id, 0)))
    });

    let usecase = GetPointTransactionHistoryUsecase::new(
        Arc::new(mock_txs_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
    );

    // Act
    let result = usecase
        .get_point_transaction_history(GetPointTransactionHistoryInput {
            user_id: user_id.to_string(),
            count: 10,
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.transactions.len(), 2);

    // First transaction (incoming)
    assert_eq!(output.transactions[0].id, tx1_id);
    assert_eq!(output.transactions[0].amount, 100);
    assert_eq!(output.transactions[0].direction, "In");
    assert_eq!(output.transactions[0].counter_party.id, "user456");

    // Second transaction (outgoing)
    assert_eq!(output.transactions[1].id, tx2_id);
    assert_eq!(output.transactions[1].amount, 50);
    assert_eq!(output.transactions[1].direction, "Out");
    assert_eq!(output.transactions[1].counter_party.id, "789");
}

#[tokio::test]
async fn test_get_transaction_history_system_transaction() {
    // Arrange
    let mut mock_txs_repo = MockMockTxsFspRepo::new();
    let mut mock_users_repo = MockMockUsersRepo::new();
    let mock_artists_repo = MockMockArtistsRepo::new();

    let user_id = "user123";
    let tx_id = Uuid::new_v4();

    let transactions = vec![create_test_transaction(
        tx_id,
        None,
        user_id.to_string(),
        100,
    )];

    mock_txs_repo
        .expect_mock_get_by_user_id()
        .returning(move |_, _| Ok(transactions.clone()));

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq("system".to_string()))
        .returning(|_| Ok(None));

    mock_users_repo
        .expect_mock_find_by_id()
        .with(eq(user_id.to_string()))
        .returning(|id| Ok(Some(create_test_user(&id))));

    let usecase = GetPointTransactionHistoryUsecase::new(
        Arc::new(mock_txs_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
    );

    // Act
    let result = usecase
        .get_point_transaction_history(GetPointTransactionHistoryInput {
            user_id: user_id.to_string(),
            count: 10,
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.transactions.len(), 1);
    assert_eq!(output.transactions[0].counter_party.name, "System");
    assert_eq!(output.transactions[0].direction, "In");
    assert_eq!(output.transactions[0].amount, 100);
    assert_eq!(output.transactions[0].id, tx_id);
}

#[tokio::test]
async fn test_get_transaction_history_empty() {
    // Arrange
    let mut mock_txs_repo = MockMockTxsFspRepo::new();
    let mock_users_repo = MockMockUsersRepo::new();
    let mock_artists_repo = MockMockArtistsRepo::new();

    mock_txs_repo
        .expect_mock_get_by_user_id()
        .returning(|_, _| Ok(vec![]));

    let usecase = GetPointTransactionHistoryUsecase::new(
        Arc::new(mock_txs_repo),
        Arc::new(mock_users_repo),
        Arc::new(mock_artists_repo),
    );

    // Act
    let result = usecase
        .get_point_transaction_history(GetPointTransactionHistoryInput {
            user_id: "user123".to_string(),
            count: 10,
        })
        .await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap().transactions.len(), 0);
}
