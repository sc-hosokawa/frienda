use async_trait::async_trait;
use std::sync::Arc;

use domain::repositories::prizes_repo::PrizesRepository;

//
// Define the input for the usecase
//
pub struct DeletePrizeInput {
    pub id: i32,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait DeletePrizeUsecaseTrait: Send + Sync {
    async fn delete(&self, input: DeletePrizeInput) -> Result<(), anyhow::Error>;
}

//
// Implement the usecase
//
pub struct DeletePrizeUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
}

impl DeletePrizeUsecase {
    pub fn new(prizes_repo: Arc<dyn PrizesRepository>) -> Self {
        Self { prizes_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl DeletePrizeUsecaseTrait for DeletePrizeUsecase {
    async fn delete(&self, input: DeletePrizeInput) -> Result<(), anyhow::Error> {
        self.prizes_repo.delete(input.id).await?;
        Ok(())
    }
}

#[cfg(test)]
#[path = "delete_prize_usecase_tests.rs"]
mod tests;
