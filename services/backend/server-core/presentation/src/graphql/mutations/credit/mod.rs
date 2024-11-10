use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct CreditMutation;

#[Object]
impl CreditMutation {
    async fn register_credit(
        &self,
        ctx: &Context<'_>,
        input: models::credit::RegisterCreditInput,
    ) -> Result<models::credit::RegisterCreditResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        usecases
            .register_credit
            .register(
                application::usecases::credit::register_usecase::RegisterUsecaseInput {
                    register_info: input
                        .register_info
                        .iter()
                        .map(
                            |info| application::usecases::credit::register_usecase::RegisterInfo {
                                isrc: info.isrc.clone(),
                                commit_user: info.commit_user.clone(),
                                credit_role: info.credit_role.clone(),
                                credit_name: info.credit_name.clone(),
                                email: info.email.clone(),
                                is_invite: info.is_invite,
                                memo: info.memo.clone(),
                            },
                        )
                        .collect(),
                },
            )
            .await?;
        Ok(models::credit::RegisterCreditResponse { is_success: true })
    }
}
