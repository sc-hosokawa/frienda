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

#[derive(SimpleObject)]
pub struct ChartDataForAdmin {
    pub line_chart_data: Vec<LineChartDataForAdmin>,
}
#[derive(SimpleObject)]
pub struct LineChartDataForAdmin {
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}

#[derive(SimpleObject)]
pub struct UserReport {
    pub id: i32,
    pub reported_user_id: String,
    pub reporter_user_id: String,
    pub report_content: String,
    pub created_at: String,
}

#[derive(SimpleObject)]
pub struct OfferReport {
    pub id: i32,
    pub offer_id: i32,
    pub reporter_user_id: String,
    pub report_content: String,
    pub created_at: String,
}

#[derive(SimpleObject)]
pub struct ReleaseReport {
    pub id: i32,
    pub release: String, // UPC or ISRC
    pub reporter_user_id: String,
    pub report_content: String,
    pub created_at: String,
}

#[derive(InputObject)]
pub struct SearchTracksQuery {
    pub isrc: Option<String>,
    pub track_title: Option<String>,
    pub artist_id: Option<String>,
}

#[derive(SimpleObject)]
pub struct TrackData {
    pub isrc: String,
    pub track_title: String,
    pub artist_id: String,
    pub artist_name: String,
    pub product_title: String,
}

#[derive(InputObject)]
pub struct SearchProductsQuery {
    pub upc: Option<String>,
    pub product_title: Option<String>,
    pub artist_id: Option<String>,
    pub product_type: Option<String>,
}

#[derive(SimpleObject)]
pub struct ProductData {
    pub upc: String,
    pub title: String,
    pub img_url: Option<String>,
    pub product_type: Option<String>,
    pub distributed_at: Option<String>,
    pub artist_id: String,
    pub artist_name_ja: String,
    pub number_of_tracks: i32,
}

#[derive(InputObject)]
pub struct UpdateTrackInput {
    pub isrc: String,
    pub title: Option<String>,
}

#[derive(InputObject)]
pub struct UpdateProductInput {
    pub upc: String,
    pub title: Option<String>,
    pub img_url: Option<String>,
    pub r#type: Option<String>,
    pub distributed_at: Option<String>,
    pub artist_id: Option<String>,
}

impl From<application::usecases::admin::all_track_playback_usecase::ChartDataByDSPForAdmin>
    for LineChartDataForAdmin
{
    fn from(
        d: application::usecases::admin::all_track_playback_usecase::ChartDataByDSPForAdmin,
    ) -> Self {
        Self {
            date: d.date,
            spotify: d.spotify,
            apple: d.apple,
            line: d.line,
            amazon: d.amazon,
            youtube: d.youtube,
        }
    }
}
