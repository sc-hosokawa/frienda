use async_trait::async_trait;
use std::collections::HashMap;
use std::collections::HashSet;
use std::sync::Arc;

use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Products;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;

pub struct GetTrendingUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
}

pub struct GetTrendingUsecaseOutput {
    pub trending: Vec<TrendTrack>,
}
pub struct TrendTrack {
    pub isrc: String,
    pub track_title: Option<String>,
    pub upc_title: Option<String>,
    pub image_url: Option<String>, // img_url of UPC
    pub total_play_count: i32,
    pub weekly_play_count: i32,
}

#[async_trait]
pub trait GetTrendingUsecaseTrait: Send + Sync {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error>;
    async fn get_trending_from_spotify(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error>;
}

pub struct GetTrendingUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl GetTrendingUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            products_repo,
            tracks_repo,
            product_track_repo,
        }
    }
}

#[async_trait]
impl GetTrendingUsecaseTrait for GetTrendingUsecase {
    async fn get_trending_from_spotify(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error> {
        Ok(GetTrendingUsecaseOutput { trending: vec![] })
    }

    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error> {
        let products: Vec<Products> = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let upcs: Vec<String> = products
            .iter()
            .map(|p| p.upc.clone())
            .collect::<Vec<String>>();
        let product_tracks: Vec<ProductTrack> = self.product_track_repo.get_by_upcs(upcs).await?;
        let isrcs: Vec<String> = product_tracks
            .iter()
            .map(|p| p.isrc.clone())
            .collect::<HashSet<String>>()
            .into_iter()
            .collect();

        let plays_monthly: Vec<PlaysMonthly> = self.plays_monthly_repo.find_by_isrcs(isrcs).await?;

        // ISRCごとの合計を計算
        let mut plays_by_isrc: HashMap<String, i32> = HashMap::new();
        for play in plays_monthly {
            *plays_by_isrc.entry(play.isrc.clone().unwrap()).or_insert(0) += play.sum.unwrap_or(0);
        }

        // 再生数で降順ソートして上位5件を取得
        let mut top_plays: Vec<(String, i32)> = plays_by_isrc.into_iter().collect();
        top_plays.sort_by(|a, b| b.1.cmp(&a.1)); // 再生数で降順ソート
        let top_5_plays = top_plays.into_iter().take(5);

        #[derive(Debug)]
        struct PlayCount {
            isrc: String,
            count: i32,
        }

        let top_5_plays: Vec<PlayCount> = top_plays
            .into_iter()
            .take(5)
            .map(|(isrc, count)| PlayCount { isrc, count })
            .collect();

        let trending = top_5_plays.into_iter().map(|play| TrendTrack {
            isrc: play.isrc,
            track_title: None,
            upc_title: None,
            image_url: None,
            total_play_count: play.count,
            weekly_play_count: 0,
        });

        Ok(GetTrendingUsecaseOutput { trending })
    }
}
