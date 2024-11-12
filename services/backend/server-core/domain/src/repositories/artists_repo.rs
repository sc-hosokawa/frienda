use crate::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait ArtistsRepository: Send + Sync {
    async fn create(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError>;
    async fn update(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError>;

    async fn find_by_id(&self, id: &str) -> Result<Option<Artist>, DomainError>;
    async fn find_by_ids(&self, ids: Vec<&str>) -> Result<Vec<Artist>, DomainError>;
    async fn find_by_name(&self, name: &str) -> Result<Vec<Artist>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Artist>, DomainError>;
    async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn update_fsp(&self, id: &str, fsp: i32) -> Result<Artist, DomainError>;
}
