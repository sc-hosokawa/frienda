use crate::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ArtistsRepository {
    async fn create(&self, artist: &ArtistActiveModel) -> Result<Artist, DomainError>;
    async fn update(&self, artist: &ArtistActiveModel) -> Result<Artist, DomainError>;

    async fn find_by_id(&self, id: i32) -> Result<Option<Artist>, DomainError>;
    async fn find_by_name(&self, name: &str) -> Result<Vec<Artist>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Artist>, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
}
