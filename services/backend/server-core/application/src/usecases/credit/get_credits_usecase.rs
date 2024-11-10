use async_trait::async_trait;
use chrono::{DateTime, NaiveDateTime, Utc};
use std::sync::Arc;

use domain::entities::track_credits::Model as TrackCredits;
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct GetCreditsUsecaseInput {
    pub user_id: String,
    pub artist_id: String,
    pub isrc: String,
}

pub struct GetCreditsUsecaseOutput {
    pub credits: Vec<SimpleTrackCredit>,
}
pub struct SimpleTrackCredit {
    pub isrc: String,
    pub commit_user: String,
    pub credit_role: String,
    pub credit_name: String,
    pub email: String,
    pub is_invite: Option<bool>,
    pub memo: Option<String>,
    pub created_at: DateTime<Utc>,
}

pub struct GetAllCreditsUsecaseOutput {
    pub credits: Vec<TrackCredits>,
}

#[async_trait]
pub trait GetCreditsUsecaseTrait: Send + Sync {
    async fn get_credits(
        &self,
        input: GetCreditsUsecaseInput,
    ) -> Result<GetCreditsUsecaseOutput, anyhow::Error>;
    async fn get_all_credits(
        &self,
        user_id: String,
    ) -> Result<GetAllCreditsUsecaseOutput, anyhow::Error>;
}

pub struct GetCreditsUsecase {
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
    users_repo: Arc<dyn UsersRepository>,
}

impl GetCreditsUsecase {
    pub fn new(
        track_credits_repo: Arc<dyn TrackCreditsRepository>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            track_credits_repo,
            users_repo,
        }
    }
}

#[async_trait]
impl GetCreditsUsecaseTrait for GetCreditsUsecase {
    async fn get_credits(
        &self,
        input: GetCreditsUsecaseInput,
    ) -> Result<GetCreditsUsecaseOutput, anyhow::Error> {
        let credits: Vec<TrackCredits> = self.track_credits_repo.find_by_isrc(&input.isrc).await?;
        Ok(GetCreditsUsecaseOutput {
            credits: credits
                .iter()
                .map(|credit| SimpleTrackCredit {
                    isrc: credit.isrc.clone(),
                    commit_user: credit.commit_user.clone(),
                    credit_role: credit.credit_role.clone(),
                    credit_name: credit.credit_name.clone(),
                    email: credit.email.clone(),
                    is_invite: credit.is_invite,
                    memo: credit.memo.clone(),
                    created_at: credit.created_at.and_utc(),
                })
                .collect(),
        })
    }

    async fn get_all_credits(
        &self,
        user_id: String,
    ) -> Result<GetAllCreditsUsecaseOutput, anyhow::Error> {
        // let is_super_admin = self.users_repo.is_super_admin(&user_id).await?;
        let user: Option<domain::entities::users::Model> =
            self.users_repo.find_by_id(&user_id).await?;
        if user.unwrap().is_superadmin.unwrap() {
            let credits: Vec<TrackCredits> = self.track_credits_repo.find_all().await?;
            Ok(GetAllCreditsUsecaseOutput { credits })
        } else {
            Err(anyhow::anyhow!("Unauthorized"))
        }
    }
}
