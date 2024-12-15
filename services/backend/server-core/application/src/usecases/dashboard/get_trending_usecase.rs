use async_trait::async_trait;
use chrono::{Duration, Utc};
use std::collections::HashMap;
use std::collections::HashSet;
use std::sync::Arc;

use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Products;
use domain::entities::tracks::Model as Track;

use domain::repositories::artists_repo::ArtistsRepository;
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

pub struct GetTrendingByUpcUsecaseInput {
    pub user_id: String,
    pub upc: String,
}
pub struct GetTrendingByUpcUsecaseOutput {
    pub artist_name: String,
    pub product_img_url: Option<String>,
    pub product_title: String,
    pub trending: Vec<TrendTrack>,
}

#[async_trait]
pub trait GetTrendingUsecaseTrait: Send + Sync {
    async fn get_trending(
        &self,
        input: GetTrendingUsecaseInput,
    ) -> Result<GetTrendingUsecaseOutput, anyhow::Error>;
    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error>;
}

pub struct GetTrendingUsecase {
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetTrendingUsecase {
    pub fn new(
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            plays_monthly_repo,
            plays_daily_repo,
            products_repo,
            tracks_repo,
            product_track_repo,
            artists_repo,
        }
    }
}

#[async_trait]
impl GetTrendingUsecaseTrait for GetTrendingUsecase {
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

        let plays_monthly: Vec<PlaysMonthly> =
            self.plays_monthly_repo.find_by_isrcs(isrcs.clone()).await?;

        // ISRCごとの合計を計算
        let mut plays_by_isrc: HashMap<String, i32> = HashMap::new();
        for play in plays_monthly {
            *plays_by_isrc.entry(play.isrc.clone().unwrap()).or_insert(0) += play.sum.unwrap_or(0);
        }

        // 再生数で降順ソートして上位5件を取得
        let mut top_plays: Vec<(String, i32)> = plays_by_isrc.into_iter().collect();
        top_plays.sort_by(|a, b| b.1.cmp(&a.1));
        let top_5_isrcs: Vec<String> = top_plays
            .iter()
            .take(5)
            .map(|(isrc, _)| isrc.clone())
            .collect();
        tracing::info!("top_5_isrcs: {:?}", top_5_isrcs);

        // 過去7日間の再生数を取得
        let today = Utc::now().date_naive();
        let seven_days_ago = today - Duration::days(9);
        let two_days_ago = today - Duration::days(2);

        let plays_daily_in_top5: Vec<PlaysDaily> = self
            .plays_daily_repo
            .find_by_isrcs(top_5_isrcs.clone())
            .await?;

        let mut plays_by_isrc_daily: HashMap<String, i32> = HashMap::new();
        for play in plays_daily_in_top5 {
            if let Some(date) = play.date {
                if date <= two_days_ago && date >= seven_days_ago {
                    *plays_by_isrc_daily
                        .entry(play.isrc.clone().unwrap())
                        .or_insert(0) += play.sum.unwrap_or(0);
                }
            }
        }
        tracing::info!("weekly_plays: {:?}", plays_by_isrc_daily);

        let tracks: Vec<Track> = self.tracks_repo.get_by_isrcs(top_5_isrcs).await?;

        let mut trending: Vec<TrendTrack> = vec![];

        for track in tracks {
            let mapping: Vec<ProductTrack> =
                self.product_track_repo.get_by_isrc(&track.isrc).await?;
            let product_in_top5: Option<ProductTrack> = mapping.first().cloned();
            let product_upc_in_top5 = product_in_top5.unwrap().upc;
            let product_info = products.iter().find(|p| p.upc == product_upc_in_top5);
            let product_title = product_info.map(|p| p.title.clone());
            let product_img_url = product_info.map(|p| p.img_url.clone().unwrap());
            trending.push(TrendTrack {
                isrc: track.isrc.clone(),
                track_title: Some(track.title),
                upc_title: product_title,
                image_url: product_img_url,
                total_play_count: top_plays
                    .iter()
                    .find(|(isrc, _)| isrc == &track.isrc)
                    .map(|(_, count)| *count)
                    .unwrap_or(0),
                weekly_play_count: plays_by_isrc_daily.get(&track.isrc).copied().unwrap_or(0),
            });
        }

        Ok(GetTrendingUsecaseOutput { trending })
    }

    async fn get_trending_by_upc(
        &self,
        input: GetTrendingByUpcUsecaseInput,
    ) -> Result<GetTrendingByUpcUsecaseOutput, anyhow::Error> {
        let product: Option<Products> = self.products_repo.get_by_upc(&input.upc).await?;
        let artist_id: String = product.clone().unwrap().artist_id.unwrap();
        let artist = self.artists_repo.find_by_id(&artist_id).await?;
        let artist_name: String = artist.unwrap().display_name_jp;
        let product_img_url: Option<String> = product.clone().unwrap().img_url;
        let product_title: String = product.clone().unwrap().title;

        let mut product_tracks: Vec<ProductTrack> =
            self.product_track_repo.get_by_upc(&input.upc).await?;

        // Sort product_tracks by track_no
        product_tracks.sort_by_key(|pt| pt.track_no.unwrap_or(i32::MAX));

        let isrcs_in_upc: Vec<String> = product_tracks.iter().map(|p| p.isrc.clone()).collect();

        let plays_monthly: Vec<PlaysMonthly> = self
            .plays_monthly_repo
            .find_by_isrcs(isrcs_in_upc.clone())
            .await?;
        let mut plays_by_isrc: HashMap<String, i32> = HashMap::new();
        for play in plays_monthly {
            *plays_by_isrc.entry(play.isrc.clone().unwrap()).or_insert(0) += play.sum.unwrap_or(0);
        }
        tracing::info!("monthly_plays: {:?} in {}", plays_by_isrc, input.upc);

        let plays_daily: Vec<PlaysDaily> = self
            .plays_daily_repo
            .find_by_isrcs(isrcs_in_upc.clone())
            .await?;
        let mut plays_by_isrc_daily: HashMap<String, i32> = HashMap::new();
        for play in plays_daily {
            *plays_by_isrc_daily
                .entry(play.isrc.clone().unwrap())
                .or_insert(0) += play.sum.unwrap_or(0);
        }
        tracing::info!("weekly_plays: {:?} in {}", plays_by_isrc_daily, input.upc);

        let mut tracks: Vec<Track> = self.tracks_repo.get_by_isrcs(isrcs_in_upc).await?;

        // Sort tracks according to the product_tracks order
        let isrc_order: std::collections::HashMap<String, usize> = product_tracks
            .iter()
            .enumerate()
            .map(|(index, pt)| (pt.isrc.clone(), index))
            .collect();

        tracks.sort_by_key(|track| isrc_order.get(&track.isrc).copied().unwrap_or(usize::MAX));

        let mut trending: Vec<TrendTrack> = vec![];

        for track in tracks {
            trending.push(TrendTrack {
                isrc: track.isrc.clone(),
                track_title: Some(track.title),
                upc_title: None,
                image_url: None,
                total_play_count: plays_by_isrc.get(&track.isrc).unwrap_or(&0).clone(),
                weekly_play_count: plays_by_isrc_daily.get(&track.isrc).unwrap_or(&0).clone(),
            });
        }

        Ok(GetTrendingByUpcUsecaseOutput {
            artist_name,
            product_img_url,
            product_title,
            trending,
        })
    }
}
