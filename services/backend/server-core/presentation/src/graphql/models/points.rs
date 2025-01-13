use async_graphql::SimpleObject;

// ==== Query ====
#[derive(SimpleObject)]
pub struct UserPointBalanceData {
    pub fsp_balance: i32,
    pub fsp_balance_temp: i32,
    pub credential_balance: i32,
    pub is_credential_available: bool,
}

// ==== Mutation ====
