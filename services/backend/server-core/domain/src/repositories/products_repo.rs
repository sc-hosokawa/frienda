use crate::entities::products::{ActiveModel as ProductActiveModel, Model as Product};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[derive(Default)]
pub struct SearchProductsOptions {
    pub upc: Option<String>,
    pub product_title: Option<String>,
    pub product_type: Option<String>,
}

#[async_trait]
pub trait ProductsRepository: Send + Sync {
    async fn create(&self, product: ProductActiveModel) -> Result<Product, DomainError>;
    async fn create_many(&self, products: Vec<ProductActiveModel>) -> Result<bool, DomainError>;
    async fn update(&self, product: ProductActiveModel) -> Result<Product, DomainError>;

    async fn delete(&self, upc: &str) -> Result<(), DomainError>;
    async fn get_by_upc(&self, upc: &str) -> Result<Option<Product>, DomainError>;
    async fn get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<Product>, DomainError>;
    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Product>, DomainError>;
    async fn find_all(&self) -> Result<Vec<Product>, DomainError>;
    async fn search(&self, options: SearchProductsOptions) -> Result<Vec<Product>, DomainError>;
}
