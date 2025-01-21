use async_trait::async_trait;
use std::sync::Arc;

use crate::services::request_llm::LlmServiceTrait;
use domain::services::llm::{Answer, Question};

use domain::entities::artists::Model as Artist;
use domain::entities::offers::Model as Offer;
use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::tracks::Model as Track;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::product_track_repo::ProductTrackRepository;
use domain::repositories::products_repo::ProductsRepository;
use domain::repositories::tracks_repo::TracksRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct RequestLlmInput {
    pub user_id: String,
    pub question: String,
}

pub struct RequestLlmOutput {
    pub answer: String,
}

struct ReleaseDataForTemplate {
    artist_name: String,
    track_title: String,
    last_6_month_play_count_history: Vec<MonthlyPlayCountHistory>,
    last_7_day_play_count_history: Vec<DailyPlayCountHistory>,
}

struct MonthlyPlayCountHistory {
    month: String,
    sum: i32,
}

struct DailyPlayCountHistory {
    date: String,
    sum: i32,
}

struct QuestionTemplate {
    version: i32,
    template: String,
}

impl QuestionTemplate {
    fn new() -> Self {
        Self {
            version: 3,
            template: String::from(
                "あなたはFRIENDSHIPDAOというアーティストの音楽活動を支援するシステムの専門アシスタントです。\
                以下の情報に基づいて、具体的で実用的な回答を提供してください。\n\n\
                【基本情報】\n\
                - 対象アーティスト：{artist_name}\n\
                - 現在募集中のオファー：\n{offer}\n\n\
                【対象アーティストの楽曲再生数データ】\n\
                {release_data}\n\n\
                【回答の制約事項】\n\
                1. 必ず与えられた情報の範囲内で回答してください\n\
                2. 具体的な数値や例を含めて説明してください\n\
                3. 一つの回答は3-5文程度で簡潔にまとめてください\n\
                4. 思い込みや推測による回答は避けてください\n\n\
                5. 対象となるアーティストは全て日本のアーティストです\n\n\
                6. 再生数はSpotify、Apple Music、LINE Music、Amazon Music、YouTube Musicの再生数の合計です\n\n\
                7. 存在しないオファーや楽曲について回答を行わないでください\n\n\
                8. 具体的なアーティスト名が質問にない場合は、それを踏まえて同じ質問をするように回答してください。\n\n\
                9, 音楽に関する質問に対しては最近の音楽業界の動向と与えられたデータを合わせて検討し回答してください。\n\n\
                10. ハルシネーションをしないようにしてください。\n\n\
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

    fn format(
        &self,
        question: &str,
        artists: Vec<Artist>,
        offers: Vec<Offer>,
        release_data: Vec<ReleaseDataForTemplate>,
    ) -> String {
        let release_data_str = release_data
            .iter()
            .map(|data| {
                format!(
                    "{}の楽曲「{}」の再生数推移データ:（過去6ヶ月: {}）",
                    data.artist_name,
                    data.track_title,
                    format_monthly_play_count_history(&data.last_6_month_play_count_history),
                )
            })
            .collect::<Vec<String>>()
            .join("\n\n");

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
            .replace("{release_data}", &release_data_str)
    }
}

fn format_monthly_play_count_history(history: &[MonthlyPlayCountHistory]) -> String {
    history
        .iter()
        .map(|h| format!("{}月:{}回", h.month, h.sum))
        .collect::<Vec<String>>()
        .join("、")
}

fn format_daily_play_count_history(history: &[DailyPlayCountHistory]) -> String {
    history
        .iter()
        .map(|h| format!("{}:{}", h.date, h.sum))
        .collect::<Vec<String>>()
        .join("、")
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
    plays_daily_repo: Arc<dyn PlaysDailyRepository>,
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    products_repo: Arc<dyn ProductsRepository>,
    product_track_repo: Arc<dyn ProductTrackRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
}

impl RequestLlmUsecase {
    pub fn new(
        llm_service: Arc<dyn LlmServiceTrait>,
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        user_artist_repo: Arc<dyn UserArtistRepository>,
        offers_repo: Arc<dyn OffersRepository>,
        plays_daily_repo: Arc<dyn PlaysDailyRepository>,
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
        products_repo: Arc<dyn ProductsRepository>,
        product_track_repo: Arc<dyn ProductTrackRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
    ) -> Self {
        Self {
            llm_service,
            users_repo,
            artists_repo,
            user_artist_repo,
            template: QuestionTemplate::new(),
            offers_repo,
            plays_daily_repo,
            plays_monthly_repo,
            products_repo,
            product_track_repo,
            tracks_repo,
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

        let mut release_data_list = Vec::new();

        // Get release data for template
        for artist in artist_id {
            let products: Vec<Product> = self.products_repo.find_by_artist_id(&artist).await?;
            let product_tracks: Vec<ProductTrack> = self
                .product_track_repo
                .get_by_upcs(
                    products
                        .iter()
                        .map(|p| p.upc.clone())
                        .collect::<Vec<String>>(),
                )
                .await?;
            let tracks: Vec<Track> = self
                .tracks_repo
                .get_by_isrcs(
                    product_tracks
                        .iter()
                        .map(|p| p.isrc.clone())
                        .collect::<Vec<String>>(),
                )
                .await?;

            for track in tracks {
                let plays_daily: Vec<PlaysDaily> = self
                    .plays_daily_repo
                    .find_by_isrc_and_period(&track.isrc, 7)
                    .await?;
                println!("plays_daily: {:?}", plays_daily);
                let plays_monthly: Vec<PlaysMonthly> = self
                    .plays_monthly_repo
                    .find_by_isrc_and_period(&track.isrc, 6)
                    .await?;
                println!("plays_monthly: {:?}", plays_monthly);

                let monthly_history: Vec<MonthlyPlayCountHistory> = plays_monthly
                    .iter()
                    .map(|pm| MonthlyPlayCountHistory {
                        month: pm.month.unwrap().format("%Y-%m").to_string(),
                        sum: pm.spotify + pm.apple + pm.line + pm.amazon + pm.youtube,
                    })
                    .filter(|h| h.sum > 0)
                    .collect();

                let daily_history: Vec<DailyPlayCountHistory> = plays_daily
                    .iter()
                    .map(|pd| DailyPlayCountHistory {
                        date: pd.date.unwrap().format("%Y-%m-%d").to_string(),
                        sum: pd.spotify + pd.apple + pd.line,
                    })
                    .filter(|h| h.sum > 0)
                    .collect();

                if !monthly_history.is_empty() || !daily_history.is_empty() {
                    release_data_list.push(ReleaseDataForTemplate {
                        artist_name: artists
                            .iter()
                            .find(|a| a.artist_id == artist)
                            .map_or(String::new(), |a| a.display_name_jp.clone()),
                        track_title: track.title,
                        last_6_month_play_count_history: monthly_history,
                        last_7_day_play_count_history: daily_history,
                    });
                }
            }
        }

        let formatted_question: String =
            self.template
                .format(&input.question, artists, offers, release_data_list);

        tracing::info!("formatted_question: {:?}", formatted_question);

        let question: Question = Question {
            text: formatted_question,
        };

        let answer: Answer = self.llm_service.ask_question(question).await?;

        Ok(RequestLlmOutput {
            answer: answer.text,
        })
    }
}
