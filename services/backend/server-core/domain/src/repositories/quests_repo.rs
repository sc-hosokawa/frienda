use crate::entities::quests::Entity as Quest;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait QuestsRepository {
    async fn create(&self, quest: Quest) -> Result<Quest, DomainError>;
    async fn find_by_id(&self, id: &str) -> Result<Option<Quest>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Quest>, DomainError>;
    async fn update(&self, quest: Quest) -> Result<Quest, DomainError>;
    async fn delete(&self, id: &str) -> Result<(), DomainError>;

    async fn find_by_name(&self, name: &str) -> Result<Vec<Quest>, DomainError>;
    async fn find_recent(&self, limit: u64) -> Result<Vec<Quest>, DomainError>;
}
