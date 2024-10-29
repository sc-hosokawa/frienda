use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct PrizeQuery;

#[Object]
impl PrizeQuery {
    async fn get_popular_prizes(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::prizes::PrizeData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_prize_list
            .get_prize_list(
                application::usecases::prize::get_prize_list_usecase::GetPrizeListInput {
                    limit: 10,
                    offset: 0,
                },
            )
            .await?;

        let popular = result.prizes.into_iter().map(|p| p.into()).collect();

        Ok(popular)
    }

    async fn get_all_prizes(&self, ctx: &Context<'_>) -> Result<Vec<models::prizes::PrizeData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_prize_list
            .get_prize_list(
                application::usecases::prize::get_prize_list_usecase::GetPrizeListInput {
                    limit: 100,
                    offset: 0,
                },
            )
            .await?;

        let all = result.prizes.into_iter().map(|p| p.into()).collect();

        Ok(all)
    }

    async fn get_prize_detail(
        &self,
        ctx: &Context<'_>,
        prize_id: i32,
    ) -> Result<models::prizes::PrizeDetailData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let detail = usecases
            .get_prize
            .get_prize(
                application::usecases::prize::get_prize_usecase::GetPrizeInput { id: prize_id },
            )
            .await?;

        Ok(detail.prize.into())
    }
}
