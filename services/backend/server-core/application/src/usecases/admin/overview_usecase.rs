use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::track_credits::Model as TrackCredits;
use domain::entities::tracks::Model as Track;
use domain::entities::txs_fsp::Model as TxsFsp;
use domain::entities::users::Model as User;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use domain::repositories::tracks_repo::TracksRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct OverviewOutput {
    pub total_users: i64,
    pub total_artists: i64,
    pub total_fsp: i64,
    pub total_revenue: i64,
    pub total_play_count: i64,
    pub mobile_app_users_count: i32,
}

pub struct Credit {
    pub date: String,
    pub title: String,
    pub isrc: String,
    pub user: String,
    pub role: String,
    pub name: String,
    pub email: String,
}

pub struct FspHistory {
    pub date: String,
    pub from: String, // username
    pub to: String,   // username
    pub amount: i32,
    pub notes: Option<String>,
}

#[async_trait]
pub trait OverviewUsecaseTrait: Send + Sync {
    async fn get_system_overview(&self) -> Result<OverviewOutput, anyhow::Error>;
    async fn get_all_credits(&self, count: i32) -> Result<Vec<Credit>, anyhow::Error>;
    async fn get_fsp_history(&self, count: i32) -> Result<Vec<FspHistory>, anyhow::Error>;
    async fn get_balance_mobile_app_users(&self) -> Result<i32, anyhow::Error>;
    async fn get_all_users(&self) -> Result<Vec<User>, anyhow::Error>;
}

pub struct OverviewUsecase {
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
    tracks_repo: Arc<dyn TracksRepository>,
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
}

impl OverviewUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        track_credits_repo: Arc<dyn TrackCreditsRepository>,
        tracks_repo: Arc<dyn TracksRepository>,
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        plays_monthly_repo: Arc<dyn PlaysMonthlyRepository>,
    ) -> Self {
        Self {
            users_repo,
            artists_repo,
            track_credits_repo,
            tracks_repo,
            txs_fsp_repo,
            plays_monthly_repo,
        }
    }
}

#[async_trait]
impl OverviewUsecaseTrait for OverviewUsecase {
    async fn get_system_overview(&self) -> Result<OverviewOutput, anyhow::Error> {
        let all_users: Vec<User> = self.users_repo.get_all_users().await?;
        let all_fsps: i32 = all_users.iter().map(|user| user.fsp).sum::<i32>();
        let total_artists: i64 = self.artists_repo.count().await?;
        let mobile_app_users_count: i32 = self.get_balance_mobile_app_users().await?;
        let total_play_count: i64 = self.plays_monthly_repo.get_total_play_count_all().await?;

        Ok(OverviewOutput {
            total_users: all_users.len() as i64,
            total_artists,
            total_fsp: all_fsps as i64,
            total_revenue: 0,
            total_play_count,
            mobile_app_users_count,
        })
    }

    async fn get_all_credits(&self, count: i32) -> Result<Vec<Credit>, anyhow::Error> {
        let credits: Vec<TrackCredits> = self.track_credits_repo.all_credits(count).await?;
        let mut result: Vec<Credit> = vec![];
        for credit in credits {
            let user: User = self
                .users_repo
                .find_by_id(&credit.commit_user)
                .await?
                .unwrap();
            let track: Track = self.tracks_repo.get_by_isrc(&credit.isrc).await?.unwrap();
            result.push(Credit {
                date: credit.created_at.to_string(),
                title: track.title,
                isrc: credit.isrc,
                user: user.username,
                role: credit.credit_role,
                name: credit.credit_name,
                email: credit.email,
            });
        }

        Ok(result)
    }

    async fn get_fsp_history(&self, count: i32) -> Result<Vec<FspHistory>, anyhow::Error> {
        let history: Vec<TxsFsp> = self.txs_fsp_repo.find_all().await?;
        let mut result: Vec<FspHistory> = vec![];

        for tx in history {
            if let Some(from_id) = tx.from {
                if let Some(from_user) = self.users_repo.find_by_id(&from_id).await? {
                    let to_user: User = self.users_repo.find_by_id(&tx.to).await?.unwrap();
                    result.push(FspHistory {
                        date: tx.tx_at.to_string(),
                        from: from_user.username,
                        to: to_user.username,
                        amount: tx.amount,
                        notes: tx.notes,
                    });
                }
            }
        }
        Ok(result)
    }

    async fn get_balance_mobile_app_users(&self) -> Result<i32, anyhow::Error> {
        let users: Vec<User> = self.users_repo.get_all_users().await?;
        let mobile_app_users_count = users.iter().filter(|user| user.fcm_token.is_some()).count();
        Ok(mobile_app_users_count as i32)
    }

    async fn get_all_users(&self) -> Result<Vec<User>, anyhow::Error> {
        let users: Vec<User> = self.users_repo.get_all_users().await?;
        Ok(users)
    }
}
