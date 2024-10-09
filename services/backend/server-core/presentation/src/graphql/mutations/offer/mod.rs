use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct OfferMutation;

#[Object]
impl OfferMutation {
    async fn create_new_offer(
        &self,
        ctx: &Context<'_>,
        input: models::offers::CreateNewOfferInput,
    ) -> Result<models::offers::CreateNewOfferResponse> {
        todo!()
    }

    async fn update_offer(
        &self,
        ctx: &Context<'_>,
        input: models::offers::UpdateOfferInput,
    ) -> Result<models::offers::UpdateOfferResponse> {
        todo!()
    }

    async fn delete_offer(
        &self,
        ctx: &Context<'_>,
        input: models::offers::DeleteOfferInput,
    ) -> Result<models::offers::DeleteOfferResponse> {
        todo!()
    }
}
