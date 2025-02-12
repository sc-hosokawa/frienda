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

#[derive(SimpleObject)]
pub struct PrizesByUserIdData {
    pub unused_prize_list: Vec<PrizeDetailData>,
    pub requested_prize_list: Vec<PrizeDetailData>,
    pub used_prize_list: Vec<PrizeDetailData>,
}

#[derive(SimpleObject)]
pub struct PrizesHistoryByUserIdData {
    pub used_history: Vec<ExchangeHistoryData>,
    pub requested_history: Vec<ExchangeHistoryData>,
    pub unused_history: Vec<ExchangeHistoryData>,
}

#[derive(SimpleObject)]
pub struct ExchangeHistoryData {
    pub id: i32,
    pub prize_id: i32,
    pub user_id: String,
    pub img_url: Option<String>,
    pub username: String,
    pub realname: String,
    pub email: String,
    pub point_used: i32,
    pub amount: i32,
    pub exchanged_at: String,
    pub is_requested: bool,
    pub requested_at: Option<String>,
    pub is_used: bool,
    pub used_at: Option<String>,
}

impl From<application::usecases::prize::get_prize_list_usecase::ExchangeHistory>
    for ExchangeHistoryData
{
    fn from(
        history: application::usecases::prize::get_prize_list_usecase::ExchangeHistory,
    ) -> Self {
        ExchangeHistoryData {
            id: history.history.id,
            prize_id: history.history.prize_id,
            user_id: history.user.id,
            img_url: history.user.img_url,
            username: history.user.username,
            realname: history.user.realname,
            email: history.user.email,
            point_used: history.history.point_used,
            amount: history.history.amount,
            exchanged_at: history.history.exchanged_at.to_string(),
            is_requested: history.history.is_requested,
            requested_at: history.history.requested_at.map(|dt| dt.to_string()),
            is_used: history.history.is_used,
            used_at: history.history.used_at.map(|dt| dt.to_string()),
        }
    }
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
    pub publicity: Option<bool>,
}

#[derive(SimpleObject)]
pub struct CreateNewPrizeResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct ExchangePrizeInput {
    pub user_id: String,
    pub prize_id: i32,
    pub amount: Option<i32>,
}

#[derive(SimpleObject)]
pub struct ExchangePrizeResponse {
    pub id: i32,
    pub tx_id: String,
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
    pub publicity: Option<bool>,
}

#[derive(SimpleObject)]
pub struct UpdatePrizeResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct RequestPrizeInput {
    pub user_id: String,
    pub prize_id: i32,
}

#[derive(SimpleObject)]
pub struct RequestPrizeResponse {
    pub id: i32,
}

#[derive(InputObject)]
pub struct UsePrizeInput {
    pub representation_user_id: String,
    pub user_id: String,
    pub prize_id: i32,
    pub code: Option<String>,
}

#[derive(SimpleObject)]
pub struct UsePrizeResponse {
    pub id: i32,
}

// ===== convert =====
impl From<domain::entities::prizes::Model> for PrizeData {
    fn from(prize: domain::entities::prizes::Model) -> Self {
        PrizeData {
            id: prize.id,
            img_url: prize.img_url,
            name: prize.name,
            point: prize.point,
        }
    }
}

impl From<domain::entities::prizes::Model> for PrizeDetailData {
    fn from(prize: domain::entities::prizes::Model) -> Self {
        PrizeDetailData {
            id: prize.id,
            img_url: prize.img_url,
            name: prize.name,
            point: prize.point,
            description: prize.description,
            representation: prize.representation,
            condition: prize.condition,
        }
    }
}
