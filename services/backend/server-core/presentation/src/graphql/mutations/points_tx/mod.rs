use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct PointsTxMutation;

#[Object]
impl PointsTxMutation {
    async fn create_fsp_tx(
        &self,
        ctx: &Context<'_>,
        input: models::transactions::CreateNewTransactionInput,
    ) -> Result<models::transactions::CreateNewTransactionResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .transfer_point_between_accounts
            .transfer(application::usecases::point::transfer_point_between_accounts_usecase::TransferPointBetweenAccountsInput {
                from: input.from,
                to: input.to,
                amount: input.amount,
                notes: input.note,
            })
            .await?;
        Ok(models::transactions::CreateNewTransactionResponse { new_balance: 2 })
    }

    async fn create_bulk_fsp_tx(
        &self,
        ctx: &Context<'_>,
        input: Vec<models::transactions::CreateNewTransactionInput>,
    ) -> Result<Vec<models::transactions::CreateNewTransactionResponse>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .transfer_point_between_accounts
            .bulk_transfer(input.iter().map(|i|
                application::usecases::point::transfer_point_between_accounts_usecase::TransferPointBetweenAccountsInput {
                    from: i.from.clone(),
                    to: i.to.clone(),
                    amount: i.amount,
                    notes: i.note.clone(),
                }
            ).collect())
            .await?;
        Ok(vec![models::transactions::CreateNewTransactionResponse {
            new_balance: 2,
        }])
    }
}
