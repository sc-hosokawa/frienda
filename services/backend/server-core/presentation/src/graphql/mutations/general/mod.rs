use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct GeneralMutation;

#[Object]
impl GeneralMutation {
    async fn create_new_user_data(
        &self,
        ctx: &Context<'_>,
        input: models::users::CreateNewUserDataInput,
    ) -> Result<models::users::CreateNewUserDataResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .create_user
            .create(
                application::usecases::basic::create_user_usecase::CreateUserInput {
                    id: input.id.clone(),
                    email: input.email.clone(),
                    name: input.name.clone(),
                    image_url: input.image_url.clone(),
                    invited_by: input.invited_by,
                    category: models::users::from_string_to_user_category(&input.category).unwrap(),
                    primary_category: models::users::from_string_to_user_category(
                        &input.primary_category,
                    )
                    .unwrap(),
                },
            )
            .await?;

        Ok(models::users::CreateNewUserDataResponse {
            user_id: res.id,
            name: res.username,
            image_url: res.img_url,
        })
    }

    async fn update_user_data(
        &self,
        ctx: &Context<'_>,
        input: models::users::UpdateUserDataInput,
    ) -> Result<models::users::UpdateUserDataResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .update_user_profile
            .update(
                application::usecases::basic::update_user_profile_usecase::UpdateUserProfileInput {
                    id: input.id,
                    name: input.name,
                    image_url: input.image_url,
                    email: input.email,
                    // TODO: 処理内容を吟味する
                    primary_category: input.primary_category.as_deref().map(|category| {
                        models::users::from_string_to_user_category(category).unwrap()
                    }),
                    evm_addr: input.evm_addr,
                },
            )
            .await?;

        Ok(models::users::UpdateUserDataResponse {
            user_info: models::users::UserDetailData {
                id: res.updated_user.id,
                name: res.updated_user.username,
                image_url: res.updated_user.img_url,
                fsp_balance: res.updated_user.fsp,
                credential_balance: res.updated_user.credential,
                role: models::users::from_user_category_to_string(&res.updated_user.category),
                created_at: res.updated_user.created_at.to_string(),
                greeting: res.updated_user.greeting,
                skill: res.updated_user.skill,
                x_handle: res.updated_user.x_handle,
                instagram_handle: res.updated_user.instagram_handle,
                fb_handle: res.updated_user.fb_handle,
                interest_offer: res
                    .updated_user
                    .interest_offer
                    .map(|offer| models::users::from_offer_category_to_string(&offer)),
                primary_role: models::users::from_user_category_to_string(
                    &res.updated_user.primary_category,
                ),
                belongs_to_artists: res
                    .artists
                    .belongs_to_artists
                    .into_iter()
                    .map(|artist| models::artists::ArtistByUserData::from_domain(artist).unwrap())
                    .collect(),
                primary_artist: res
                    .artists
                    .primary_artist
                    .map(|artist| models::artists::ArtistByUserData::from_domain(artist).unwrap()),
            },
        })
    }

    async fn update_belongs_to_artist_status(
        &self,
        ctx: &Context<'_>,
        input: models::users::UpdateBelongsToArtistStatusInput,
    ) -> Result<models::users::UpdateBelongsToArtistStatusResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .update_user_profile
            .update_belongs_to_artist_status(
                application::usecases::basic::update_user_profile_usecase::UpdateBelongsToArtistStatusInput {
                    user_id: input.user_id,
                    artist_id: input.artist_id,
                    next_status_is_admin: input.next_status_is_admin,
                    next_status: input.next_status.as_deref().map(|status| {
                        models::users::from_string_to_user_artist_status(status).unwrap()
                    }),
                },
            )
            .await?;
        Ok(models::users::UpdateBelongsToArtistStatusResponse {
            updated_user_artist: models::artists::ArtistByUserData::from_domain(
                res.updated_user_artist,
            )
            .unwrap(),
        })
    }

    async fn contact_to_admin(
        &self,
        ctx: &Context<'_>,
        input: models::contact_us::ContactToAdminInput,
    ) -> Result<models::contact_us::ContactToAdminResponse> {
        todo!()
    }

    async fn update_user_detail_profile(
        &self,
        ctx: &Context<'_>,
        input: models::users::UpdateUserDetailProfileInput,
    ) -> Result<models::users::UpdateUserDetailProfileResponse> {
        todo!()
    }
}
