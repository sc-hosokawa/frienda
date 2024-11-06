use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct QuestData {
    pub id: i32,
    pub name: String,
    pub description: String,
}

#[derive(InputObject)]
pub struct CreateQuestInput {
    pub name: String,
    pub description: String,
}

#[derive(SimpleObject)]
pub struct MarkAsDoneResponse {
    pub quest_id: i32,
}

#[derive(SimpleObject)]
pub struct CreateQuestResponse {
    pub quest_id: i32,
}
