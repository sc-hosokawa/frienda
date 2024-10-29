use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::prizes::Model as Prize;
use domain::repositories::prizes_repo::PrizesRepository;

//
// Define the input for the usecase
//
pub struct GetPrizeInput {
    pub id: i32,
}

pub struct GetPrizeOutput {
    pub prize: Prize,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetPrizeUsecaseTrait: Send + Sync {
    async fn get_prize(&self, input: GetPrizeInput) -> Result<GetPrizeOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetPrizeUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
}

impl GetPrizeUsecase {
    pub fn new(prizes_repo: Arc<dyn PrizesRepository>) -> Self {
        Self { prizes_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetPrizeUsecaseTrait for GetPrizeUsecase {
    async fn get_prize(&self, input: GetPrizeInput) -> Result<GetPrizeOutput, anyhow::Error> {
        let prize = self
            .prizes_repo
            .get_by_id(input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Prize not found"))?;
        Ok(GetPrizeOutput { prize })
    }
}
