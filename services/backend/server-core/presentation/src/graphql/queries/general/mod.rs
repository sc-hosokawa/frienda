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

    async fn get_user_data(
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

    async fn get_user_point_balance(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::points::UserPointBalanceData> {
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
        })
    }
}
