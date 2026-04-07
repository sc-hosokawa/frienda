use async_trait::async_trait;
use domain::entities::invitations::{ActiveModel as InvitationActiveModel, Model as Invitation};
use domain::repositories::invitations_repo::InvitationsRepository;
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockInvitationsRepo {
    async fn mock_create(
        &self,
        invitation: InvitationActiveModel,
    ) -> Result<Invitation, DomainError>;
    async fn mock_update(
        &self,
        invitation: InvitationActiveModel,
    ) -> Result<Invitation, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<Invitation>, DomainError>;
    async fn mock_find_by_id(&self, id: i32) -> Result<Option<Invitation>, DomainError>;
    async fn mock_find_by_invitee(&self, invitee: String) -> Result<Vec<Invitation>, DomainError>;
    async fn mock_find_by_inviter(&self, inviter: String) -> Result<Vec<Invitation>, DomainError>;
    async fn mock_find_by_digest_code(
        &self,
        digest_code: String,
    ) -> Result<Option<Invitation>, DomainError>;
    async fn mock_find_invited_user_emails(&self) -> Result<Vec<String>, DomainError>;
}

#[async_trait]
impl InvitationsRepository for MockMockInvitationsRepo {
    async fn create(&self, invitation: InvitationActiveModel) -> Result<Invitation, DomainError> {
        self.mock_create(invitation).await
    }

    async fn update(&self, invitation: InvitationActiveModel) -> Result<Invitation, DomainError> {
        self.mock_update(invitation).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn find_all(&self) -> Result<Vec<Invitation>, DomainError> {
        self.mock_find_all().await
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<Invitation>, DomainError> {
        self.mock_find_by_id(id).await
    }

    async fn find_by_invitee(&self, invitee: &str) -> Result<Vec<Invitation>, DomainError> {
        self.mock_find_by_invitee(invitee.to_string()).await
    }

    async fn find_by_inviter(&self, inviter: &str) -> Result<Vec<Invitation>, DomainError> {
        self.mock_find_by_inviter(inviter.to_string()).await
    }

    async fn find_by_digest_code(
        &self,
        digest_code: &str,
    ) -> Result<Option<Invitation>, DomainError> {
        self.mock_find_by_digest_code(digest_code.to_string()).await
    }

    async fn find_invited_user_emails(&self) -> Result<Vec<String>, DomainError> {
        self.mock_find_invited_user_emails().await
    }
}
