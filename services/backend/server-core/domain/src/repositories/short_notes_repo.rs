use crate::entities::short_notes::{ActiveModel as ShortNoteActiveModel, Model as ShortNote};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait ShortNotesRepository: Send + Sync {
    async fn create(&self, short_note: ShortNoteActiveModel) -> Result<ShortNote, DomainError>;
    async fn update(&self, short_note: ShortNoteActiveModel) -> Result<ShortNote, DomainError>;

    async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: Uuid) -> Result<Option<ShortNote>, DomainError>;
    async fn get_by_writer(&self, writer: &str) -> Result<Vec<ShortNote>, DomainError>;
    async fn get_by_to_user(&self, to_user: &str) -> Result<Vec<ShortNote>, DomainError>;
    async fn get_by_writer_and_to_user(
        &self,
        writer: &str,
        to_user: &str,
    ) -> Result<Vec<ShortNote>, DomainError>;
}
