use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::tracks::{
    ActiveModel as TracksActiveModel, Column, Entity as TracksEntity, Model as Tracks,
};
use domain::repositories::tracks_repo::TracksRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct TracksRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl TracksRepository for TracksRepoImpl {
    async fn create(&self, model: TracksActiveModel) -> Result<Tracks, DomainError> {
        let res = TracksEntity::insert(model).exec(&self.db).await?;
        let inserted_model: Option<Tracks> = TracksEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn create_many(&self, models: Vec<TracksActiveModel>) -> Result<(), DomainError> {
        let _res = TracksEntity::insert_many(models)
            .on_conflict(
                sea_orm::sea_query::OnConflict::column(Column::Isrc)
                    .do_nothing()
                    .to_owned(),
            )
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn update(&self, model: TracksActiveModel) -> Result<Tracks, DomainError> {
        let res: Tracks = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: &str) -> Result<(), DomainError> {
        TracksEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_isrc(&self, isrc: &str) -> Result<Option<Tracks>, DomainError> {
        let res: Option<Tracks> = TracksEntity::find_by_id(isrc).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<Tracks>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Tracks>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn count(&self) -> Result<i64, DomainError> {
        let res: u64 = TracksEntity::find().count(&self.db).await?;
        Ok(res as i64)
    }

    async fn find_all(&self) -> Result<Vec<Tracks>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find().all(&self.db).await?;
        Ok(res)
    }
}
