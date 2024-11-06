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
        input: models::artists::CreateNewArtistInput,
    ) -> Result<models::artists::CreateNewArtistResponse> {
        let usecases = ctx.data_unchecked::<Usecases>();
        todo!();
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
