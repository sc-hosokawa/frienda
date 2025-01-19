use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct OfferMutation;

#[Object]
impl OfferMutation {
    async fn create_new_offer(
        &self,
        ctx: &Context<'_>,
        input: models::offers::CreateNewOfferInput,
    ) -> Result<models::offers::CreateNewOfferResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let new_offer_id = usecases
            .register_task
            .register_task(
                application::usecases::offer::register_task_usecase::RegisterTaskInput {
                    owner: input.owner,
                    title: input.title,
                    description: input.description,
                    place: input.place,
                    attention: input.attention,
                    required_skill: input.required_skill,
                    target_role: input
                        .target_role
                        .map(|s| models::users::from_string_to_user_category(&s).unwrap()),
                    fee: input.fee,
                    deadline: input.deadline.map(|d| d.to_string()),
                    image_url: input.image_url,
                    attached_imgs: input.attached_imgs,
                    attached_files: input.attached_files,
                    raid_id: input.raid_id,
                    category: input
                        .category
                        .map(|s| models::offers::from_string_to_offer_category(&s).unwrap()),
                    publicity: input.publicity,
                },
            )
            .await?;
        Ok(models::offers::CreateNewOfferResponse { id: new_offer_id })
    }

    async fn update_offer_info(
        &self,
        ctx: &Context<'_>,
        input: models::offers::UpdateOfferInput,
    ) -> Result<models::offers::UpdateOfferResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .update_task
            .update(
                application::usecases::offer::update_task_usecase::UpdateTaskInput {
                    id: input.id,
                    title: input.title,
                    description: input.description,
                    fee: input.fee,
                    image_url: input.image_url,
                    category: input
                        .category
                        .map(|s| models::offers::from_string_to_offer_category(&s).unwrap()),
                    place: input.place,
                    attention: input.attention,
                    required_skill: input.required_skill,
                    target_role: input
                        .target_role
                        .map(|s| models::users::from_string_to_user_category(&s).unwrap()),
                    publicity: input.publicity,
                    attached_imgs: input.attached_imgs.clone(),
                    attached_files: input.attached_files.clone(),
                    deadline: input.deadline.map(|d| d.to_string()),
                },
            )
            .await?;

        Ok(models::offers::UpdateOfferResponse {
            id: result.offer.id,
        })
    }

    async fn update_offer_status(
        &self,
        ctx: &Context<'_>,
        input: models::offers::UpdateOfferStatusInput,
    ) -> Result<models::offers::UpdateOfferStatusResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result =
            match input.status.as_str() {
                "Applied" => usecases
                    .change_status
                    .apply(
                        application::usecases::offer::change_status_usecase::ChangeStatusInput {
                            id: input.id,
                            user_id: input.user_id,
                            status: models::offers::from_string_to_offer_status(&input.status)
                                .unwrap(),
                        },
                    )
                    .await,
                "Finished" => usecases
                    .change_status
                    .complete(
                        application::usecases::offer::change_status_usecase::ChangeStatusInput {
                            id: input.id,
                            user_id: input.user_id,
                            status: models::offers::from_string_to_offer_status(&input.status)
                                .unwrap(),
                        },
                    )
                    .await,
                _ => usecases
                    .change_status
                    .change_status(
                        application::usecases::offer::change_status_usecase::ChangeStatusInput {
                            id: input.id,
                            user_id: input.user_id,
                            status: models::offers::from_string_to_offer_status(&input.status)
                                .unwrap(),
                        },
                    )
                    .await,
            }?;

        Ok(models::offers::UpdateOfferStatusResponse {
            id: result.0,
            offer_id: result.1,
        })
    }

    async fn delete_offer(
        &self,
        ctx: &Context<'_>,
        input: models::offers::DeleteOfferInput,
    ) -> Result<models::offers::DeleteOfferResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .delete_offer
            .delete(
                application::usecases::offer::delete_offer_usecase::DeleteOfferInput {
                    id: input.id,
                },
            )
            .await?;

        Ok(models::offers::DeleteOfferResponse { id: result })
    }

    async fn report_offer(
        &self,
        ctx: &Context<'_>,
        input: models::offers::ReportOfferInput,
    ) -> Result<models::offers::ReportOfferResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .report
            .report_offer(
                application::usecases::basic::report_usecase::OfferReportInput {
                    offer_id: input.offer_id,
                    reporter_user_id: input.reporter_user_id,
                    report_content: input.report_content,
                },
            )
            .await?;
        Ok(models::offers::ReportOfferResponse { id: result.id })
    }
}
