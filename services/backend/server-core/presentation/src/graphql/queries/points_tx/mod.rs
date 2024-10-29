use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

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
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_point_transaction_history
            .get_point_transaction_history(
                application::usecases::point::get_point_transaction_history_usecase::GetPointTransactionHistoryInput {
                    user_id,
                    count,
            })
            .await?;

        Ok(models::transactions::TransactionsByUserData {
            transaction_list: result
                .transactions
                .into_iter()
                .map(|tx| tx.into())
                .collect(),
        })
    }
}
