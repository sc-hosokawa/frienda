use async_trait::async_trait;
use chrono::Duration;
use std::collections::HashMap;
use std::collections::HashSet;
use std::sync::Arc;

use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Products;
use domain::entities::tracks::Model as Track;

use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::plays_daily_repo::{PlayCountAggregate, PlaysDailyRepository};
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
    pub total_play_count_details: PlayCountDetails,
    pub weekly_play_count_details: PlayCountDetails,
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

#[derive(Clone)]
pub struct PlayCountDetails {
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub amazon: i32,
    pub youtube: i32,
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
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetTrendingUsecase {
    pub fn new(
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            plays_daily_repo,
            products_repo,
            tracks_repo,
            product_track_repo,
            artists_repo,
        }
    }

    fn aggregate_map(aggregates: Vec<PlayCountAggregate>) -> HashMap<String, PlayCountAggregate> {
        aggregates
            .into_iter()
            .map(|aggregate| (aggregate.isrc.clone(), aggregate))
            .collect()
    }

    fn details_from_aggregate(aggregate: Option<&PlayCountAggregate>) -> PlayCountDetails {
        aggregate
            .map(|aggregate| PlayCountDetails {
                spotify: aggregate.spotify as i32,
                apple: aggregate.apple as i32,
                line: aggregate.line as i32,
                amazon: aggregate.amazon as i32,
                youtube: aggregate.youtube as i32,
            })
            .unwrap_or(PlayCountDetails {
                spotify: 0,
                apple: 0,
                line: 0,
                amazon: 0,
                youtube: 0,
            })
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

        // 日本時間基準での現在時刻を取得
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let end_date_for_total = today_jst - Duration::days(3);
        let total_aggregates = self
            .plays_daily_repo
            .aggregate_by_isrcs(isrcs.clone(), None, Some(end_date_for_total), Some(5))
            .await?;

        let top_5_isrcs: Vec<String> = total_aggregates
            .iter()
            .map(|aggregate| aggregate.isrc.clone())
            .collect();
        tracing::info!("top_5_isrcs: {:?}", top_5_isrcs);
        let plays_by_isrc = Self::aggregate_map(total_aggregates);

        // 過去7日間の再生数を取得
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let start_date = today_jst - Duration::days(9);
        let end_date = today_jst - Duration::days(3);

        let weekly_aggregates = self
            .plays_daily_repo
            .aggregate_by_isrcs(top_5_isrcs.clone(), Some(start_date), Some(end_date), None)
            .await?;
        let plays_by_isrc_daily = Self::aggregate_map(weekly_aggregates);

        let mut tracks: Vec<Track> = self.tracks_repo.get_by_isrcs(top_5_isrcs.clone()).await?;
        let isrc_order: HashMap<String, usize> = top_5_isrcs
            .iter()
            .enumerate()
            .map(|(index, isrc)| (isrc.clone(), index))
            .collect();
        tracks.sort_by_key(|track| isrc_order.get(&track.isrc).copied().unwrap_or(usize::MAX));
        let product_by_upc: HashMap<String, Products> = products
            .into_iter()
            .map(|product| (product.upc.clone(), product))
            .collect();
        let mut product_track_by_isrc: HashMap<String, ProductTrack> = HashMap::new();
        for product_track in product_tracks {
            product_track_by_isrc
                .entry(product_track.isrc.clone())
                .or_insert(product_track);
        }

        let mut trending: Vec<TrendTrack> = vec![];

        for track in tracks {
            let product_upc_in_top5 = product_track_by_isrc
                .get(&track.isrc)
                .map(|product_track| product_track.upc.clone());
            let product_info = product_upc_in_top5
                .as_ref()
                .and_then(|upc| product_by_upc.get(upc));
            let product_title = product_info.map(|p| p.title.clone());
            let product_img_url = product_info.and_then(|p| p.img_url.clone());
            trending.push(TrendTrack {
                isrc: track.isrc.clone(),
                track_title: Some(track.title),
                upc_title: product_title,
                image_url: product_img_url,
                total_play_count: plays_by_isrc
                    .get(&track.isrc)
                    .map(|aggregate| aggregate.total as i32)
                    .unwrap_or(0),
                weekly_play_count: plays_by_isrc_daily
                    .get(&track.isrc)
                    .map(|aggregate| aggregate.total as i32)
                    .unwrap_or(0),
                total_play_count_details: Self::details_from_aggregate(
                    plays_by_isrc.get(&track.isrc),
                ),
                weekly_play_count_details: Self::details_from_aggregate(
                    plays_by_isrc_daily.get(&track.isrc),
                ),
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

        // 日本時間基準での現在時刻を取得
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let end_date_for_total = today_jst - Duration::days(3);
        let plays_by_isrc = Self::aggregate_map(
            self.plays_daily_repo
                .aggregate_by_isrcs(isrcs_in_upc.clone(), None, Some(end_date_for_total), None)
                .await?,
        );

        // 日本時間基準での週間集計
        let jst = chrono::FixedOffset::east_opt(9 * 3600).unwrap();
        let today_jst = chrono::Utc::now().with_timezone(&jst).date_naive();
        let start_date = today_jst - Duration::days(9); // 9日前
        let end_date = today_jst - Duration::days(3); // 3日前

        let plays_by_isrc_daily = Self::aggregate_map(
            self.plays_daily_repo
                .aggregate_by_isrcs(isrcs_in_upc.clone(), Some(start_date), Some(end_date), None)
                .await?,
        );

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
            let isrc = track.isrc.clone();
            trending.push(TrendTrack {
                isrc: isrc.clone(),
                track_title: Some(track.title),
                upc_title: None,
                image_url: None,
                total_play_count: plays_by_isrc
                    .get(&isrc)
                    .map(|aggregate| aggregate.total as i32)
                    .unwrap_or(0),
                weekly_play_count: plays_by_isrc_daily
                    .get(&isrc)
                    .map(|aggregate| aggregate.total as i32)
                    .unwrap_or(0),
                total_play_count_details: Self::details_from_aggregate(plays_by_isrc.get(&isrc)),
                weekly_play_count_details: Self::details_from_aggregate(
                    plays_by_isrc_daily.get(&isrc),
                ),
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

#[cfg(test)]
#[path = "get_trending_usecase_tests.rs"]
mod tests;
