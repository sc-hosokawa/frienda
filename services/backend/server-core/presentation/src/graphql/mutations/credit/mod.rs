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

    async fn update_credit(
        &self,
        ctx: &Context<'_>,
        input: models::credit::UpdateCreditInput,
    ) -> Result<models::credit::UpdateCreditResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        usecases
            .manage_credit
            .update_credit(
                application::usecases::credit::manage_credit_usecase::UpdateCreditUsecaseInput {
                    credit_id: input.credit_id,
                    commit_user: input.commit_user,
                    credit_role: input.credit_role,
                    credit_name: input.credit_name,
                    email: input.email,
                    is_invite: input.is_invite,
                    memo: input.memo,
                },
            )
            .await?;
        Ok(models::credit::UpdateCreditResponse { is_success: true })
    }

    async fn delete_credit(
        &self,
        ctx: &Context<'_>,
        input: models::credit::DeleteCreditInput,
    ) -> Result<models::credit::DeleteCreditResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        usecases
            .manage_credit
            .delete_credit(
                application::usecases::credit::manage_credit_usecase::DeleteCreditUsecaseInput {
                    credit_id: input.credit_id,
                },
            )
            .await?;
        Ok(models::credit::DeleteCreditResponse { is_success: true })
    }
}
