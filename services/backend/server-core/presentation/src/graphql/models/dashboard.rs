use async_graphql::SimpleObject;
use serde::Serialize;
use std::collections::HashMap;

// ===== Query =====

#[derive(SimpleObject)]
pub struct TotalOverviewData {
    pub total_playbacks: i32,
    pub weekly_playbacks: i32,
}

#[derive(SimpleObject)]
pub struct TrendingData {
    pub trending_tracks: Vec<TrendTrack>,
}
#[derive(SimpleObject)]
pub struct TrendTrack {
    pub isrc: String,
    pub track_title: Option<String>,
    pub upc_title: Option<String>,
    pub image_url: Option<String>, // img_url of UPC
    pub total_play_count: i32,
    pub weekly_play_count: i32,
}
impl From<application::usecases::dashboard::get_trending_usecase::TrendTrack> for TrendTrack {
    fn from(t: application::usecases::dashboard::get_trending_usecase::TrendTrack) -> Self {
        Self {
            isrc: t.isrc,
            track_title: t.track_title,
            upc_title: t.upc_title,
            image_url: t.image_url,
            total_play_count: t.total_play_count,
            weekly_play_count: t.weekly_play_count,
        }
    }
}

// ===== Histrical Data by Artist =====
#[derive(SimpleObject)]
pub struct ChartData {
    pub line_chart_data: Vec<LineChartData>,
}
#[derive(SimpleObject)]
pub struct LineChartData {
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}
impl From<application::usecases::dashboard::get_play_count_history_usecase::ChartDataByDSP>
    for LineChartData
{
    fn from(
        d: application::usecases::dashboard::get_play_count_history_usecase::ChartDataByDSP,
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

// ===== Histrical Data by UPC =====
#[derive(SimpleObject)]
pub struct ChartDataByUPC {
    pub line_chart_data: Vec<ChartDataByISRC>,
}

#[derive(SimpleObject, Serialize)]
pub struct ChartDataByISRC {
    pub date: String,
    #[serde(flatten)]
    pub isrc_count: HashMap<String, i32>,
}
impl From<application::usecases::dashboard::get_play_count_history_usecase::ChartDataByISRC>
    for ChartDataByISRC
{
    fn from(
        d: application::usecases::dashboard::get_play_count_history_usecase::ChartDataByISRC,
    ) -> Self {
        Self {
            date: d.date,
            isrc_count: d.isrc_count,
        }
    }
}

// ===== Playbacks by Gender, Generation =====
#[derive(SimpleObject)]
pub struct GenderGenRateData {
    pub gender_rate: GenderPlaybackRate,
    pub gen_rate: GenPlaybackRate,
}
#[derive(SimpleObject)]
pub struct GenderPlaybackRate {
    pub male_count: i32,
    pub female_count: i32,
}
impl From<application::usecases::dashboard::get_playback_gender_gen_usecase::GenderPlaybackRate>
    for GenderPlaybackRate
{
    fn from(
        d: application::usecases::dashboard::get_playback_gender_gen_usecase::GenderPlaybackRate,
    ) -> Self {
        Self {
            male_count: d.male_count,
            female_count: d.female_count,
        }
    }
}
#[derive(SimpleObject)]
pub struct GenPlaybackRate {
    pub under_14: i32,
    pub gen_15_19: i32,
    pub gen_20_24: i32,
    pub gen_25_29: i32,
    pub gen_30_34: i32,
    pub gen_35_39: i32,
    pub gen_40_44: i32,
    pub gen_45_49: i32,
    pub gen_50_over: i32,
}
impl From<application::usecases::dashboard::get_playback_gender_gen_usecase::GenPlaybackRate>
    for GenPlaybackRate
{
    fn from(
        d: application::usecases::dashboard::get_playback_gender_gen_usecase::GenPlaybackRate,
    ) -> Self {
        Self {
            under_14: d.under_14,
            gen_15_19: d._15_19,
            gen_20_24: d._20_24,
            gen_25_29: d._25_29,
            gen_30_34: d._30_34,
            gen_35_39: d._35_39,
            gen_40_44: d._40_44,
            gen_45_49: d._45_49,
            gen_50_over: d._50_over,
        }
    }
}

#[derive(SimpleObject)]
pub struct PlaybacksByCountryData {
    pub country_jp: i32,
    pub country_us: i32,
    pub country_other: i32,
}

// ===== Mutation =====
