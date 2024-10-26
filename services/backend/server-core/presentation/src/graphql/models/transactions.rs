use crate::graphql::models::users::*;
use async_graphql::{Enum, InputObject, SimpleObject};

// ==== Query ====
#[derive(Enum, Copy, Clone, Eq, PartialEq)]
pub enum TransactionDirection {
    In,
    Out,
}

#[derive(SimpleObject)]
pub struct TransactionData {
    pub id: String,
    pub from: Option<UserSimpleData>,
    pub to: Option<UserSimpleData>,
    pub amount: i32,
    pub tx_at: String,
}

#[derive(SimpleObject)]
pub struct TransactionsData {
    pub transaction_list: Vec<TransactionData>,
}

#[derive(SimpleObject)]
pub struct TransactionByUserData {
    pub id: String,
    pub amount: i32,
    pub direction: TransactionDirection,
    pub counter_party: UserSimpleData,
    pub tx_at: String,
}

#[derive(SimpleObject)]
pub struct TransactionsByUserData {
    pub transaction_list: Vec<TransactionByUserData>,
}

// ==== Mutation ====
#[derive(InputObject)]
pub struct CreateNewTransactionInput {
    pub from: Option<String>,
    pub to: String,
    pub amount: i32,
    pub note: Option<String>, // abstract
}

#[derive(SimpleObject)]
pub struct CreateNewTransactionResponse {
    pub new_balance: i32,
}
