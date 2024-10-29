use crate::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait ArtistsRepository: Send + Sync {
    async fn create(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError>;
    async fn update(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError>;

    async fn find_by_id(&self, id: Uuid) -> Result<Option<Artist>, DomainError>;
    async fn find_by_ids(&self, ids: Vec<Uuid>) -> Result<Vec<Artist>, DomainError>;
    async fn find_by_name(&self, name: &str) -> Result<Vec<Artist>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Artist>, DomainError>;
    async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
}
