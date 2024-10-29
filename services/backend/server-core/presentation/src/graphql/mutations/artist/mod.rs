use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct ArtistMutation;

#[Object]
impl ArtistMutation {
    async fn create_new_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::CreateNewArtistInput,
    ) -> Result<models::artists::CreateNewArtistResponse> {
        let usecase = ctx.data_unchecked::<Usecases>();
        todo!()
    }
}
