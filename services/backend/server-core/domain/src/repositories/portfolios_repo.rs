use crate::entities::portfolios::{ActiveModel as PortfolioActiveModel, Model as Portfolio};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait PortfoliosRepository: Send + Sync {
    async fn create(&self, portfolio: PortfolioActiveModel) -> Result<Portfolio, DomainError>;
    async fn update(&self, portfolio: PortfolioActiveModel) -> Result<Portfolio, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn get_all(&self) -> Result<Vec<Portfolio>, DomainError>;
    async fn get_by_id(&self, id: i32) -> Result<Option<Portfolio>, DomainError>;
    async fn get_by_user_id(&self, user_id: String) -> Result<Vec<Portfolio>, DomainError>;
}
