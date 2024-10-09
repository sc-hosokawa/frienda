use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;

#[derive(Default)]
pub struct MessageQuery;

// ===== for Query =====

#[Object]
impl MessageQuery {
    async fn get_message_rooms(
        &self,
        ctx: &Context<'_>,
    ) -> Result<models::users::MessageRoomsByUserData> {
        todo!()
    }

    async fn get_messages_by_message_room_id(
        &self,
        ctx: &Context<'_>,
        message_room_id: String,
    ) -> Result<models::messages::MessagesByMessageRoomIdData> {
        todo!()
    }
}
