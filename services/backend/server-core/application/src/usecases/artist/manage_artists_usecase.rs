use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use shared::error::domain_err::DomainError;

use domain::entities::artists::{ActiveModel as ArtistActiveModel, Model as Artist};
use domain::entities::sea_orm_active_enums::ArtistStatus;
use domain::repositories::artists_repo::ArtistsRepository;

pub struct AddArtistsInput {
    pub artists: Vec<AddArtistInput>,
}

pub struct AddArtistInput {
    pub display_name_jp: String,
    pub display_name_en: String,
    pub display_name_kana: Option<String>,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: String,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

pub struct AddArtistsResponse {
    pub added_artists: Vec<ArtistRes>,
}

pub struct ArtistRes {
    pub artist_id: String,
    pub display_name_jp: String,
}

pub struct UpdateArtistsInput {
    pub artist_id: String,
    pub display_name_jp: Option<String>,
    pub display_name_en: Option<String>,
    pub display_name_kana: Option<String>,
    pub img_url: Option<String>,
    pub fsp: Option<i32>,
    pub status: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

#[async_trait]
pub trait ManageArtistsUsecaseTrait: Send + Sync {
    async fn add_artists(&self, input: AddArtistsInput) -> Result<AddArtistsResponse, DomainError>;
    async fn update_artists(&self, input: UpdateArtistsInput) -> Result<String, DomainError>;
}

pub struct ManageArtistsUsecase {
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl ManageArtistsUsecase {
    pub fn new(artists_repo: Arc<dyn ArtistsRepository>) -> Self {
        Self { artists_repo }
    }
}

#[async_trait]
impl ManageArtistsUsecaseTrait for ManageArtistsUsecase {
    async fn add_artists(&self, input: AddArtistsInput) -> Result<AddArtistsResponse, DomainError> {
        let latest_artist: Option<Artist> = self.artists_repo.find_latest().await?;
        tracing::info!("latest_artist: {:?}", latest_artist);

        let mut current_sequence = match latest_artist {
            Some(artist) => {
                let num_str = artist.artist_id.split('_').last().unwrap_or("0");
                num_str.parse::<u64>().unwrap_or(0) + 1
            }
            None => 1,
        };
        tracing::info!("current_sequence: {:?}", current_sequence);

        let mut artists: Vec<ArtistRes> = Vec::new();

        for artist in input.artists {
            let new_artist_id: String = format!("artist_00_{:0>15}", current_sequence);

            let artist_model: ArtistActiveModel = ArtistActiveModel {
                artist_id: ActiveValue::Set(new_artist_id.clone()),
                display_name_jp: ActiveValue::Set(artist.display_name_jp.clone()),
                display_name_en: ActiveValue::Set(artist.display_name_en.clone()),
                display_name_kana: ActiveValue::Set(artist.display_name_kana.clone()),
                img_url: ActiveValue::Set(artist.img_url.clone()),
                fsp: ActiveValue::Set(artist.fsp),
                status: ActiveValue::Set(match artist.status.to_lowercase().as_str() {
                    "hidden" => ArtistStatus::Hidden,
                    "visible" => ArtistStatus::Visible,
                    "unknown" => ArtistStatus::Unknown,
                    _ => ArtistStatus::Visible,
                }),
                universal_id: ActiveValue::Set(artist.universal_id.clone()),
                apple_key: ActiveValue::Set(artist.apple_key.clone()),
                spotify_key: ActiveValue::Set(artist.spotify_key.clone()),
                line_key: ActiveValue::Set(artist.line_key.clone()),
                amazon_key: ActiveValue::Set(artist.amazon_key.clone()),
                youtube_key: ActiveValue::Set(artist.youtube_key.clone()),
                ..Default::default()
            };

            self.artists_repo.create(artist_model).await?;

            current_sequence += 1;

            artists.push(ArtistRes {
                artist_id: new_artist_id.clone(),
                display_name_jp: artist.display_name_jp.clone(),
            });

            tracing::info!(
                "Added artist: {:?}({})",
                artist.display_name_jp,
                new_artist_id
            );
        }

        Ok(AddArtistsResponse {
            added_artists: artists,
        })
    }

    async fn update_artists(&self, input: UpdateArtistsInput) -> Result<String, DomainError> {
        let artist: Option<Artist> = self.artists_repo.find_by_id(&input.artist_id).await?;

        if let Some(artist) = artist {
            let artist_model: ArtistActiveModel = ArtistActiveModel {
                id: ActiveValue::Set(artist.id),
                artist_id: ActiveValue::Set(artist.artist_id.clone()),
                display_name_jp: ActiveValue::Set(
                    input
                        .display_name_jp
                        .unwrap_or(artist.display_name_jp.clone()),
                ),
                display_name_en: ActiveValue::Set(
                    input
                        .display_name_en
                        .unwrap_or(artist.display_name_en.clone()),
                ),
                display_name_kana: ActiveValue::Set(input.display_name_kana),
                img_url: ActiveValue::Set(input.img_url),
                fsp: ActiveValue::Set(input.fsp.unwrap_or(artist.fsp)),
                status: ActiveValue::Set(
                    match input.status.as_ref().map(|s| s.to_lowercase()).as_deref() {
                        Some("hidden") => ArtistStatus::Hidden,
                        Some("visible") => ArtistStatus::Visible,
                        Some("unknown") => ArtistStatus::Unknown,
                        _ => ArtistStatus::Visible,
                    },
                ),
                universal_id: ActiveValue::Set(input.universal_id),
                apple_key: ActiveValue::Set(input.apple_key),
                spotify_key: ActiveValue::Set(input.spotify_key),
                line_key: ActiveValue::Set(input.line_key),
                amazon_key: ActiveValue::Set(input.amazon_key),
                youtube_key: ActiveValue::Set(input.youtube_key),
                ..Default::default()
            };

            self.artists_repo.update(artist_model).await?;
        }

        Ok(input.artist_id)
    }
}
