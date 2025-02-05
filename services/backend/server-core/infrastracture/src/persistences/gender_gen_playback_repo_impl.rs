use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::gender_gen_playback::{
    ActiveModel as GenderGenPlaybackActiveModel, Column, Entity as GenderGenPlaybackEntity,
    Model as GenderGenPlayback,
};
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct GenderGenPlaybackRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl GenderGenPlaybackRepository for GenderGenPlaybackRepoImpl {
    async fn create(
        &self,
        model: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError> {
        let res: InsertResult<GenderGenPlaybackActiveModel> =
            GenderGenPlaybackEntity::insert(model)
                .exec(&self.db)
                .await?;

        let inserted_model = GenderGenPlaybackEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(
        &self,
        model: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError> {
        let res: GenderGenPlayback = model.update(&self.db).await?;
        Ok(res)
    }

    async fn insert_many(
        &self,
        models: Vec<GenderGenPlaybackActiveModel>,
    ) -> Result<(), DomainError> {
        GenderGenPlaybackEntity::insert_many(models)
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        GenderGenPlaybackEntity::delete_by_id(id)
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<GenderGenPlayback>, DomainError> {
        let res: Option<GenderGenPlayback> = GenderGenPlaybackEntity::find_by_id(id)
            .one(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrc_and_year(
        &self,
        isrc: &str,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .filter(Column::Date.like(&format!("{}%", year)))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs(
        &self,
        isrcs: Vec<String>,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs_and_year(
        &self,
        isrcs: Vec<String>,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Date.like(&format!("{}%", year)))
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_lastest_id(&self) -> Result<i32, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .order_by(Column::Id, Order::Desc)
            .limit(1)
            .all(&self.db)
            .await?;

        Ok(res.first().map_or(0, |record| record.id))
    }
}
