use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

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
                    artist_id,
                },
            )
            .await?;

        Ok(models::artists::ArtistFullData::from_domain(result).unwrap())
    }

    async fn get_artists_by_ids(
        &self,
        ctx: &Context<'_>,
        artist_ids: Vec<String>,
    ) -> Result<models::artists::ArtistsData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_artist
            .get_artists_by_ids(artist_ids.iter().map(|s| s.as_str()).collect())
            .await?;

        Ok(models::artists::ArtistsData {
            artist_list: result
                .artists
                .iter()
                .map(|artist| models::artists::ArtistData::from_domain(artist.clone()))
                .collect::<Result<Vec<_>, _>>()?,
        })
    }

    async fn get_artists_by_name(
        &self,
        ctx: &Context<'_>,
        name: String,
    ) -> Result<models::artists::ArtistsData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;

        let result = usecases
            .get_artist
            .get_artists_by_name(name.as_str())
            .await?;

        Ok(models::artists::ArtistsData {
            artist_list: result
                .artists
                .iter()
                .map(|artist| models::artists::ArtistData::from_domain(artist.clone()))
                .collect::<Result<Vec<_>, _>>()?,
        })
    }

    async fn get_members_joined_to_artist(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: Option<String>,
    ) -> Result<Vec<models::users::UserSimpleData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_members
            .get_members_joined_to_artist(
                application::usecases::artist::get_members_usecase::GetMembersUsecaseInput {
                    artist_id,
                    user_id,
                },
            )
            .await?;

        Ok(result
            .members
            .into_iter()
            .map(|user| models::users::UserSimpleData {
                id: user.id,
                name: user.username,
                realname: user.realname,
                image_url: user.img_url,
            })
            .collect::<Vec<models::users::UserSimpleData>>())
    }

    async fn get_members_belonged_to_artist(
        &self,
        ctx: &Context<'_>,
        artist_id: String,
        user_id: Option<String>,
    ) -> Result<Vec<models::users::UserSimpleData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_members
            .get_members_belonged_to_artist(
                application::usecases::artist::get_members_usecase::GetMembersUsecaseInput {
                    artist_id,
                    user_id,
                },
            )
            .await?;

        Ok(result
            .members
            .into_iter()
            .map(|user| models::users::UserSimpleData {
                id: user.id,
                name: user.username,
                realname: user.realname,
                image_url: user.img_url,
            })
            .collect())
    }

    async fn get_all_pending_members(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<Vec<models::artists::AllPendingMember>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_members
            .get_all_pending_members(user_id)
            .await?;

        Ok(result
            .members
            .into_iter()
            .map(|member| models::artists::AllPendingMember {
                member: models::artists::PendingMember {
                    id: member.member.id,
                    name: member.member.username,
                    realname: member.member.realname,
                    email: member.member.email,
                    image_url: member.member.img_url,
                },
                artist_name: member.artist_name,
                artist_id: member.artist_id,
                request_message: member.request_message,
            })
            .collect())
    }
}
