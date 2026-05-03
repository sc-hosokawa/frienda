use async_trait::async_trait;
use sea_orm::ActiveValue;
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

pub struct RequestToAccessUsecaseInput {
    pub user_id: String,
    pub artist_ids: Vec<String>,
}

pub struct RequestToAccessUsecaseOutput {
    pub created_mappings: Vec<ArtistSimpleInfoWithMappingId>,
}
pub struct ArtistSimpleInfoWithMappingId {
    pub mapping_id: i32,
    pub id: Uuid,
    pub artist_id: String,
    pub name: String,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: UserArtistStatus,
    pub is_admin: bool,
}

#[async_trait]
pub trait RequestToAccessUsecaseTrait: Send + Sync {
    async fn request_to_access(
        &self,
        input: RequestToAccessUsecaseInput,
    ) -> Result<RequestToAccessUsecaseOutput, anyhow::Error>;
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
    ) -> Result<RequestToAccessUsecaseOutput, anyhow::Error> {
        let mut created_mappings: Vec<ArtistSimpleInfoWithMappingId> = Vec::new();

        let mut seen_artist_ids = HashSet::new();
        let unique_artist_ids: Vec<String> = input
            .artist_ids
            .into_iter()
            .filter(|artist_id| seen_artist_ids.insert(artist_id.clone()))
            .collect();
        if unique_artist_ids.is_empty() {
            return Ok(RequestToAccessUsecaseOutput { created_mappings });
        }

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
            let artist = artists_by_id
                .get(artist_id)
                .ok_or_else(|| anyhow::anyhow!("Artist not found"))?;

            let user_artist = UserArtistActiveModel {
                user_id: ActiveValue::Set(input.user_id.clone()),
                artist_id: ActiveValue::Set(artist_id.clone()),
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
            });
        }

        Ok(RequestToAccessUsecaseOutput { created_mappings })
    }
}

#[cfg(test)]
#[path = "request_to_access_usecase_tests.rs"]
mod tests;
