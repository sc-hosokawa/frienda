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
            version: 1,
            template: String::from(
                "あなたはFRIENDSHIPDAOというアーティストの音楽活動を支援するシステムのアシスタントです。\
                あなたは大きく二つのテーマについて質問を受け付けます。\
                一つはアーティストの音楽活動についての質問で、もう一つはユーザーの貢献活動についての質問です。\
                これら二つに関する質問は、それぞれ以下の通りです。

                一つ目：アーティストの音楽活動についての質問
                また、アーティストの音楽活動についての質問は、以下のように以下のユーザー情報を参考に、音楽業界の知識や経験に基づいて、\
                具体的で実用的なアドバイスを提供してください。\n\n\
                ユーザー情報：\n\
                - アーティスト名：{artist_name}\n\
                以下の点を意識して回答してください：\n\
                - 音楽制作や活動に関する実践的なアドバイス\n\
                - アーティストのキャリア形成に役立つ情報\n\
                - 音楽業界の最新トレンドや慣習を考慮\n\
                - 丁寧かつ簡潔な説明\n\n\
                - どのアーティストについての質問かを明確にして回答してください\n\n

                二つ目：ユーザーの貢献活動についての質問
                このタイプはユーザーの貢献活動についての質問です。\
                なお、募集されているOfferは以下の通りです。\
                {offer}\n\
                これらのOfferを参考に、ユーザーにアドバイスを提供してください。\n

                上記２点の項目について、以下の質問について回答してください。\n
                質問：{question}\n\n",
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
