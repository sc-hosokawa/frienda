use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::sea_orm_active_enums::UserArtistStatus;
use domain::entities::user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist};
use domain::repositories::user_artist_repo::UserArtistRepository;
use shared::error::domain_err::DomainError;

pub struct MarkAsMemberUsecaseInput {
    pub member: String,
    pub artist_id: String,
    pub mapping: Vec<UserStatus>,
}
pub struct UserStatus {
    pub user_id: String,
    pub status: UserArtistStatus,
}

pub struct MarkAsAdminUsecaseInput {
    pub admin_member: String,
    pub user_id: String,
    pub artist_id: String,
}

#[async_trait]
pub trait MarkAsMemberUsecaseTrait: Send + Sync {
    async fn mark_as_member(
        &self,
        input: MarkAsMemberUsecaseInput,
    ) -> Result<Vec<UserArtist>, DomainError>;
    async fn mark_as_admin(
        &self,
        input: MarkAsAdminUsecaseInput,
    ) -> Result<UserArtist, DomainError>;
}

pub struct MarkAsMemberUsecase {
    user_artist_repo: Arc<dyn UserArtistRepository>,
}

impl MarkAsMemberUsecase {
    pub fn new(user_artist_repo: Arc<dyn UserArtistRepository>) -> Self {
        Self { user_artist_repo }
    }
}

#[async_trait]
impl MarkAsMemberUsecaseTrait for MarkAsMemberUsecase {
    async fn mark_as_member(
        &self,
        input: MarkAsMemberUsecaseInput,
    ) -> Result<Vec<UserArtist>, DomainError> {
        let super_admin_user_id = "BnHP2OVFtRUrZ9G6rGN48DRUim53";

        if input.member != super_admin_user_id {
            let user_artist = self
                .user_artist_repo
                .find_by_artist_id_and_user_id(&input.artist_id, &input.member)
                .await?;

            if user_artist.is_none() {
                return Err(DomainError::NotFound);
            }

            if !user_artist.unwrap().is_admin {
                return Err(DomainError::AuthorizationError(
                    "You are not allowed to do this action".to_string(),
                ));
            }
        }

        let mut results: Vec<UserArtist> = Vec::new();

        for user_status in input.mapping {
            let existing = self
                .user_artist_repo
                .find_by_artist_id_and_user_id(&input.artist_id, &user_status.user_id)
                .await?;

            if let Some(existing_record) = existing {
                let user_artist_mapping = UserArtistActiveModel {
                    id: ActiveValue::Set(existing_record.id),
                    artist_id: ActiveValue::Set(input.artist_id.clone()),
                    user_id: ActiveValue::Set(user_status.user_id),
                    status: ActiveValue::Set(user_status.status),
                    ..Default::default()
                };

                let result = self.user_artist_repo.update(user_artist_mapping).await?;
                results.push(result);
            } else {
                return Err(DomainError::NotFound);
            }
        }

        Ok(results)
    }

    async fn mark_as_admin(
        &self,
        input: MarkAsAdminUsecaseInput,
    ) -> Result<UserArtist, DomainError> {
        let super_admin_user_id = "BnHP2OVFtRUrZ9G6rGN48DRUim53";

        if input.admin_member != super_admin_user_id {
            let user_artist = self
                .user_artist_repo
                .find_by_artist_id_and_user_id(&input.artist_id, &input.admin_member)
                .await?;

            if user_artist.is_none() {
                return Err(DomainError::NotFound);
            }
            if !user_artist.unwrap().is_admin {
                return Err(DomainError::AuthorizationError(
                    "You are not allowed to do this action".to_string(),
                ));
            }
        }

        let existing = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.user_id)
            .await?;

        if let Some(existing_record) = existing {
            let user_artist_mapping = UserArtistActiveModel {
                id: ActiveValue::Set(existing_record.id),
                artist_id: ActiveValue::Set(input.artist_id.clone()),
                user_id: ActiveValue::Set(input.user_id),
                is_admin: ActiveValue::Set(true),
                status: ActiveValue::Set(UserArtistStatus::Accept),
                ..Default::default()
            };

            let result = self.user_artist_repo.update(user_artist_mapping).await?;
            Ok(result)
        } else {
            Err(DomainError::NotFound)
        }
    }
}
