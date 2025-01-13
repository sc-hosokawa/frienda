use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct GeneralQuery;

#[Object]
impl GeneralQuery {
    async fn get_all_users(&self, ctx: &Context<'_>) -> Result<models::users::AllUsersData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_all_users.get_all_users().await?;
        Ok(models::users::AllUsersData {
            users: result
                .users
                .into_iter()
                .map(|user| models::users::UserSimpleData {
                    id: user.id,
                    name: user.name,
                    realname: "".to_string(),
                    image_url: user.image_url,
                })
                .collect::<Vec<_>>(),
        })
    }

    async fn get_all_users_except_me(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::users::AllUsersData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_all_users
            .get_all_users_except_me(user_id)
            .await?;
        Ok(models::users::AllUsersData {
            users: result
                .users
                .into_iter()
                .map(|user| models::users::UserSimpleData {
                    id: user.id,
                    name: user.name,
                    realname: "".to_string(),
                    image_url: user.image_url,
                })
                .collect::<Vec<_>>(),
        })
    }

    #[tracing::instrument(skip(self, ctx))]
    async fn get_user_data(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::users::UserDetailData> {
        tracing::info!("get_user_data called with user_id: {}", user_id);
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_user_basic_info
            .get_user_basic_info(
                application::usecases::basic::get_user_basic_info_usecase::GetUserBasicInfoInput {
                    user_id,
                },
            )
            .await?;
        Ok(models::users::UserDetailData::from_domain(result).unwrap())
    }

    async fn get_belonged_artists(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::artists::ArtistByUserDataList> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_user_basic_info
            .get_belongs_to_artists(user_id)
            .await?;
        Ok(models::artists::ArtistByUserDataList {
            artist_list: result
                .into_iter()
                .map(|artist| models::artists::ArtistByUserData::from_domain(artist))
                .collect::<Result<Vec<_>, _>>()?,
        })
    }

    async fn get_user_detail_profile(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::users::UserDetailData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_user_basic_info
            .get_user_basic_info(
                application::usecases::basic::get_user_basic_info_usecase::GetUserBasicInfoInput {
                    user_id,
                },
            )
            .await?;
        Ok(models::users::UserDetailData::from_domain(result).unwrap())
    }

    #[tracing::instrument(skip(self, ctx))]
    async fn get_user_point_balance(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::points::UserPointBalanceData> {
        tracing::info!("get_user_point_balance called with user_id: {}", user_id);
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_user_point_balance
            .get_user_point_balance(
                application::usecases::point::get_user_point_balance_usecase::GetUserPointBalanceInput {
                    user_id,
                },
            )
            .await?;
        Ok(models::points::UserPointBalanceData {
            fsp_balance: result.fsp_balance,
            fsp_balance_temp: result.fsp_balance_temp,
            credential_balance: result.credential_balance,
            is_credential_available: result.is_credential_available,
        })
    }

    async fn search_users(
        &self,
        ctx: &Context<'_>,
        username: String,
    ) -> Result<Vec<models::users::UserSimpleData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .search_users
            .search_users(
                application::usecases::basic::search_users_usecase::SearchUsersInput { username },
            )
            .await?;
        Ok(result
            .users
            .into_iter()
            .map(|user| models::users::UserSimpleData {
                id: user.id,
                name: user.username,
                realname: user.realname,
                image_url: user.img_url,
            })
            .collect())
    }

    async fn get_notifications(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<Vec<models::notifications::NotificationData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_notifications
            .get_notifications(&user_id)
            .await?;
        Ok(result
            .notifications
            .into_iter()
            .map(|n| models::notifications::NotificationData {
                id: n.id.to_string(),
                title: n.title,
                category: n.category,
                content: n.content,
                is_read: n.is_read,
                created_at: n.created_at.to_string(),
            })
            .collect())
    }

    async fn get_portfolios_by_user_id(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<Vec<models::portfolios::Portfolio>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .manage_portfolios
            .get_portfolios_by_user_id(user_id)
            .await?;
        Ok(result
            .into_iter()
            .map(|p| models::portfolios::Portfolio {
                id: p.id,
                user_id: p.user_id,
                title: p.title,
                description: p.description,
                img_url: p.img_url,
                category: p.category,
                release_date: p.release_date.map(|date| date.to_string()),
                external_url: p.external_url,
                created_at: p.created_at.to_string(),
                updated_at: p.updated_at.to_string(),
            })
            .collect())
    }

    async fn get_all_portfolios(
        &self,
        ctx: &Context<'_>,
    ) -> Result<Vec<models::portfolios::Portfolio>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.manage_portfolios.get_all_portfolios().await?;
        Ok(result
            .into_iter()
            .map(|p| models::portfolios::Portfolio {
                id: p.id,
                user_id: p.user_id,
                title: p.title,
                description: p.description,
                img_url: p.img_url,
                category: p.category,
                release_date: p.release_date.map(|date| date.to_string()),
                external_url: p.external_url,
                created_at: p.created_at.to_string(),
                updated_at: p.updated_at.to_string(),
            })
            .collect())
    }
}
