use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct NotificationQuery;

#[Object]
impl NotificationQuery {
    async fn get_notifications(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::users::NotificationsByUserData> {
        todo!()
    }
    async fn get_all_notifications(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::notifications::NotificationsData> {
        todo!()
    }
}
