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
    pub note: Option<String>,
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
    pub tx_id: String,
}

// ===== Convert =====
impl From<application::usecases::point::get_point_transaction_history_usecase::TransactionData>
    for TransactionByUserData
{
    fn from(
        tx: application::usecases::point::get_point_transaction_history_usecase::TransactionData,
    ) -> Self {
        TransactionByUserData {
            id: tx.id.to_string(),
            direction: tx.direction.into(),
            counter_party: tx.counter_party.into(),
            amount: tx.amount,
            tx_at: tx.tx_at.to_string(),
            note: tx.note,
        }
    }
}
impl From<application::usecases::point::get_point_transaction_history_usecase::UserSimpleData>
    for UserSimpleData
{
    fn from(
        user: application::usecases::point::get_point_transaction_history_usecase::UserSimpleData,
    ) -> Self {
        UserSimpleData {
            id: user.id,
            name: user.name,
            image_url: user.img_url,
            realname: "".to_string(),
        }
    }
}
impl From<String> for TransactionDirection {
    fn from(direction: String) -> Self {
        match direction.as_str() {
            "In" => TransactionDirection::In,
            "Out" => TransactionDirection::Out,
            _ => unreachable!(),
        }
    }
}
