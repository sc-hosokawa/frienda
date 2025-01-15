use async_trait::async_trait;
use chrono::NaiveDate;
use futures::join;
use sea_orm::ActiveValue;
use std::collections::HashMap;
use std::sync::Arc;

use domain::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use domain::entities::product_track::{
    ActiveModel as ProductTrackActiveModel, Model as ProductTrack,
};
use domain::entities::products::{ActiveModel as ProductActiveModel, Model as Product};
use domain::entities::tracks::{ActiveModel as TrackActiveModel, Model as Track};
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;

pub struct RegisterReleasesInput {
    pub releases: Vec<Release>,
}

pub struct Release {
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

#[async_trait]
pub trait ManageTracksUsecaseTrait: Send + Sync {
    async fn get_all_tracks(&self) -> Result<Vec<Track>, anyhow::Error>;
    async fn get_all_products(&self) -> Result<Vec<Product>, anyhow::Error>;
    async fn register_releases(&self, input: RegisterReleasesInput) -> Result<bool, anyhow::Error>;
    async fn _increase_artists_fsp(&self, artist_ids: Vec<String>) -> Result<(), anyhow::Error>;
}

pub struct ManageTracksUsecase {
    tracks_repo: Arc<dyn TracksRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl ManageTracksUsecase {
    pub fn new(
        tracks_repo: Arc<dyn TracksRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            tracks_repo,
            products_repo,
            artists_repo,
            product_track_repo,
        }
    }
}

#[async_trait]
impl ManageTracksUsecaseTrait for ManageTracksUsecase {
    async fn get_all_tracks(&self) -> Result<Vec<Track>, anyhow::Error> {
        let tracks: Vec<Track> = self
            .tracks_repo
            .find_all()
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        Ok(tracks)
    }

    async fn get_all_products(&self) -> Result<Vec<Product>, anyhow::Error> {
        let products: Vec<Product> = self
            .products_repo
            .find_all()
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        Ok(products)
    }

    async fn register_releases(&self, input: RegisterReleasesInput) -> Result<bool, anyhow::Error> {
        // UPCをキーとした製品の一時保存用HashMap
        let mut unique_products: HashMap<String, ProductActiveModel> = HashMap::new();
        let mut tracks: Vec<TrackActiveModel> = Vec::with_capacity(input.releases.len());
        let mut product_tracks: Vec<ProductTrackActiveModel> =
            Vec::with_capacity(input.releases.len());
        tracing::info!("========== Releases count = {}", input.releases.len());

        let start_id = self.product_track_repo.get_max_id().await?.unwrap();
        tracing::info!("========== Start ID = {}", start_id);

        let mut id_counter = start_id + 1;

        for release in &input.releases {
            if !unique_products.contains_key(&release.upc) {
                unique_products.insert(
                    release.upc.clone(),
                    ProductActiveModel {
                        upc: ActiveValue::Set(release.upc.clone()),
                        title: ActiveValue::Set(release.title.clone()),
                        r#type: ActiveValue::Set(Some(release.format.clone())),
                        distributed_at: ActiveValue::Set(Some(
                            NaiveDate::parse_from_str(&release.release_date, "%Y/%m/%d")
                                .map_err(|e| anyhow::anyhow!(e))?,
                        )),
                        artist_id: ActiveValue::Set(Some(release.artist_id.clone())),
                        img_url: ActiveValue::Set(release.image_url.clone()),
                        ..Default::default()
                    },
                );
            }

            tracks.push(TrackActiveModel {
                isrc: ActiveValue::Set(release.isrc.clone()),
                title: ActiveValue::Set(format!(
                    "{} ({})",
                    release.track_title, release.track_title_version
                )),
                artist_id: ActiveValue::Set(Some(release.artist_id.clone())),
                ..Default::default()
            });

            product_tracks.push(ProductTrackActiveModel {
                id: ActiveValue::Set(id_counter),
                upc: ActiveValue::Set(release.upc.clone()),
                isrc: ActiveValue::Set(release.isrc.clone()),
                track_no: ActiveValue::Set(Some(release.track_no)),
            });
            id_counter += 1;
        }

        // HashMapの値を Vec に変換
        let products: Vec<ProductActiveModel> = unique_products.into_values().collect();

        // 順序を保証するため、順次実行に変更し、各ステップでエラーハンドリング
        let product_res: bool = self
            .products_repo
            .create_many(products)
            .await
            .map_err(|e| {
                tracing::error!("Failed to create products: {:?}", e);
                anyhow::anyhow!("Failed to create products: {}", e)
            })?;
        tracing::info!("Products created: {}", product_res);

        let track_res: bool = self.tracks_repo.create_many(tracks).await.map_err(|e| {
            tracing::error!("Failed to create tracks: {:?}", e);
            anyhow::anyhow!("Failed to create tracks: {}", e)
        })?;
        tracing::info!("Tracks created: {}", track_res);

        let product_track_res = self
            .product_track_repo
            .create_many(product_tracks)
            .await
            .map_err(|e| {
                tracing::error!("Failed to create product tracks: {:?}", e);
                anyhow::anyhow!("Failed to create product tracks: {}", e)
            })?;

        // 全ての処理が成功した場合
        tracing::info!("Successfully registered all releases");

        // アーティストのFSPを更新
        let artist_ids: Vec<String> = input
            .releases
            .iter()
            .map(|release| release.artist_id.clone())
            .collect();
        self._increase_artists_fsp(artist_ids).await?;

        Ok(true)
    }

    async fn _increase_artists_fsp(&self, artist_ids: Vec<String>) -> Result<(), anyhow::Error> {
        // アーティストIDごとの出現回数をカウント
        let mut artist_track_counts: HashMap<String, i32> = HashMap::new();
        for artist_id in artist_ids {
            *artist_track_counts.entry(artist_id).or_insert(0) += 1;
        }

        for (artist_id, track_count) in artist_track_counts {
            let fsp_points: i32 = if track_count <= 10 {
                track_count * 10 // 10曲以下: 曲数 × 10ポイント
            } else {
                100 // 11曲以上: 100ポイント（上限）
            };

            let artist = self
                .artists_repo
                .find_by_id(&artist_id)
                .await
                .map_err(|e| anyhow::anyhow!("Failed to find artist: {}", e))?;

            if let Some(artist) = artist {
                let current_fsp: i32 = artist.fsp;
                let mut artist_active: ArtistActiveModel = artist.into();
                artist_active.fsp = ActiveValue::Set(current_fsp + fsp_points);

                self.artists_repo
                    .update(artist_active)
                    .await
                    .map_err(|e| anyhow::anyhow!("Failed to update artist FSP: {}", e))?;
            }
        }

        Ok(())
    }
}
