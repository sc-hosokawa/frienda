use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct OverviewData {
    pub total_users: i64,
    pub total_artists: i64,
    pub total_fsp: i64,
    pub total_revenue: i64,
    pub total_play_count: i64,
}
