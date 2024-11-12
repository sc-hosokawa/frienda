use async_trait::async_trait;
use std::sync::Arc;

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
            .find_all()
            .await?
            .into_iter()
            .filter(|member| member.status == UserArtistStatus::Check)
            .collect();

        let mut all_pending_members: Vec<AllPendingMember> = vec![];

        for mapping in mappings {
            let user = self.users_repo.find_by_id(&mapping.user_id).await?.unwrap();
            let artist = self
                .artists_repo
                .find_by_id(&mapping.artist_id)
                .await?
                .unwrap();
            all_pending_members.push(AllPendingMember {
                member: user,
                artist_name: artist.display_name_jp,
            });
        }

        Ok(GetAllPendingMembersUsecaseOutput {
            members: all_pending_members,
        })
    }
}
