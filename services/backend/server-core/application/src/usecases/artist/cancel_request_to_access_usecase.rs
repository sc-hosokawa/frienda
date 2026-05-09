use async_trait::async_trait;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

use domain::entities::artists::Model as Artist;
use domain::entities::{
    sea_orm_active_enums::UserArtistStatus,
    user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist},
};
use domain::repositories::{
    artists_repo::ArtistsRepository, user_artist_repo::UserArtistRepository,
};

use crate::usecases::artist::request_to_access_usecase::ArtistSimpleInfoWithMappingId;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct CancelRequestToAccessUsecaseInput {
    pub user_id: String,
    pub artist_id: String,
}

#[derive(Debug)]
pub struct CancelRequestToAccessUsecaseOutput {
    pub canceled_mapping: ArtistSimpleInfoWithMappingId,
}

#[derive(Debug)]
pub enum CancelRequestToAccessError {
    NotFound,
    InvalidState(String),
    Domain(DomainError),
}

impl From<DomainError> for CancelRequestToAccessError {
    fn from(error: DomainError) -> Self {
        match error {
            DomainError::NotFound => Self::NotFound,
            other => Self::Domain(other),
        }
    }
}

#[async_trait]
pub trait CancelRequestToAccessUsecaseTrait: Send + Sync {
    async fn cancel_request_to_access(
        &self,
        input: CancelRequestToAccessUsecaseInput,
    ) -> Result<CancelRequestToAccessUsecaseOutput, CancelRequestToAccessError>;
}

pub struct CancelRequestToAccessUsecase {
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl CancelRequestToAccessUsecase {
    pub fn new(
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            user_artist_repo,
            artists_repo,
        }
    }

    async fn find_artist(&self, artist_id: &str) -> Result<Artist, CancelRequestToAccessError> {
        self.artists_repo
            .find_by_ids(vec![artist_id])
            .await?
            .into_iter()
            .next()
            .ok_or(CancelRequestToAccessError::NotFound)
    }
}

#[async_trait]
impl CancelRequestToAccessUsecaseTrait for CancelRequestToAccessUsecase {
    async fn cancel_request_to_access(
        &self,
        input: CancelRequestToAccessUsecaseInput,
    ) -> Result<CancelRequestToAccessUsecaseOutput, CancelRequestToAccessError> {
        let existing_mapping = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.user_id)
            .await?
            .ok_or(CancelRequestToAccessError::NotFound)?;

        if !matches!(existing_mapping.status, UserArtistStatus::Check) {
            return Err(CancelRequestToAccessError::InvalidState(
                "artist access request cannot be canceled in the current status".to_string(),
            ));
        }

        let artist = self.find_artist(&input.artist_id).await?;

        let canceled_mapping: UserArtist = self
            .user_artist_repo
            .update(UserArtistActiveModel {
                id: ActiveValue::Set(existing_mapping.id),
                status: ActiveValue::Set(UserArtistStatus::Canceled),
                ..Default::default()
            })
            .await?;

        Ok(CancelRequestToAccessUsecaseOutput {
            canceled_mapping: ArtistSimpleInfoWithMappingId {
                mapping_id: canceled_mapping.id,
                id: artist.id,
                artist_id: canceled_mapping.artist_id,
                name: artist.display_name_jp,
                img_url: artist.img_url,
                fsp: artist.fsp,
                status: canceled_mapping.status,
                is_admin: canceled_mapping.is_admin,
                request_message: canceled_mapping.request_message,
            },
        })
    }
}

#[cfg(test)]
#[path = "cancel_request_to_access_usecase_tests.rs"]
mod tests;
