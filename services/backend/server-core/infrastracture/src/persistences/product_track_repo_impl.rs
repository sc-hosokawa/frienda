use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::product_track::{
    ActiveModel as ProductTrackActiveModel, Column, Entity as ProductTrackEntity,
    Model as ProductTrack,
};
use domain::repositories::product_track_repo::ProductTrackRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ProductTrackRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl ProductTrackRepository for ProductTrackRepoImpl {
    async fn create(&self, model: ProductTrackActiveModel) -> Result<ProductTrack, DomainError> {
        let res = ProductTrackEntity::insert(model).exec(&self.db).await?;

        let inserted_model = ProductTrackEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn create_many(
        &self,
        models: Vec<ProductTrackActiveModel>,
    ) -> Result<InsertResult<ProductTrackActiveModel>, DomainError> {
        let res: InsertResult<ProductTrackActiveModel> = ProductTrackEntity::insert_many(models)
            .exec(&self.db)
            .await?;
        Ok(res)
    }

    async fn update(&self, model: ProductTrackActiveModel) -> Result<ProductTrack, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        ProductTrackEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<ProductTrack>, DomainError> {
        let res = ProductTrackEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_upc(&self, upc: &str) -> Result<Vec<ProductTrack>, DomainError> {
        let res = ProductTrackEntity::find()
            .filter(Column::Upc.eq(upc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_isrc(&self, isrc: &str) -> Result<Vec<ProductTrack>, DomainError> {
        let res = ProductTrackEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError> {
        let res = ProductTrackEntity::find()
            .filter(Column::Upc.is_in(upcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<ProductTrack>, DomainError> {
        let res = ProductTrackEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}
