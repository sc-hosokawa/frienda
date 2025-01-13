use crate::entities::invitations::{ActiveModel as InvitationActiveModel, Model as Invitation};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait InvitationsRepository: Send + Sync {
    async fn create(&self, invitation: InvitationActiveModel) -> Result<Invitation, DomainError>;
    async fn update(&self, invitation: InvitationActiveModel) -> Result<Invitation, DomainError>;
    async fn delete(&self, id: i32) -> Result<(), DomainError>;

    async fn find_all(&self) -> Result<Vec<Invitation>, DomainError>;
    async fn find_by_id(&self, id: i32) -> Result<Option<Invitation>, DomainError>;
    async fn find_by_invitee(&self, invitee: &str) -> Result<Vec<Invitation>, DomainError>;
    async fn find_by_inviter(&self, inviter: &str) -> Result<Vec<Invitation>, DomainError>;
    async fn find_by_digest_code(
        &self,
        digest_code: &str,
    ) -> Result<Option<Invitation>, DomainError>;
    async fn find_invited_user_emails(&self) -> Result<Vec<String>, DomainError>;
}
