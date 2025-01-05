use crate::entities::tracks::{ActiveModel as TrackActiveModel, Model as Track};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait TracksRepository: Send + Sync {
    async fn create(&self, track: TrackActiveModel) -> Result<Track, DomainError>;
    async fn create_many(&self, tracks: Vec<TrackActiveModel>) -> Result<(), DomainError>;
    async fn update(&self, track: TrackActiveModel) -> Result<Track, DomainError>;

    async fn delete(&self, isrc: &str) -> Result<(), DomainError>;
    async fn get_by_isrc(&self, isrc: &str) -> Result<Option<Track>, DomainError>;
    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<Track>, DomainError>;
    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Track>, DomainError>;
    async fn count(&self) -> Result<i64, DomainError>;
    async fn find_all(&self) -> Result<Vec<Track>, DomainError>;
}
