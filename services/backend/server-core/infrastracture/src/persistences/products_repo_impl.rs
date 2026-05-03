use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use tracing::info;

use domain::entities::products::{
    ActiveModel as ProductsActiveModel, Column, Entity as ProductsEntity, Model as Products,
};
use domain::entities::tracks::Model as Tracks;
use domain::repositories::products_repo::{
    DashboardProductRow, ProductsRepository, SearchProductsOptions,
};
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ProductsRepoImpl {
    db: DatabaseConnection,
}

#[derive(Debug, FromQueryResult)]
struct DashboardProductQueryRow {
    product_upc: String,
    product_title: String,
    product_img_url: Option<String>,
    product_type: Option<String>,
    product_distributed_at: Option<sea_orm::prelude::Date>,
    product_artist_id: Option<String>,
    track_isrc: Option<String>,
    track_img_url: Option<String>,
    track_title: Option<String>,
    track_artist_id: Option<String>,
}

impl DashboardProductQueryRow {
    fn into_dashboard_row(self) -> DashboardProductRow {
        let track = match (self.track_isrc, self.track_title) {
            (Some(isrc), Some(title)) => Some(Tracks {
                isrc,
                img_url: self.track_img_url,
                title,
                artist_id: self.track_artist_id,
            }),
            _ => None,
        };

        DashboardProductRow {
            product: Products {
                upc: self.product_upc,
                title: self.product_title,
                img_url: self.product_img_url,
                r#type: self.product_type,
                distributed_at: self.product_distributed_at,
                artist_id: self.product_artist_id,
            },
            track,
        }
    }
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

    async fn find_dashboard_products_by_artist_id(
        &self,
        artist_id: &str,
    ) -> Result<Vec<DashboardProductRow>, DomainError> {
        let rows = DashboardProductQueryRow::find_by_statement(Statement::from_sql_and_values(
            DbBackend::Postgres,
            r#"
            SELECT
                p.upc AS product_upc,
                p.title AS product_title,
                p.img_url AS product_img_url,
                p."type" AS product_type,
                p.distributed_at AS product_distributed_at,
                p.artist_id AS product_artist_id,
                t.isrc AS track_isrc,
                t.img_url AS track_img_url,
                t.title AS track_title,
                t.artist_id AS track_artist_id
            FROM products p
            LEFT JOIN product_track pt ON pt.upc = p.upc
            LEFT JOIN tracks t ON t.isrc = pt.isrc
            WHERE p.artist_id = $1
            ORDER BY p.distributed_at DESC NULLS LAST,
                pt.track_no ASC NULLS LAST,
                pt.id ASC
            "#,
            vec![artist_id.into()],
        ))
        .all(&self.db)
        .await?;

        Ok(rows
            .into_iter()
            .map(DashboardProductQueryRow::into_dashboard_row)
            .collect())
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
    use sea_orm::{DbBackend, MockDatabase, Value};
    use std::collections::BTreeMap;

    fn row(values: Vec<(&str, Value)>) -> BTreeMap<String, Value> {
        values
            .into_iter()
            .map(|(key, value)| (key.to_string(), value))
            .collect()
    }

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

    #[tokio::test]
    async fn find_dashboard_products_by_artist_id_left_joins_tracks_and_preserves_order_contract() {
        // get_products は 1 read で product を落とさず track を付けるため、products 起点の LEFT JOIN と dashboard 用順序を固定する。
        let date = chrono::NaiveDate::from_ymd_opt(2024, 6, 1).unwrap();
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("product_upc", Into::<Value>::into("UPC1")),
                ("product_title", Into::<Value>::into("Release")),
                ("product_img_url", Into::<Value>::into(Option::<String>::None)),
                ("product_type", Into::<Value>::into(Some("album".to_string()))),
                ("product_distributed_at", Into::<Value>::into(Some(date))),
                (
                    "product_artist_id",
                    Into::<Value>::into(Some("artist-1".to_string())),
                ),
                ("track_isrc", Into::<Value>::into(Option::<String>::None)),
                ("track_img_url", Into::<Value>::into(Option::<String>::None)),
                ("track_title", Into::<Value>::into(Option::<String>::None)),
                ("track_artist_id", Into::<Value>::into(Option::<String>::None)),
            ])]])
            .into_connection();
        let repo = ProductsRepoImpl::new(db);

        let result = repo
            .find_dashboard_products_by_artist_id("artist-1")
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].product.upc, "UPC1");
        assert_eq!(result[0].product.title, "Release");
        assert!(result[0].track.is_none());

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("FROM products p"), "{log}");
        assert!(log.contains("LEFT JOIN product_track pt ON pt.upc = p.upc"), "{log}");
        assert!(log.contains("LEFT JOIN tracks t ON t.isrc = pt.isrc"), "{log}");
        assert!(log.contains("WHERE p.artist_id = $1"), "{log}");
        assert!(log.contains("artist-1"), "{log}");
        assert!(log.contains("ORDER BY p.distributed_at DESC NULLS LAST"), "{log}");
        assert!(log.contains("pt.track_no ASC NULLS LAST"), "{log}");
        assert!(log.contains("pt.id ASC"), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }
}
