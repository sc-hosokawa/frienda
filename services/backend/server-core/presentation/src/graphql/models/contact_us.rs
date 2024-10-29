use async_graphql::{InputObject, SimpleObject};

#[derive(InputObject)]
pub struct ContactToAdminInput {
    pub username: String,
    pub category: String,
    pub email: String,
    pub content: String,
}

#[derive(SimpleObject)]
pub struct ContactToAdminResponse {
    pub id: String, // ハッシュとか計算して返す
}
