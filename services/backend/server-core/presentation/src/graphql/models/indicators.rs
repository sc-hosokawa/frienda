use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct IndicatorData {
    pub id: String,
    pub name: String,
    pub description: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(InputObject)]
pub struct IndicatorInput {
    pub name: String,
    pub description: String,
}
