use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct MessageMutation;

#[Object]
impl MessageMutation {
    async fn create_new_message_room(
        &self,
        ctx: &Context<'_>,
        input: models::messages::CreateNewMessageRoomInput,
    ) -> Result<models::messages::CreateNewMessageRoomResponse> {
        todo!()
    }

    async fn send_message(
        &self,
        ctx: &Context<'_>,
        input: models::messages::SendMessageInput,
    ) -> Result<models::messages::SendMessageResponse> {
        todo!()
    }
}
