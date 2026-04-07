use async_trait::async_trait;
use domain::entities::gender_gen_playback::{
    ActiveModel as GenderGenPlaybackActiveModel, Model as GenderGenPlayback,
};
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockGenderGenPlaybackRepo {
    async fn mock_create(
        &self,
        gender_gen_playback: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError>;
    async fn mock_update(
        &self,
        gender_gen_playback: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError>;
    async fn mock_insert_many(
        &self,
        gender_gen_playback: Vec<GenderGenPlaybackActiveModel>,
    ) -> Result<(), DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_find_by_id(&self, id: i32) -> Result<Option<GenderGenPlayback>, DomainError>;
    async fn mock_find_by_isrc(&self, isrc: String) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn mock_find_by_isrc_and_year(
        &self,
        isrc: String,
        year: String,
    ) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn mock_find_by_isrcs(
        &self,
        isrcs: Vec<String>,
    ) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn mock_find_by_isrcs_and_year(
        &self,
        isrcs: Vec<String>,
        year: String,
    ) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn mock_find_lastest_id(&self) -> Result<i32, DomainError>;
}

#[async_trait]
impl GenderGenPlaybackRepository for MockMockGenderGenPlaybackRepo {
    async fn create(
        &self,
        gender_gen_playback: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError> {
        self.mock_create(gender_gen_playback).await
    }

    async fn update(
        &self,
        gender_gen_playback: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError> {
        self.mock_update(gender_gen_playback).await
    }

    async fn insert_many(
        &self,
        gender_gen_playback: Vec<GenderGenPlaybackActiveModel>,
    ) -> Result<(), DomainError> {
        self.mock_insert_many(gender_gen_playback).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<GenderGenPlayback>, DomainError> {
        self.mock_find_by_id(id).await
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<GenderGenPlayback>, DomainError> {
        self.mock_find_by_isrc(isrc.to_string()).await
    }

    async fn find_by_isrc_and_year(
        &self,
        isrc: &str,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        self.mock_find_by_isrc_and_year(isrc.to_string(), year.to_string())
            .await
    }

    async fn find_by_isrcs(
        &self,
        isrcs: Vec<String>,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        self.mock_find_by_isrcs(isrcs).await
    }

    async fn find_by_isrcs_and_year(
        &self,
        isrcs: Vec<String>,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        self.mock_find_by_isrcs_and_year(isrcs, year.to_string())
            .await
    }

    async fn find_lastest_id(&self) -> Result<i32, DomainError> {
        self.mock_find_lastest_id().await
    }
}
