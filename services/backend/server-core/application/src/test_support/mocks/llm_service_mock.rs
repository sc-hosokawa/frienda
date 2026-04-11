use crate::services::request_llm::LlmServiceTrait;
use async_trait::async_trait;
use domain::services::llm::{Answer, Question};
use mockall::automock;

#[automock]
#[async_trait]
pub trait MockLlmService {
    async fn mock_ask_question(&self, question: Question) -> Result<Answer, anyhow::Error>;
}

#[async_trait]
impl LlmServiceTrait for MockMockLlmService {
    async fn ask_question(&self, question: Question) -> Result<Answer, anyhow::Error> {
        self.mock_ask_question(question).await
    }
}
