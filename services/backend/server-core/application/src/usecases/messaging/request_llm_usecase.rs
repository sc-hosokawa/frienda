use async_trait::async_trait;
use std::sync::Arc;

use crate::services::request_llm::LlmServiceTrait;
use domain::services::llm::{Answer, Question};

use domain::entities::artists::Model as Artist;
use domain::entities::offers::Model as Offer;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct RequestLlmInput {
    pub user_id: String,
    pub question: String,
}

pub struct RequestLlmOutput {
    pub answer: String,
}

struct QuestionTemplate {
    version: i32,
    template: String,
}

impl QuestionTemplate {
    fn new() -> Self {
        Self {
            version: 2,
            template: String::from(
                "あなたはFRIENDSHIPDAOというアーティストの音楽活動を支援するシステムの専門アシスタントです。\
                以下の情報に基づいて、具体的で実用的な回答を提供してください。\n\n\
                【基本情報】\n\
                - 対象アーティスト：{artist_name}\n\
                - 現在募集中のオファー：\n{offer}\n\n\
                【回答の制約事項】\n\
                1. 必ず与えられた情報の範囲内で回答してください\n\
                2. 具体的な数値や例を含めて説明してください\n\
                3. 一つの回答は3-5文程度で簡潔にまとめてください\n\
                4. 思い込みや推測による回答は避けてください\n\n\
                【質問のカテゴリ】\n\
                A) アーティスト活動に関する質問の場合：\n\
                   - 音楽制作・活動に関する具体的なアドバイス\n\
                   - キャリア形成のための実践的なステップ\n\
                   - 現在の音楽業界のトレンドを踏まえた提案\n\n\
                B) ユーザーの貢献活動に関する質問の場合：\n\
                   - 募集中のオファーに基づいた具体的なアドバイス\n\
                   - 貢献可能な方法の提案\n\
                   - 期待される成果の明確な説明\n\n\
                【ユーザーからの質問】\n\
                {question}\n\n\
                ",
            ),
        }
    }

    fn format(&self, question: &str, artists: Vec<Artist>, offers: Vec<Offer>) -> String {
        self.template
            .replace("{question}", question)
            .replace(
                "{artist_name}",
                &artists
                    .iter()
                    .map(|a| a.display_name_jp.as_str())
                    .collect::<Vec<&str>>()
                    .join(", "),
            )
            .replace(
                "{offer}",
                &offers
                    .iter()
                    .map(|o| format!("{}: {}({})", o.title, o.description, o.place))
                    .collect::<Vec<String>>()
                    .join(", "),
            )
    }
}

#[async_trait]
pub trait RequestLlmUsecaseTrait: Send + Sync {
    async fn request_llm(&self, input: RequestLlmInput) -> Result<RequestLlmOutput, anyhow::Error>;
}

pub struct RequestLlmUsecase {
    llm_service: Arc<dyn LlmServiceTrait>,
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    user_artist_repo: Arc<dyn UserArtistRepository>,
    template: QuestionTemplate,
    offers_repo: Arc<dyn OffersRepository>,
}

impl RequestLlmUsecase {
    pub fn new(
        llm_service: Arc<dyn LlmServiceTrait>,
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        user_artist_repo: Arc<dyn UserArtistRepository>,
        offers_repo: Arc<dyn OffersRepository>,
    ) -> Self {
        Self {
            llm_service,
            users_repo,
            artists_repo,
            user_artist_repo,
            template: QuestionTemplate::new(),
            offers_repo,
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

        tracing::info!("template version: {:?}", self.template.version);
        tracing::info!("user interacted with llm: {:?}", user.id);

        // Get artists related to the user
        let belonging_artist: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_user_id(&input.user_id)
            .await?;
        let artist_id: Vec<String> = belonging_artist
            .iter()
            .map(|ua| ua.artist_id.clone())
            .collect::<Vec<String>>();
        let artists: Vec<Artist> = self
            .artists_repo
            .find_by_ids(
                artist_id
                    .iter()
                    .map(|id| id.as_str())
                    .collect::<Vec<&str>>(),
            )
            .await?;

        let offers: Vec<Offer> = self
            .offers_repo
            .get_active_offers()
            .await?
            .into_iter()
            .filter(|offer| offer.owner != user.id)
            .take(10)
            .collect::<Vec<Offer>>();

        let formatted_question = self.template.format(&input.question, artists, offers);

        let question: Question = Question {
            text: formatted_question,
        };

        let answer: Answer = self.llm_service.ask_question(question).await?;

        Ok(RequestLlmOutput {
            answer: answer.text,
        })
    }
}
