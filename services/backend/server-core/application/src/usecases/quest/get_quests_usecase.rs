use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::quest_user::Model as QuestUser;
use domain::entities::quests::Model as Quest;
use domain::repositories::quest_user_repo::QuestUserRepository;
use domain::repositories::quests_repo::QuestsRepository;

pub struct GetQuestsUsecaseOutput {
    pub quests: Vec<Quest>,
}
pub struct QuestWithUserStatus {
    pub quest: Quest,
    pub is_done: bool,
}

#[async_trait]
pub trait GetQuestsUsecaseTrait: Send + Sync {
    async fn get_all(&self) -> Result<Vec<Quest>, anyhow::Error>;
    async fn get_by_user(&self, user_id: &str) -> Result<Vec<Quest>, anyhow::Error>;
}

pub struct GetQuestsUsecase {
    quests_repo: Arc<dyn QuestsRepository>,
    quest_user_repo: Arc<dyn QuestUserRepository>,
}

impl GetQuestsUsecase {
    pub fn new(
        quests_repo: Arc<dyn QuestsRepository>,
        quest_user_repo: Arc<dyn QuestUserRepository>,
    ) -> Self {
        Self {
            quests_repo,
            quest_user_repo,
        }
    }
}

#[async_trait]
impl GetQuestsUsecaseTrait for GetQuestsUsecase {
    async fn get_all(&self) -> Result<Vec<Quest>, anyhow::Error> {
        let quests = self.quests_repo.find_all().await?;

        Ok(quests)
    }

    async fn get_by_user(&self, user_id: &str) -> Result<Vec<Quest>, anyhow::Error> {
        let quest_user: Vec<QuestUser> = self
            .quest_user_repo
            .get_by_user_and_status(user_id, true)
            .await?;

        let completed_quest_ids: std::collections::HashSet<i32> =
            quest_user.iter().map(|qu| qu.quest).collect();

        let all_quests = self.quests_repo.find_all().await?;
        let uncompleted_quests: Vec<Quest> = all_quests
            .into_iter()
            .filter(|quest| !completed_quest_ids.contains(&quest.id))
            .collect();

        Ok(uncompleted_quests)
    }
}
