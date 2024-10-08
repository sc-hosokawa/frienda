use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct Users {
    pub id: String,
    pub email: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(InputObject)]
pub struct UsersInput {
    pub id: String,
    pub email: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(SimpleObject)]
pub struct Indicator {
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
