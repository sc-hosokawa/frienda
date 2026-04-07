use async_trait::async_trait;
use chrono::Utc;
use sea_orm::ActiveValue;
use std::collections::HashSet;
use std::sync::Arc;
use uuid::Uuid;

use crate::services::send_email::EmailServiceTrait;
use domain::entities::invitations::{ActiveModel as InvitationActiveModel, Model as Invitation};
use domain::entities::track_credits::Model as TrackCredits;
use domain::entities::users::ActiveModel as UserActiveModel;
use domain::repositories::invitations_repo::InvitationsRepository;
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use domain::repositories::users_repo::UsersRepository;
use domain::services::email::Email;

pub struct InvitationUsecaseOutput {
    pub invitation: Vec<Invitation>,
}

#[async_trait]
pub trait InvitationUsecaseTrait: Send + Sync {
    async fn invite(&self, pass: String) -> Result<InvitationUsecaseOutput, anyhow::Error>;
    async fn join_with_code(
        &self,
        digest_code: String,
        joined_user_id: String,
        joined_email: String,
    ) -> Result<(), anyhow::Error>;
}

pub struct InvitationUsecase {
    invitations_repo: Arc<dyn InvitationsRepository>,
    users_repo: Arc<dyn UsersRepository>,
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
    email_service: Arc<dyn EmailServiceTrait>,
}

impl InvitationUsecase {
    pub fn new(
        invitations_repo: Arc<dyn InvitationsRepository>,
        users_repo: Arc<dyn UsersRepository>,
        track_credits_repo: Arc<dyn TrackCreditsRepository>,
        email_service: Arc<dyn EmailServiceTrait>,
    ) -> Self {
        Self {
            invitations_repo,
            users_repo,
            track_credits_repo,
            email_service,
        }
    }
}

#[async_trait]
impl InvitationUsecaseTrait for InvitationUsecase {
    async fn invite(&self, pass: String) -> Result<InvitationUsecaseOutput, anyhow::Error> {
        if pass != "friendshipdao" {
            return Err(anyhow::anyhow!("Invalid password"));
        }

        let count: i64 = self.track_credits_repo.count_credits().await?;
        let registered_credits: Vec<TrackCredits> =
            self.track_credits_repo.all_credits(count as i32).await?;

        let invitations: Vec<Invitation> = self.invitations_repo.find_all().await?;
        let invited_user_emails: Vec<String> = invitations
            .iter()
            .map(|invitation| invitation.inviter_email.clone())
            .collect();

        let unique_invited_user_emails: HashSet<String> = invited_user_emails.into_iter().collect();

        let unique_emails: HashSet<String> = registered_credits
            .iter()
            .map(|credit| credit.email.clone())
            .collect();

        let title: &str = "フレンドシップ. DAOへの招待";
        let body: &str = "フレンドシップ. DAOへの招待";

        let mut invitations = Vec::new();

        for email in unique_emails {
            if unique_invited_user_emails.contains(&email) {
                continue;
            }

            let user_id: String = registered_credits
                .iter()
                .find(|credit| credit.email == email)
                .map(|credit| credit.commit_user.clone())
                .ok_or_else(|| anyhow::anyhow!("User not found"))?;

            let digest_code = Uuid::new_v4().to_string();

            let invitation = InvitationActiveModel {
                invitee: ActiveValue::Set(user_id),
                inviter_email: ActiveValue::Set(email.clone()),
                digest_code: ActiveValue::Set(Some(digest_code.clone())),
                ..Default::default()
            };
            let saved_invitation = self.invitations_repo.create(invitation).await?;
            invitations.push(saved_invitation);

            let invitation_link =
                format!("https://app.friendshipdao.xyz/signin?code={}", digest_code);
            let email_notification = Email {
                from: "info@friendshipdao.xyz".to_string(),
                to: email,
                subject: format!("【FRIENDSHIP. DAO】{}", title),
                body: format!(
                    "{}\n\n以下のリンクから登録してください：\n{}",
                    body, invitation_link
                ),
            };

            self.email_service.send_email(email_notification).await?;
        }

        Ok(InvitationUsecaseOutput {
            invitation: invitations,
        })
    }

    async fn join_with_code(
        &self,
        digest_code: String,
        joined_user_id: String,
        joined_email: String,
    ) -> Result<(), anyhow::Error> {
        if digest_code.is_empty() || joined_user_id.is_empty() || joined_email.is_empty() {
            return Err(anyhow::anyhow!("Invalid input parameters"));
        }

        if !joined_email.contains('@') {
            return Err(anyhow::anyhow!("Invalid email format"));
        }

        let invitation = self
            .invitations_repo
            .find_by_digest_code(&digest_code)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Invitation not found"))?;

        if invitation.is_joined {
            return Err(anyhow::anyhow!("Invitation code already used"));
        }

        let joined_user_active_model = UserActiveModel {
            id: ActiveValue::Set(joined_user_id),
            invited_by: ActiveValue::Set(Some(invitation.invitee)),
            ..Default::default()
        };
        self.users_repo.update(joined_user_active_model).await?;

        let invitation_active_model = InvitationActiveModel {
            id: ActiveValue::Set(invitation.id),
            is_joined: ActiveValue::Set(true),
            joined_email: ActiveValue::Set(Some(joined_email)),
            joined_at: ActiveValue::Set(Some(Utc::now().naive_utc())),
            ..Default::default()
        };
        self.invitations_repo
            .update(invitation_active_model)
            .await?;

        Ok(())
    }
}

#[cfg(test)]
#[path = "invitation_usecase_tests.rs"]
mod tests;
