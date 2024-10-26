use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct PrizeData {
    pub id: i32, // integer
    pub img_url: Option<String>,
    pub name: String,
    pub point: i32,
}

#[derive(SimpleObject)]
pub struct PrizeDetailData {
    pub id: i32,
    pub img_url: Option<String>,
    pub name: String,
    pub point: i32,
    pub description: String,
    pub representation: String,
    pub condition: Option<String>,
}

#[derive(SimpleObject)]
pub struct PrizesData {
    pub prize_list: Vec<PrizeData>,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct CreateNewPrizeInput {
    pub name: String,
    pub point: i32,
    pub description: String,
    pub representation: String,
    pub condition: Option<String>,
    pub img_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct CreateNewPrizeResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct DeletePrizeInput {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct DeletePrizeResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct UpdatePrizeInput {
    pub id: i32,
    pub name: Option<String>,
    pub point: Option<i32>,
    pub description: Option<String>,
    pub representation: Option<String>,
    pub condition: Option<String>,
    pub img_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdatePrizeResponse {
    pub id: i32,
}
