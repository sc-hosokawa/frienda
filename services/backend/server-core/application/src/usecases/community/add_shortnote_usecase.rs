use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use shared::error::domain_err::DomainError;

use domain::entities::short_notes::ActiveModel as ShortNoteActiveModel;
use domain::repositories::short_notes_repo::ShortNotesRepository;

pub struct AddShortnoteInput {
    pub writer: String,
    pub to_user: String,
    pub comment: String,
}

pub struct EditShortnoteInput {
    pub id: Uuid,
    pub comment: String,
}

#[async_trait]
pub trait AddShortnoteUsecaseTrait: Send + Sync {
    async fn add_shortnote(&self, input: AddShortnoteInput) -> Result<String, DomainError>;
    async fn edit_shortnote(&self, input: EditShortnoteInput) -> Result<String, DomainError>;
    async fn delete_shortnote(&self, shortnote_id: Uuid) -> Result<Uuid, DomainError>;
}

pub struct AddShortnoteUsecase {
    short_notes_repo: Arc<dyn ShortNotesRepository>,
}

impl AddShortnoteUsecase {
    pub fn new(short_notes_repo: Arc<dyn ShortNotesRepository>) -> Self {
        Self { short_notes_repo }
    }
}

#[async_trait]
impl AddShortnoteUsecaseTrait for AddShortnoteUsecase {
    async fn add_shortnote(&self, input: AddShortnoteInput) -> Result<String, DomainError> {
        let short_note: ShortNoteActiveModel = ShortNoteActiveModel {
            writer: ActiveValue::Set(input.writer.clone()),
            to_user: ActiveValue::Set(input.to_user.clone()),
            comment: ActiveValue::Set(input.comment.clone()),
            ..Default::default()
        };
        self.short_notes_repo.create(short_note).await?;
        Ok(input.comment)
    }

    async fn edit_shortnote(&self, input: EditShortnoteInput) -> Result<String, DomainError> {
        let short_note: ShortNoteActiveModel = ShortNoteActiveModel {
            id: ActiveValue::Set(input.id),
            comment: ActiveValue::Set(input.comment.clone()),
            ..Default::default()
        };
        self.short_notes_repo.update(short_note).await?;
        Ok(input.comment)
    }

    async fn delete_shortnote(&self, shortnote_id: Uuid) -> Result<Uuid, DomainError> {
        let _res = self.short_notes_repo.delete(shortnote_id).await?;
        Ok(shortnote_id)
    }
}

#[cfg(test)]
#[path = "add_shortnote_usecase_tests.rs"]
mod tests;
