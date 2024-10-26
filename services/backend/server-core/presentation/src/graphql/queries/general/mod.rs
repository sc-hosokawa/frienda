use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct GeneralQuery;

#[Object]
impl GeneralQuery {
    async fn get_user_data(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::users::UserDetailData> {
        todo!()
    }

    async fn get_belonged_artists(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::artists::ArtistByUserDataList> {
        todo!()
    }
}
