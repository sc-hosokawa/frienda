use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct CommunityQuery;

#[Object]
impl CommunityQuery {
    async fn get_own_community(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::communities::ConnectedUsersData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_user_connections
            .get_own_community(user_id)
            .await?;
        Ok(models::communities::ConnectedUsersData {
            community: result.community.into_iter().map(|c| c.into()).collect(),
        })
    }

    async fn get_other_user_community(
        &self,
        ctx: &Context<'_>,
        viewer_id: String,
        target_user_id: String,
    ) -> Result<models::communities::ConnectedUsersData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_user_connections
            .get_other_user_community(viewer_id, target_user_id)
            .await?;

        Ok(models::communities::ConnectedUsersData {
            community: result.community.into_iter().map(|c| c.into()).collect(),
        })
    }
}
