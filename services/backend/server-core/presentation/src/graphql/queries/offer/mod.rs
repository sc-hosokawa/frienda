use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct OfferQuery;

#[Object]
impl OfferQuery {
    async fn get_offer_stats_by_user(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::offers::OfferStatsByUserData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_offer_stats
            .get_stats(
                application::usecases::offer::get_offer_stats_usecase::GetOfferStatsInput {
                    user_id,
                },
            )
            .await?;

        Ok(result.into())
    }

    async fn get_offers_by_owner(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::offers::OffersData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_offer_by_owner
            .get_by_owner(
                application::usecases::offer::get_offer_by_owner_usecase::GetOfferByOwnerInput {
                    user_id,
                },
            )
            .await?;
        Ok(models::offers::OffersData {
            offer_list: result.offers.into_iter().map(|o| o.into()).collect(),
        })
    }

    async fn get_offers_by_status(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::offers::OfferByStatusData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_offer_by_status
            .get_by_status(
                application::usecases::offer::get_offer_by_status_usecase::GetOfferByStatusInput {
                    user_id,
                },
            )
            .await?;

        Ok(models::offers::OfferByStatusData {
            inprogress_offers: result
                .inprogress_offers
                .into_iter()
                .map(|o| o.into())
                .collect(),
            applied_offers: result
                .applied_offers
                .into_iter()
                .map(|o| o.into())
                .collect(),
        })
    }

    async fn get_offers(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_available_offer.get_available_offers().await?;

        Ok(models::offers::OffersData {
            offer_list: result.offers.into_iter().map(|o| o.into()).collect(),
        })
    }

    async fn get_all_offers(&self, ctx: &Context<'_>) -> Result<Vec<models::offers::OfferData>> {
        todo!()
    }

    async fn get_offers_by_category(
        &self,
        ctx: &Context<'_>,
        category: String,
    ) -> Result<models::offers::OffersData> {
        todo!()
    }

    /*
    async fn get_offers_by_id(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_applied(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_applied_user(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_status(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_tag(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_title(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_deadline(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_points(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_user_category(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::offers::OffersData> {
        todo!()
    }
    */
}
