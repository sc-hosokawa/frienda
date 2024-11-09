use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;

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
}

impl GetPlaybackGenderGenUsecase {
    pub fn new(gender_gen_playback_repo: Arc<dyn GenderGenPlaybackRepository>) -> Self {
        Self {
            gender_gen_playback_repo,
        }
    }
}

#[async_trait]
impl GetPlaybackGenderGenUsecaseTrait for GetPlaybackGenderGenUsecase {
    async fn get_playback_gender_gen(
        &self,
        input: GetPlaybackGenderGenUsecaseInput,
    ) -> Result<GetPlaybackGenderGenUsecaseOutput, anyhow::Error> {
        Ok(GetPlaybackGenderGenUsecaseOutput {
            gender_rate: GenderPlaybackRate {
                male_count: 0,
                female_count: 0,
            },
            gen_rate: GenPlaybackRate {
                under_14: 0,
                _15_19: 0,
                _20_24: 0,
                _25_29: 0,
                _30_34: 0,
                _35_39: 0,
                _40_44: 0,
                _45_49: 0,
                _50_over: 0,
            },
        })
    }
}
