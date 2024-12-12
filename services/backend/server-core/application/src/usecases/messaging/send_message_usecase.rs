use async_trait::async_trait;
use chrono::Utc;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::message_attach::ActiveModel as MessageAttachActiveModel;
use domain::entities::messages::ActiveModel as MessageActiveModel;
use domain::entities::messages::Model as Message;
use domain::entities::rooms::ActiveModel as RoomActiveModel;
use domain::repositories::message_attach_repo::MessageAttachRepository;
use domain::repositories::messages_repo::MessagesRepository;
use domain::repositories::room_user_repo::RoomUserRepository;
use domain::repositories::rooms_repo::RoomsRepository;
use domain::repositories::users_repo::UsersRepository;

use crate::services::push_notification::PushNotificationServiceTrait;
use domain::services::notification::PushNotification;

//
// Define the input for the usecase
//
pub struct SendMessageInput {
    pub room_id: Uuid,
    pub sent_by: String, // varchar(28)
    pub message: String,
    pub attached_file: Option<Vec<String>>,
    pub attached_img: Option<Vec<String>>,
}

pub struct SendMessageOutput {
    pub room_id: Uuid,
    pub message: Message,
    pub attached_files: Option<Vec<String>>,
    pub attached_imgs: Option<Vec<String>>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait SendMessageUsecaseTrait: Send + Sync {
    async fn send_message(
        &self,
        message: SendMessageInput,
    ) -> Result<SendMessageOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct SendMessageUsecase {
    messages_repo: Arc<dyn MessagesRepository>,
    message_attach_repo: Arc<dyn MessageAttachRepository>,
    rooms_repo: Arc<dyn RoomsRepository>,
    push_notification_service: Arc<dyn PushNotificationServiceTrait>,
    users_repo: Arc<dyn UsersRepository>,
    room_user_repo: Arc<dyn RoomUserRepository>,
}

impl SendMessageUsecase {
    pub fn new(
        messages_repo: Arc<dyn MessagesRepository>,
        message_attach_repo: Arc<dyn MessageAttachRepository>,
        rooms_repo: Arc<dyn RoomsRepository>,
        push_notification_service: Arc<dyn PushNotificationServiceTrait>,
        users_repo: Arc<dyn UsersRepository>,
        room_user_repo: Arc<dyn RoomUserRepository>,
    ) -> Self {
        Self {
            messages_repo,
            message_attach_repo,
            rooms_repo,
            push_notification_service,
            users_repo,
            room_user_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl SendMessageUsecaseTrait for SendMessageUsecase {
    async fn send_message(
        &self,
        message: SendMessageInput,
    ) -> Result<SendMessageOutput, anyhow::Error> {
        let message_active_model: MessageActiveModel = MessageActiveModel {
            room_id: ActiveValue::Set(message.room_id),
            send_by: ActiveValue::Set(message.sent_by.clone()),
            message: ActiveValue::Set(message.message),
            ..Default::default()
        };
        let created_message: Message = self.messages_repo.create(message_active_model).await?;

        let room_active_model: RoomActiveModel = RoomActiveModel {
            id: ActiveValue::Set(message.room_id),
            latest_message_id: ActiveValue::Set(Some(created_message.id)),
            latest_message: ActiveValue::Set(Some(created_message.message.clone())),
            latest_sent_at: ActiveValue::Set(Some(Utc::now().naive_utc())),
            ..Default::default()
        };

        let room = self.rooms_repo.update(room_active_model).await?;

        let mut attachments = Vec::new();

        if let Some(ref files) = message.attached_file {
            attachments.extend(files.iter().map(|file| MessageAttachActiveModel {
                message_id: ActiveValue::Set(Some(created_message.id)),
                attached_file_url: ActiveValue::Set(Some(file.clone())),
                attached_img_url: ActiveValue::Set(None),
                ..Default::default()
            }));
        }

        if let Some(ref images) = message.attached_img {
            attachments.extend(images.iter().map(|image| MessageAttachActiveModel {
                message_id: ActiveValue::Set(Some(created_message.id)),
                attached_file_url: ActiveValue::Set(None),
                attached_img_url: ActiveValue::Set(Some(image.clone())),
                ..Default::default()
            }));
        }

        if !attachments.is_empty() {
            self.message_attach_repo.create_many(attachments).await?;
        }

        let room_users = self.room_user_repo.get_by_room_id(message.room_id).await?;

        let sent_by = &message.sent_by;
        let other_users = room_users
            .iter()
            .filter(|room_user| &room_user.user_id != sent_by)
            .collect::<Vec<_>>();

        let sender = self
            .users_repo
            .find_by_id(&message.sent_by)
            .await?
            .ok_or(anyhow::anyhow!("User not found"))?;
        let sender_name = sender.username;

        for room_user in other_users {
            if let Ok(user) = self.users_repo.find_by_id(&room_user.user_id).await {
                if let Some(fcm_token) = user.unwrap().fcm_token {
                    let push_notification = PushNotification {
                        token: fcm_token,
                        title: "新着メッセージがあります".to_string(),
                        body: format!("{}さんからメッセージが届きました", sender_name),
                    };
                    if let Err(e) = self
                        .push_notification_service
                        .send_push_notification(push_notification)
                        .await
                    {
                        tracing::info!("Failed to send push notification: {}", e);
                    }
                }
            }
        }

        Ok(SendMessageOutput {
            room_id: room.id,
            message: created_message,
            attached_files: message.attached_file,
            attached_imgs: message.attached_img,
        })
    }
}
