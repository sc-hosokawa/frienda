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
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::plays_yearly_repo::PlaysYearlyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::{ProductsRepository, SearchProductsOptions};
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use domain::repositories::tracks_repo::{SearchTracksOptions, TracksRepository};

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

pub struct SearchTracksInput {
    pub isrc: Option<String>,
    pub track_title: Option<String>,
    pub artist_id: Option<String>,
}

pub struct SearchTracksOutput {
    pub isrc: String,
    pub title: String,
    pub artist_id: String,
    pub artist_name_ja: String,
    pub product_title: String,
}

pub struct SearchProductsInput {
    pub upc: Option<String>,
    pub product_title: Option<String>,
    pub artist_id: Option<String>,
    pub product_type: Option<String>,
}

pub struct SearchProductsOutput {
    pub upc: String,
    pub title: String,
    pub img_url: Option<String>,
    pub product_type: Option<String>,
    pub distributed_at: Option<NaiveDate>,
    pub artist_id: String,
    pub artist_name_ja: String,
    pub number_of_tracks: i32,
}

pub struct UpdateTrackInput {
    pub isrc: String,
    pub title: Option<String>,
}

pub struct UpdateProductInput {
    pub upc: String,
    pub title: Option<String>,
    pub img_url: Option<String>,
    pub r#type: Option<String>,
    pub distributed_at: Option<NaiveDate>,
    pub artist_id: Option<String>,
}

#[async_trait]
pub trait ManageTracksUsecaseTrait: Send + Sync {
    async fn get_all_tracks(&self) -> Result<Vec<Track>, anyhow::Error>;
    async fn get_all_products(&self) -> Result<Vec<Product>, anyhow::Error>;
    async fn register_releases(&self, input: RegisterReleasesInput) -> Result<bool, anyhow::Error>;
    async fn search_tracks(
        &self,
        input: SearchTracksInput,
    ) -> Result<Vec<SearchTracksOutput>, anyhow::Error>;
    async fn search_products(
        &self,
        input: SearchProductsInput,
    ) -> Result<Vec<SearchProductsOutput>, anyhow::Error>;
    async fn update_track(&self, input: UpdateTrackInput) -> Result<Track, anyhow::Error>;
    async fn update_product(&self, input: UpdateProductInput) -> Result<Product, anyhow::Error>;
    async fn delete_track(&self, isrc: String) -> Result<bool, anyhow::Error>;
    async fn delete_product(&self, upc: String) -> Result<bool, anyhow::Error>;
    async fn _increase_artists_fsp(&self, artist_ids: Vec<String>) -> Result<(), anyhow::Error>;
}

pub struct ManageTracksUsecase {
    tracks_repo: Arc<dyn TracksRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    plays_yearly_repo: Arc<dyn PlaysYearlyRepository>,
}

impl ManageTracksUsecase {
    pub fn new(
        tracks_repo: Arc<dyn TracksRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        track_credits_repo: Arc<dyn TrackCreditsRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        plays_yearly_repo: Arc<dyn PlaysYearlyRepository>,
    ) -> Self {
        Self {
            tracks_repo,
            products_repo,
            artists_repo,
            product_track_repo,
            track_credits_repo,
            plays_daily_repo,
            plays_monthly_repo,
            plays_yearly_repo,
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
                title: ActiveValue::Set(release.track_title.clone()),
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

    async fn search_tracks(
        &self,
        input: SearchTracksInput,
    ) -> Result<Vec<SearchTracksOutput>, anyhow::Error> {
        // inputにartist_idが含まれている場合は、artist_idでupc->isrcで取得してリスト構築
        let mut res_from_artist_id: Vec<SearchTracksOutput> = Vec::new();
        if let Some(artist_id) = input.artist_id {
            let artist = self
                .artists_repo
                .find_by_id(&artist_id)
                .await
                .map_err(|e| anyhow::anyhow!(e))?;
            let products: Vec<Product> = self
                .products_repo
                .find_by_artist_id(&artist_id)
                .await
                .map_err(|e| anyhow::anyhow!(e))?;
            let mapping: Vec<ProductTrack> = self
                .product_track_repo
                .get_by_upcs(products.iter().map(|p| p.upc.clone()).collect())
                .await
                .map_err(|e| anyhow::anyhow!(e))?;
            let tracks: Vec<Track> = self
                .tracks_repo
                .get_by_isrcs(mapping.iter().map(|m| m.isrc.clone()).collect())
                .await
                .map_err(|e| anyhow::anyhow!(e))?;

            // Create a mapping from ISRC to related products using ProductTrack
            let isrc_to_products: HashMap<String, Vec<&Product>> = mapping
                .iter()
                .filter_map(|m| {
                    let product = products.iter().find(|p| p.upc == m.upc);
                    product.map(|p| (m.isrc.clone(), p))
                })
                .fold(HashMap::new(), |mut acc, (isrc, product)| {
                    acc.entry(isrc).or_insert_with(Vec::new).push(product);
                    acc
                });

            res_from_artist_id = tracks
                .iter()
                .map(|t| {
                    let related_products = match isrc_to_products.get(&t.isrc) {
                        Some(products) => products,
                        None => &Vec::new(),
                    };
                    SearchTracksOutput {
                        isrc: t.isrc.clone(),
                        title: t.title.clone(),
                        artist_id: artist_id.clone(),
                        artist_name_ja: artist.as_ref().unwrap().display_name_jp.clone(),
                        product_title: related_products
                            .iter()
                            .map(|p| p.title.clone())
                            .collect::<Vec<String>>()
                            .join(","),
                    }
                })
                .collect();
        }

        // inputにisrcかタイトルもしくは両方が含まれている場合は、isrcで取得してリスト構築
        let tracks: Vec<Track> = self
            .tracks_repo
            .search(SearchTracksOptions {
                isrc: input.isrc,
                track_title: input.track_title,
            })
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        let mapping_from_query: Vec<ProductTrack> = self
            .product_track_repo
            .get_by_isrcs(tracks.iter().map(|t| t.isrc.clone()).collect())
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        let products: Vec<Product> = self
            .products_repo
            .get_by_upcs(mapping_from_query.iter().map(|m| m.upc.clone()).collect())
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        let isrc_to_products: HashMap<String, Vec<&Product>> = mapping_from_query
            .iter()
            .filter_map(|m| {
                let product = products.iter().find(|p| p.upc == m.upc);
                product.map(|p| (m.isrc.clone(), p))
            })
            .fold(HashMap::new(), |mut acc, (isrc, product)| {
                acc.entry(isrc).or_insert_with(Vec::new).push(product);
                acc
            });

        let mut res_from_isrc: Vec<SearchTracksOutput> = Vec::new();
        for t in tracks.iter() {
            let related_products = isrc_to_products.get(&t.isrc).unwrap();
            if let Some(first_product) = related_products.first() {
                if let Some(artist_id) = &first_product.artist_id {
                    let artist = self
                        .artists_repo
                        .find_by_id(artist_id)
                        .await
                        .map_err(|e| anyhow::anyhow!(e))?;
                    if let Some(artist) = artist {
                        res_from_isrc.push(SearchTracksOutput {
                            isrc: t.isrc.clone(),
                            title: t.title.clone(),
                            artist_id: artist_id.clone(),
                            artist_name_ja: artist.display_name_jp.clone(),
                            product_title: related_products
                                .iter()
                                .map(|p| p.title.clone())
                                .collect::<Vec<String>>()
                                .join(","),
                        });
                    }
                }
            }
        }

        // 両方のリストが存在する場合は、共通のISRCを持つ結果のみを返す
        let final_results = if !res_from_artist_id.is_empty() && !res_from_isrc.is_empty() {
            res_from_isrc
                .into_iter()
                .filter(|isrc_result| {
                    res_from_artist_id
                        .iter()
                        .any(|artist_result| artist_result.isrc == isrc_result.isrc)
                })
                .collect()
        } else if !res_from_artist_id.is_empty() {
            res_from_artist_id
        } else {
            res_from_isrc
        };

        Ok(final_results)
    }

    async fn search_products(
        &self,
        input: SearchProductsInput,
    ) -> Result<Vec<SearchProductsOutput>, anyhow::Error> {
        let mut res_from_artist_id: Vec<SearchProductsOutput> = Vec::new();
        if let Some(artist_id) = input.artist_id {
            let artist = self
                .artists_repo
                .find_by_id(&artist_id)
                .await
                .map_err(|e| anyhow::anyhow!(e))?;
            if let Some(artist) = artist {
                let products: Vec<Product> = self
                    .products_repo
                    .find_by_artist_id(&artist_id)
                    .await
                    .map_err(|e| anyhow::anyhow!(e))?;

                // 各プロダクトに対応するトラック数を取得
                for product in products {
                    let track_count: i32 = self
                        .product_track_repo
                        .get_by_upc(&product.upc)
                        .await
                        .map_err(|e| anyhow::anyhow!(e))?
                        .len() as i32;

                    res_from_artist_id.push(SearchProductsOutput {
                        upc: product.upc,
                        title: product.title,
                        img_url: product.img_url,
                        product_type: product.r#type,
                        distributed_at: product.distributed_at,
                        artist_id: artist_id.clone(),
                        artist_name_ja: artist.display_name_jp.clone(),
                        number_of_tracks: track_count,
                    });
                }
            }
        }

        let mut res_from_upc: Vec<SearchProductsOutput> = Vec::new();
        let products: Vec<Product> = self
            .products_repo
            .search(SearchProductsOptions {
                upc: input.upc,
                product_title: input.product_title,
                product_type: input.product_type,
            })
            .await
            .map_err(|e| anyhow::anyhow!(e))?;

        for product in products.iter() {
            if let Some(artist_id) = product.artist_id.clone() {
                let artist = self
                    .artists_repo
                    .find_by_id(&artist_id)
                    .await
                    .map_err(|e| anyhow::anyhow!(e))?;

                // プロダクトに紐づくトラック数を取得
                let track_count = self
                    .product_track_repo
                    .get_by_upc(&product.upc)
                    .await
                    .map_err(|e| anyhow::anyhow!(e))?
                    .len() as i32;

                res_from_upc.push(SearchProductsOutput {
                    upc: product.upc.clone(),
                    title: product.title.clone(),
                    img_url: product.img_url.clone(),
                    product_type: product.r#type.clone(),
                    distributed_at: product.distributed_at.clone(),
                    artist_id: artist_id.clone(),
                    artist_name_ja: artist.as_ref().unwrap().display_name_jp.clone(),
                    number_of_tracks: track_count,
                });
            }
        }

        let result = if !res_from_artist_id.is_empty() && !res_from_upc.is_empty() {
            // 両方の結果がある場合、共通のUPCを持つ結果のみをフィルタリング
            res_from_upc
                .into_iter()
                .filter(|product| {
                    res_from_artist_id
                        .iter()
                        .any(|artist_result| artist_result.upc == product.upc)
                })
                .collect()
        } else if !res_from_artist_id.is_empty() {
            res_from_artist_id
        } else {
            res_from_upc
        };

        Ok(result)
    }

    async fn update_track(&self, input: UpdateTrackInput) -> Result<Track, anyhow::Error> {
        let update_track = TrackActiveModel {
            isrc: ActiveValue::Set(input.isrc),
            title: match input.title {
                Some(title) => ActiveValue::Set(title),
                None => ActiveValue::NotSet,
            },
            ..Default::default()
        };
        let track: Track = self
            .tracks_repo
            .update(update_track)
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        Ok(track)
    }

    async fn update_product(&self, input: UpdateProductInput) -> Result<Product, anyhow::Error> {
        let update_product: ProductActiveModel = ProductActiveModel {
            upc: ActiveValue::Set(input.upc),
            title: match input.title {
                Some(title) => ActiveValue::Set(title),
                None => ActiveValue::NotSet,
            },
            img_url: match input.img_url {
                Some(url) => ActiveValue::Set(Some(url)),
                None => ActiveValue::NotSet,
            },
            r#type: match input.r#type {
                Some(type_val) => ActiveValue::Set(Some(type_val)),
                None => ActiveValue::NotSet,
            },
            distributed_at: match input.distributed_at {
                Some(date) => ActiveValue::Set(Some(date)),
                None => ActiveValue::NotSet,
            },
            artist_id: match input.artist_id {
                Some(id) => ActiveValue::Set(Some(id)),
                None => ActiveValue::NotSet,
            },
            ..Default::default()
        };
        let product = self
            .products_repo
            .update(update_product)
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        Ok(product)
    }

    async fn delete_track(&self, isrc: String) -> Result<bool, anyhow::Error> {
        let (
            product_track_result,
            track_credits_result,
            plays_daily_result,
            plays_monthly_result,
            plays_yearly_result,
        ) = join!(
            self.product_track_repo.delete_by_isrc(&isrc),
            self.track_credits_repo.delete_by_isrc(&isrc),
            self.plays_daily_repo.delete_by_isrc(&isrc),
            self.plays_monthly_repo.delete_by_isrc(&isrc),
            self.plays_yearly_repo.delete_by_isrc(&isrc)
        );
        product_track_result.map_err(|e| anyhow::anyhow!(e))?;
        track_credits_result.map_err(|e| anyhow::anyhow!(e))?;
        plays_daily_result.map_err(|e| anyhow::anyhow!(e))?;
        plays_monthly_result.map_err(|e| anyhow::anyhow!(e))?;
        plays_yearly_result.map_err(|e| anyhow::anyhow!(e))?;

        self.tracks_repo
            .delete(&isrc)
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        Ok(true)
    }

    async fn delete_product(&self, upc: String) -> Result<bool, anyhow::Error> {
        self.product_track_repo
            .delete_by_upc(&upc)
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        self.products_repo
            .delete(&upc)
            .await
            .map_err(|e| anyhow::anyhow!(e))?;
        Ok(true)
    }
}
