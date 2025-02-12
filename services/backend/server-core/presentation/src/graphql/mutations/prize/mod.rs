use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct PrizeMutation;

#[Object]
impl PrizeMutation {
    async fn create_prize(
        &self,
        ctx: &Context<'_>,
        input: models::prizes::CreateNewPrizeInput,
    ) -> Result<models::prizes::CreateNewPrizeResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .create_prize
            .create(
                application::usecases::prize::create_prize_usecase::CreatePrizeInput {
                    name: input.name,
                    description: input.description,
                    point: input.point,
                    representation: input.representation,
                    condition: input.condition,
                    img_url: input.img_url,
                },
            )
            .await?;
        Ok(models::prizes::CreateNewPrizeResponse { id: result })
    }

    async fn exchange_prize(
        &self,
        ctx: &Context<'_>,
        input: models::prizes::ExchangePrizeInput,
    ) -> Result<models::prizes::ExchangePrizeResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .exchange_prize
            .exchange(
                application::usecases::prize::exchange_prize_usecase::ExchangePrizeInput {
                    user_id: input.user_id,
                    prize_id: input.prize_id,
                    amount: input.amount,
                },
            )
            .await?;
        Ok(models::prizes::ExchangePrizeResponse {
            id: result.0,
            tx_id: result.1.to_string(),
        })
    }

    async fn request_prize(
        &self,
        ctx: &Context<'_>,
        input: models::prizes::RequestPrizeInput,
    ) -> Result<models::prizes::RequestPrizeResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result: i32 = usecases
            .exchange_prize
            .request_prize(
                application::usecases::prize::exchange_prize_usecase::RequestPrizeInput {
                    user_id: input.user_id,
                    prize_id: input.prize_id,
                },
            )
            .await?;
        Ok(models::prizes::RequestPrizeResponse { id: result })
    }

    async fn use_prize(
        &self,
        ctx: &Context<'_>,
        input: models::prizes::UsePrizeInput,
    ) -> Result<models::prizes::UsePrizeResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result: i32 = usecases
            .exchange_prize
            .use_prize(
                application::usecases::prize::exchange_prize_usecase::UsePrizeInput {
                    user_id: input.user_id,
                    prize_id: input.prize_id,
                    code: input.code,
                    representation_user_id: input.representation_user_id,
                },
            )
            .await?;
        Ok(models::prizes::UsePrizeResponse { id: result })
    }
}
