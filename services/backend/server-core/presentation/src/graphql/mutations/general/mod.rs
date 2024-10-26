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

    async fn update_user_data(
        &self,
        ctx: &Context<'_>,
        input: models::users::UpdateUserDataInput,
    ) -> Result<models::users::UpdateUserDataResponse> {
        todo!()
    }

    async fn update_belongs_to_artist_status(
        &self,
        ctx: &Context<'_>,
        input: models::users::UpdateBelongsToArtistStatusInput,
    ) -> Result<models::users::UpdateBelongsToArtistStatusResponse> {
        todo!()
    }

    async fn contact_to_admin(
        &self,
        ctx: &Context<'_>,
        input: models::contact_us::ContactToAdminInput,
    ) -> Result<models::contact_us::ContactToAdminResponse> {
        todo!()
    }
}
