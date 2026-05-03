use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use tracing::info;

use domain::entities::products::{
    ActiveModel as ProductsActiveModel, Column, Entity as ProductsEntity, Model as Products,
};
use domain::repositories::products_repo::{ProductsRepository, SearchProductsOptions};
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ProductsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl ProductsRepository for ProductsRepoImpl {
    async fn create(&self, model: ProductsActiveModel) -> Result<Products, DomainError> {
        let res = ProductsEntity::insert(model).exec(&self.db).await?;
        let inserted_model = ProductsEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn create_many(&self, models: Vec<ProductsActiveModel>) -> Result<bool, DomainError> {
        info!("========== Before insert: models count = {}", models.len());

        let try_res = ProductsEntity::insert_many(models)
            .on_conflict(
                sea_orm::sea_query::OnConflict::column(Column::Upc)
                    .do_nothing()
                    .to_owned(),
            )
            .do_nothing()
            .exec(&self.db)
            .await?;

        let success = matches!(try_res, TryInsertResult::Inserted(_));
        info!(
            "========== Insert completed: {}",
            if success { "inserted" } else { "skipped" }
        );

        Ok(success)
    }

    async fn update(&self, model: ProductsActiveModel) -> Result<Products, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: &str) -> Result<(), DomainError> {
        ProductsEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_upc(&self, upc: &str) -> Result<Option<Products>, DomainError> {
        let res = ProductsEntity::find_by_id(upc).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_upcs(&self, upcs: Vec<String>) -> Result<Vec<Products>, DomainError> {
        let res = ProductsEntity::find()
            .filter(Column::Upc.is_in(upcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Products>, DomainError> {
        let res = ProductsEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_all(&self) -> Result<Vec<Products>, DomainError> {
        let res: Vec<Products> = ProductsEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn search(&self, options: SearchProductsOptions) -> Result<Vec<Products>, DomainError> {
        let mut query: Select<ProductsEntity> = ProductsEntity::find();

        if let Some(upc) = options.upc {
            query = query.filter(Column::Upc.eq(upc));
        }

        if let Some(product_title) = options.product_title {
            query = query.filter(Column::Title.contains(&product_title));
        }

        if let Some(product_type) = options.product_type {
            query = query.filter(Column::Type.eq(&product_type));
        }

        let res: Vec<Products> = query.all(&self.db).await?;
        Ok(res)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::products_repo::ProductsRepository;
    use sea_orm::{DbBackend, MockDatabase};

    #[tokio::test]
    async fn find_by_artist_id_filters_artist_products_for_dashboard() {
        // dashboard の release 起点集計が別 artist の product を混ぜないよう、artist_id filter を固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<Products>::new()])
            .into_connection();
        let repo = ProductsRepoImpl::new(db);

        repo.find_by_artist_id("artist-1").await.unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("products"), "{log}");
        assert!(log.contains("artist_id"), "{log}");
        assert!(log.contains(" = "), "{log}");
        assert!(log.contains("artist-1"), "{log}");
    }

    #[tokio::test]
    async fn get_by_upcs_filters_requested_release_ids() {
        // track 詳細で紐付く release だけを返すため、UPC list filter が外れないことを固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<Products>::new()])
            .into_connection();
        let repo = ProductsRepoImpl::new(db);

        repo.get_by_upcs(vec!["UPC1".to_string(), "UPC2".to_string()])
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("products"), "{log}");
        assert!(log.contains("upc"), "{log}");
        assert!(log.contains(" IN "), "{log}");
        assert!(log.contains("UPC1"), "{log}");
        assert!(log.contains("UPC2"), "{log}");
    }
}
