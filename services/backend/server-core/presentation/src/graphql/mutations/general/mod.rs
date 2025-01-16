use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use chrono::NaiveDate;
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
                    fcm_token: input.fcm_token.clone(),
                    email: input.email.clone(),
                    name: input.name.clone(),
                    realname: input.realname.clone(),
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
                    greeting: input.greeting,
                    skill: input.skill,
                    x_handle: input.x_handle,
                    instagram_handle: input.instagram_handle,
                    fb_handle: input.fb_handle,
                    primary_category: input.primary_category.as_deref().map(|category| {
                        models::users::from_string_to_user_category(category).unwrap()
                    }),
                    evm_addr: input.evm_addr,
                    fcm_token: input.fcm_token,
                    interest_offer: input.interest_offer.as_deref().map(|category| {
                        models::users::from_string_to_offer_category(category).unwrap()
                    }),
                },
            )
            .await?;

        Ok(models::users::UpdateUserDataResponse {
            user_info: models::users::UserDetailData {
                id: res.updated_user.id,
                name: res.updated_user.username,
                realname: res.updated_user.realname,
                email: res.updated_user.email,
                is_super_admin: res.updated_user.is_superadmin.unwrap_or(false),
                image_url: res.updated_user.img_url,
                fsp_balance: res.updated_user.fsp,
                credential_balance: res.updated_user.credential,
                evm_addr: res.updated_user.evm_addr,
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

    async fn register_portfolio(
        &self,
        ctx: &Context<'_>,
        input: models::portfolios::RegisterPortfolioInput,
    ) -> Result<models::portfolios::RegisterPortfolioResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_portfolios
            .register_portfolio(
                application::usecases::basic::manage_portfolios_usecase::RegisterPortfolioInput {
                    user_id: input.user_id,
                    title: input.title,
                    description: input.description,
                    img_url: Some(input.img_url),
                    category: input.category,
                    release_date: Some(input.release_date.parse::<NaiveDate>().unwrap()),
                    external_url: Some(input.external_url),
                },
            )
            .await?;
        Ok(models::portfolios::RegisterPortfolioResponse {
            portfolio_id: res.id,
        })
    }

    async fn update_portfolio(
        &self,
        ctx: &Context<'_>,
        input: models::portfolios::UpdatePortfolioInput,
    ) -> Result<models::portfolios::UpdatePortfolioResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let res = usecases
            .manage_portfolios
            .update_portfolio(
                application::usecases::basic::manage_portfolios_usecase::UpdatePortfolioInput {
                    id: input.id,
                    title: input.title,
                    description: input.description,
                    img_url: input.img_url,
                    category: input.category,
                    release_date: input
                        .release_date
                        .as_deref()
                        .map(|date| date.parse::<NaiveDate>().unwrap()),
                    external_url: input.external_url,
                },
            )
            .await?;
        Ok(models::portfolios::UpdatePortfolioResponse {
            portfolio_id: res.id,
        })
    }

    async fn delete_portfolio(
        &self,
        ctx: &Context<'_>,
        input: models::portfolios::DeletePortfolioInput,
    ) -> Result<models::portfolios::DeletePortfolioResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        usecases
            .manage_portfolios
            .delete_portfolio(input.id)
            .await?;
        Ok(models::portfolios::DeletePortfolioResponse {
            portfolio_id: input.id,
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

    async fn join_with_invitation_code(
        &self,
        ctx: &Context<'_>,
        code: String,
        joined_user_id: String,
        joined_email: String,
    ) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res = usecases
            .invitation
            .join_with_code(code, joined_user_id, joined_email)
            .await?;
        Ok(true)
    }

    async fn invite(&self, ctx: &Context<'_>, pass: String) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res = usecases.invitation.invite(pass).await?;
        Ok(true)
    }

    async fn report_user(
        &self,
        ctx: &Context<'_>,
        input: models::users::ReportUserInput,
    ) -> Result<models::users::ReportUserResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .report
            .report_user(
                application::usecases::basic::report_usecase::UserReportInput {
                    reported_user_id: input.reported_user_id,
                    reporter_user_id: input.reporter_user_id,
                    report_content: input.report_content,
                },
            )
            .await?;
        Ok(models::users::ReportUserResponse { id: result.id })
    }

    async fn contact_to_admin(
        &self,
        ctx: &Context<'_>,
        input: models::contact_us::ContactToAdminInput,
    ) -> Result<bool> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let _res = usecases
            .contact_to_admin
            .contact_to_admin(
                application::usecases::admin::contact_usecase::ContactToAdminInput {
                    name: input.username,
                    category: input.category,
                    email: input.email,
                    message: input.content,
                },
            )
            .await?;
        Ok(true)
    }
}
