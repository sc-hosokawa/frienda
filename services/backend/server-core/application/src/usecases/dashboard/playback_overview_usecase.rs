use async_trait::async_trait;
use chrono::{Duration, FixedOffset, NaiveDate, Utc};
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;

pub struct PlaybackOverviewUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
    pub upc: Option<String>,
}

pub struct PlaybackOverviewUsecaseOutput {
    pub total_play_count: i32,
    pub weekly_play_count: i32,
}

#[async_trait]
pub trait PlaybackOverviewUsecaseTrait: Send + Sync {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error>;
    async fn get_playback_overview_by_upc(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error>;
}

pub struct PlaybackOverviewUsecase {
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl PlaybackOverviewUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            plays_daily_repo,
            products_repo,
            product_track_repo,
        }
    }

    fn aggregate_sum(
        plays_daily: &[PlaysDaily],
        start: Option<NaiveDate>,
        end: Option<NaiveDate>,
    ) -> i32 {
        plays_daily
            .iter()
            .filter_map(|p| {
                let date = p.date?;

                if let Some(start_date) = start {
                    if date < start_date {
                        return None;
                    }
                }
                if let Some(end_date) = end {
                    if date > end_date {
                        return None;
                    }
                }

                Some(p.sum.unwrap_or(0))
            })
            .sum()
    }
}

#[async_trait]
impl PlaybackOverviewUsecaseTrait for PlaybackOverviewUsecase {
    async fn get_playback_overview(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        let products: Vec<Product> = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let upcs: Vec<String> = products.iter().map(|p| p.upc.clone()).collect();
        let product_tracks: Vec<ProductTrack> = self.product_track_repo.get_by_upcs(upcs).await?;
        let isrcs: Vec<String> = product_tracks.iter().map(|p| p.isrc.clone()).collect();

        let plays_daily: Vec<PlaysDaily> =
            self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;
        // 日本時間基準での現在時刻を取得
        let jst = FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = Utc::now().with_timezone(&jst).date_naive();

        // 直近3日を除いた全期間の合計（従来の月次 + 当月日次相当）
        let end_date_for_total = today_jst - Duration::days(3);
        let total_play_count = Self::aggregate_sum(&plays_daily, None, Some(end_date_for_total));

        let start_date_weekly = today_jst - Duration::days(9);
        let end_date_weekly = today_jst - Duration::days(3);
        let weekly_play_count =
            Self::aggregate_sum(&plays_daily, Some(start_date_weekly), Some(end_date_weekly));

        Ok(PlaybackOverviewUsecaseOutput {
            total_play_count,
            weekly_play_count,
        })
    }

    async fn get_playback_overview_by_upc(
        &self,
        input: PlaybackOverviewUsecaseInput,
    ) -> Result<PlaybackOverviewUsecaseOutput, anyhow::Error> {
        if let Some(upc) = input.upc {
            let product_track: Vec<ProductTrack> = self.product_track_repo.get_by_upc(&upc).await?;
            let isrcs: Vec<String> = product_track.iter().map(|p| p.isrc.clone()).collect();

            let plays_daily: Vec<PlaysDaily> =
                self.plays_daily_repo.find_by_isrcs(isrcs.clone()).await?;
            // 日本時間基準での現在時刻を取得
            let jst = FixedOffset::east_opt(9 * 3600).unwrap();
            let today_jst = Utc::now().with_timezone(&jst).date_naive();

            // 直近3日を除いた全期間の合計
            let end_date_for_total = today_jst - Duration::days(3);
            let total_play_count =
                Self::aggregate_sum(&plays_daily, None, Some(end_date_for_total));

            let start_date_weekly = today_jst - Duration::days(9);
            let end_date_weekly = today_jst - Duration::days(3);
            let weekly_play_count =
                Self::aggregate_sum(&plays_daily, Some(start_date_weekly), Some(end_date_weekly));

            Ok(PlaybackOverviewUsecaseOutput {
                total_play_count,
                weekly_play_count,
            })
        } else {
            Err(anyhow::anyhow!("UPC is required"))
        }
    }
}
