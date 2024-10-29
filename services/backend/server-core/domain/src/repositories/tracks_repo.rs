use crate::entities::tracks::{ActiveModel as TrackActiveModel, Model as Track};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait TracksRepository {
    async fn create(&self, track: &TrackActiveModel) -> Result<Track, DomainError>;
    async fn update(&self, track: &TrackActiveModel) -> Result<Track, DomainError>;

    async fn delete(&self, isrc: &str) -> Result<(), DomainError>;
    async fn get_by_isrc(&self, isrc: &str) -> Result<Option<Track>, DomainError>;
}
