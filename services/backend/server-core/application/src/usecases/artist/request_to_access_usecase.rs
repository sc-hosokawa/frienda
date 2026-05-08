use async_trait::async_trait;
use chrono::Utc;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::{
    collections::{HashMap, HashSet},
    sync::Arc,
};
use uuid::Uuid;

use domain::entities::artists::Model as Artist;
use domain::entities::{
    sea_orm_active_enums::UserArtistStatus,
    user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist},
};
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct RequestToAccessUsecaseInput {
    pub user_id: String,
    pub requests: Vec<RequestToAccessArtistRequest>,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct RequestToAccessArtistRequest {
    pub artist_id: String,
    pub message: Option<String>,
}

#[derive(Debug)]
pub struct RequestToAccessUsecaseOutput {
    pub created_mappings: Vec<ArtistSimpleInfoWithMappingId>,
}
#[derive(Debug)]
pub struct ArtistSimpleInfoWithMappingId {
    pub mapping_id: i32,
    pub id: Uuid,
    pub artist_id: String,
    pub name: String,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: UserArtistStatus,
    pub is_admin: bool,
    pub request_message: Option<String>,
}

#[async_trait]
pub trait RequestToAccessUsecaseTrait: Send + Sync {
    async fn request_to_access(
        &self,
        input: RequestToAccessUsecaseInput,
    ) -> Result<RequestToAccessUsecaseOutput, DomainError>;
}

pub struct RequestToAccessUsecase {
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl RequestToAccessUsecase {
    pub fn new(
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            user_artist_repo,
            artists_repo,
        }
    }
}

#[async_trait]
impl RequestToAccessUsecaseTrait for RequestToAccessUsecase {
    async fn request_to_access(
        &self,
        input: RequestToAccessUsecaseInput,
    ) -> Result<RequestToAccessUsecaseOutput, DomainError> {
        let mut created_mappings: Vec<ArtistSimpleInfoWithMappingId> = Vec::new();

        let mut seen_artist_ids = HashSet::new();
        let unique_requests: Vec<RequestToAccessArtistRequest> = input
            .requests
            .into_iter()
            .filter(|request| seen_artist_ids.insert(request.artist_id.clone()))
            .collect();
        if unique_requests.is_empty() {
            return Ok(RequestToAccessUsecaseOutput { created_mappings });
        }

        for request in unique_requests.iter() {
            if let Some(message) = request.message.as_ref() {
                if message.is_empty() {
                    return Err(DomainError::ValidationError(
                        "request message must not be empty".to_string(),
                    ));
                }
                if message.chars().count() > 200 {
                    return Err(DomainError::ValidationError(
                        "request message must be 200 characters or fewer".to_string(),
                    ));
                }
            }
        }

        let unique_artist_ids: Vec<String> = unique_requests
            .iter()
            .map(|request| request.artist_id.clone())
            .collect();
        let request_message_by_artist_id: HashMap<String, Option<String>> = unique_requests
            .into_iter()
            .map(|request| (request.artist_id, request.message))
            .collect();

        let existing_artist_ids: HashSet<String> = self
            .user_artist_repo
            .find_by_user_id_and_artist_ids(
                &input.user_id,
                unique_artist_ids.iter().map(String::as_str).collect(),
            )
            .await?
            .into_iter()
            .map(|mapping| mapping.artist_id)
            .collect();

        let new_artist_ids: Vec<String> = unique_artist_ids
            .into_iter()
            .filter(|artist_id| !existing_artist_ids.contains(artist_id))
            .collect();

        let artists_by_id: HashMap<String, Artist> = if new_artist_ids.is_empty() {
            HashMap::new()
        } else {
            self.artists_repo
                .find_by_ids(new_artist_ids.iter().map(String::as_str).collect())
                .await?
                .into_iter()
                .map(|artist| (artist.artist_id.clone(), artist))
                .collect()
        };

        for artist_id in new_artist_ids.iter() {
            let artist = artists_by_id.get(artist_id).ok_or(DomainError::NotFound)?;
            let request_message = request_message_by_artist_id
                .get(artist_id)
                .cloned()
                .unwrap_or(None);

            let user_artist = UserArtistActiveModel {
                user_id: ActiveValue::Set(input.user_id.clone()),
                artist_id: ActiveValue::Set(artist_id.clone()),
                request_message: ActiveValue::Set(request_message.clone()),
                requested_at: ActiveValue::Set(Some(Utc::now().naive_utc())),
                ..Default::default()
            };
            let created_mapping: UserArtist = self.user_artist_repo.create(user_artist).await?;
            created_mappings.push(ArtistSimpleInfoWithMappingId {
                mapping_id: created_mapping.id,
                id: artist.id,
                artist_id: created_mapping.artist_id,
                name: artist.display_name_jp.clone(),
                img_url: artist.img_url.clone(),
                fsp: artist.fsp,
                status: created_mapping.status,
                is_admin: created_mapping.is_admin,
                request_message: created_mapping.request_message,
            });
        }

        Ok(RequestToAccessUsecaseOutput { created_mappings })
    }
}

#[cfg(test)]
#[path = "request_to_access_usecase_tests.rs"]
mod tests;
