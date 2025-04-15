use anyhow::anyhow;
use application::services::request_llm::LlmServiceTrait;
use async_trait::async_trait;
use domain::services::llm::{Answer, Question};
use google_generative_ai_rs::v1::{
    api::Client,
    gemini::Model::Gemini2_0Flash,
    gemini::{request::Request, Content, Part, Role},
};
use std::env;

pub struct GeminiService {
    client: Client,
}

impl GeminiService {
    pub fn new() -> Result<Self, anyhow::Error> {
        tracing::info!("Setting up GeminiService...");
        let api_key = env::var("GEMINI_API_KEY").map_err(|_| anyhow!("GEMINI_API_KEY not set"))?;
        let client = Client::new_from_model(Gemini2_0Flash, api_key);
        Ok(Self { client })
    }
}

#[async_trait]
impl LlmServiceTrait for GeminiService {
    async fn ask_question(&self, question: Question) -> Result<Answer, anyhow::Error> {
        let txt_request = Request {
            contents: vec![Content {
                role: Role::User,
                parts: vec![Part {
                    text: Some(question.text),
                    inline_data: None,
                    file_data: None,
                    video_metadata: None,
                }],
            }],
            tools: vec![],
            safety_settings: vec![],
            generation_config: None,
            system_instruction: None,
        };

        let response = self.client.post(30, &txt_request).await?;
        let text = response
            .rest()
            .ok_or_else(|| anyhow!("Failed to get response"))?
            .candidates
            .first()
            .ok_or_else(|| anyhow!("No candidates found"))?
            .content
            .parts
            .first()
            .ok_or_else(|| anyhow!("No parts found"))?
            .text
            .clone()
            .ok_or_else(|| anyhow!("No text found"))?;

        Ok(Answer { text })
    }
}
