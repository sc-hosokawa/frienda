use async_trait::async_trait;
use chrono::Utc;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::{collections::HashSet, sync::Arc};

use domain::entities::artists::Model as Artist;
use domain::entities::{
    notification_user::ActiveModel as NotificationUserActiveModel,
    notifications::ActiveModel as NotificationActiveModel,
    sea_orm_active_enums::UserArtistStatus,
    user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist},
};
use domain::repositories::{
    artists_repo::ArtistsRepository, notification_user_repo::NotificationUserRepository,
    notifications_repo::NotificationsRepository, user_artist_repo::UserArtistRepository,
};

use crate::usecases::artist::request_to_access_usecase::ArtistSimpleInfoWithMappingId;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct ResendRequestToAccessUsecaseInput {
    pub user_id: String,
    pub artist_id: String,
    pub message: Option<String>,
}

#[derive(Debug)]
pub struct ResendRequestToAccessUsecaseOutput {
    pub updated_mapping: ArtistSimpleInfoWithMappingId,
}

#[derive(Debug)]
pub enum ResendRequestToAccessError {
    BadUserInput(String),
    NotFound,
    InvalidState(String),
    Domain(DomainError),
}

impl From<DomainError> for ResendRequestToAccessError {
    fn from(error: DomainError) -> Self {
        match error {
            DomainError::NotFound => Self::NotFound,
            DomainError::ValidationError(message) | DomainError::InvalidParameter(message) => {
                Self::BadUserInput(message)
            }
            other => Self::Domain(other),
        }
    }
}

#[async_trait]
pub trait ResendRequestToAccessUsecaseTrait: Send + Sync {
    async fn resend_request_to_access(
        &self,
        input: ResendRequestToAccessUsecaseInput,
    ) -> Result<ResendRequestToAccessUsecaseOutput, ResendRequestToAccessError>;
}

pub struct ResendRequestToAccessUsecase {
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    notifications_repo: Arc<dyn NotificationsRepository>,
    notification_user_repo: Arc<dyn NotificationUserRepository>,
}

impl ResendRequestToAccessUsecase {
    pub fn new(
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        notifications_repo: Arc<dyn NotificationsRepository>,
        notification_user_repo: Arc<dyn NotificationUserRepository>,
    ) -> Self {
        Self {
            user_artist_repo,
            artists_repo,
            notifications_repo,
            notification_user_repo,
        }
    }

    fn validate_message(message: Option<&String>) -> Result<(), ResendRequestToAccessError> {
        if let Some(message) = message {
            if message.is_empty() {
                return Err(ResendRequestToAccessError::BadUserInput(
                    "request message must not be empty".to_string(),
                ));
            }
            if message.chars().count() > 200 {
                return Err(ResendRequestToAccessError::BadUserInput(
                    "request message must be 200 characters or fewer".to_string(),
                ));
            }
        }

        Ok(())
    }

    async fn find_artist(&self, artist_id: &str) -> Result<Artist, ResendRequestToAccessError> {
        self.artists_repo
            .find_by_ids(vec![artist_id])
            .await?
            .into_iter()
            .next()
            .ok_or(ResendRequestToAccessError::NotFound)
    }

    async fn notify_artist_admins(
        &self,
        artist: &Artist,
    ) -> Result<(), ResendRequestToAccessError> {
        let target_user_ids: Vec<String> = self
            .user_artist_repo
            .find_by_artist_id(&artist.artist_id)
            .await?
            .into_iter()
            .filter(|mapping| {
                mapping.is_admin && matches!(mapping.status, UserArtistStatus::Accept)
            })
            .map(|mapping| mapping.user_id)
            .collect::<HashSet<_>>()
            .into_iter()
            .collect();

        if target_user_ids.is_empty() {
            return Ok(());
        }

        let notification = self
            .notifications_repo
            .create(NotificationActiveModel {
                title: ActiveValue::Set("アーティスト所属申請が再送されました".to_string()),
                content: ActiveValue::Set(format!(
                    "{}への所属申請が再送されました",
                    artist.display_name_jp
                )),
                category: ActiveValue::Set(Some("artist_request".to_string())),
                ..Default::default()
            })
            .await?;

        for user_id in target_user_ids {
            self.notification_user_repo
                .create(NotificationUserActiveModel {
                    notification_id: ActiveValue::Set(notification.id),
                    user: ActiveValue::Set(user_id),
                    is_read: ActiveValue::Set(false),
                    is_deleted: ActiveValue::Set(false),
                    ..Default::default()
                })
                .await?;
        }

        Ok(())
    }
}

#[async_trait]
impl ResendRequestToAccessUsecaseTrait for ResendRequestToAccessUsecase {
    async fn resend_request_to_access(
        &self,
        input: ResendRequestToAccessUsecaseInput,
    ) -> Result<ResendRequestToAccessUsecaseOutput, ResendRequestToAccessError> {
        Self::validate_message(input.message.as_ref())?;

        let existing_mapping = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.user_id)
            .await?
            .ok_or(ResendRequestToAccessError::NotFound)?;

        if !matches!(
            existing_mapping.status,
            UserArtistStatus::Reject | UserArtistStatus::Canceled | UserArtistStatus::Check
        ) {
            return Err(ResendRequestToAccessError::InvalidState(
                "artist access request cannot be resent in the current status".to_string(),
            ));
        }

        let artist = self.find_artist(&input.artist_id).await?;

        let updated_mapping: UserArtist = self
            .user_artist_repo
            .update(UserArtistActiveModel {
                id: ActiveValue::Set(existing_mapping.id),
                status: ActiveValue::Set(UserArtistStatus::Check),
                request_message: ActiveValue::Set(input.message),
                requested_at: ActiveValue::Set(Some(Utc::now().naive_utc())),
                ..Default::default()
            })
            .await?;

        self.notify_artist_admins(&artist).await?;

        Ok(ResendRequestToAccessUsecaseOutput {
            updated_mapping: ArtistSimpleInfoWithMappingId {
                mapping_id: updated_mapping.id,
                id: artist.id,
                artist_id: updated_mapping.artist_id,
                name: artist.display_name_jp,
                img_url: artist.img_url,
                fsp: artist.fsp,
                status: updated_mapping.status,
                is_admin: updated_mapping.is_admin,
                request_message: updated_mapping.request_message,
            },
        })
    }
}

#[cfg(test)]
#[path = "resend_request_to_access_usecase_tests.rs"]
mod tests;
