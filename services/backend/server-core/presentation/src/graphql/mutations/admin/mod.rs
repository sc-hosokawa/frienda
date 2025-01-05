use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct AdminMutation;

#[Object]
impl AdminMutation {
    async fn register_releases(
        &self,
        ctx: &Context<'_>,
        input: models::admin::RegisterReleases,
    ) -> Result<models::admin::RegisterReleasesResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_tracks
            .register_releases(
                application::usecases::admin::manage_tracks_usecase::RegisterReleasesInput {
                    releases: input
                        .releases
                        .into_iter()
                        .map(|release| {
                            application::usecases::admin::manage_tracks_usecase::Release {
                                upc: release.upc,
                                format: release.format,
                                track_count: release.track_count,
                                title: release.title,
                                release_date: release.release_date,
                                isrc: release.isrc,
                                track_no: release.track_no,
                                track_title: release.track_title,
                                track_title_version: release.track_title_version,
                                artist_id: release.artist_id,
                            }
                        })
                        .collect(),
                },
            )
            .await?;
        Ok(models::admin::RegisterReleasesResponse { success: true })
    }
}
