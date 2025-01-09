use async_trait::async_trait;
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
    async fn register_releases(&self, input: RegisterReleasesInput) -> Result<(), anyhow::Error>;
    async fn _increase_artists_fsp(&self, artist_id: &str) -> Result<(), anyhow::Error>;
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

    async fn register_releases(&self, input: RegisterReleasesInput) -> Result<(), anyhow::Error> {
        let mut artist_products_map: HashMap<String, HashMap<String, Vec<String>>> = HashMap::new();

        let mut products: Vec<ProductActiveModel> = Vec::with_capacity(input.releases.len());
        let mut tracks: Vec<TrackActiveModel> = Vec::with_capacity(input.releases.len());
        let mut product_tracks: Vec<ProductTrackActiveModel> =
            Vec::with_capacity(input.releases.len());

        for release in input.releases {
            artist_products_map
                .entry(release.artist_id.clone())
                .or_insert(HashMap::new())
                .entry(release.format.clone())
                .or_insert(vec![])
                .push(release.upc.clone());

            products.push(ProductActiveModel {
                upc: ActiveValue::Set(release.upc.clone()),
                title: ActiveValue::Set(release.title),
                r#type: ActiveValue::Set(Some(release.format.clone())),
                distributed_at: ActiveValue::Set(Some(release.release_date.parse().unwrap())),
                artist_id: ActiveValue::Set(Some(release.artist_id.clone())),
                img_url: ActiveValue::Set(release.image_url.clone()),
                ..Default::default()
            });

            tracks.push(TrackActiveModel {
                isrc: ActiveValue::Set(release.isrc.clone()),
                title: ActiveValue::Set(release.track_title),
                artist_id: ActiveValue::Set(Some(release.artist_id.clone())),
                ..Default::default()
            });

            product_tracks.push(ProductTrackActiveModel {
                upc: ActiveValue::Set(release.upc.clone()),
                isrc: ActiveValue::Set(release.isrc.clone()),
                track_no: ActiveValue::Set(Some(release.track_no)),
                ..Default::default()
            });
        }

        let (product_track_res, track_res, product_res) = join!(
            self.product_track_repo.create_many(product_tracks),
            self.tracks_repo.create_many(tracks),
            self.products_repo.create_many(products),
        );

        product_track_res.map_err(|e| anyhow::anyhow!(e))?;
        track_res.map_err(|e| anyhow::anyhow!(e))?;
        product_res.map_err(|e| anyhow::anyhow!(e))?;

        /* アーティストのfspを更新する */
        //for (artist_id, products) in artist_products_map {
        //    self._increase_artists_fsp(&artist_id).await?;
        //}

        Ok(())
    }

    async fn _increase_artists_fsp(&self, artist_id: &str) -> Result<(), anyhow::Error> {
        let artist: Option<Artist> = self
            .artists_repo
            .find_by_id(&artist_id)
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        let artist: Artist = artist.unwrap();
        let mut artist_active_model: ArtistActiveModel = artist.into();

        artist_active_model.fsp = ActiveValue::Set(artist_active_model.fsp.unwrap() + 1);
        self.artists_repo.update(artist_active_model).await?;
        Ok(())
    }
}
