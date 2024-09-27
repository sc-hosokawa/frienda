use async_trait::async_trait;
use chrono::Utc;
use domain::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use domain::entities::users::{ActiveModel as ActiveUser, Model as User};
use domain::repositories::users_repo::UsersRepository;
use mockall::mock;
use sea_orm::Set;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

mock! {
    pub UsersRepository {}

    #[async_trait]
    impl UsersRepository for UsersRepository {
        async fn find_by_id(&self, id: Uuid) -> Result<Option<User>, DomainError>;
        async fn find_by_email(&self, email: &str) -> Result<Option<User>, DomainError>;
        async fn create(&self, user: &ActiveUser) -> Result<User, DomainError>;
        async fn update(&self, user: &ActiveUser) -> Result<User, DomainError>;
        async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
        async fn list(&self, limit: usize, offset: usize) -> Result<Vec<User>, DomainError>;
        async fn find_by_username(&self, username: &str) -> Result<Option<User>, DomainError>;
        async fn find_by_evm_addr(&self, evm_addr: &str) -> Result<Option<User>, DomainError>;
        async fn find_by_invited_by(&self, invited_by: Uuid) -> Result<Vec<User>, DomainError>;
        async fn update_status(&self, id: Uuid, status: UserStatus) -> Result<User, DomainError>;
        async fn find_by_category(&self, category: UserCategory) -> Result<Vec<User>, DomainError>;
        async fn count(&self) -> Result<i64, DomainError>;
    }
}

fn create_test_user(
    id: Uuid,
    evm_addr: Option<String>,
    status: UserStatus,
    invited_by: Option<Uuid>,
    category: UserCategory,
) -> User {
    User {
        id,
        username: format!("user_{}", id),
        evm_addr,
        status: Some(status),
        invited_by,
        fsp: 0,
        credential: 0,
        category,
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_user_repository_create() {
    let new_user = ActiveUser {
        username: Set("Alice".to_owned()),
        evm_addr: Set(None),
        status: Set(Some(UserStatus::Invited)),
        invited_by: Set(None),
        category: Set(UserCategory::Musician),
        ..Default::default()
    };

    let mut mock_repository = MockUsersRepository::new();

    let expected_user = User {
        id: Uuid::new_v4(), // 新しいUUIDを生成
        username: "Alice".to_owned(),
        evm_addr: None,
        status: Some(UserStatus::Invited),
        invited_by: None,
        category: UserCategory::Musician,
        fsp: 0,
        credential: 0,
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
    };

    mock_repository
        .expect_create()
        .with(mockall::predicate::eq(new_user.clone()))
        .times(1)
        .returning(move |_| Ok(expected_user.clone()));

    let created_user = mock_repository.create(&new_user).await.unwrap();

    assert_eq!(created_user.username, "Alice");
    assert_eq!(created_user.evm_addr, None);
    assert_eq!(created_user.status, Some(UserStatus::Invited));
    assert_eq!(created_user.invited_by, None);
    assert_eq!(created_user.category, UserCategory::Musician);
}

#[tokio::test]
async fn test_user_repository_find_by_id() {
    let mut mock_repository = MockUsersRepository::new();
    let user = create_test_user(
        Uuid::new_v4(),
        Some("0x1234567890123456789012345678901234567890".to_string()),
        UserStatus::Joined,
        None,
        UserCategory::Musician,
    );

    let expected_user = user.clone();
    mock_repository
        .expect_find_by_id()
        .with(mockall::predicate::eq(user.id))
        .times(1)
        .returning(move |_| Ok(Some(expected_user.clone())));

    let found_user = mock_repository.find_by_id(user.id).await.unwrap();
    assert_eq!(found_user, Some(user));
}

#[tokio::test]
async fn test_find_by_evm_addr() {
    let mut mock_repository = MockUsersRepository::new();
    let evm_addr = "0x1234567890123456789012345678901234567890";
    let user = create_test_user(
        Uuid::new_v4(),
        Some(evm_addr.to_string()),
        UserStatus::Joined,
        None,
        UserCategory::Musician,
    );

    let expected_user = user.clone();
    mock_repository
        .expect_find_by_evm_addr()
        .with(mockall::predicate::eq(evm_addr))
        .times(1)
        .returning(move |_| Ok(Some(expected_user.clone())));

    let found_user = mock_repository.find_by_evm_addr(evm_addr).await.unwrap();
    assert_eq!(found_user, Some(user));
}

#[tokio::test]
async fn test_find_by_invited_by() {
    let mut mock_repository = MockUsersRepository::new();
    let inviter_id = Uuid::new_v4();
    let invited_user = create_test_user(
        Uuid::new_v4(),
        None,
        UserStatus::Invited,
        Some(inviter_id),
        UserCategory::Musician,
    );
    let invited_user2 = create_test_user(
        Uuid::new_v4(),
        None,
        UserStatus::Invited,
        Some(inviter_id),
        UserCategory::Musician,
    );
    let invited_users = vec![invited_user, invited_user2];

    let expected_users = invited_users.clone();
    mock_repository
        .expect_find_by_invited_by()
        .with(mockall::predicate::eq(inviter_id))
        .times(1)
        .returning(move |_| Ok(expected_users.clone()));

    let found_users = mock_repository
        .find_by_invited_by(inviter_id)
        .await
        .unwrap();
    assert_eq!(found_users, invited_users);
}

#[tokio::test]
async fn test_update_status() {
    let mut mock_repository = MockUsersRepository::new();
    let user_id = Uuid::new_v4();
    let initial_user = create_test_user(
        user_id,
        None,
        UserStatus::Invited,
        None,
        UserCategory::Musician,
    );
    let updated_user = User {
        status: Some(UserStatus::Joined),
        ..initial_user.clone()
    };

    let expected_updated_user = updated_user.clone();

    mock_repository
        .expect_update_status()
        .with(
            mockall::predicate::eq(user_id),
            mockall::predicate::eq(UserStatus::Joined),
        )
        .times(1)
        .returning(move |_, _| Ok(updated_user.clone()));

    let result = mock_repository
        .update_status(user_id, UserStatus::Joined)
        .await
        .unwrap();
    assert_eq!(result, expected_updated_user);
}

#[tokio::test]
async fn test_find_by_category() {
    let mut mock_repository = MockUsersRepository::new();
    let users = vec![
        create_test_user(
            Uuid::new_v4(),
            None,
            UserStatus::Joined,
            None,
            UserCategory::Musician,
        ),
        create_test_user(
            Uuid::new_v4(),
            None,
            UserStatus::Joined,
            None,
            UserCategory::Musician,
        ),
    ];

    let expected_users = users.clone();

    mock_repository
        .expect_find_by_category()
        .with(mockall::predicate::eq(UserCategory::Musician))
        .times(1)
        .returning(move |_| Ok(expected_users.clone()));
    let found_users = mock_repository
        .find_by_category(UserCategory::Musician)
        .await
        .unwrap();
    assert_eq!(found_users, users);
}

#[tokio::test]
async fn test_count() {
    let mut mock_repository = MockUsersRepository::new();
    let expected_count = 42;

    mock_repository
        .expect_count()
        .times(1)
        .returning(move || Ok(expected_count));

    let count = mock_repository.count().await.unwrap();
    assert_eq!(count, expected_count);
}
