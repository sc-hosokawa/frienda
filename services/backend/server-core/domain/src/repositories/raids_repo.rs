use crate::entities::raids::{ActiveModel as RaidActiveModel, Model as Raid};
use crate::entities::sea_orm_active_enums::OfferCategory;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait RaidsRepository {
    async fn create(&self, raid: &RaidActiveModel) -> Result<Raid, DomainError>;
    async fn update(&self, raid: &RaidActiveModel) -> Result<Raid, DomainError>;

    async fn find_by_id(&self, id: &str) -> Result<Option<Raid>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Raid>, DomainError>;
    async fn delete(&self, id: &str) -> Result<(), DomainError>;
    async fn find_by_owner(&self, owner: Uuid) -> Result<Vec<Raid>, DomainError>;
    async fn find_by_category(&self, category: OfferCategory) -> Result<Vec<Raid>, DomainError>;
    async fn find_recent(&self, limit: u64) -> Result<Vec<Raid>, DomainError>;
    async fn search_by_title(&self, title: &str) -> Result<Vec<Raid>, DomainError>;
    async fn update_description(&self, id: &str, description: &str) -> Result<Raid, DomainError>;
}
