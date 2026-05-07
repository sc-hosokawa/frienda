use async_trait::async_trait;
use domain::entities::sea_orm_active_enums::UserStatus;
use domain::entities::users::{ActiveModel as UserActiveModel, Model as User};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::entities::sea_orm_active_enums::UserCategory;
use domain::entities::users::ActiveModel as ActiveUser;
use domain::repositories::users_repo::UsersRepository;

#[automock]
#[async_trait]
pub trait MockUsersRepo {
    async fn mock_create(&self, user: UserActiveModel) -> Result<User, DomainError>;
    async fn mock_update(&self, user: UserActiveModel) -> Result<User, DomainError>;
    async fn mock_update_fsp(&self, id: String, fsp: i32) -> Result<User, DomainError>;
    async fn mock_find_by_id_and_update_fsp(
        &self,
        id: String,
        fsp: i32,
    ) -> Result<Option<User>, DomainError>;
    async fn mock_find_by_id(&self, id: String) -> Result<Option<User>, DomainError>;
    async fn mock_find_by_ids(&self, ids: Vec<String>) -> Result<Vec<User>, DomainError>;
    async fn mock_find_by_email(&self, email: String) -> Result<Option<User>, DomainError>;
    async fn mock_delete(&self, id: String) -> Result<(), DomainError>;
    async fn mock_list(&self, limit: usize, offset: usize) -> Result<Vec<User>, DomainError>;
    async fn mock_get_all_users(&self) -> Result<Vec<User>, DomainError>;
    async fn mock_find_by_username(&self, username: String) -> Result<Option<User>, DomainError>;
    async fn mock_find_by_evm_addr(&self, evm_addr: String) -> Result<Option<User>, DomainError>;
    async fn mock_find_by_invited_by(&self, invited_by: String) -> Result<Vec<User>, DomainError>;
    async fn mock_update_status(&self, id: String, status: UserStatus)
        -> Result<User, DomainError>;
    async fn mock_find_by_category(&self, category: UserCategory)
        -> Result<Vec<User>, DomainError>;
    async fn mock_count(&self) -> Result<i64, DomainError>;
    async fn mock_sum_fsp(&self) -> Result<i64, DomainError>;
    async fn mock_count_mobile_app_users(&self) -> Result<i64, DomainError>;
    async fn mock_find_by_username_or_email(
        &self,
        username_or_email: String,
    ) -> Result<Option<User>, DomainError>;
    async fn mock_search_users(&self, username: String) -> Result<Vec<User>, DomainError>;
    async fn mock_update_many(&self, users: Vec<ActiveUser>) -> Result<(), DomainError>;
    async fn mock_find_users_have_evm_addr(&self) -> Result<Vec<User>, DomainError>;
}

#[async_trait]
impl UsersRepository for MockMockUsersRepo {
    async fn create(&self, user: ActiveUser) -> Result<User, DomainError> {
        self.mock_create(user).await
    }

    async fn update(&self, user: ActiveUser) -> Result<User, DomainError> {
        self.mock_update(user).await
    }

    async fn update_fsp(&self, id: &str, fsp: i32) -> Result<User, DomainError> {
        self.mock_update_fsp(id.to_string(), fsp).await
    }

    async fn find_by_id_and_update_fsp(
        &self,
        id: &str,
        fsp: i32,
    ) -> Result<Option<User>, DomainError> {
        self.mock_find_by_id_and_update_fsp(id.to_string(), fsp)
            .await
    }

    async fn find_by_id(&self, id: &str) -> Result<Option<User>, DomainError> {
        self.mock_find_by_id(id.to_string()).await
    }

    async fn find_by_ids(&self, ids: Vec<&str>) -> Result<Vec<User>, DomainError> {
        self.mock_find_by_ids(ids.iter().map(|&id| id.to_string()).collect())
            .await
    }

    async fn find_by_email(&self, email: &str) -> Result<Option<User>, DomainError> {
        self.mock_find_by_email(email.to_string()).await
    }

    async fn delete(&self, id: &str) -> Result<(), DomainError> {
        self.mock_delete(id.to_string()).await
    }

    async fn list(&self, limit: usize, offset: usize) -> Result<Vec<User>, DomainError> {
        self.mock_list(limit, offset).await
    }

    async fn get_all_users(&self) -> Result<Vec<User>, DomainError> {
        self.mock_get_all_users().await
    }

    async fn find_by_username(&self, username: &str) -> Result<Option<User>, DomainError> {
        self.mock_find_by_username(username.to_string()).await
    }

    async fn find_by_evm_addr(&self, evm_addr: &str) -> Result<Option<User>, DomainError> {
        self.mock_find_by_evm_addr(evm_addr.to_string()).await
    }

    async fn find_by_invited_by(&self, invited_by: &str) -> Result<Vec<User>, DomainError> {
        self.mock_find_by_invited_by(invited_by.to_string()).await
    }

    async fn update_status(&self, id: &str, status: UserStatus) -> Result<User, DomainError> {
        self.mock_update_status(id.to_string(), status).await
    }

    async fn find_by_category(&self, category: UserCategory) -> Result<Vec<User>, DomainError> {
        self.mock_find_by_category(category).await
    }

    async fn count(&self) -> Result<i64, DomainError> {
        self.mock_count().await
    }

    async fn sum_fsp(&self) -> Result<i64, DomainError> {
        self.mock_sum_fsp().await
    }

    async fn count_mobile_app_users(&self) -> Result<i64, DomainError> {
        self.mock_count_mobile_app_users().await
    }

    async fn find_by_username_or_email(
        &self,
        username_or_email: &str,
    ) -> Result<Option<User>, DomainError> {
        self.mock_find_by_username_or_email(username_or_email.to_string())
            .await
    }

    async fn search_users(&self, username: &str) -> Result<Vec<User>, DomainError> {
        self.mock_search_users(username.to_string()).await
    }

    async fn find_users_have_evm_addr(&self) -> Result<Vec<User>, DomainError> {
        self.mock_find_users_have_evm_addr().await
    }

    async fn update_many(&self, users: Vec<ActiveUser>) -> Result<(), DomainError> {
        self.mock_update_many(users).await
    }
}
