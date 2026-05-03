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
            .on_conflict(
                sea_orm::sea_query::OnConflict::new()
                    .do_nothing()
                    .to_owned(),
            )
            .exec(&self.db)
            .await?;
        tracing::info!("Insert result: {:?}", res);
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

    async fn get_max_id(&self) -> Result<Option<i32>, DomainError> {
        let res = ProductTrackEntity::find()
            .select_only()
            .column_as(sea_orm::sea_query::Expr::col(Column::Id).max(), "max_id")
            .into_tuple::<Option<i32>>()
            .one(&self.db)
            .await?
            .flatten();

        Ok(res)
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        let _res = ProductTrackEntity::delete_many()
            .filter(Column::Isrc.eq(isrc))
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn delete_by_upc(&self, upc: &str) -> Result<(), DomainError> {
        let _res = ProductTrackEntity::delete_many()
            .filter(Column::Upc.eq(upc))
            .exec(&self.db)
            .await?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::product_track_repo::ProductTrackRepository;
    use sea_orm::{DbBackend, MockDatabase};

    #[tokio::test]
    async fn get_by_upcs_filters_release_track_mappings() {
        // dashboard の artist release 展開で対象 UPC 以外の track mapping を混ぜないことを固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<ProductTrack>::new()])
            .into_connection();
        let repo = ProductTrackRepoImpl::new(db);

        repo.get_by_upcs(vec!["UPC1".to_string(), "UPC2".to_string()])
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("product_track"), "{log}");
        assert!(log.contains("upc"), "{log}");
        assert!(log.contains(" IN "), "{log}");
        assert!(log.contains("UPC1"), "{log}");
        assert!(log.contains("UPC2"), "{log}");
    }

    #[tokio::test]
    async fn get_by_upc_filters_single_release_tracks() {
        // UPC dashboard は指定 release の track だけを対象にするため、単一 UPC filter を固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<ProductTrack>::new()])
            .into_connection();
        let repo = ProductTrackRepoImpl::new(db);

        repo.get_by_upc("UPC1").await.unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("product_track"), "{log}");
        assert!(log.contains("upc"), "{log}");
        assert!(log.contains(" = "), "{log}");
        assert!(log.contains("UPC1"), "{log}");
    }
}
