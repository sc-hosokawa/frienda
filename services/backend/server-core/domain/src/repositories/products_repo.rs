use crate::entities::products::{ActiveModel as ProductActiveModel, Model as Product};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ProductsRepository: Send + Sync {
    async fn create(&self, product: ProductActiveModel) -> Result<Product, DomainError>;
    async fn update(&self, product: ProductActiveModel) -> Result<Product, DomainError>;

    async fn delete(&self, upc: &str) -> Result<(), DomainError>;
    async fn get_by_upc(&self, upc: &str) -> Result<Option<Product>, DomainError>;
    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Product>, DomainError>;
}
