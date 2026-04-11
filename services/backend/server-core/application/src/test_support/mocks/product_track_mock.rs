use async_trait::async_trait;
use domain::entities::product_track::{
    ActiveModel as ProductTrackActiveModel, Model as ProductTrack,
};
use domain::repositories::product_track_repo::ProductTrackRepository;
use mockall::automock;
use sea_orm::InsertResult;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockProductTrackRepo {
    async fn mock_create(
        &self,
        product_track: ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError>;
    async fn mock_create_many(
        &self,
        product_tracks: Vec<ProductTrackActiveModel>,
    ) -> Result<InsertResult<ProductTrackActiveModel>, DomainError>;
    async fn mock_update(
        &self,
        product_track: ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_delete_by_isrc(&self, isrc: String) -> Result<(), DomainError>;
    async fn mock_delete_by_upc(&self, upc: String) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<ProductTrack>, DomainError>;
    async fn mock_get_by_upc(&self, upc: String) -> Result<Vec<ProductTrack>, DomainError>;
    async fn mock_get_by_isrc(&self, isrc: String) -> Result<Vec<ProductTrack>, DomainError>;
    async fn mock_get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError>;
    async fn mock_get_by_isrcs(&self, isrcs: Vec<String>)
        -> Result<Vec<ProductTrack>, DomainError>;
    async fn mock_get_max_id(&self) -> Result<Option<i32>, DomainError>;
}

#[async_trait]
impl ProductTrackRepository for MockMockProductTrackRepo {
    async fn create(
        &self,
        product_track: ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError> {
        self.mock_create(product_track).await
    }

    async fn create_many(
        &self,
        product_tracks: Vec<ProductTrackActiveModel>,
    ) -> Result<InsertResult<ProductTrackActiveModel>, DomainError> {
        self.mock_create_many(product_tracks).await
    }

    async fn update(
        &self,
        product_track: ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError> {
        self.mock_update(product_track).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        self.mock_delete_by_isrc(isrc.to_string()).await
    }

    async fn delete_by_upc(&self, upc: &str) -> Result<(), DomainError> {
        self.mock_delete_by_upc(upc.to_string()).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<ProductTrack>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_upc(&self, upc: &str) -> Result<Vec<ProductTrack>, DomainError> {
        self.mock_get_by_upc(upc.to_string()).await
    }

    async fn get_by_isrc(&self, isrc: &str) -> Result<Vec<ProductTrack>, DomainError> {
        self.mock_get_by_isrc(isrc.to_string()).await
    }

    async fn get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError> {
        self.mock_get_by_upcs(upcs).await
    }

    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError> {
        self.mock_get_by_isrcs(isrcs).await
    }

    async fn get_max_id(&self) -> Result<Option<i32>, DomainError> {
        self.mock_get_max_id().await
    }
}
