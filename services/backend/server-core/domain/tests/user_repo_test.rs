use domain::entities::users::Model as User;
use domain::repositories::users_repo::UsersRepository;
use shared::error::domain_err::DomainError;
use domain::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use async_trait::async_trait;
use mockall::mock;
use uuid::Uuid;
use chrono::Utc;

mock! {
    pub UsersRepository {}

    #[async_trait]
    impl UsersRepository for UsersRepository {
        async fn find_by_id(&self, id: Uuid) -> Result<Option<User>, DomainError>;
        async fn find_by_email(&self, email: &str) -> Result<Option<User>, DomainError>;
        async fn create(&self, user: &User) -> Result<User, DomainError>;
        async fn update(&self, user: &User) -> Result<User, DomainError>;
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

#[tokio::test]
async fn test_user_repository() {
    let mut mock_repository: MockUsersRepository = MockUsersRepository::new();

    let id: Uuid = Uuid::new_v4();
    let username: String = "test_user".to_string();
    let email: String = "test@example.com".to_string();
    let now: chrono::NaiveDateTime = Utc::now().naive_utc();

    let user = User {
        id,
        username: username.clone(),
        evm_addr: None,
        status: Some(UserStatus::Invited),
        invited_by: None,
        fsp: 0,
        credential: 0,
        category: UserCategory::Musician,
        created_at: now,
        updated_at: now
    };

    // createのテスト
    mock_repository
        .expect_create()
        .with(mockall::predicate::eq(user.clone()))
        .times(1)
        .returning(|_| Ok(user.clone()));

    let created_user = mock_repository.create(&user).await.unwrap();
    assert_eq!(created_user, user);

    // find_by_idのテスト
    mock_repository
        .expect_find_by_id()
        .with(mockall::predicate::eq(id))
        .times(1)
        .returning(|_| Ok(Some(user.clone())));

    let found_user = mock_repository.find_by_id(id).await.unwrap();
    assert_eq!(found_user, Some(user));
}