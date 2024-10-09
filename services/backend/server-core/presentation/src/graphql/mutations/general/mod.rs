use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct GeneralMutation;

#[Object]
impl GeneralMutation {
    async fn create_new_user_data(
        &self,
        ctx: &Context<'_>,
        input: models::users::CreateNewUserDataInput,
    ) -> Result<models::users::CreateNewUserDataResponse> {
        todo!()
    }
}
