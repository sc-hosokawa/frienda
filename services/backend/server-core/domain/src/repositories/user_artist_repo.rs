use crate::entities::user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait UserArtistRepository: Send + Sync {
    async fn create(&self, user_artist: UserArtistActiveModel) -> Result<UserArtist, DomainError>;
    async fn update(&self, user_artist: UserArtistActiveModel) -> Result<UserArtist, DomainError>;
    async fn update_status(
        &self,
        user_artist: UserArtistActiveModel,
    ) -> Result<UserArtist, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn find_all(&self) -> Result<Vec<UserArtist>, DomainError>;
    async fn find_by_user_id(&self, user_id: &str) -> Result<Vec<UserArtist>, DomainError>;
    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<UserArtist>, DomainError>;
    async fn find_by_artist_ids(
        &self,
        artist_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError>;
    async fn find_by_artist_id_and_user_id(
        &self,
        artist_id: &str,
        user_id: &str,
    ) -> Result<Option<UserArtist>, DomainError>;
    async fn exists(&self, user_id: &str, artist_id: &str) -> Result<bool, DomainError>;
}
