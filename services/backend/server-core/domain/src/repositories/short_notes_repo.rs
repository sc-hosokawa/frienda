use crate::entities::short_notes::{ActiveModel as ShortNoteActiveModel, Model as ShortNote};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait ShortNotesRepository {
    async fn create(&self, short_note: &ShortNoteActiveModel) -> Result<ShortNote, DomainError>;
    async fn update(&self, short_note: &ShortNoteActiveModel) -> Result<ShortNote, DomainError>;
}
