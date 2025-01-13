use async_trait::async_trait;
use std::collections::HashMap;
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;

pub struct AllTrackPlaybackHistoryUsecaseInput {
    pub period: i32,
}

pub struct AllTrackPlaybackHistoryUsecaseOutput {
    pub chart_data: Vec<ChartDataByDSPForAdmin>,
}

pub struct ChartDataByDSPForAdmin {
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
}

#[async_trait]
pub trait AllTrackPlaybackHistoryUsecaseTrait: Send + Sync {
    async fn get_all_track_playback_history(
        &self,
        input: AllTrackPlaybackHistoryUsecaseInput,
    ) -> Result<AllTrackPlaybackHistoryUsecaseOutput, anyhow::Error>;
}

pub struct AllTrackPlaybackHistoryUsecase {
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
}

impl AllTrackPlaybackHistoryUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    ) -> Self {
        Self {
            plays_daily_repo,
            plays_monthly_repo,
        }
    }
}

#[async_trait]
impl AllTrackPlaybackHistoryUsecaseTrait for AllTrackPlaybackHistoryUsecase {
    async fn get_all_track_playback_history(
        &self,
        input: AllTrackPlaybackHistoryUsecaseInput,
    ) -> Result<AllTrackPlaybackHistoryUsecaseOutput, anyhow::Error> {
        let mut chart_data: Vec<ChartDataByDSPForAdmin> = vec![];

        if input.period == 7 || input.period == 30 {
            let plays_daily = self
                .plays_daily_repo
                .get_all_by_period(input.period)
                .await?;
            let mut aggregated_data: HashMap<String, ChartDataByDSPForAdmin> = HashMap::new();

            for play in plays_daily.iter() {
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
                    .or_insert(ChartDataByDSPForAdmin {
                        date: play.date.unwrap().format("%Y-%m-%d").to_string(),
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon.unwrap_or(0),
                        youtube: play.youtube.unwrap_or(0),
                    });
            }

            chart_data = aggregated_data.into_values().collect();
        } else if input.period == 12 || input.period == 36 {
            let plays_monthly = self
                .plays_monthly_repo
                .get_all_by_period(input.period)
                .await?;
            let mut aggregated_data: HashMap<String, ChartDataByDSPForAdmin> = HashMap::new();

            for play in plays_monthly.iter() {
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
                    .or_insert(ChartDataByDSPForAdmin {
                        date: play.month.unwrap().format("%Y-%m").to_string(),
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon,
                        youtube: play.youtube,
                    });
            }

            chart_data = aggregated_data.into_values().collect();
        } else if input.period == -1 {
            let plays_monthly = self.plays_monthly_repo.get_all().await?;
            let mut aggregated_data: HashMap<String, ChartDataByDSPForAdmin> = HashMap::new();

            for play in plays_monthly.iter() {
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
                    .or_insert(ChartDataByDSPForAdmin {
                        date: play.month.unwrap().format("%Y-%m").to_string(),
                        spotify: play.spotify,
                        apple: play.apple,
                        line: play.line,
                        amazon: play.amazon,
                        youtube: play.youtube,
                    });
            }

            chart_data = aggregated_data.into_values().collect();
        } else {
            return Err(anyhow::anyhow!("Invalid period"));
        }

        // Sort by date in ascending order
        chart_data.sort_by(|a, b| a.date.cmp(&b.date));

        Ok(AllTrackPlaybackHistoryUsecaseOutput { chart_data })
    }
}
