use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

use domain::entities::artists::Model as Artist;
use domain::entities::{sea_orm_active_enums::UserArtistStatus, user_artist::Model as UserArtist};
use domain::repositories::{
    artists_repo::ArtistsRepository, user_artist_repo::UserArtistRepository,
};

use crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct SetDefaultBelongedArtistUsecaseInput {
    pub user_id: String,
    pub artist_id: String,
}

#[derive(Debug)]
pub struct SetDefaultBelongedArtistUsecaseOutput {
    pub default_artist: ArtistSimpleInfo,
}

#[derive(Debug)]
pub enum SetDefaultBelongedArtistError {
    NotFound,
    InvalidState(String),
    Domain(DomainError),
}

impl From<DomainError> for SetDefaultBelongedArtistError {
    fn from(error: DomainError) -> Self {
        match error {
            DomainError::NotFound => Self::NotFound,
            other => Self::Domain(other),
        }
    }
}

#[async_trait]
pub trait SetDefaultBelongedArtistUsecaseTrait: Send + Sync {
    async fn set_default_belonged_artist(
        &self,
        input: SetDefaultBelongedArtistUsecaseInput,
    ) -> Result<SetDefaultBelongedArtistUsecaseOutput, SetDefaultBelongedArtistError>;
}

pub struct SetDefaultBelongedArtistUsecase {
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl SetDefaultBelongedArtistUsecase {
    pub fn new(
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            user_artist_repo,
            artists_repo,
        }
    }

    async fn find_artist(&self, artist_id: &str) -> Result<Artist, SetDefaultBelongedArtistError> {
        self.artists_repo
            .find_by_ids(vec![artist_id])
            .await?
            .into_iter()
            .next()
            .ok_or(SetDefaultBelongedArtistError::NotFound)
    }
}

#[async_trait]
impl SetDefaultBelongedArtistUsecaseTrait for SetDefaultBelongedArtistUsecase {
    async fn set_default_belonged_artist(
        &self,
        input: SetDefaultBelongedArtistUsecaseInput,
    ) -> Result<SetDefaultBelongedArtistUsecaseOutput, SetDefaultBelongedArtistError> {
        let existing_mapping = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.user_id)
            .await?
            .ok_or(SetDefaultBelongedArtistError::NotFound)?;

        if !matches!(existing_mapping.status, UserArtistStatus::Accept) {
            return Err(SetDefaultBelongedArtistError::InvalidState(
                "default artist can only be set for accepted belonged artists".to_string(),
            ));
        }

        let artist = self.find_artist(&input.artist_id).await?;
        let default_mapping: UserArtist = self
            .user_artist_repo
            .set_default_for_user(&input.user_id, &input.artist_id)
            .await?;

        Ok(SetDefaultBelongedArtistUsecaseOutput {
            default_artist: ArtistSimpleInfo {
                id: artist.id,
                artist_id: default_mapping.artist_id,
                name: artist.display_name_jp,
                img_url: artist.img_url,
                fsp: artist.fsp,
                status: default_mapping.status,
                is_admin: default_mapping.is_admin,
                request_message: default_mapping.request_message,
                is_default: default_mapping.is_default,
            },
        })
    }
}

#[cfg(test)]
#[path = "set_default_belonged_artist_usecase_tests.rs"]
mod tests;
