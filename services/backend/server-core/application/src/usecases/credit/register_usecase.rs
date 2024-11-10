use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::track_credits::{
    ActiveModel as TrackCreditsActiveModel, Model as TrackCredits,
};
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use shared::error::domain_err::DomainError;

pub struct RegisterUsecaseInput {
    pub register_info: Vec<RegisterInfo>,
}
pub struct RegisterInfo {
    pub isrc: String,
    pub commit_user: String, // varchar(28)
    pub credit_role: String,
    pub credit_name: String,
    pub email: String,
    pub is_invite: bool,
    pub memo: Option<String>,
}

#[async_trait]
pub trait RegisterUsecaseTrait: Send + Sync {
    async fn register(&self, input: RegisterUsecaseInput) -> Result<(), DomainError>;
}

pub struct RegisterUsecase {
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
}

impl RegisterUsecase {
    pub fn new(track_credits_repo: Arc<dyn TrackCreditsRepository>) -> Self {
        Self { track_credits_repo }
    }
}

#[async_trait]
impl RegisterUsecaseTrait for RegisterUsecase {
    async fn register(&self, input: RegisterUsecaseInput) -> Result<(), DomainError> {
        for register_info in input.register_info.iter() {
            let track_credits = TrackCreditsActiveModel {
                isrc: ActiveValue::Set(register_info.isrc.clone()),
                commit_user: ActiveValue::Set(register_info.commit_user.clone()),
                credit_role: ActiveValue::Set(register_info.credit_role.clone()),
                credit_name: ActiveValue::Set(register_info.credit_name.clone()),
                email: ActiveValue::Set(register_info.email.clone()),
                is_invite: ActiveValue::Set(Some(register_info.is_invite)),
                memo: ActiveValue::Set(register_info.memo.clone()),
                ..Default::default()
            };
            let res = self.track_credits_repo.create(track_credits).await?;
            tracing::info!("track_credits: {:?}", res);
        }
        Ok(())
    }
}
