use crate::graphql::models::track::*;
use async_graphql::SimpleObject;

// ===== Query =====

#[derive(SimpleObject)]
pub struct TotalOverviewData {
    pub total_playbacks: i32,
    pub weekly_playbacks: i32,
}

#[derive(SimpleObject)]
pub struct TrendingData {
    pub trending_tracks: Vec<TrackData>,
}

#[derive(SimpleObject)]
pub struct ChartData {
    pub line_chart_data: Vec<i32>,
}

#[derive(SimpleObject)]
pub struct PlaybacksByGenderData {
    pub male_playbacks: i32,
    pub female_playbacks: i32,
    pub unknown_playbacks: i32,
}

#[derive(SimpleObject)]
pub struct PlaybacksByGenerationData {
    pub playbacks_over_60: i32,
    pub playbacks_50s: i32,
    pub playbacks_40s: i32,
    pub playbacks_30s: i32,
    pub playbacks_20s: i32,
    pub playbacks_under_10s: i32,
}

#[derive(SimpleObject)]
pub struct PlaybacksByCountryData {
    pub country_jp: i32,
    pub country_us: i32,
    pub country_other: i32,
}

// ===== Mutation =====
