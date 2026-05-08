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
    users_repo::UsersRepository,
};

use crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct LeaveBelongedArtistUsecaseInput {
    pub operator_user_id: String,
    pub user_id: String,
    pub artist_id: String,
}

#[derive(Debug)]
pub struct LeaveBelongedArtistUsecaseOutput {
    pub left_artist: ArtistSimpleInfo,
}

#[derive(Debug)]
pub enum LeaveBelongedArtistError {
    NotFound,
    Forbidden(String),
    InvalidState(String),
    Domain(DomainError),
}

impl From<DomainError> for LeaveBelongedArtistError {
    fn from(error: DomainError) -> Self {
        match error {
            DomainError::NotFound => Self::NotFound,
            DomainError::AuthorizationError(message) => Self::Forbidden(message),
            other => Self::Domain(other),
        }
    }
}

#[async_trait]
pub trait LeaveBelongedArtistUsecaseTrait: Send + Sync {
    async fn leave_belonged_artist(
        &self,
        input: LeaveBelongedArtistUsecaseInput,
    ) -> Result<LeaveBelongedArtistUsecaseOutput, LeaveBelongedArtistError>;
}

pub struct LeaveBelongedArtistUsecase {
    users_repo: Arc<dyn UsersRepository>,
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl LeaveBelongedArtistUsecase {
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

    async fn authorize_operator(
        &self,
        input: &LeaveBelongedArtistUsecaseInput,
    ) -> Result<(), LeaveBelongedArtistError> {
        let operator = self
            .users_repo
            .find_by_id(&input.operator_user_id)
            .await?
            .ok_or(LeaveBelongedArtistError::NotFound)?;

        if operator.is_superadmin.unwrap_or(false) {
            return Ok(());
        }

        let operator_mapping = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.operator_user_id)
            .await?
            .ok_or_else(|| {
                LeaveBelongedArtistError::Forbidden(
                    "You are not allowed to do this action".to_string(),
                )
            })?;

        if operator_mapping.is_admin && matches!(operator_mapping.status, UserArtistStatus::Accept)
        {
            Ok(())
        } else {
            Err(LeaveBelongedArtistError::Forbidden(
                "You are not allowed to do this action".to_string(),
            ))
        }
    }

    async fn find_artist(&self, artist_id: &str) -> Result<Artist, LeaveBelongedArtistError> {
        self.artists_repo
            .find_by_ids(vec![artist_id])
            .await?
            .into_iter()
            .next()
            .ok_or(LeaveBelongedArtistError::NotFound)
    }
}

#[async_trait]
impl LeaveBelongedArtistUsecaseTrait for LeaveBelongedArtistUsecase {
    async fn leave_belonged_artist(
        &self,
        input: LeaveBelongedArtistUsecaseInput,
    ) -> Result<LeaveBelongedArtistUsecaseOutput, LeaveBelongedArtistError> {
        self.authorize_operator(&input).await?;

        let existing_mapping = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.user_id)
            .await?
            .ok_or(LeaveBelongedArtistError::NotFound)?;

        if !matches!(existing_mapping.status, UserArtistStatus::Accept) {
            return Err(LeaveBelongedArtistError::InvalidState(
                "belonged artist cannot be left in the current status".to_string(),
            ));
        }

        let artist = self.find_artist(&input.artist_id).await?;

        let left_mapping: UserArtist = self
            .user_artist_repo
            .update(UserArtistActiveModel {
                id: ActiveValue::Set(existing_mapping.id),
                status: ActiveValue::Set(UserArtistStatus::Reject),
                is_admin: ActiveValue::Set(false),
                is_default: ActiveValue::Set(false),
                ..Default::default()
            })
            .await?;

        Ok(LeaveBelongedArtistUsecaseOutput {
            left_artist: ArtistSimpleInfo {
                id: artist.id,
                artist_id: left_mapping.artist_id,
                name: artist.display_name_jp,
                img_url: artist.img_url,
                fsp: artist.fsp,
                status: left_mapping.status,
                is_admin: left_mapping.is_admin,
                request_message: left_mapping.request_message,
                is_default: left_mapping.is_default,
            },
        })
    }
}

#[cfg(test)]
#[path = "leave_belonged_artist_usecase_tests.rs"]
mod tests;
