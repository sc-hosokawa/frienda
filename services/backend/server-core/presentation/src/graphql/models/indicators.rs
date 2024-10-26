use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct IndicatorData {
    pub id: i16,
    pub name: String,
    pub description: Option<String>,
    pub logic: String,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct CreateNewIndicatorInput {
    pub name: String,
    pub description: Option<String>,
    pub logic: String,
}

#[derive(SimpleObject)]
pub struct CreateNewIndicatorResponse {
    pub id: i16,
}

#[derive(InputObject)]
pub struct DeleteIndicatorInput {
    pub id: i16,
}

#[derive(SimpleObject)]
pub struct DeleteIndicatorResponse {
    pub id: i16,
}

#[derive(InputObject)]
pub struct UpdateIndicatorInput {
    pub id: i16,
    pub name: Option<String>,
    pub description: Option<String>,
    pub logic: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdateIndicatorResponse {
    pub id: i16,
}
