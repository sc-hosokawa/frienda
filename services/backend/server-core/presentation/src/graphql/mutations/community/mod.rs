use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;
use uuid::Uuid;

#[derive(Default)]
pub struct CommunityMutation;

#[Object]
impl CommunityMutation {
    async fn add_shortnote(
        &self,
        ctx: &Context<'_>,
        favorite_id: String,
        comment: String,
    ) -> Result<models::communities::AddShortnoteResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .add_shortnote
            .add_shortnote(
                application::usecases::community::add_shortnote_usecase::AddShortnoteInput {
                    favorite_id: Uuid::parse_str(&favorite_id).unwrap(),
                    comment: comment.clone(),
                },
            )
            .await?;
        Ok(models::communities::AddShortnoteResponse { id: res })
    }

    async fn mark_favorite(
        &self,
        ctx: &Context<'_>,
        target_user_id: String,
        liked_by: String,
    ) -> Result<models::communities::MarkFavoriteResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .mark_favorite
            .mark_favorite(
                application::usecases::community::mark_favorite_usecase::MarkFavoriteInput {
                    user_id: target_user_id.clone(),
                    liked_by: liked_by.clone(),
                },
            )
            .await?;
        Ok(models::communities::MarkFavoriteResponse { id: res })
    }
}
