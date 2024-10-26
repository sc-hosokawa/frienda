use async_trait::async_trait;
use domain::repositories::offers_repo::OffersRepository;
use std::sync::Arc;


//
// Define the input for the usecase
//
pub struct RegisterTaskInput {
    pub task_id: Uuid,
    pub user_id: Uuid,
}

//
#[async_trait]
pub trait RegisterTaskUseCase: Send + Sync {
    async fn register_task(&self, input: RegisterTaskInput) -> Result<(), DomainError>;
}
