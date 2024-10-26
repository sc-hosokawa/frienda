use crate::entities::comments::{ActiveModel as CommentActiveModel, Model as Comment};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait CommentsRepository {
    async fn create(&self, comment: &CommentActiveModel) -> Result<Comment, DomainError>;
    async fn update(&self, comment: &CommentActiveModel) -> Result<Comment, DomainError>;

    async fn find_by_id(&self, id: i32) -> Result<Option<Comment>, DomainError>;
    async fn find_by_user_id(&self, user_id: &str) -> Result<Vec<Comment>, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;
}
