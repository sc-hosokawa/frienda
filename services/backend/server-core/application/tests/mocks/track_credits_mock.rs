use async_trait::async_trait;
use domain::entities::track_credits::{
    ActiveModel as TrackCreditsActiveModel, Model as TrackCredits,
};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::track_credits_repo::TrackCreditsRepository;

#[automock]
#[async_trait]
pub trait MockTrackCreditsRepo {
    async fn mock_create(
        &self,
        track_credits: TrackCreditsActiveModel,
    ) -> Result<TrackCredits, DomainError>;
    async fn mock_update(
        &self,
        track_credits: TrackCreditsActiveModel,
    ) -> Result<TrackCredits, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<TrackCredits>, DomainError>;
    async fn mock_find_by_id(&self, id: i32) -> Result<Option<TrackCredits>, DomainError>;
    async fn mock_find_by_isrc(&self, isrc: &str) -> Result<Vec<TrackCredits>, DomainError>;
    async fn mock_find_by_is_invite(
        &self,
        is_invite: bool,
    ) -> Result<Vec<TrackCredits>, DomainError>;
    async fn mock_all_credits(&self, count: i32) -> Result<Vec<TrackCredits>, DomainError>;
    async fn mock_count_credits(&self) -> Result<i64, DomainError>;
}

#[async_trait]
impl TrackCreditsRepository for MockMockTrackCreditsRepo {
    async fn create(
        &self,
        track_credits: TrackCreditsActiveModel,
    ) -> Result<TrackCredits, DomainError> {
        self.mock_create(track_credits).await
    }

    async fn update(
        &self,
        track_credits: TrackCreditsActiveModel,
    ) -> Result<TrackCredits, DomainError> {
        self.mock_update(track_credits).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn find_all(&self) -> Result<Vec<TrackCredits>, DomainError> {
        self.mock_find_all().await
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<TrackCredits>, DomainError> {
        self.mock_find_by_id(id).await
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<TrackCredits>, DomainError> {
        self.mock_find_by_isrc(isrc).await
    }

    async fn find_by_is_invite(&self, is_invite: bool) -> Result<Vec<TrackCredits>, DomainError> {
        self.mock_find_by_is_invite(is_invite).await
    }

    async fn all_credits(&self, count: i32) -> Result<Vec<TrackCredits>, DomainError> {
        self.mock_all_credits(count).await
    }

    async fn count_credits(&self) -> Result<i64, DomainError> {
        self.mock_count_credits().await
    }
}
