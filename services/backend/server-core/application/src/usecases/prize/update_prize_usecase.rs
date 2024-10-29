use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::prizes::ActiveModel as PrizeActiveModel;
use domain::repositories::prizes_repo::PrizesRepository;

//
// Define the input for the usecase
//
pub struct UpdatePrizeInput {
    pub id: i32,
    pub name: Option<String>,
    pub point: Option<i32>,
    pub description: Option<String>,
    pub representation: Option<String>,
    pub condition: Option<String>,
    pub img_url: Option<String>,
    pub publicity: Option<bool>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait UpdatePrizeUsecaseTrait: Send + Sync {
    async fn update(&self, input: UpdatePrizeInput) -> Result<i32, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct UpdatePrizeUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
}

impl UpdatePrizeUsecase {
    pub fn new(prizes_repo: Arc<dyn PrizesRepository>) -> Self {
        Self { prizes_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl UpdatePrizeUsecaseTrait for UpdatePrizeUsecase {
    async fn update(&self, input: UpdatePrizeInput) -> Result<i32, anyhow::Error> {
        let prize = self
            .prizes_repo
            .get_by_id(input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Prize not found"))?;

        let mut updated_prize: PrizeActiveModel = prize.into();

        if let Some(name) = input.name {
            updated_prize.name = ActiveValue::Set(name);
        }
        if let Some(point) = input.point {
            updated_prize.point = ActiveValue::Set(point);
        }
        if let Some(description) = input.description {
            updated_prize.description = ActiveValue::Set(description);
        }
        if let Some(representation) = input.representation {
            updated_prize.representation = ActiveValue::Set(representation);
        }
        if let Some(condition) = input.condition {
            updated_prize.condition = ActiveValue::Set(Some(condition));
        }
        if let Some(img_url) = input.img_url {
            updated_prize.img_url = ActiveValue::Set(Some(img_url));
        }
        if let Some(publicity) = input.publicity {
            updated_prize.publicity = ActiveValue::Set(publicity);
        }

        let res = self.prizes_repo.update(updated_prize).await?;

        Ok(res.id)
    }
}
