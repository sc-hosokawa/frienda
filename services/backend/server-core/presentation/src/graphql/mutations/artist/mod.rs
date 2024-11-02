use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

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

    async fn request_to_access_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::RequestToAccessArtistInput,
    ) -> Result<models::artists::RequestToAccessArtistResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .request_to_access
            .request_to_access(application::usecases::artist::request_to_access_usecase::RequestToAccessUsecaseInput {
                user_id: input.user_id,
                artist_ids: input.artist_ids,
            })
            .await?;
        Ok(models::artists::RequestToAccessArtistResponse {
            created_mappings: res
                .created_mappings
                .into_iter()
                .map(|mapping| {
                    models::artists::ArtistByUserDataWithMappingId::from_domain_on_request_to_access(mapping)
                        .unwrap()
                })
                .collect(),
        })
    }
}
