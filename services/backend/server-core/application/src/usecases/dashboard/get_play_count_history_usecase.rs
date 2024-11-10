use async_trait::async_trait;
use serde::Serialize;
use std::collections::HashMap;
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;

pub struct GetAllHistroyUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
    pub period: i32,
}
pub struct GetAllHistoryUsecaseOutput {
    pub chart_data: Vec<ChartDataByDSP>,
}

pub struct GetUPCHistoryUsecaseInput {
    pub upc: String,
    pub period: i32,
}
pub struct GetUPCHistoryUsecaseOutput {
    pub chart_data: Vec<ChartDataByISRC>,
}

pub struct ChartDataByDSP {
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}

#[derive(Debug, Serialize)]
pub struct ChartDataByISRC {
    pub date: String,
    #[serde(flatten)]
    pub isrc_count: HashMap<String, i32>,
}

#[async_trait]
pub trait GetPlayCountHistoryUsecaseTrait: Send + Sync {
    async fn get_play_count_by_artist(
        &self,
        input: GetAllHistroyUsecaseInput,
    ) -> Result<GetAllHistoryUsecaseOutput, anyhow::Error>;
    async fn get_play_count_by_upc(
        &self,
        input: GetUPCHistoryUsecaseInput,
    ) -> Result<GetUPCHistoryUsecaseOutput, anyhow::Error>;
}

pub struct GetPlayCountHistoryUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl GetPlayCountHistoryUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            gender_gen_playback_repo,
            products_repo,
            product_track_repo,
        }
    }
}

#[async_trait]
impl GetPlayCountHistoryUsecaseTrait for GetPlayCountHistoryUsecase {
    async fn get_play_count_by_artist(
        &self,
        input: GetAllHistroyUsecaseInput,
    ) -> Result<GetAllHistoryUsecaseOutput, anyhow::Error> {
        let products_by_artist = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let upcs: Vec<String> = products_by_artist
            .iter()
            .map(|p| p.upc.clone())
            .collect::<Vec<String>>();

        let product_tracks_by_upcs = self.product_track_repo.get_by_upcs(upcs).await?;
        let isrcs: Vec<String> = product_tracks_by_upcs
            .iter()
            .map(|p| p.isrc.clone())
            .collect::<Vec<String>>();

        let mut chart_data: Vec<ChartDataByDSP> = vec![];
        if input.period == 7 || input.period == 30 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrcs_and_period(isrcs, input.period)
                .await?;

            let mut aggregated_data: HashMap<String, ChartDataByDSP> = HashMap::new();

            for play in plays_daily_by_isrcs.iter() {
                let date = play.date.unwrap().format("%Y-%m-%d").to_string();
                aggregated_data
                    .entry(date)
                    .and_modify(|e| {
                        e.spotify += play.spotify;
                        e.apple += play.apple;
                        e.line += play.line;
                        e.amazon += play.amazon.unwrap_or(0);
                        e.youtube += play.youtube.unwrap_or(0);
                    })
                    .or_insert(ChartDataByDSP {
                        date: play.date.unwrap().format("%Y-%m-%d").to_string(),
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon.unwrap_or(0),
                        youtube: play.youtube.unwrap_or(0),
                    });
            }

            chart_data = aggregated_data
                .into_values()
                .collect::<Vec<ChartDataByDSP>>();

            // Sort by date in ascending order
            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else if input.period == 12 || input.period == 36 {
            let plays_monthly_by_isrcs: Vec<PlaysMonthly> = self
                .plays_monthly_repo
                .find_by_isrcs_and_period(isrcs, input.period)
                .await?;

            let mut aggregated_data: HashMap<String, ChartDataByDSP> = HashMap::new();

            for play in plays_monthly_by_isrcs.iter() {
                let date = play.month.unwrap().format("%Y-%m").to_string();
                aggregated_data
                    .entry(date)
                    .and_modify(|e| {
                        e.spotify += play.spotify;
                        e.apple += play.apple;
                        e.line += play.line;
                        e.amazon += play.amazon;
                        e.youtube += play.youtube;
                    })
                    .or_insert(ChartDataByDSP {
                        date: play.month.unwrap().format("%Y-%m").to_string(),
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon,
                        youtube: play.youtube,
                    });
            }

            chart_data = aggregated_data
                .into_values()
                .collect::<Vec<ChartDataByDSP>>();

            // Sort by date in ascending order
            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else if input.period == -1 {
            let plays_monthly_by_isrcs: Vec<PlaysMonthly> =
                self.plays_monthly_repo.find_by_isrcs(isrcs).await?;

            let mut aggregated_data: HashMap<String, ChartDataByDSP> = HashMap::new();

            for play in plays_monthly_by_isrcs.iter() {
                let date = play.month.unwrap().format("%Y-%m").to_string();
                aggregated_data
                    .entry(date)
                    .and_modify(|e| {
                        e.spotify += play.spotify;
                        e.apple += play.apple;
                        e.line += play.line;
                        e.amazon += play.amazon;
                        e.youtube += play.youtube;
                    })
                    .or_insert(ChartDataByDSP {
                        date: play.month.unwrap().format("%Y-%m").to_string(),
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon,
                        youtube: play.youtube,
                    });
            }

            chart_data = aggregated_data
                .into_values()
                .collect::<Vec<ChartDataByDSP>>();

            // Sort by date in ascending order
            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else {
            return Err(anyhow::anyhow!("Invalid period"));
        }

        Ok(GetAllHistoryUsecaseOutput { chart_data })
    }
    async fn get_play_count_by_upc(
        &self,
        input: GetUPCHistoryUsecaseInput,
    ) -> Result<GetUPCHistoryUsecaseOutput, anyhow::Error> {
        let product_track: Vec<ProductTrack> =
            self.product_track_repo.get_by_upc(&input.upc).await?;
        let isrcs: Vec<String> = product_track
            .iter()
            .map(|p| p.isrc.clone())
            .collect::<Vec<String>>();

        let mut chart_data: Vec<ChartDataByISRC> = vec![];

        if input.period == 7 || input.period == 30 {
            let plays_daily_by_isrcs: Vec<PlaysDaily> = self
                .plays_daily_repo
                .find_by_isrcs_and_period(isrcs.clone(), input.period)
                .await?;
            chart_data = plays_daily_by_isrcs
                .iter()
                .map(|p| {
                    let mut isrc_count: HashMap<String, i32> = HashMap::new();
                    isrc_count.insert(p.isrc.clone().unwrap(), p.sum.unwrap_or(0));

                    ChartDataByISRC {
                        date: p.date.unwrap().format("%Y-%m-%d").to_string(),
                        isrc_count,
                    }
                })
                .collect::<Vec<ChartDataByISRC>>();

            let mut merged_data: HashMap<String, HashMap<String, i32>> = HashMap::new();
            for data in chart_data {
                merged_data
                    .entry(data.date)
                    .and_modify(|e| e.extend(data.isrc_count.clone()))
                    .or_insert(data.isrc_count.clone());
            }

            chart_data = merged_data
                .into_iter()
                .map(|(date, isrc_count)| ChartDataByISRC { date, isrc_count })
                .collect();

            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else if input.period == 12 || input.period == 36 {
            let plays_monthly_by_isrcs: Vec<PlaysMonthly> = self
                .plays_monthly_repo
                .find_by_isrcs_and_period(isrcs.clone(), input.period)
                .await?;
            chart_data = plays_monthly_by_isrcs
                .iter()
                .map(|p| {
                    let mut isrc_count: HashMap<String, i32> = HashMap::new();
                    isrc_count.insert(p.isrc.clone().unwrap(), p.sum.unwrap_or(0));

                    ChartDataByISRC {
                        date: p.month.unwrap().format("%Y-%m").to_string(),
                        isrc_count,
                    }
                })
                .collect::<Vec<ChartDataByISRC>>();

            let mut merged_data: HashMap<String, HashMap<String, i32>> = HashMap::new();
            for data in chart_data {
                merged_data
                    .entry(data.date)
                    .and_modify(|e| e.extend(data.isrc_count.clone()))
                    .or_insert(data.isrc_count.clone());
            }

            chart_data = merged_data
                .into_iter()
                .map(|(date, isrc_count)| ChartDataByISRC { date, isrc_count })
                .collect();

            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else if input.period == -1 {
            let plays_monthly_by_isrcs: Vec<PlaysMonthly> =
                self.plays_monthly_repo.find_by_isrcs(isrcs.clone()).await?;
            chart_data = plays_monthly_by_isrcs
                .iter()
                .map(|p| {
                    let mut isrc_count: HashMap<String, i32> = HashMap::new();
                    isrc_count.insert(p.isrc.clone().unwrap(), p.sum.unwrap_or(0));

                    ChartDataByISRC {
                        date: p.month.unwrap().format("%Y-%m").to_string(),
                        isrc_count,
                    }
                })
                .collect::<Vec<ChartDataByISRC>>();

            let mut merged_data: HashMap<String, HashMap<String, i32>> = HashMap::new();
            for data in chart_data {
                merged_data
                    .entry(data.date)
                    .and_modify(|e| e.extend(data.isrc_count.clone()))
                    .or_insert(data.isrc_count.clone());
            }

            chart_data = merged_data
                .into_iter()
                .map(|(date, isrc_count)| ChartDataByISRC { date, isrc_count })
                .collect();

            chart_data.sort_by(|a, b| a.date.cmp(&b.date));
        } else {
            return Err(anyhow::anyhow!("Invalid period"));
        }

        Ok(GetUPCHistoryUsecaseOutput { chart_data })
    }
}
