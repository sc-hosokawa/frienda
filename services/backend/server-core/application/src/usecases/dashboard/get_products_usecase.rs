use async_trait::async_trait;
use std::sync::Arc;

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

#[async_trait]
pub trait GetProductsUsecaseTrait: Send + Sync {
    async fn get_products(
        &self,
        input: GetProductsUsecaseInput,
    ) -> Result<GetProductsUsecaseOutput, anyhow::Error>;
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
        let products: Vec<Product> = self
            .products_repo
            .find_by_artist_id(&input.artist_id)
            .await?;

        let mut output = GetProductsUsecaseOutput {
            album: vec![],
            single: vec![],
            ep: vec![],
        };

        for product in products {
            let category: String = product.r#type.clone().unwrap_or("".to_string());
            let product_track_map = self.product_track_repo.get_by_upc(&product.upc).await?;
            let tracks: Vec<Track> = self
                .tracks_repo
                .get_by_isrcs(product_track_map.iter().map(|p| p.isrc.clone()).collect())
                .await?;
            match category.as_str() {
                "album" => output.album.push(ProductWithTracks { product, tracks }),
                "single" => output.single.push(ProductWithTracks { product, tracks }),
                "ep" => output.ep.push(ProductWithTracks { product, tracks }),
                _ => (),
            }
        }
        Ok(output)
    }
}
