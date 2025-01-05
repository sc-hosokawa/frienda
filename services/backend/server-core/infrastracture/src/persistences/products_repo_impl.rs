use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::products::{
    ActiveModel as ProductsActiveModel, Column, Entity as ProductsEntity, Model as Products,
};
use domain::repositories::products_repo::ProductsRepository;
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

    async fn create_many(&self, models: Vec<ProductsActiveModel>) -> Result<(), DomainError> {
        let _res = ProductsEntity::insert_many(models)
            .on_conflict(
                sea_orm::sea_query::OnConflict::column(Column::Upc)
                    .do_nothing()
                    .to_owned(),
            )
            .exec(&self.db)
            .await?;
        Ok(())
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
}
