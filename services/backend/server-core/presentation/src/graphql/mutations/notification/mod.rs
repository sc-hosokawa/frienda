use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct NotificationMutation;

#[Object]
impl NotificationMutation {
    async fn create_new_notification(
        &self,
        ctx: &Context<'_>,
        input: models::notifications::CreateNewNotificationInput,
    ) -> Result<models::notifications::CreateNewNotificationResponse> {
        todo!()
    }

    async fn update_notification(
        &self,
        ctx: &Context<'_>,
        input: models::notifications::UpdateNotificationInput,
    ) -> Result<models::notifications::UpdateNotificationResponse> {
        todo!()
    }

    async fn delete_notification(
        &self,
        ctx: &Context<'_>,
        input: models::notifications::DeleteNotificationInput,
    ) -> Result<models::notifications::DeleteNotificationResponse> {
        todo!()
    }
}
