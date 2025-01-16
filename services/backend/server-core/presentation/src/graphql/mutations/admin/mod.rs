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
                                image_url: release.image_url,
                            }
                        })
                        .collect(),
                },
            )
            .await;

        match res {
            Ok(_) => Ok(models::admin::RegisterReleasesResponse { success: true }),
            Err(e) => {
                // エラーログを出力
                tracing::error!("Register releases error: {:?}", e);
                Ok(models::admin::RegisterReleasesResponse { success: false })
            }
        }
    }

    async fn delete_user_report(&self, ctx: &Context<'_>, id: i32) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res = usecases.report.delete_user_report(id).await?;
        Ok(true)
    }

    async fn delete_offer_report(&self, ctx: &Context<'_>, id: i32) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res = usecases.report.delete_offer_report(id).await?;
        Ok(true)
    }

    async fn delete_release_report(&self, ctx: &Context<'_>, id: i32) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res = usecases.report.delete_release_report(id).await?;
        Ok(true)
    }
}
