use crate::entities::user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait UserArtistRepository {
    async fn create(&self, user_artist: &UserArtistActiveModel) -> Result<UserArtist, DomainError>;
    async fn update(&self, user_artist: &UserArtistActiveModel) -> Result<UserArtist, DomainError>;
}
