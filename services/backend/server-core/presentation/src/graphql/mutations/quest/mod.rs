use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct QuestMutation;

#[Object]
impl QuestMutation {
    async fn quest_mark_as_done(
        &self,
        ctx: &Context<'_>,
        quest_id: i32,
        user_id: String,
    ) -> Result<models::quests::MarkAsDoneResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .quest_mark_as_done
            .mark_as_done(
                application::usecases::quest::mark_as_done_usecase::MarkAsDoneUsecaseInput {
                    quest_id,
                    user_id,
                },
            )
            .await?;
        Ok(models::quests::MarkAsDoneResponse {
            quest_id: result.quest,
        })
    }

    async fn create_quest(
        &self,
        ctx: &Context<'_>,
        input: models::quests::CreateQuestInput,
    ) -> Result<models::quests::CreateQuestResponse> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let result = usecases
            .create_quest
            .create(application::usecases::quest::create_quest_usecase::CreateQuestUsecaseInput {
                name: input.name,
                description: input.description,
            })
            .await?;
        Ok(models::quests::CreateQuestResponse {
            quest_id: result.id,
        })
    }
}
