use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use shared::error::domain_err::DomainError;

use domain::entities::invitations::{
    ActiveModel as InvitationActiveModel, Column, Entity as InvitationEntity, Model as Invitation,
};
use domain::repositories::invitations_repo::InvitationsRepository;

#[derive(new)]
pub struct InvitationsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl InvitationsRepository for InvitationsRepoImpl {
    async fn create(&self, invitation: InvitationActiveModel) -> Result<Invitation, DomainError> {
        let res: InsertResult<InvitationActiveModel> =
            InvitationEntity::insert(invitation).exec(&self.db).await?;
        let created_invitation: Option<Invitation> =
            InvitationEntity::find_by_id(res.last_insert_id)
                .one(&self.db)
                .await?;
        Ok(created_invitation.unwrap())
    }

    async fn update(&self, invitation: InvitationActiveModel) -> Result<Invitation, DomainError> {
        let updated_invitation: Invitation = invitation.update(&self.db).await?;
        Ok(updated_invitation)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _deleted_invitation: DeleteResult =
            InvitationEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn find_all(&self) -> Result<Vec<Invitation>, DomainError> {
        let invitations = InvitationEntity::find().all(&self.db).await?;
        Ok(invitations)
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<Invitation>, DomainError> {
        let invitation = InvitationEntity::find_by_id(id).one(&self.db).await?;
        Ok(invitation)
    }

    async fn find_by_invitee(&self, invitee: &str) -> Result<Vec<Invitation>, DomainError> {
        let invitations = InvitationEntity::find()
            .filter(Column::Invitee.eq(invitee))
            .all(&self.db)
            .await?;
        Ok(invitations)
    }

    async fn find_by_inviter(&self, inviter: &str) -> Result<Vec<Invitation>, DomainError> {
        let invitations = InvitationEntity::find()
            .filter(Column::InviterEmail.eq(inviter))
            .all(&self.db)
            .await?;
        Ok(invitations)
    }

    async fn find_by_digest_code(
        &self,
        digest_code: &str,
    ) -> Result<Option<Invitation>, DomainError> {
        let invitation = InvitationEntity::find()
            .filter(Column::DigestCode.eq(digest_code))
            .one(&self.db)
            .await?;
        Ok(invitation)
    }

    async fn find_invited_user_emails(&self) -> Result<Vec<String>, DomainError> {
        let invitations = InvitationEntity::find()
            .filter(Column::InviterEmail.is_not_null())
            .all(&self.db)
            .await?;
        let emails: Vec<String> = invitations
            .iter()
            .map(|invitation| invitation.inviter_email.clone())
            .collect();
        Ok(emails)
    }
}
