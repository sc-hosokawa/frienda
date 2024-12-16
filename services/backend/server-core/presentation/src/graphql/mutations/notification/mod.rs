use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct NotificationMutation;

#[Object]
impl NotificationMutation {
    async fn mark_notification_as_read(
        &self,
        ctx: &Context<'_>,
        notification_id: i32,
        user_id: String,
    ) -> Result<i32> {
        let usecase = ctx.data::<Usecases>()?;
        let response = usecase
            .mark_notification_as_read
            .mark_notification_as_read(notification_id, &user_id)
            .await?;
        Ok(response)
    }
}
