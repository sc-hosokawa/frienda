use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use std::sync::Arc;

use registry::Usecases;

#[derive(Default)]
pub struct CreditQuery;

#[Object]
impl CreditQuery {
    async fn get_credits(
        &self,
        ctx: &Context<'_>,
        user_id: String,
        artist_id: String,
        isrc: String,
    ) -> Result<Vec<models::credit::TrackCredit>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_credits
            .get_credits(
                application::usecases::credit::get_credits_usecase::GetCreditsUsecaseInput {
                    user_id,
                    artist_id,
                    isrc,
                },
            )
            .await?;
        Ok(result.credits.into_iter().map(|c| c.into()).collect())
    }

    async fn get_all_credits(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::credit::GetAllCreditsOutput> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_credits.get_all_credits(user_id).await?;
        Ok(models::credit::GetAllCreditsOutput {
            credits: result.credits.into_iter().map(|c| c.into()).collect(),
        })
    }
}
