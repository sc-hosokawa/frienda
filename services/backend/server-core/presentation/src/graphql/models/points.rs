use async_graphql::{InputObject, SimpleObject};

// ==== Query ====
#[derive(SimpleObject)]
pub struct FspBalanceByUserData {
    pub balance: i32,
    pub balance_temp: Option<i32>,
}

#[derive(SimpleObject)]
pub struct CredentialBalanceByUserData {
    pub balance: i32,
}

// ==== Mutation ====
