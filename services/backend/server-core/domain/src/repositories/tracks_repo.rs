use crate::entities::tracks::{ActiveModel as TrackActiveModel, Model as Track};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait TracksRepository {
    async fn create(&self, track: &TrackActiveModel) -> Result<Track, DomainError>;
    async fn update(&self, track: &TrackActiveModel) -> Result<Track, DomainError>;
}
