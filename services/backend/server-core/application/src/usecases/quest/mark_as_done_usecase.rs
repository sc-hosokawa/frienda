use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::quest_user::{ActiveModel as QuestUserActiveModel, Model as QuestUser};
use domain::repositories::quest_user_repo::QuestUserRepository;

pub struct MarkAsDoneUsecaseInput {
    pub quest_id: i32,
    pub user_id: String, // varchar(28)
}

#[async_trait]
pub trait MarkAsDoneUsecaseTrait: Send + Sync {
    async fn mark_as_done(&self, input: MarkAsDoneUsecaseInput)
        -> Result<QuestUser, anyhow::Error>;
}

pub struct MarkAsDoneUsecase {
    quest_user_repo: Arc<dyn QuestUserRepository>,
}

impl MarkAsDoneUsecase {
    pub fn new(quest_user_repo: Arc<dyn QuestUserRepository>) -> Self {
        Self { quest_user_repo }
    }
}

#[async_trait]
impl MarkAsDoneUsecaseTrait for MarkAsDoneUsecase {
    async fn mark_as_done(
        &self,
        input: MarkAsDoneUsecaseInput,
    ) -> Result<QuestUser, anyhow::Error> {
        let quest_user: QuestUserActiveModel = QuestUserActiveModel {
            quest: ActiveValue::Set(input.quest_id),
            user: ActiveValue::Set(input.user_id),
            is_done: ActiveValue::Set(true),
            ..Default::default()
        };
        let updated_quest_user_mapping: QuestUser = self.quest_user_repo.create(quest_user).await?;
        Ok(updated_quest_user_mapping)
    }
}
