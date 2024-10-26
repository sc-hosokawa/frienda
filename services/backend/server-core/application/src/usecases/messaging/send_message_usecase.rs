use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::message_attach::ActiveModel as MessageAttachActiveModel;
use domain::entities::messages::ActiveModel as MessageActiveModel;
use domain::repositories::message_attach_repo::MessageAttachRepository;
use domain::repositories::messages_repo::MessagesRepository;

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

//
// Define the interface for the usecase
//
#[async_trait]
pub trait SendMessageUsecaseTrait: Send + Sync {
    async fn send_message(&self, message: SendMessageInput) -> Result<bool, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct SendMessageUsecase {
    messages_repo: Arc<dyn MessagesRepository>,
    message_attach_repo: Arc<dyn MessageAttachRepository>,
}

impl SendMessageUsecase {
    pub fn new(
        messages_repo: Arc<dyn MessagesRepository>,
        message_attach_repo: Arc<dyn MessageAttachRepository>,
    ) -> Self {
        Self {
            messages_repo,
            message_attach_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl SendMessageUsecaseTrait for SendMessageUsecase {
    async fn send_message(&self, message: SendMessageInput) -> Result<bool, anyhow::Error> {
        let message_active_model: MessageActiveModel = MessageActiveModel {
            room_id: ActiveValue::Set(message.room_id),
            send_by: ActiveValue::Set(message.sent_by),
            message: ActiveValue::Set(message.message),
            ..Default::default()
        };

        let created_message = self.messages_repo.create(&message_active_model).await?;

        let mut attachments = Vec::new();

        if let Some(files) = message.attached_file {
            attachments.extend(files.into_iter().map(|file| MessageAttachActiveModel {
                message_id: ActiveValue::Set(Some(created_message.id)),
                attached_file_url: ActiveValue::Set(Some(file)),
                attached_img_url: ActiveValue::Set(None),
                ..Default::default()
            }));
        }

        if let Some(images) = message.attached_img {
            attachments.extend(images.into_iter().map(|image| MessageAttachActiveModel {
                message_id: ActiveValue::Set(Some(created_message.id)),
                attached_file_url: ActiveValue::Set(None),
                attached_img_url: ActiveValue::Set(Some(image)),
                ..Default::default()
            }));
        }

        if !attachments.is_empty() {
            self.message_attach_repo.create_many(&attachments).await?;
        }

        Ok(true)
    }
}
