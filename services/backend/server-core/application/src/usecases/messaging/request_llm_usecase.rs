use async_trait::async_trait;
use std::sync::Arc;

use crate::services::request_llm::LlmServiceTrait;
use domain::services::llm::{Answer, Question};

use domain::entities::users::Model as User;
use domain::repositories::users_repo::UsersRepository;

pub struct RequestLlmInput {
    pub user_id: String,
    pub question: String,
}

pub struct RequestLlmOutput {
    pub answer: String,
}

#[async_trait]
pub trait RequestLlmUsecaseTrait: Send + Sync {
    async fn request_llm(&self, input: RequestLlmInput) -> Result<RequestLlmOutput, anyhow::Error>;
}

pub struct RequestLlmUsecase {
    llm_service: Arc<dyn LlmServiceTrait>,
    users_repo: Arc<dyn UsersRepository>,
}

impl RequestLlmUsecase {
    pub fn new(
        llm_service: Arc<dyn LlmServiceTrait>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            llm_service,
            users_repo,
        }
    }
}

#[async_trait]
impl RequestLlmUsecaseTrait for RequestLlmUsecase {
    async fn request_llm(&self, input: RequestLlmInput) -> Result<RequestLlmOutput, anyhow::Error> {
        let user: User = self
            .users_repo
            .find_by_id(&input.user_id)
            .await?
            .ok_or(anyhow::anyhow!("User not found"))?;
        tracing::info!("user interactied with llm: {:?}", user.id);
        let question: Question = Question {
            text: input.question,
        };
        let answer: Answer = self.llm_service.ask_question(question).await?;
        Ok(RequestLlmOutput {
            answer: answer.text,
        })
    }
}
