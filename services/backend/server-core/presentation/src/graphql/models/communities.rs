use async_graphql::{InputObject, SimpleObject};

// ===== Query =====

// ===== Mutation =====

#[derive(InputObject)]
pub struct AddNewConnectionInput {
    pub user_id: String,
}

#[derive(SimpleObject)]
pub struct AddNewConnectionResponse {
    pub map_id: String,
}
