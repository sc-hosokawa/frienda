use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct CommunityQuery;

#[Object]
impl CommunityQuery {
    async fn get_communities(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::communities::ConnectedUsersData> {
        todo!()
    }

    async fn get_user_info(&self, ctx: &Context<'_>) -> Result<models::users::UserFullData> {
        todo!()
    }
}
