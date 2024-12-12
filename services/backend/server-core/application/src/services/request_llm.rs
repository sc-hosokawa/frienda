use async_trait::async_trait;
use std::sync::Arc;

use domain::services::llm::{Answer, Question};

#[async_trait]
pub trait LlmServiceTrait: Send + Sync {
    async fn ask_question(&self, question: Question) -> Result<Answer, anyhow::Error>;
}

pub struct LlmService {
    llm_service: Arc<dyn LlmServiceTrait>,
}

impl LlmService {
    pub fn new(llm_service: Arc<dyn LlmServiceTrait>) -> Self {
        Self { llm_service }
    }
}

#[async_trait]
impl LlmServiceTrait for LlmService {
    async fn ask_question(&self, question: Question) -> Result<Answer, anyhow::Error> {
        self.llm_service.ask_question(question).await
    }
}
