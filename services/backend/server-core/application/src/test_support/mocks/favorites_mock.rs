use async_trait::async_trait;
use domain::entities::favorites::{ActiveModel as FavoriteActiveModel, Model as Favorite};
use domain::repositories::favorites_repo::FavoritesRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[automock]
#[async_trait]
pub trait MockFavoritesRepo {
    async fn mock_create(&self, favorite: FavoriteActiveModel) -> Result<Favorite, DomainError>;
    async fn mock_update(&self, favorite: FavoriteActiveModel) -> Result<Favorite, DomainError>;
    async fn mock_delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn mock_get_by_source_user_id(
        &self,
        source_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError>;
    async fn mock_get_by_target_user_id(
        &self,
        target_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError>;
    async fn mock_get_by_source_user_id_and_target_user_id(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError>;
    async fn mock_exists(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError>;
}

#[async_trait]
impl FavoritesRepository for MockMockFavoritesRepo {
    async fn create(&self, favorite: FavoriteActiveModel) -> Result<Favorite, DomainError> {
        self.mock_create(favorite).await
    }

    async fn update(&self, favorite: FavoriteActiveModel) -> Result<Favorite, DomainError> {
        self.mock_update(favorite).await
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_source_user_id(
        &self,
        source_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError> {
        self.mock_get_by_source_user_id(source_user_id).await
    }

    async fn get_by_target_user_id(
        &self,
        target_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError> {
        self.mock_get_by_target_user_id(target_user_id).await
    }

    async fn get_by_source_user_id_and_target_user_id(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError> {
        self.mock_get_by_source_user_id_and_target_user_id(source_user_id, target_user_id)
            .await
    }

    async fn exists(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError> {
        self.mock_exists(source_user_id, target_user_id).await
    }
}
