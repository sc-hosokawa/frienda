use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::quests::{ActiveModel as QuestActiveModel, Model as Quest};
use domain::repositories::quests_repo::QuestsRepository;

pub struct CreateQuestUsecaseInput {
    pub name: String,
    pub description: String,
}

#[async_trait]
pub trait CreateQuestUsecaseTrait: Send + Sync {
    async fn create(&self, input: CreateQuestUsecaseInput) -> Result<Quest, anyhow::Error>;
}

pub struct CreateQuestUsecase {
    quests_repo: Arc<dyn QuestsRepository>,
}

impl CreateQuestUsecase {
    pub fn new(quests_repo: Arc<dyn QuestsRepository>) -> Self {
        Self { quests_repo }
    }
}

#[async_trait]
impl CreateQuestUsecaseTrait for CreateQuestUsecase {
    async fn create(&self, input: CreateQuestUsecaseInput) -> Result<Quest, anyhow::Error> {
        let quest = QuestActiveModel {
            name: ActiveValue::Set(input.name),
            description: ActiveValue::Set(input.description),
            ..Default::default()
        };
        let created_quest = self.quests_repo.create(quest).await?;
        Ok(created_quest)
    }
}
