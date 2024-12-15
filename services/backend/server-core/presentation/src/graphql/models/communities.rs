use crate::graphql::models::users::*;
use async_graphql::{InputObject, SimpleObject};

// ===== Query =====

#[derive(SimpleObject)]
pub struct ConnectedUserByUserData {
    pub id: String, // uuid
    pub connected_user: UserBasicData,
}

#[derive(SimpleObject)]
pub struct ConnectedUsersData {
    pub connected_user_list: Vec<ConnectedUserByUserData>,
    pub count_of_users: Option<i32>,
}

// ===== Mutation =====

#[derive(InputObject)]
pub struct AddNewConnectionByUserInput {
    pub user_id: String,
}

#[derive(SimpleObject)]
pub struct AddNewConnectionResponse {
    pub map_id: String, // uuid
}

#[derive(SimpleObject)]
pub struct AddShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct MarkFavoriteResponse {
    pub id: String, // uuid
}
