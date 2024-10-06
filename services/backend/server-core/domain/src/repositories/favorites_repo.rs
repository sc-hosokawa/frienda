use crate::entities::favorites::{ActiveModel as FavoriteActiveModel, Model as Favorite};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait FavoritesRepository {
    async fn create(&self, favorite: &FavoriteActiveModel) -> Result<Favorite, DomainError>;
    async fn update(&self, favorite: &FavoriteActiveModel) -> Result<Favorite, DomainError>;
}
