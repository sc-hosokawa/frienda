use async_trait::async_trait;
use domain::entities::quests::{ActiveModel as QuestActiveModel, Model as Quest};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::quests_repo::QuestsRepository;

#[automock]
#[async_trait]
pub trait MockQuestsRepo {
    async fn mock_create(&self, quest: QuestActiveModel) -> Result<Quest, DomainError>;
    async fn mock_update(&self, quest: QuestActiveModel) -> Result<Quest, DomainError>;
    async fn mock_find_by_id(&self, id: i32) -> Result<Option<Quest>, DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<Quest>, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_find_by_name(&self, name: String) -> Result<Vec<Quest>, DomainError>;
    async fn mock_find_recent(&self, limit: u64) -> Result<Vec<Quest>, DomainError>;
}

#[async_trait]
impl QuestsRepository for MockMockQuestsRepo {
    async fn create(&self, quest: QuestActiveModel) -> Result<Quest, DomainError> {
        self.mock_create(quest).await
    }

    async fn update(&self, quest: QuestActiveModel) -> Result<Quest, DomainError> {
        self.mock_update(quest).await
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<Quest>, DomainError> {
        self.mock_find_by_id(id).await
    }

    async fn find_all(&self) -> Result<Vec<Quest>, DomainError> {
        self.mock_find_all().await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn find_by_name(&self, name: &str) -> Result<Vec<Quest>, DomainError> {
        self.mock_find_by_name(name.to_string()).await
    }

    async fn find_recent(&self, limit: u64) -> Result<Vec<Quest>, DomainError> {
        self.mock_find_recent(limit).await
    }
}
