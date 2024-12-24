use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::short_notes::{
    ActiveModel as ShortNoteActiveModel, Column, Entity as ShortNoteEntity, Model as ShortNote,
};
use domain::repositories::short_notes_repo::ShortNotesRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ShortNotesRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl ShortNotesRepository for ShortNotesRepoImpl {
    async fn create(&self, model: ShortNoteActiveModel) -> Result<ShortNote, DomainError> {
        let res = ShortNoteEntity::insert(model).exec(&self.db).await?;
        let inserted_model = ShortNoteEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: ShortNoteActiveModel) -> Result<ShortNote, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        ShortNoteEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_id(&self, id: Uuid) -> Result<Option<ShortNote>, DomainError> {
        let res = ShortNoteEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_writer(&self, writer: &str) -> Result<Vec<ShortNote>, DomainError> {
        let res: Vec<ShortNote> = ShortNoteEntity::find()
            .filter(Column::Writer.eq(writer))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_to_user(&self, to_user: &str) -> Result<Vec<ShortNote>, DomainError> {
        let res: Vec<ShortNote> = ShortNoteEntity::find()
            .filter(Column::ToUser.eq(to_user))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_writer_and_to_user(
        &self,
        writer: &str,
        to_user: &str,
    ) -> Result<Option<ShortNote>, DomainError> {
        let res: Option<ShortNote> = ShortNoteEntity::find()
            .filter(Column::Writer.eq(writer))
            .filter(Column::ToUser.eq(to_user))
            .one(&self.db)
            .await?;
        Ok(res)
    }
}
