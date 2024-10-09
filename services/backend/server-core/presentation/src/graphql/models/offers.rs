use async_graphql::{InputObject, SimpleObject};

// ===== Query =====

#[derive(SimpleObject)]
pub struct OffersData {
    pub id: String,
    pub title: String,
    pub content: String,
    pub created_at: String,
    pub updated_at: String,
}

// ===== Mutation =====

#[derive(InputObject)]
pub struct CreateNewOfferInput {
    pub title: String,
    pub content: String,
}

#[derive(InputObject)]
pub struct UpdateOfferInput {
    pub id: String,
    pub title: String,
    pub content: String,
}

#[derive(InputObject)]
pub struct DeleteOfferInput {
    pub id: String,
}

#[derive(SimpleObject)]
pub struct CreateNewOfferResponse {
    pub id: String,
}

#[derive(SimpleObject)]
pub struct UpdateOfferResponse {
    pub id: String,
}

#[derive(SimpleObject)]
pub struct DeleteOfferResponse {
    pub id: String,
}
