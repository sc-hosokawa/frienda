use crate::entities::products::{ActiveModel as ProductActiveModel, Model as Product};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ProductsRepository {
    async fn create(&self, product: &ProductActiveModel) -> Result<Product, DomainError>;
    async fn update(&self, product: &ProductActiveModel) -> Result<Product, DomainError>;
}
