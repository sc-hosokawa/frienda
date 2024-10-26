use crate::entities::raids::{ActiveModel as RaidActiveModel, Model as Raid};
use crate::entities::sea_orm_active_enums::OfferCategory;
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait RaidsRepository {
    async fn create(&self, raid: &RaidActiveModel) -> Result<Raid, DomainError>;
    async fn update(&self, raid: &RaidActiveModel) -> Result<Raid, DomainError>;

    async fn find_by_id(&self, id: i32) -> Result<Option<Raid>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Raid>, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn find_by_owner(&self, owner: &str) -> Result<Vec<Raid>, DomainError>;
    async fn find_by_category(&self, category: OfferCategory) -> Result<Vec<Raid>, DomainError>;
    async fn find_recent(&self, limit: u64) -> Result<Vec<Raid>, DomainError>;
    async fn search_by_title(&self, title: &str) -> Result<Vec<Raid>, DomainError>;
}
