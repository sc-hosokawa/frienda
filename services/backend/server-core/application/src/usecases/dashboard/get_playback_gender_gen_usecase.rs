use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::gender_gen_playback::Model as GenderGenPlayback;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Products;
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;

// Input and Output
pub struct GetPlaybackGenderGenUsecaseInput {
    pub artist_id: String,
    pub user_id: String,
    pub isrc: Option<String>,
    pub upc: Option<String>,
}

pub struct GetPlaybackGenderGenUsecaseOutput {
    pub gender_rate: GenderPlaybackRate,
    pub gen_rate: GenPlaybackRate,
}
pub struct GenderPlaybackRate {
    pub male_count: i32,
    pub female_count: i32,
}
pub struct GenPlaybackRate {
    pub under_14: i32,
    pub _15_19: i32,
    pub _20_24: i32,
    pub _25_29: i32,
    pub _30_34: i32,
    pub _35_39: i32,
    pub _40_44: i32,
    pub _45_49: i32,
    pub _50_over: i32,
}

// Trait
#[async_trait]
pub trait GetPlaybackGenderGenUsecaseTrait: Send + Sync {
    async fn get_playback_gender_gen(
        &self,
        input: GetPlaybackGenderGenUsecaseInput,
    ) -> Result<GetPlaybackGenderGenUsecaseOutput, anyhow::Error>;
}

pub struct GetPlaybackGenderGenUsecase {
    gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    products_repo: Arc<dyn ProductsRepository>,
}

impl GetPlaybackGenderGenUsecase {
    pub fn new(
        gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        products_repo: Arc<dyn ProductsRepository>,
    ) -> Self {
        Self {
            gender_gen_playback_repo,
            product_track_repo,
            products_repo,
        }
    }
}

#[async_trait]
impl GetPlaybackGenderGenUsecaseTrait for GetPlaybackGenderGenUsecase {
    async fn get_playback_gender_gen(
        &self,
        input: GetPlaybackGenderGenUsecaseInput,
    ) -> Result<GetPlaybackGenderGenUsecaseOutput, anyhow::Error> {
        if input.upc.is_some() {
            let product_track = self
                .product_track_repo
                .get_by_upc(&input.upc.unwrap())
                .await?;
            let isrcs_in_upc: Vec<String> = product_track
                .iter()
                .map(|p| p.isrc.clone())
                .collect::<Vec<String>>();
            let gender_gen_playback_by_upc: Vec<GenderGenPlayback> = self
                .gender_gen_playback_repo
                .find_by_isrcs(isrcs_in_upc)
                .await?;

            // Gender Balance
            let male_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.gender == Some("male".to_string()))
                .map(|p| p.play_count)
                .sum();

            let female_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.gender == Some("female".to_string()))
                .map(|p| p.play_count)
                .sum();
            let total_count = male_count + female_count;

            let male_percentage: i32 = if total_count > 0 {
                (male_count as f64 / total_count as f64 * 100.0).round() as i32
            } else {
                0
            };

            let female_percentage: i32 = if total_count > 0 {
                (female_count as f64 / total_count as f64 * 100.0).round() as i32
            } else {
                0
            };

            // Generation Balance
            let under_14_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("under-14".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _15_19_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("15-19".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _20_24_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("20-24".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _25_29_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("25-29".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _30_34_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("30-34".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _35_39_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("35-39".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _40_44_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("40-44".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _45_49_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("45-49".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _50_over_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("50-over".to_string()))
                .map(|p| p.play_count)
                .sum();

            let total_gen_count: i32 = under_14_count
                + _15_19_count
                + _20_24_count
                + _25_29_count
                + _30_34_count
                + _35_39_count
                + _40_44_count
                + _45_49_count
                + _50_over_count;

            // GenPlaybackRateの更新（パーセンテージに変換）
            let gen_rate = GenPlaybackRate {
                under_14: if total_gen_count > 0 {
                    (under_14_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _15_19: if total_gen_count > 0 {
                    (_15_19_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _20_24: if total_gen_count > 0 {
                    (_20_24_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _25_29: if total_gen_count > 0 {
                    (_25_29_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _30_34: if total_gen_count > 0 {
                    (_30_34_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _35_39: if total_gen_count > 0 {
                    (_35_39_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _40_44: if total_gen_count > 0 {
                    (_40_44_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _45_49: if total_gen_count > 0 {
                    (_45_49_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _50_over: if total_gen_count > 0 {
                    (_50_over_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
            };

            Ok(GetPlaybackGenderGenUsecaseOutput {
                gender_rate: GenderPlaybackRate {
                    male_count: male_percentage,
                    female_count: female_percentage,
                },
                gen_rate,
            })
        } else {
            // アーティストの全商品を取得
            let products: Vec<Products> = self
                .products_repo
                .find_by_artist_id(&input.artist_id)
                .await?;
            // 商品のUPCを取得
            let upcs: Vec<String> = products
                .iter()
                .map(|p| p.upc.clone())
                .collect::<Vec<String>>();
            // UPCから商品トラックを取得
            let product_track_by_upcs: Vec<ProductTrack> =
                self.product_track_repo.get_by_upcs(upcs).await?;
            // 商品トラックのISRCを取得
            let isrcs_in_products: Vec<String> = product_track_by_upcs
                .iter()
                .map(|p| p.isrc.clone())
                .collect::<Vec<String>>();
            // ISRCから性別ジェンバー再生回数を取得
            let gender_gen_playback_by_artist: Vec<GenderGenPlayback> = self
                .gender_gen_playback_repo
                .find_by_isrcs(isrcs_in_products)
                .await?;
            // Gender Balance
            let male_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.gender == Some("male".to_string()))
                .map(|p| p.play_count)
                .sum();

            let female_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.gender == Some("female".to_string()))
                .map(|p| p.play_count)
                .sum();
            let total_count = male_count + female_count;

            let male_percentage: i32 = if total_count > 0 {
                (male_count as f64 / total_count as f64 * 100.0).round() as i32
            } else {
                0
            };

            let female_percentage: i32 = if total_count > 0 {
                (female_count as f64 / total_count as f64 * 100.0).round() as i32
            } else {
                0
            };

            // Generation Balance
            let under_14_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("under-14".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _15_19_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("15-19".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _20_24_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("20-24".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _25_29_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("25-29".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _30_34_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("30-34".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _35_39_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("35-39".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _40_44_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("40-44".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _45_49_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("45-49".to_string()))
                .map(|p| p.play_count)
                .sum();

            let _50_over_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("50-over".to_string()))
                .map(|p| p.play_count)
                .sum();

            let total_gen_count: i32 = under_14_count
                + _15_19_count
                + _20_24_count
                + _25_29_count
                + _30_34_count
                + _35_39_count
                + _40_44_count
                + _45_49_count
                + _50_over_count;

            // GenPlaybackRateの更新（パーセンテージに変換）
            let gen_rate = GenPlaybackRate {
                under_14: if total_gen_count > 0 {
                    (under_14_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _15_19: if total_gen_count > 0 {
                    (_15_19_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _20_24: if total_gen_count > 0 {
                    (_20_24_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _25_29: if total_gen_count > 0 {
                    (_25_29_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _30_34: if total_gen_count > 0 {
                    (_30_34_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _35_39: if total_gen_count > 0 {
                    (_35_39_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _40_44: if total_gen_count > 0 {
                    (_40_44_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _45_49: if total_gen_count > 0 {
                    (_45_49_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _50_over: if total_gen_count > 0 {
                    (_50_over_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
            };

            Ok(GetPlaybackGenderGenUsecaseOutput {
                gender_rate: GenderPlaybackRate {
                    male_count: male_percentage,
                    female_count: female_percentage,
                },
                gen_rate,
            })
        }
    }
}
