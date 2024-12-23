use async_trait::async_trait;
use domain::entities::short_notes::{ActiveModel as ShortNoteActiveModel, Model as ShortNote};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::short_notes_repo::ShortNotesRepository;

#[automock]
#[async_trait]
pub trait MockShortNotesRepo {
    async fn mock_create(&self, short_note: ShortNoteActiveModel)
        -> Result<ShortNote, DomainError>;
    async fn mock_update(&self, short_note: ShortNoteActiveModel)
        -> Result<ShortNote, DomainError>;
    async fn mock_delete(&self, id: Uuid) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: Uuid) -> Result<Option<ShortNote>, DomainError>;
    async fn mock_get_by_writer(&self, writer: &str) -> Result<Vec<ShortNote>, DomainError>;
    async fn mock_get_by_to_user(&self, to_user: &str) -> Result<Vec<ShortNote>, DomainError>;
    async fn mock_get_by_writer_and_to_user(
        &self,
        writer: &str,
        to_user: &str,
    ) -> Result<Vec<ShortNote>, DomainError>;
}

#[async_trait]
impl ShortNotesRepository for MockMockShortNotesRepo {
    async fn create(&self, short_note: ShortNoteActiveModel) -> Result<ShortNote, DomainError> {
        self.mock_create(short_note).await
    }

    async fn update(&self, short_note: ShortNoteActiveModel) -> Result<ShortNote, DomainError> {
        self.mock_update(short_note).await
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn get_by_id(&self, id: Uuid) -> Result<Option<ShortNote>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_writer(&self, writer: &str) -> Result<Vec<ShortNote>, DomainError> {
        self.mock_get_by_writer(writer).await
    }

    async fn get_by_to_user(&self, to_user: &str) -> Result<Vec<ShortNote>, DomainError> {
        self.mock_get_by_to_user(to_user).await
    }

    async fn get_by_writer_and_to_user(
        &self,
        writer: &str,
        to_user: &str,
    ) -> Result<Vec<ShortNote>, DomainError> {
        self.mock_get_by_writer_and_to_user(writer, to_user).await
    }
}
