use async_trait::async_trait;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::sea_orm_active_enums::UserArtistStatus;
use domain::entities::{
    artists::Model as Artist, user_artist::Model as UserArtist, users::Model as User,
};
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct GetUserBasicInfoInput {
    pub user_id: String,
}

pub struct GetUserBasicInfoOutput {
    pub user: User,
    pub belongs_to_artists: Vec<ArtistSimpleInfo>,
    pub primary_artist: Option<ArtistSimpleInfo>,
}
#[derive(Clone, Debug)]
pub struct ArtistSimpleInfo {
    pub id: Uuid,
    pub artist_id: String,
    pub name: String,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: UserArtistStatus,
    pub is_admin: bool,
    pub request_message: Option<String>,
    pub is_default: bool,
}

pub(crate) fn build_artist_info_with_effective_default(
    belongs_to_artists: &[UserArtist],
    artists: Vec<Artist>,
) -> (Vec<ArtistSimpleInfo>, Option<ArtistSimpleInfo>) {
    let explicit_default_artist_id = belongs_to_artists
        .iter()
        .filter(|user_artist| {
            matches!(user_artist.status, UserArtistStatus::Accept) && user_artist.is_default
        })
        .map(|user_artist| user_artist.artist_id.as_str())
        .min();

    let fallback_default_artist_id = belongs_to_artists
        .iter()
        .filter(|user_artist| matches!(user_artist.status, UserArtistStatus::Accept))
        .map(|user_artist| user_artist.artist_id.as_str())
        .min();

    let effective_default_artist_id = explicit_default_artist_id.or(fallback_default_artist_id);

    let artist_info: Vec<ArtistSimpleInfo> = artists
        .into_iter()
        .map(|artist| {
            let user_artist = belongs_to_artists
                .iter()
                .find(|ua| ua.artist_id == artist.artist_id)
                .expect("UserArtist should exist for this artist");
            let is_effective_default = effective_default_artist_id
                == Some(artist.artist_id.as_str())
                && matches!(user_artist.status, UserArtistStatus::Accept);

            ArtistSimpleInfo {
                id: artist.id,
                artist_id: artist.artist_id,
                name: artist.display_name_jp,
                img_url: artist.img_url,
                fsp: artist.fsp,
                status: user_artist.status.clone(),
                is_admin: user_artist.is_admin,
                request_message: user_artist.request_message.clone(),
                is_default: is_effective_default,
            }
        })
        .collect();

    let primary_artist = artist_info
        .iter()
        .find(|artist| artist.is_default && matches!(artist.status, UserArtistStatus::Accept))
        .cloned();

    (artist_info, primary_artist)
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetUserBasicInfoUsecaseTrait: Send + Sync {
    async fn get_user_basic_info(
        &self,
        input: GetUserBasicInfoInput,
    ) -> Result<GetUserBasicInfoOutput, anyhow::Error>;
    async fn get_belongs_to_artists(
        &self,
        user_id: String,
    ) -> Result<Vec<ArtistSimpleInfo>, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetUserBasicInfoUsecase {
    users_repo: Arc<dyn UsersRepository>,
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetUserBasicInfoUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            users_repo,
            user_artist_repo,
            artists_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetUserBasicInfoUsecaseTrait for GetUserBasicInfoUsecase {
    async fn get_user_basic_info(
        &self,
        input: GetUserBasicInfoInput,
    ) -> Result<GetUserBasicInfoOutput, anyhow::Error> {
        let user = self
            .users_repo
            .find_by_id(&input.user_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found"))?;

        let belongs_to_artists: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_user_id(&input.user_id)
            .await?;

        let artists: Vec<Artist> = self
            .artists_repo
            .find_by_ids(
                belongs_to_artists
                    .iter()
                    .map(|a| a.artist_id.as_str())
                    .collect(),
            )
            .await?;

        let (artist_info, primary_artist) =
            build_artist_info_with_effective_default(&belongs_to_artists, artists);

        Ok(GetUserBasicInfoOutput {
            user,
            belongs_to_artists: artist_info,
            primary_artist,
        })
    }

    async fn get_belongs_to_artists(
        &self,
        user_id: String,
    ) -> Result<Vec<ArtistSimpleInfo>, anyhow::Error> {
        let belongs_to_artists: Vec<UserArtist> =
            self.user_artist_repo.find_by_user_id(&user_id).await?;

        let artists: Vec<Artist> = self
            .artists_repo
            .find_by_ids(
                belongs_to_artists
                    .iter()
                    .map(|a| a.artist_id.as_str())
                    .collect(),
            )
            .await?;

        let (artist_info, _) =
            build_artist_info_with_effective_default(&belongs_to_artists, artists);

        Ok(artist_info)
    }
}

#[cfg(test)]
#[path = "get_user_basic_info_usecase_tests.rs"]
mod tests;
