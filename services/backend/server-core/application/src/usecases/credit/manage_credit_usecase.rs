use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::track_credits::ActiveModel as TrackCreditsActiveModel;
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use shared::error::domain_err::DomainError;

pub struct UpdateCreditUsecaseInput {
    pub credit_id: i32,
    pub commit_user: String, // varchar(28)
    pub credit_role: Option<String>,
    pub credit_name: Option<String>,
    pub email: Option<String>,
    pub is_invite: Option<bool>,
    pub memo: Option<String>,
}

pub struct DeleteCreditUsecaseInput {
    pub credit_id: i32,
}

#[async_trait]
pub trait ManageCreditUsecaseTrait: Send + Sync {
    async fn update_credit(&self, input: UpdateCreditUsecaseInput) -> Result<(), DomainError>;
    async fn delete_credit(&self, input: DeleteCreditUsecaseInput) -> Result<(), DomainError>;
}

pub struct ManageCreditUsecase {
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
}

impl ManageCreditUsecase {
    pub fn new(track_credits_repo: Arc<dyn TrackCreditsRepository>) -> Self {
        Self { track_credits_repo }
    }
}

#[async_trait]
impl ManageCreditUsecaseTrait for ManageCreditUsecase {
    async fn update_credit(&self, input: UpdateCreditUsecaseInput) -> Result<(), DomainError> {
        let update_credit = TrackCreditsActiveModel {
            id: ActiveValue::Set(input.credit_id),
            commit_user: ActiveValue::Set(input.commit_user),
            credit_role: match input.credit_role {
                Some(role) => ActiveValue::Set(role),
                None => ActiveValue::NotSet,
            },
            credit_name: match input.credit_name {
                Some(name) => ActiveValue::Set(name),
                None => ActiveValue::NotSet,
            },
            email: match input.email {
                Some(email) => ActiveValue::Set(email),
                None => ActiveValue::NotSet,
            },
            is_invite: match input.is_invite {
                Some(invite) => ActiveValue::Set(Some(invite)),
                None => ActiveValue::NotSet,
            },
            memo: match input.memo {
                Some(memo) => ActiveValue::Set(Some(memo)),
                None => ActiveValue::NotSet,
            },
            ..Default::default()
        };
        self.track_credits_repo.update(update_credit).await?;
        Ok(())
    }

    async fn delete_credit(&self, input: DeleteCreditUsecaseInput) -> Result<(), DomainError> {
        self.track_credits_repo.delete(input.credit_id).await?;
        Ok(())
    }
}
