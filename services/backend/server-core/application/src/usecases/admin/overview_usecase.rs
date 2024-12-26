use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::users_repo::UsersRepository;
pub struct OverviewOutput {
    pub total_users: i64,
    pub total_artists: i64,
    pub total_fsp: i64,
    pub total_revenue: i64,
    pub total_play_count: i64,
}

#[async_trait]
pub trait OverviewUsecaseTrait: Send + Sync {
    async fn get_overview(&self) -> Result<OverviewOutput, anyhow::Error>;
}

pub struct OverviewUsecase {
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl OverviewUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            users_repo,
            artists_repo,
        }
    }
}

#[async_trait]
impl OverviewUsecaseTrait for OverviewUsecase {
    async fn get_overview(&self) -> Result<OverviewOutput, anyhow::Error> {
        let all_users: Vec<User> = self.users_repo.get_all_users().await?;
        let all_fsps: i32 = all_users.iter().map(|user| user.fsp).sum::<i32>();
        let total_artists: i64 = self.artists_repo.count().await?;

        Ok(OverviewOutput {
            total_users: all_users.len() as i64,
            total_artists,
            total_fsp: all_fsps as i64,
            total_revenue: 0,
            total_play_count: 0,
        })
    }
}
