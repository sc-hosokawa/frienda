use async_trait::async_trait;
use domain::entities::quest_user::{ActiveModel as QuestUserActiveModel, Model as QuestUser};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::quest_user_repo::QuestUserRepository;

#[automock]
#[async_trait]
pub trait MockQuestUserRepo {
    async fn mock_create(&self, quest_user: QuestUserActiveModel)
        -> Result<QuestUser, DomainError>;
    async fn mock_update(&self, quest_user: QuestUserActiveModel)
        -> Result<QuestUser, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<QuestUser>, DomainError>;
    async fn mock_get_by_user_id(&self, user_id: String) -> Result<Vec<QuestUser>, DomainError>;
    async fn mock_get_by_user_and_status(
        &self,
        user_id: String,
        is_done: bool,
    ) -> Result<Vec<QuestUser>, DomainError>;
}

#[async_trait]
impl QuestUserRepository for MockMockQuestUserRepo {
    async fn create(&self, quest_user: QuestUserActiveModel) -> Result<QuestUser, DomainError> {
        self.mock_create(quest_user).await
    }

    async fn update(&self, quest_user: QuestUserActiveModel) -> Result<QuestUser, DomainError> {
        self.mock_update(quest_user).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<QuestUser>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<QuestUser>, DomainError> {
        self.mock_get_by_user_id(user_id.to_string()).await
    }

    async fn get_by_user_and_status(
        &self,
        user_id: &str,
        is_done: bool,
    ) -> Result<Vec<QuestUser>, DomainError> {
        self.mock_get_by_user_and_status(user_id.to_string(), is_done)
            .await
    }
}
