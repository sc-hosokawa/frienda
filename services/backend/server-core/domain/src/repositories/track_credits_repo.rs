use crate::entities::track_credits::{
    ActiveModel as TrackCreditsActiveModel, Model as TrackCredits,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait TrackCreditsRepository: Send + Sync {
    async fn create(
        &self,
        track_credits: TrackCreditsActiveModel,
    ) -> Result<TrackCredits, DomainError>;
    async fn update(
        &self,
        track_credits: TrackCreditsActiveModel,
    ) -> Result<TrackCredits, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn find_all(&self) -> Result<Vec<TrackCredits>, DomainError>;
    async fn find_by_id(&self, id: i32) -> Result<Option<TrackCredits>, DomainError>;
    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<TrackCredits>, DomainError>;
    async fn find_by_is_invite(&self, is_invite: bool) -> Result<Vec<TrackCredits>, DomainError>;
    async fn all_credits(&self, count: i32) -> Result<Vec<TrackCredits>, DomainError>;
    async fn count_credits(&self) -> Result<i64, DomainError>;
}
