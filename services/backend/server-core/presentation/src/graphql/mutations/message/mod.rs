use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;
use uuid::Uuid;

#[derive(Default)]
pub struct MessageMutation;

#[Object]
impl MessageMutation {
    async fn create_new_message_room(
        &self,
        ctx: &Context<'_>,
        input: models::messages::CreateNewMessageRoomInput,
    ) -> Result<models::messages::CreateNewMessageRoomResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        usecases
            .create_message_room
            .create(application::usecases::messaging::create_message_room_usecase::CreateMessageRoomInput {
                category: models::messages::from_string_to_message_room_type(&input.category).unwrap(),
                user_list: input.user_list,
                created_by: input.created_by.clone(),
            })
            .await?;

        let new_room = usecases
            .get_room_list
            .get_active_rooms(input.created_by.clone())
            .await?;

        let new_room_id = new_room.rooms.first().unwrap().id.clone();

        Ok(models::messages::CreateNewMessageRoomResponse { id: new_room_id })
    }

    async fn send_message(
        &self,
        ctx: &Context<'_>,
        input: models::messages::SendMessageInput,
    ) -> Result<models::messages::SendMessageResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        usecases
            .send_message
            .send_message(
                application::usecases::messaging::send_message_usecase::SendMessageInput {
                    room_id: Uuid::parse_str(&input.room_id).unwrap(),
                    message: input.message.clone(),
                    sent_by: input.sent_by.clone(),
                    attached_file: input.attached_file,
                    attached_img: input.attached_img,
                },
            )
            .await?;

        let messages = usecases
            .get_messages
            .get_messages_on_dm(
                application::usecases::messaging::get_messages_usecase::GetMessagesInput {
                    room_id: Uuid::parse_str(&input.room_id).unwrap(),
                    user_id: input.sent_by.clone(),
                },
            )
            .await?;

        let message_id = messages.id;

        Ok(models::messages::SendMessageResponse { id: message_id })
    }
}
