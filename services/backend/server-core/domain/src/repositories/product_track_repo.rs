use crate::entities::product_track::{
    ActiveModel as ProductTrackActiveModel, Model as ProductTrack,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ProductTrackRepository {
    async fn create(
        &self,
        product_track: &ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError>;
    async fn update(
        &self,
        product_track: &ProductTrackActiveModel,
    ) -> Result<ProductTrack, DomainError>;
}
