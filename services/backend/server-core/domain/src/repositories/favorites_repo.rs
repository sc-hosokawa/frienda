use crate::entities::favorites::{ActiveModel as FavoriteActiveModel, Model as Favorite};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait FavoritesRepository: Send + Sync {
    async fn create(&self, favorite: FavoriteActiveModel) -> Result<Favorite, DomainError>;
    async fn update(&self, favorite: FavoriteActiveModel) -> Result<Favorite, DomainError>;

    async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn get_by_source_user_id(
        &self,
        source_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError>;
    async fn get_by_target_user_id(
        &self,
        target_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError>;
    async fn get_by_source_user_id_and_target_user_id(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError>;
    async fn exists(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError>;
}
