use crate::graphql::models::users::*;
use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct CommentData {
    pub id: i32,
    pub commented_user: UserSimpleData,
    pub offer_id: i32,
    pub created_at: String,
    pub content: String,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct CreateNewCommentInput {
    pub commented_user_id: String,
    pub offer_id: i32,
    pub content: String,
}

#[derive(SimpleObject)]
pub struct CreateNewCommentResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct DeleteCommentInput {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct DeleteCommentResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct UpdateCommentInput {
    pub id: i32,
    pub content: String,
}

#[derive(SimpleObject)]
pub struct UpdateCommentResponse {
    pub id: i32,
    pub content: String,
}
