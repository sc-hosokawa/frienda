use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use chrono::NaiveDate;
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

    async fn update_track(
        &self,
        ctx: &Context<'_>,
        input: models::admin::UpdateTrackInput,
    ) -> Result<String> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .manage_tracks
            .update_track(
                application::usecases::admin::manage_tracks_usecase::UpdateTrackInput {
                    isrc: input.isrc,
                    title: input.title,
                },
            )
            .await?;
        Ok(result.isrc)
    }

    async fn update_product(
        &self,
        ctx: &Context<'_>,
        input: models::admin::UpdateProductInput,
    ) -> Result<String> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .manage_tracks
            .update_product(
                application::usecases::admin::manage_tracks_usecase::UpdateProductInput {
                    upc: input.upc,
                    title: input.title,
                    img_url: input.img_url,
                    r#type: input.r#type,
                    distributed_at: input
                        .distributed_at
                        .map(|d| NaiveDate::parse_from_str(&d, "%Y-%m-%d").unwrap()),
                    artist_id: input.artist_id,
                },
            )
            .await?;
        Ok(result.upc)
    }

    async fn delete_track(&self, ctx: &Context<'_>, isrc: String) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res: bool = usecases.manage_tracks.delete_track(isrc).await?;
        Ok(true)
    }

    async fn delete_product(&self, ctx: &Context<'_>, upc: String) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res: bool = usecases.manage_tracks.delete_product(upc).await?;
        Ok(true)
    }
}
