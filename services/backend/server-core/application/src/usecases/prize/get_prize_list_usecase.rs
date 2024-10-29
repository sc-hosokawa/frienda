use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::prizes::Model as Prize;
use domain::repositories::prizes_repo::PrizesRepository;

//
// Define the input for the usecase
//
pub struct GetPrizeListInput {
    pub limit: u32,
    pub offset: u32,
}

pub struct GetPrizeListOutput {
    pub prizes: Vec<Prize>,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetPrizeListUsecaseTrait: Send + Sync {
    async fn get_prize_list(
        &self,
        input: GetPrizeListInput,
    ) -> Result<GetPrizeListOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetPrizeListUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
}

impl GetPrizeListUsecase {
    pub fn new(prizes_repo: Arc<dyn PrizesRepository>) -> Self {
        Self { prizes_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetPrizeListUsecaseTrait for GetPrizeListUsecase {
    async fn get_prize_list(
        &self,
        input: GetPrizeListInput,
    ) -> Result<GetPrizeListOutput, anyhow::Error> {
        let prizes = self.prizes_repo.list(input.limit, input.offset).await?;
        Ok(GetPrizeListOutput { prizes })
    }
}
