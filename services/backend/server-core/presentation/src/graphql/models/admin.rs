use async_graphql::{InputObject, SimpleObject};

#[derive(SimpleObject)]
pub struct OverviewData {
    pub total_users: i64,
    pub total_artists: i64,
    pub total_fsp: i64,
    pub total_revenue: i64,
    pub total_play_count: i64,
    pub mobile_app_users_count: i32,
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

#[derive(InputObject)]
pub struct RegisterReleases {
    pub releases: Vec<ReleaseData>,
}

#[derive(InputObject)]
pub struct ReleaseData {
    pub upc: String,
    pub format: String,
    pub track_count: i32,
    pub title: String,
    pub release_date: String,
    pub isrc: String,
    pub track_no: i32,
    pub track_title: String,
    pub track_title_version: String,
    pub artist_id: String,
    pub image_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct RegisterReleasesResponse {
    pub success: bool,
}

#[derive(SimpleObject)]
pub struct User {
    pub id: String,
    pub image_url: Option<String>,
    pub realname: String,
    pub username: String,
    pub email: String,
    pub role: String,
    pub primary_role: String,
    pub created_at: String,
}
