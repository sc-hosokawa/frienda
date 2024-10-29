use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;
use uuid::Uuid;

#[derive(Default)]
pub struct MessageQuery;

// ===== for Query =====

#[Object]
impl MessageQuery {
    async fn get_message_rooms(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::messages::MessageRoomsByUserData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_room_list
            .get_room_list(
                application::usecases::messaging::get_room_list_usecase::GetRoomListInput {
                    user_id,
                },
            )
            .await?;

        Ok(models::messages::MessageRoomsByUserData {
            message_room_list: result.rooms.into_iter().map(|r| r.into()).collect(),
            count_of_message_rooms: result.count_of_messages_rooms,
        })
    }

    async fn get_messages_in_progress(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<models::messages::MessageRoomsByUserData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases.get_room_list.get_active_rooms(user_id).await?;

        Ok(models::messages::MessageRoomsByUserData {
            message_room_list: result.rooms.into_iter().map(|r| r.into()).collect(),
            count_of_message_rooms: result.count_of_messages_rooms,
        })
    }

    async fn get_messages_by_message_room_id(
        &self,
        ctx: &Context<'_>,
        user_id: String,
        message_room_id: String,
    ) -> Result<models::messages::MessagesByRoomIdByUserData> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .get_messages
            .get_messages_on_dm(
                application::usecases::messaging::get_messages_usecase::GetMessagesInput {
                    user_id,
                    room_id: message_room_id.parse::<Uuid>().unwrap(),
                },
            )
            .await?;

        Ok(result.into())
    }
}
