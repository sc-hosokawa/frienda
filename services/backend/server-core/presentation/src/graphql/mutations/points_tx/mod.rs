use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct PointsTxMutation;

#[Object]
impl PointsTxMutation {
    async fn create_fsp_tx(
        &self,
        ctx: &Context<'_>,
        input: models::transactions::CreateNewTransactionInput,
    ) -> Result<models::transactions::CreateNewTransactionResponse> {
        todo!()
    }
}
