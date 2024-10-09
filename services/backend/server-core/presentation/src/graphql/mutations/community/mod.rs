use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct CommunityMutation;

#[Object]
impl CommunityMutation {
    async fn add_new_connection(
        &self,
        ctx: &Context<'_>,
        input: models::communities::AddNewConnectionInput,
    ) -> Result<models::communities::AddNewConnectionResponse> {
        todo!()
    }
}
