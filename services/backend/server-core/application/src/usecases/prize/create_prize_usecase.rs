use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::prizes::ActiveModel as PrizeActiveModel;
use domain::repositories::prizes_repo::PrizesRepository;

//
// Define the input for the usecase
//
pub struct CreatePrizeInput {
    pub name: String,
    pub point: i32,
    pub description: String,
    pub representation: String,
    pub condition: Option<String>,
    pub img_url: Option<String>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait CreatePrizeUsecaseTrait: Send + Sync {
    async fn create(&self, input: CreatePrizeInput) -> Result<(), anyhow::Error>;
}

//
// Implement the usecase
//
pub struct CreatePrizeUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
}

impl CreatePrizeUsecase {
    pub fn new(prizes_repo: Arc<dyn PrizesRepository>) -> Self {
        Self { prizes_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl CreatePrizeUsecaseTrait for CreatePrizeUsecase {
    async fn create(&self, input: CreatePrizeInput) -> Result<(), anyhow::Error> {
        let prize: PrizeActiveModel = PrizeActiveModel {
            name: ActiveValue::Set(input.name),
            ..Default::default()
        };
        self.prizes_repo.create(prize).await?;
        Ok(())
    }
}
