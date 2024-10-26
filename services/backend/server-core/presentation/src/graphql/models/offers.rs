use async_graphql::{InputObject, SimpleObject};

// ===== Query =====
#[derive(SimpleObject)]
pub struct OfferStatsByUserData {
    pub inprogress_offers: i32,
    pub appled_offers: i32,
    pub completed_offers: i32,
    pub rejected_offers: i32,
    pub canceled_offers: i32,
    pub total_earnings: i32,
}

#[derive(SimpleObject)]
pub struct OfferData {
    pub id: i32,
    pub title: String,
    pub description: String,
    pub image_url: Option<String>,
    pub fee: i32,
    pub category: Option<String>,
}

#[derive(SimpleObject)]
pub struct OffersData {
    pub offer_list: Vec<OfferData>,
}

#[derive(SimpleObject)]
pub struct OfferByStatusData {
    pub inprogress_offers: Vec<OfferData>,
    pub appled_offers: Vec<OfferData>,
}

// ===== Mutation =====

#[derive(InputObject)]
pub struct CreateNewOfferInput {
    pub owner: String,
    pub release_dt: String,
    pub title: String,
    pub description: String,
    pub fee: i32,
    pub image_url: Option<String>,
    pub raid_id: Option<i32>,
    pub category: Option<String>,
}

#[derive(InputObject)]
pub struct UpdateOfferInput {
    pub id: String,
    pub title: Option<String>,
    pub description: Option<String>,
    pub fee: Option<i32>,
    pub image_url: Option<String>,
    pub raid_id: Option<i32>,
    pub category: Option<String>,
}

#[derive(InputObject)]
pub struct DeleteOfferInput {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct CreateNewOfferResponse {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct UpdateOfferResponse {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct DeleteOfferResponse {
    pub id: i32,
}
