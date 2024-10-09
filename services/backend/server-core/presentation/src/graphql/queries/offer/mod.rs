use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct OfferQuery;

#[Object]
impl OfferQuery {
    async fn get_all_offers(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_category(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_id(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
        todo!()
    }

    async fn get_offers_by_owner(&self, ctx: &Context<'_>) -> Result<models::offers::OffersData> {
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
}
