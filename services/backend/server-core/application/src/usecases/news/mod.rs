use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::users::Model as User;
use domain::repositories::users_repo::UsersRepository;

use crate::services::push_notification::PushNotificationServiceTrait;
use crate::services::send_email::EmailServiceTrait;
use domain::services::email::Email;
use domain::services::notification::PushNotification;

#[async_trait]
pub trait UpdateNewsUsecaseTrait: Send + Sync {
    async fn update_news(&self) -> Result<bool, anyhow::Error>;
}

pub struct UpdateNewsUsecase {
    users_repo: Arc<dyn UsersRepository>,
    push_notification_service: Arc<dyn PushNotificationServiceTrait>,
    email_service: Arc<dyn EmailServiceTrait>,
}

impl UpdateNewsUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        push_notification_service: Arc<dyn PushNotificationServiceTrait>,
        email_service: Arc<dyn EmailServiceTrait>,
    ) -> Self {
        Self {
            users_repo,
            push_notification_service,
            email_service,
        }
    }
}

#[async_trait]
impl UpdateNewsUsecaseTrait for UpdateNewsUsecase {
    async fn update_news(&self) -> Result<bool, anyhow::Error> {
        let all_users: Vec<User> = self.users_repo.get_all_users().await?;

        // バッチサイズを設定
        const BATCH_SIZE: usize = 100;

        // ユーザーをバッチに分割して処理
        for chunk in all_users.chunks(BATCH_SIZE) {
            let mut notification_tasks = Vec::with_capacity(chunk.len());

            for user in chunk {
                let email_service = Arc::clone(&self.email_service);
                let email: String = user.email.clone();

                // 各ユーザーの通知タスクを作成
                let task = tokio::spawn(async move {
                    let email_notification = Email {
                        from: "info@friendshipdao.xyz".to_string(),
                        to: email,
                        subject: "【FRIENDSHIP. DAO】新しいニュースがあります".to_string(),
                        body: format!(
                            "新しいニュースが更新されました。\n\nウェブサイトを開いて確認する: https://app.friendshipdao.xyz",
                        ),
                    };

                    email_service.send_email(email_notification).await
                });

                notification_tasks.push(task);
            }

            // バッチ内のすべてのタスクを待機し、エラーをログに記録
            for task in futures::future::join_all(notification_tasks).await {
                if let Err(e) = task {
                    tracing::error!("Notification task failed: {}", e);
                } else if let Ok(Err(e)) = task {
                    tracing::warn!("Failed to send email notification: {}", e);
                }
            }
        }

        Ok(true)
    }
}
