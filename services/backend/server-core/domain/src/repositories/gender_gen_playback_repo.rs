use crate::entities::gender_gen_playback::{
    ActiveModel as GenderGenPlaybackActiveModel, Model as GenderGenPlayback,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait GenderGenPlaybackRepository: Send + Sync {
    async fn create(
        &self,
        gender_gen_playback: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError>;
    async fn update(
        &self,
        gender_gen_playback: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn find_by_id(&self, id: i32) -> Result<Option<GenderGenPlayback>, DomainError>;

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn find_by_isrc_and_year(
        &self,
        isrc: &str,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn find_by_isrcs(
        &self,
        isrcs: Vec<String>,
    ) -> Result<Vec<GenderGenPlayback>, DomainError>;
    async fn find_by_isrcs_and_year(
        &self,
        isrcs: Vec<String>,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError>;
}
