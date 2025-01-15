use crate::entities::product_track::{
    ActiveModel as ProductTrackActiveModel, Model as ProductTrack,
};
use async_trait::async_trait;
use sea_orm::InsertResult;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ProductTrackRepository: Send + Sync {
    async fn create(
        &self,
        product_track: ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError>;
    async fn create_many(
        &self,
        product_tracks: Vec<ProductTrackActiveModel>,
    ) -> Result<InsertResult<ProductTrackActiveModel>, DomainError>;
    async fn update(
        &self,
        product_track: ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError>;

    async fn delete(&self, id: i32) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<ProductTrack>, DomainError>;
    async fn get_by_upc(&self, upc: &str) -> Result<Vec<ProductTrack>, DomainError>;
    async fn get_by_isrc(&self, isrc: &str) -> Result<Vec<ProductTrack>, DomainError>;
    async fn get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError>;
    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError>;
}
