use async_trait::async_trait;
use std::{
    collections::{HashMap, HashSet},
    sync::Arc,
};

use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::UserArtistStatus;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct GetMembersUsecaseInput {
    pub artist_id: String,       // varchar(28)
    pub user_id: Option<String>, // varchar(28)
}

pub struct GetMembersUsecaseOutput {
    pub members: Vec<User>,
}

pub struct GetAllPendingMembersUsecaseOutput {
    pub members: Vec<AllPendingMember>,
}
pub struct AllPendingMember {
    pub member: User,
    pub artist_name: String,
    pub artist_id: String,
    pub request_message: Option<String>,
}

#[async_trait]
pub trait GetMembersUsecaseTrait: Send + Sync {
    async fn get_members_belonged_to_artist(
        &self,
        input: GetMembersUsecaseInput,
    ) -> Result<GetMembersUsecaseOutput, anyhow::Error>;
    async fn get_members_joined_to_artist(
        &self,
        input: GetMembersUsecaseInput,
    ) -> Result<GetMembersUsecaseOutput, anyhow::Error>;
    async fn get_all_pending_members(
        &self,
        user_id: String,
    ) -> Result<GetAllPendingMembersUsecaseOutput, anyhow::Error>;
}

pub struct GetMembersUsecase {
    user_artist_repo: Arc<dyn UserArtistRepository>,
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetMembersUsecase {
    pub fn new(
        user_artist_repo: Arc<dyn UserArtistRepository>,
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            user_artist_repo,
            users_repo,
            artists_repo,
        }
    }
}

#[async_trait]
impl GetMembersUsecaseTrait for GetMembersUsecase {
    async fn get_members_belonged_to_artist(
        &self,
        input: GetMembersUsecaseInput,
    ) -> Result<GetMembersUsecaseOutput, anyhow::Error> {
        if let Some(user_id) = input.user_id {
            let user_artist = self
                .user_artist_repo
                .find_by_artist_id_and_user_id(&input.artist_id, &user_id)
                .await?
                .ok_or(anyhow::anyhow!("not found"))?;
            if !user_artist.is_admin {
                return Err(anyhow::anyhow!("not admin"));
            }

            let members: Vec<UserArtist> = self
                .user_artist_repo
                .find_by_artist_id(&input.artist_id)
                .await?
                .into_iter()
                .filter(|member| member.status == UserArtistStatus::Check)
                .collect();
            let string_ids: Vec<String> =
                members.into_iter().map(|member| member.user_id).collect();
            let joined_user_ids: Vec<&str> = string_ids.iter().map(|s| s.as_str()).collect();
            let users: Vec<User> = self.users_repo.find_by_ids(joined_user_ids).await?;

            Ok(GetMembersUsecaseOutput { members: users })
        } else {
            Err(anyhow::anyhow!("user_id is required"))
        }
    }

    async fn get_members_joined_to_artist(
        &self,
        input: GetMembersUsecaseInput,
    ) -> Result<GetMembersUsecaseOutput, anyhow::Error> {
        let members: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_artist_id(&input.artist_id)
            .await?;
        let string_ids: Vec<String> = members
            .into_iter()
            .filter(|member| member.status == UserArtistStatus::Accept)
            .map(|member| member.user_id)
            .collect();
        let joined_user_ids: Vec<&str> = string_ids.iter().map(|s| s.as_str()).collect();
        let users: Vec<User> = self.users_repo.find_by_ids(joined_user_ids).await?;

        Ok(GetMembersUsecaseOutput { members: users })
    }

    async fn get_all_pending_members(
        &self,
        user_id: String,
    ) -> Result<GetAllPendingMembersUsecaseOutput, anyhow::Error> {
        let user = self.users_repo.find_by_id(&user_id).await?.unwrap();
        if !user.is_superadmin.unwrap_or(false) {
            return Err(anyhow::anyhow!("user not superadmin"));
        }

        let mappings: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_status(UserArtistStatus::Check)
            .await?;

        let mut all_pending_members: Vec<AllPendingMember> = vec![];

        let mut seen_user_ids = HashSet::new();
        let user_ids: Vec<String> = mappings
            .iter()
            .map(|mapping| mapping.user_id.clone())
            .filter(|user_id| seen_user_ids.insert(user_id.clone()))
            .collect();
        let users_by_id: HashMap<String, User> = if user_ids.is_empty() {
            HashMap::new()
        } else {
            self.users_repo
                .find_by_ids(user_ids.iter().map(String::as_str).collect())
                .await?
                .into_iter()
                .map(|user| (user.id.clone(), user))
                .collect()
        };

        let mut seen_artist_ids = HashSet::new();
        let artist_ids: Vec<String> = mappings
            .iter()
            .map(|mapping| mapping.artist_id.clone())
            .filter(|artist_id| seen_artist_ids.insert(artist_id.clone()))
            .collect();
        let artists_by_id: HashMap<String, Artist> = if artist_ids.is_empty() {
            HashMap::new()
        } else {
            self.artists_repo
                .find_by_ids(artist_ids.iter().map(String::as_str).collect())
                .await?
                .into_iter()
                .map(|artist| (artist.artist_id.clone(), artist))
                .collect()
        };

        for mapping in mappings {
            let user = users_by_id
                .get(&mapping.user_id)
                .ok_or_else(|| anyhow::anyhow!("user not found"))?;
            let artist = artists_by_id
                .get(&mapping.artist_id)
                .ok_or_else(|| anyhow::anyhow!("artist not found"))?;
            all_pending_members.push(AllPendingMember {
                member: user.clone(),
                artist_name: artist.display_name_jp.clone(),
                artist_id: mapping.artist_id,
                request_message: mapping.request_message,
            });
        }

        Ok(GetAllPendingMembersUsecaseOutput {
            members: all_pending_members,
        })
    }
}

#[cfg(test)]
#[path = "get_members_usecase_tests.rs"]
mod tests;
