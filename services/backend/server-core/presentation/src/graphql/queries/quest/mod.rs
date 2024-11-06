use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct QuestQuery;

#[Object]
impl QuestQuery {
    async fn get_quests(&self, ctx: &Context<'_>) -> Result<Vec<models::quests::QuestData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let all_quests = usecases.get_quests.get_all().await?;
        Ok(all_quests
            .into_iter()
            .map(|quest| models::quests::QuestData {
                id: quest.id,
                name: quest.name,
                description: quest.description,
            })
            .collect())
    }

    async fn get_quest_by_user_id(
        &self,
        ctx: &Context<'_>,
        user_id: String,
    ) -> Result<Vec<models::quests::QuestData>> {
        let usecases = ctx.data::<Arc<Usecases>>()?;
        let quests_by_user = usecases.get_quests.get_by_user(&user_id).await?;

        Ok(quests_by_user
            .into_iter()
            .map(|quest| models::quests::QuestData {
                id: quest.id,
                name: quest.name,
                description: quest.description,
            })
            .collect())
    }
}
