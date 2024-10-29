use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;
use uuid::Uuid;

#[derive(Default)]
pub struct ArtistQuery;

#[Object]
impl ArtistQuery {
    async fn get_all_artists(&self, ctx: &Context<'_>) -> Result<models::artists::ArtistsData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_artist.get_all_artists().await?;

        Ok(models::artists::ArtistsData {
            artist_list: result
                .artists
                .iter()
                .map(|artist| models::artists::ArtistData::from_domain(artist.clone()))
                .collect::<Result<Vec<_>, _>>()?,
        })
    }

    async fn get_artist_by_id(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
    ) -> Result<models::artists::ArtistFullData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_artist
            .get_artist_by_id(
                application::usecases::artist::get_artist_usecase::GetArtistUsecaseInput {
                    artist_id: Uuid::parse_str(&artist_id).unwrap(),
                },
            )
            .await?;

        Ok(models::artists::ArtistFullData::from_domain(result).unwrap())
    }
}
