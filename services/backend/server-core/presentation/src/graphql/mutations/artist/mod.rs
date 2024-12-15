use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

use domain::entities::sea_orm_active_enums::UserArtistStatus;

#[derive(Default)]
pub struct ArtistMutation;

#[Object]
impl ArtistMutation {
    async fn create_new_artist(
        &self,
        ctx: &Context<'_>,
        input: Vec<models::artists::CreateNewArtistInput>,
    ) -> Result<models::artists::CreateNewArtistsResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_artists
            .add_artists(
                application::usecases::artist::manage_artists_usecase::AddArtistsInput {
                    artists: input
                        .into_iter()
                        .map(|input| {
                            application::usecases::artist::manage_artists_usecase::AddArtistInput {
                                display_name_jp: input.display_name_jp,
                                display_name_en: input.display_name_en,
                                display_name_kana: input.display_name_kana,
                                img_url: input.img_url,
                                fsp: input.fsp.unwrap_or(0),
                                status: input.status.unwrap_or("visible".to_string()),
                                universal_id: input.universal_id,
                                apple_key: input.apple_key,
                                spotify_key: input.spotify_key,
                                line_key: input.line_key,
                                amazon_key: input.amazon_key,
                                youtube_key: input.youtube_key,
                            }
                        })
                        .collect(),
                },
            )
            .await?;
        Ok(models::artists::CreateNewArtistsResponse {
            added_artists: res
                .added_artists
                .into_iter()
                .map(|artist| models::artists::CreateNewArtistData {
                    artist_id: artist.artist_id,
                    display_name_jp: artist.display_name_jp,
                })
                .collect(),
        })
    }

    async fn update_artist(
        &self,
        ctx: &Context<'_>,
        input: models::artists::UpdateArtistInput,
    ) -> Result<models::artists::UpdateArtistResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_artists
            .update_artists(
                application::usecases::artist::manage_artists_usecase::UpdateArtistsInput {
                    artist_id: input.artist_id,
                    display_name_jp: input.display_name_jp,
                    display_name_en: input.display_name_en,
                    display_name_kana: input.display_name_kana,
                    img_url: input.img_url,
                    fsp: input.fsp,
                    status: input.status,
                    universal_id: input.universal_id,
                    apple_key: input.apple_key,
                    spotify_key: input.spotify_key,
                    line_key: input.line_key,
                    amazon_key: input.amazon_key,
                    youtube_key: input.youtube_key,
                },
            )
            .await?;
        Ok(models::artists::UpdateArtistResponse { artist_id: res })
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

    async fn mark_as_member(
        &self,
        ctx: &Context<'_>,
        input: models::artists::MarkAsMemberInput,
    ) -> Result<models::artists::MarkAsMemberResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .mark_as_member
            .mark_as_member(
                application::usecases::artist::mark_as_member_usecase::MarkAsMemberUsecaseInput {
                    artist_id: input.artist_id,
                    member: input.member,
                    mapping: input
                        .mapping
                        .into_iter()
                        .map(|status_user| {
                            Ok(
                                application::usecases::artist::mark_as_member_usecase::UserStatus {
                                    user_id: status_user.user_id,
                                    status: match status_user.status.as_str() {
                                        "Check" => UserArtistStatus::Check,
                                        "Accept" => UserArtistStatus::Accept,
                                        "Reject" => UserArtistStatus::Reject,
                                        _ => {
                                            return Err(async_graphql::Error::new("Invalid status"))
                                        }
                                    },
                                },
                            )
                        })
                        .collect::<Result<Vec<_>, _>>()?,
                },
            )
            .await?;
        Ok(models::artists::MarkAsMemberResponse {
            checked_user_id: res
                .iter()
                .map(|user_artist| user_artist.user_id.to_string())
                .collect(),
        })
    }

    async fn mark_as_admin(
        &self,
        ctx: &Context<'_>,
        input: models::artists::MarkAsAdminInput,
    ) -> Result<models::artists::MarkAsAdminResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .mark_as_member
            .mark_as_admin(
                application::usecases::artist::mark_as_member_usecase::MarkAsAdminUsecaseInput {
                    admin_member: input.admin_member,
                    artist_id: input.artist_id,
                    user_id: input.user_id,
                },
            )
            .await?;
        Ok(models::artists::MarkAsAdminResponse {
            checked_user_id: res.user_id.to_string(),
        })
    }
}
