use crate::entities::news::{ActiveModel as NewsActiveModel, Model as News};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait NewsRepository {
    async fn create(&self, news: &NewsActiveModel) -> Result<News, DomainError>;
    async fn update(&self, news: &NewsActiveModel) -> Result<News, DomainError>;
}
