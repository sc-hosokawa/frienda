use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct Comment {
    pub id: String,
    pub content: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(InputObject)]
pub struct CommentInput {
    pub content: String,
}
