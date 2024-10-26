use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct PrizeQuery;

#[Object]
impl PrizeQuery {
    async fn get_popular_prizes(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::prizes::PrizeData>> {
        todo!()
    }

    async fn get_all_prizes(&self, ctx: &Context<'_>) -> Result<Vec<models::prizes::PrizeData>> {
        todo!()
    }

    async fn get_prize_detail(
        &self,
        ctx: &Context<'_>,
        prize_id: i32,
    ) -> Result<models::prizes::PrizeDetailData> {
        todo!()
    }
}
