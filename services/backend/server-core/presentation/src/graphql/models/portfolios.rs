use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct Portfolio {
    pub id: i32,
    pub user_id: String,
    pub title: String,
    pub description: String,
    pub img_url: Option<String>,
    pub category: String,
    pub release_date: Option<String>,
    pub external_url: Option<String>,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(InputObject)]
pub struct RegisterPortfolioInput {
    pub user_id: String,
    pub title: String,
    pub description: String,
    pub img_url: String,
    pub category: String,
    pub release_date: String,
    pub external_url: String,
}

#[derive(SimpleObject)]
pub struct RegisterPortfolioResponse {
    pub portfolio_id: i32,
}

#[derive(InputObject)]
pub struct UpdatePortfolioInput {
    pub id: i32,
    pub title: Option<String>,
    pub description: Option<String>,
    pub img_url: Option<String>,
    pub category: Option<String>,
    pub release_date: Option<String>,
    pub external_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdatePortfolioResponse {
    pub portfolio_id: i32,
}

#[derive(InputObject)]
pub struct DeletePortfolioInput {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct DeletePortfolioResponse {
    pub portfolio_id: i32,
}
