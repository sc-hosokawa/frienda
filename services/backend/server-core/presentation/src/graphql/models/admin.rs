use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct OverviewData {
    pub total_users: i64,
    pub total_artists: i64,
    pub total_fsp: i64,
    pub total_revenue: i64,
    pub total_play_count: i64,
}

#[derive(SimpleObject)]
pub struct FspHistory {
    pub date: String,
    pub from: String, // username
    pub to: String,   // username
    pub amount: i32,
    pub notes: Option<String>,
}

#[derive(SimpleObject)]
pub struct Credit {
    pub date: String,
    pub title: String,
    pub isrc: String,
    pub user: String,
    pub role: String,
    pub name: String,
    pub email: String,
}
