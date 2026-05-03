use async_trait::async_trait;
use domain::entities::products::{ActiveModel as ProductActiveModel, Model as Product};
use domain::repositories::products_repo::{
    DashboardProductRow, ProductsRepository, SearchProductsOptions,
};
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockProductsRepo {
    async fn mock_create(&self, product: ProductActiveModel) -> Result<Product, DomainError>;
    async fn mock_create_many(
        &self,
        products: Vec<ProductActiveModel>,
    ) -> Result<bool, DomainError>;
    async fn mock_update(&self, product: ProductActiveModel) -> Result<Product, DomainError>;
    async fn mock_delete(&self, upc: String) -> Result<(), DomainError>;
    async fn mock_get_by_upc(&self, upc: String) -> Result<Option<Product>, DomainError>;
    async fn mock_get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<Product>, DomainError>;
    async fn mock_find_by_artist_id(&self, artist_id: String) -> Result<Vec<Product>, DomainError>;
    async fn mock_find_dashboard_products_by_artist_id(
        &self,
        artist_id: String,
    ) -> Result<Vec<DashboardProductRow>, DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<Product>, DomainError>;
    async fn mock_search(
        &self,
        options: SearchProductsOptions,
    ) -> Result<Vec<Product>, DomainError>;
}

#[async_trait]
impl ProductsRepository for MockMockProductsRepo {
    async fn create(&self, product: ProductActiveModel) -> Result<Product, DomainError> {
        self.mock_create(product).await
    }

    async fn create_many(&self, products: Vec<ProductActiveModel>) -> Result<bool, DomainError> {
        self.mock_create_many(products).await
    }

    async fn update(&self, product: ProductActiveModel) -> Result<Product, DomainError> {
        self.mock_update(product).await
    }

    async fn delete(&self, upc: &str) -> Result<(), DomainError> {
        self.mock_delete(upc.to_string()).await
    }

    async fn get_by_upc(&self, upc: &str) -> Result<Option<Product>, DomainError> {
        self.mock_get_by_upc(upc.to_string()).await
    }

    async fn get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<Product>, DomainError> {
        self.mock_get_by_upcs(upcs).await
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Product>, DomainError> {
        self.mock_find_by_artist_id(artist_id.to_string()).await
    }

    async fn find_dashboard_products_by_artist_id(
        &self,
        artist_id: &str,
    ) -> Result<Vec<DashboardProductRow>, DomainError> {
        self.mock_find_dashboard_products_by_artist_id(artist_id.to_string())
            .await
    }

    async fn find_all(&self) -> Result<Vec<Product>, DomainError> {
        self.mock_find_all().await
    }

    async fn search(&self, options: SearchProductsOptions) -> Result<Vec<Product>, DomainError> {
        self.mock_search(options).await
    }
}
