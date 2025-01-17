use crate::entities::user_blocks::{ActiveModel as UserBlocksActiveModel, Model as UserBlocks};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait UserBlocksRepo: Send + Sync {
    async fn create(&self, model: UserBlocksActiveModel) -> Result<UserBlocks, DomainError>;
    async fn update(&self, model: UserBlocksActiveModel) -> Result<UserBlocks, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn find_all(&self) -> Result<Vec<UserBlocks>, DomainError>;
    async fn find_by_id(&self, id: i32) -> Result<Option<UserBlocks>, DomainError>;
    async fn find_by_blocked_user_id(
        &self,
        blocked_user_id: &str,
    ) -> Result<Vec<UserBlocks>, DomainError>;
    async fn find_by_blocker_user_id(
        &self,
        blocker_user_id: &str,
    ) -> Result<Vec<UserBlocks>, DomainError>;
    async fn find_by_blocked_user_id_and_blocker_user_id(
        &self,
        blocked_user_id: &str,
        blocker_user_id: &str,
    ) -> Result<Option<UserBlocks>, DomainError>;
}
