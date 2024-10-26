use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct PointsTxQuery;

#[Object]
impl PointsTxQuery {
    async fn get_fsp_history(
        &self,
        ctx: &Context<'_>,
        user_id: String,
        count: i32,
    ) -> Result<models::transactions::TransactionsData> {
        todo!()
    }

    async fn get_fsp_history_by_user(
        &self,
        ctx: &Context<'_>,
        user_id: String,
        count: i32,
    ) -> Result<models::transactions::TransactionsByUserData> {
        todo!()
    }
}
