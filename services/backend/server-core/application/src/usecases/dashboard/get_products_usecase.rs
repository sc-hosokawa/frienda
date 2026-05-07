use async_trait::async_trait;
use std::{
    collections::{HashMap, HashSet},
    sync::Arc,
};

use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::tracks::Model as Track;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;

pub struct GetProductsUsecaseInput {
    pub artist_id: String,
}

pub struct GetProductsUsecaseOutput {
    pub album: Vec<ProductWithTracks>,
    pub single: Vec<ProductWithTracks>,
    pub ep: Vec<ProductWithTracks>,
}
pub struct ProductWithTracks {
    pub product: Product,
    pub tracks: Vec<Track>,
}

pub struct GetTrackInfoUsecaseOutput {
    pub track: Track,
    pub product: Vec<Product>,
}

#[async_trait]
pub trait GetProductsUsecaseTrait: Send + Sync {
    async fn get_products(
        &self,
        input: GetProductsUsecaseInput,
    ) -> Result<GetProductsUsecaseOutput, anyhow::Error>;

    async fn get_track_info(
        &self,
        isrc: String,
    ) -> Result<GetTrackInfoUsecaseOutput, anyhow::Error>;
}

pub struct GetProductsUsecase {
    products_repo: Arc<dyn ProductsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
}

impl GetProductsUsecase {
    pub fn new(
        products_repo: Arc<dyn ProductsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
    ) -> Self {
        Self {
            products_repo,
            tracks_repo,
            product_track_repo,
        }
    }
}

#[async_trait]
impl GetProductsUsecaseTrait for GetProductsUsecase {
    async fn get_products(
        &self,
        input: GetProductsUsecaseInput,
    ) -> Result<GetProductsUsecaseOutput, anyhow::Error> {
        let rows = self
            .products_repo
            .find_dashboard_products_by_artist_id(&input.artist_id)
            .await?;

        let mut output = GetProductsUsecaseOutput {
            album: vec![],
            single: vec![],
            ep: vec![],
        };

        if rows.is_empty() {
            return Ok(output);
        }

        let mut products: Vec<ProductWithTracks> = vec![];
        let mut product_index_by_upc: HashMap<String, usize> = HashMap::new();

        for row in rows {
            let index = match product_index_by_upc.get(&row.product.upc).copied() {
                Some(index) => index,
                None => {
                    let index = products.len();
                    product_index_by_upc.insert(row.product.upc.clone(), index);
                    products.push(ProductWithTracks {
                        product: row.product,
                        tracks: vec![],
                    });
                    index
                }
            };

            if let Some(track) = row.track {
                products[index].tracks.push(track);
            }
        }

        for product_with_tracks in products {
            let category = product_with_tracks
                .product
                .r#type
                .clone()
                .unwrap_or_default();
            match category.as_str() {
                "album" => output.album.push(product_with_tracks),
                "single" => output.single.push(product_with_tracks),
                "ep" => output.ep.push(product_with_tracks),
                _ => (),
            }
        }
        Ok(output)
    }

    async fn get_track_info(
        &self,
        isrc: String,
    ) -> Result<GetTrackInfoUsecaseOutput, anyhow::Error> {
        let track: Option<Track> = self.tracks_repo.get_by_isrc(&isrc).await?;
        if track.is_none() {
            return Err(anyhow::anyhow!("Track not found"));
        }
        let track: Track = track.unwrap();

        let product_track_map: Vec<ProductTrack> =
            self.product_track_repo.get_by_isrc(&isrc).await?;

        if product_track_map.is_empty() {
            return Ok(GetTrackInfoUsecaseOutput {
                track,
                product: vec![],
            });
        }

        let mut seen_upcs = HashSet::new();
        let upcs = product_track_map
            .iter()
            .filter_map(|pt| {
                if seen_upcs.insert(pt.upc.clone()) {
                    Some(pt.upc.clone())
                } else {
                    None
                }
            })
            .collect();

        let products: Vec<Product> = self.products_repo.get_by_upcs(upcs).await?;

        Ok(GetTrackInfoUsecaseOutput {
            track,
            product: products,
        })
    }
}

#[cfg(test)]
#[path = "get_products_usecase_tests.rs"]
mod tests;
