use crate::entities::quest_user::{ActiveModel as QuestUserActiveModel, Model as QuestUser};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait QuestUserRepository {
    async fn create(&self, quest_user: &QuestUserActiveModel) -> Result<QuestUser, DomainError>;
    async fn update(&self, quest_user: &QuestUserActiveModel) -> Result<QuestUser, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<QuestUser>, DomainError>;
    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<QuestUser>, DomainError>;
    async fn get_by_user_and_status(
        &self,
        user_id: &str,
        is_done: bool,
    ) -> Result<Vec<QuestUser>, DomainError>;
}
