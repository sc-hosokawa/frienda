use async_trait::async_trait;
use chrono::{FixedOffset, Utc};
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::users::{ActiveModel as UserActiveModel, Model as User};
use domain::repositories::users_repo::UsersRepository;

//
// Define the trait for the usecase
//
#[async_trait]
pub trait LoginRewardUsecaseTrait: Send + Sync {
    async fn login_reward(&self, user_id: String) -> Result<i32, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct LoginRewardUsecase {
    users_repo: Arc<dyn UsersRepository>,
}

impl LoginRewardUsecase {
    pub fn new(users_repo: Arc<dyn UsersRepository>) -> Self {
        Self { users_repo }
    }
}

#[async_trait]
impl LoginRewardUsecaseTrait for LoginRewardUsecase {
    async fn login_reward(&self, user_id: String) -> Result<i32, anyhow::Error> {
        let jst_offset = FixedOffset::east_opt(9 * 3600).unwrap();
        let now: chrono::NaiveDateTime = Utc::now().with_timezone(&jst_offset).naive_local();

        let user: Option<User> = self.users_repo.find_by_id(&user_id).await?;
        let user: User = user.ok_or_else(|| anyhow::anyhow!("User not found"))?;
        let mut user_update: UserActiveModel = user.clone().into();

        // last_login_atがない場合は、現在のfspを返す
        if user.last_login_at.is_none() {
            user_update.last_login_at = ActiveValue::Set(Some(now));
            self.users_repo.update(user_update).await?;
            return Ok(user.fsp);
        }

        let last_login_at: chrono::NaiveDateTime = user.last_login_at.unwrap();

        let last_login_date: chrono::NaiveDate = last_login_at.date();
        let current_date: chrono::NaiveDate = now.date();

        if current_date > last_login_date {
            user_update.fsp = ActiveValue::Set(user.fsp + 1);
        }

        user_update.last_login_at = ActiveValue::Set(Some(now));
        self.users_repo.update(user_update).await?;

        Ok(user.fsp)
    }
}
