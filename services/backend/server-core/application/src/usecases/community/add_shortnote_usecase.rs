use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

use shared::error::domain_err::DomainError;

use domain::entities::short_notes::ActiveModel as ShortNoteActiveModel;
use domain::repositories::short_notes_repo::ShortNotesRepository;

pub struct AddShortnoteInput {
    pub favorite_id: Uuid,
    pub comment: String,
}

#[async_trait]
pub trait AddShortnoteUsecaseTrait: Send + Sync {
    async fn add_shortnote(&self, input: AddShortnoteInput) -> Result<String, DomainError>;
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
            favorite_id: ActiveValue::Set(input.favorite_id),
            comment: ActiveValue::Set(input.comment.clone()),
            ..Default::default()
        };

        self.short_notes_repo.create(short_note).await?;

        Ok(input.comment)
    }
}
