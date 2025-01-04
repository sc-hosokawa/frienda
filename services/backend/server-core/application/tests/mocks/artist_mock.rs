use async_trait::async_trait;
use domain::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::artists_repo::ArtistsRepository;

#[automock]
#[async_trait]
pub trait MockArtistsRepo {
    async fn mock_create(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError>;
    async fn mock_update(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError>;
    async fn mock_find_latest(&self) -> Result<Option<Artist>, DomainError>;
    async fn mock_find_by_id(&self, id: String) -> Result<Option<Artist>, DomainError>;
    async fn mock_find_by_ids(&self, ids: Vec<String>) -> Result<Vec<Artist>, DomainError>;
    async fn mock_find_by_name(&self, name: String) -> Result<Vec<Artist>, DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<Artist>, DomainError>;
    async fn mock_delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn mock_update_fsp(&self, id: String, fsp: i32) -> Result<Artist, DomainError>;
    async fn mock_count(&self) -> Result<i64, DomainError>;
}

#[async_trait]
impl ArtistsRepository for MockMockArtistsRepo {
    async fn create(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError> {
        self.mock_create(artist).await
    }

    async fn update(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError> {
        self.mock_update(artist).await
    }

    async fn find_latest(&self) -> Result<Option<Artist>, DomainError> {
        self.mock_find_latest().await
    }

    async fn find_by_id(&self, id: &str) -> Result<Option<Artist>, DomainError> {
        self.mock_find_by_id(id.to_string()).await
    }

    async fn find_by_ids(&self, ids: Vec<&str>) -> Result<Vec<Artist>, DomainError> {
        self.mock_find_by_ids(ids.iter().map(|&id| id.to_string()).collect())
            .await
    }

    async fn find_by_name(&self, name: &str) -> Result<Vec<Artist>, DomainError> {
        self.mock_find_by_name(name.to_string()).await
    }

    async fn find_all(&self) -> Result<Vec<Artist>, DomainError> {
        self.mock_find_all().await
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn update_fsp(&self, id: &str, fsp: i32) -> Result<Artist, DomainError> {
        self.mock_update_fsp(id.to_string(), fsp).await
    }

    async fn count(&self) -> Result<i64, DomainError> {
        self.mock_count().await
    }
}
