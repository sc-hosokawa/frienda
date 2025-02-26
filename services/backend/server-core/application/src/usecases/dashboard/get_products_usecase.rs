use async_trait::async_trait;
use std::sync::Arc;

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
        let mut products: Vec<Product> = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;

        products.sort_by_key(|product| std::cmp::Reverse(product.distributed_at));

        let mut output = GetProductsUsecaseOutput {
            album: vec![],
            single: vec![],
            ep: vec![],
        };

        for product in products {
            let category: String = product.r#type.clone().unwrap_or("".to_string());
            let mut product_track_map: Vec<ProductTrack> =
                self.product_track_repo.get_by_upc(&product.upc).await?;

            // Sort product_track_map by track_no
            product_track_map.sort_by_key(|pt| pt.track_no.unwrap_or(i32::MAX));

            tracing::debug!("======== after::product_track_map: {:?}", product_track_map);

            let mut tracks: Vec<Track> = self
                .tracks_repo
                .get_by_isrcs(
                    product_track_map
                        .iter()
                        .map(|pt| pt.isrc.clone())
                        .collect::<Vec<String>>(),
                )
                .await?;

            // product_track_mapの順序に合わせてtracksをソート
            let isrc_order: std::collections::HashMap<String, usize> = product_track_map
                .iter()
                .enumerate()
                .map(|(index, pt)| (pt.isrc.clone(), index))
                .collect();

            tracks.sort_by_key(|track| isrc_order.get(&track.isrc).copied().unwrap_or(usize::MAX));

            tracing::debug!("======== tracks: {:?}", tracks);
            match category.as_str() {
                "album" => output.album.push(ProductWithTracks { product, tracks }),
                "single" => output.single.push(ProductWithTracks { product, tracks }),
                "ep" => output.ep.push(ProductWithTracks { product, tracks }),
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

        let products: Vec<Product> = self
            .products_repo
            .get_by_upcs(product_track_map.iter().map(|pt| pt.upc.clone()).collect())
            .await?;

        Ok(GetTrackInfoUsecaseOutput {
            track,
            product: products,
        })
    }
}
