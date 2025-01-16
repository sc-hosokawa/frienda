use async_graphql::InputObject;

#[derive(InputObject)]
pub struct ContactToAdminInput {
    pub username: String,
    pub category: String,
    pub email: String,
    pub content: String,
}
