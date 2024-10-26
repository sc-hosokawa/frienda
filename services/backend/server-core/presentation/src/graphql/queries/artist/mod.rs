use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct ArtistQuery;

#[Object]
impl ArtistQuery {
    async fn get_all_artists(&self, ctx: &Context<'_>) -> Result<models::artists::ArtistsData> {
        todo!()
    }

    async fn get_artist_by_id(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
    ) -> Result<models::artists::ArtistFullData> {
        todo!()
    }
}
