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
    pub neutral_count: i32,
    pub unknown_count: i32,
}
pub struct GenPlaybackRate {
    pub under_17: i32,
    pub _18_22: i32,
    pub _23_27: i32,
    pub _28_34: i32,
    pub _35_44: i32,
    pub _45_59: i32,
    pub _60_150: i32,
    pub unknown: i32,
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
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let female_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.gender == Some("female".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let neutral_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.gender == Some("neutral".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let unknown_gender_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.gender == Some("unknown".to_string()) || p.gender.is_none())
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let total_count = male_count + female_count + neutral_count + unknown_gender_count;

            let calculate_percentage = |count: i32| -> i32 {
                if total_count > 0 {
                    (count as f64 / total_count as f64 * 100.0).round() as i32
                } else {
                    0
                }
            };

            let gender_rate = GenderPlaybackRate {
                male_count: calculate_percentage(male_count),
                female_count: calculate_percentage(female_count),
                neutral_count: calculate_percentage(neutral_count),
                unknown_count: calculate_percentage(unknown_gender_count),
            };

            // Generation Balance
            let under_17_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("0-17".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _18_22_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("18-22".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _23_27_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("23-27".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _28_34_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("28-34".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _35_44_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("35-44".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _45_59_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("45-59".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _60_150_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("60-150".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let unknown_count: i32 = gender_gen_playback_by_upc
                .iter()
                .filter(|p| p.age == Some("unknown".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let total_gen_count: i32 = under_17_count
                + _18_22_count
                + _23_27_count
                + _28_34_count
                + _35_44_count
                + _45_59_count
                + _60_150_count
                + unknown_count;

            // GenPlaybackRateの更新（パーセンテージに変換）
            let gen_rate = GenPlaybackRate {
                under_17: if total_gen_count > 0 {
                    (under_17_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _18_22: if total_gen_count > 0 {
                    (_18_22_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _23_27: if total_gen_count > 0 {
                    (_23_27_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _28_34: if total_gen_count > 0 {
                    (_28_34_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _35_44: if total_gen_count > 0 {
                    (_35_44_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _45_59: if total_gen_count > 0 {
                    (_45_59_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _60_150: if total_gen_count > 0 {
                    (_60_150_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                unknown: if total_gen_count > 0 {
                    (unknown_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
            };

            Ok(GetPlaybackGenderGenUsecaseOutput {
                gender_rate,
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
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let female_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.gender == Some("female".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let neutral_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.gender == Some("neutral".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let unknown_gender_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.gender == Some("unknown".to_string()) || p.gender.is_none())
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let total_count = male_count + female_count + neutral_count + unknown_gender_count;

            let calculate_percentage = |count: i32| -> i32 {
                if total_count > 0 {
                    (count as f64 / total_count as f64 * 100.0).round() as i32
                } else {
                    0
                }
            };

            let gender_rate = GenderPlaybackRate {
                male_count: calculate_percentage(male_count),
                female_count: calculate_percentage(female_count),
                neutral_count: calculate_percentage(neutral_count),
                unknown_count: calculate_percentage(unknown_gender_count),
            };

            // Generation Balance
            let under_17_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("under-17".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _18_22_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("18-22".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _23_27_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("23-27".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _28_34_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("28-34".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _35_44_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("35-44".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _45_59_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("45-59".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let _60_150_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("60-150".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let unknown_count: i32 = gender_gen_playback_by_artist
                .iter()
                .filter(|p| p.age == Some("unknown".to_string()))
                .filter(|p| p.play_count >= 0)
                .map(|p| p.play_count)
                .sum();

            let total_gen_count: i32 = under_17_count
                + _18_22_count
                + _23_27_count
                + _28_34_count
                + _35_44_count
                + _45_59_count
                + _60_150_count
                + unknown_count;

            // GenPlaybackRateの更新（パーセンテージに変換）
            let gen_rate = GenPlaybackRate {
                under_17: if total_gen_count > 0 {
                    (under_17_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _18_22: if total_gen_count > 0 {
                    (_18_22_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _23_27: if total_gen_count > 0 {
                    (_23_27_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _28_34: if total_gen_count > 0 {
                    (_28_34_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _35_44: if total_gen_count > 0 {
                    (_35_44_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _45_59: if total_gen_count > 0 {
                    (_45_59_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                _60_150: if total_gen_count > 0 {
                    (_60_150_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
                unknown: if total_gen_count > 0 {
                    (unknown_count as f64 / total_gen_count as f64 * 100.0).round() as i32
                } else {
                    0
                },
            };

            Ok(GetPlaybackGenderGenUsecaseOutput {
                gender_rate,
                gen_rate,
            })
        }
    }
}
