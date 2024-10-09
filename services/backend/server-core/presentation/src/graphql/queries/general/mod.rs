use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct GeneralQuery;

// ===== for Query =====

#[Object]
impl GeneralQuery {
    async fn get_user_data(&self, ctx: &Context<'_>) -> Result<models::users::UserData> {
        todo!()
    }
}
