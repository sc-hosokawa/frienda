use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
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

        // 重複を排除した artist_ids を生成
        let unique_artist_ids: Vec<String> = input
            .artist_ids
            .into_iter()
            .collect::<std::collections::HashSet<_>>()
            .into_iter()
            .collect();

        // 各artist_idに対してUserArtistActiveModelを作成
        for artist_id in unique_artist_ids.iter() {
            // 既存のマッピングをチェック
            if self
                .user_artist_repo
                .exists(&input.user_id, artist_id)
                .await?
            {
                // 既存のマッピングがある場合はスキップして次の処理へ
                continue;
            }

            let user_artist = UserArtistActiveModel {
                user_id: ActiveValue::Set(input.user_id.clone()),
                artist_id: ActiveValue::Set(artist_id.clone()),
                ..Default::default()
            };
            let created_mapping: UserArtist = self.user_artist_repo.create(user_artist).await?;
            let artist: Artist = self
                .artists_repo
                .find_by_id(&created_mapping.artist_id)
                .await?
                .ok_or_else(|| anyhow::anyhow!("Artist not found"))?;
            created_mappings.push(ArtistSimpleInfoWithMappingId {
                mapping_id: created_mapping.id,
                id: artist.id,
                artist_id: created_mapping.artist_id,
                name: artist.display_name_jp,
                img_url: artist.img_url,
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
