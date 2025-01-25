use crate::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use crate::entities::users::{ActiveModel as ActiveUser, Model as User};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait UsersRepository: Send + Sync {
    async fn create(&self, user: ActiveUser) -> Result<User, DomainError>;
    async fn update(&self, user: ActiveUser) -> Result<User, DomainError>;
    async fn update_many(&self, users: Vec<ActiveUser>) -> Result<(), DomainError>;
    async fn update_fsp(&self, id: &str, fsp: i32) -> Result<User, DomainError>;
    async fn find_by_id_and_update_fsp(
        &self,
        id: &str,
        fsp: i32,
    ) -> Result<Option<User>, DomainError>;
    async fn find_by_id(&self, id: &str) -> Result<Option<User>, DomainError>;
    async fn find_by_ids(&self, ids: Vec<&str>) -> Result<Vec<User>, DomainError>;
    async fn find_by_email(&self, email: &str) -> Result<Option<User>, DomainError>;
    async fn delete(&self, id: &str) -> Result<(), DomainError>;
    async fn list(&self, limit: usize, offset: usize) -> Result<Vec<User>, DomainError>;
    async fn get_all_users(&self) -> Result<Vec<User>, DomainError>;
    async fn find_by_username(&self, username: &str) -> Result<Option<User>, DomainError>;
    async fn find_by_evm_addr(&self, evm_addr: &str) -> Result<Option<User>, DomainError>;
    async fn find_by_invited_by(&self, invited_by: &str) -> Result<Vec<User>, DomainError>;
    async fn update_status(&self, id: &str, status: UserStatus) -> Result<User, DomainError>;
    async fn find_by_category(&self, category: UserCategory) -> Result<Vec<User>, DomainError>;
    async fn count(&self) -> Result<i64, DomainError>;
    async fn find_by_username_or_email(
        &self,
        username_or_email: &str,
    ) -> Result<Option<User>, DomainError>;
    async fn search_users(&self, username: &str) -> Result<Vec<User>, DomainError>;
    async fn find_users_have_evm_addr(&self) -> Result<Vec<User>, DomainError>;
}
