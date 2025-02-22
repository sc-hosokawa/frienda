use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::plays_yearly::{
    ActiveModel as PlaysYearlyActiveModel, Column, Entity as PlaysYearlyEntity,
    Model as PlaysYearly,
};
use domain::repositories::plays_yearly_repo::PlaysYearlyRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct PlaysYearlyRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl PlaysYearlyRepository for PlaysYearlyRepoImpl {
    async fn create(&self, model: PlaysYearlyActiveModel) -> Result<PlaysYearly, DomainError> {
        let res: InsertResult<PlaysYearlyActiveModel> =
            PlaysYearlyEntity::insert(model).exec(&self.db).await?;

        let inserted_model: Option<PlaysYearly> = PlaysYearlyEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: PlaysYearlyActiveModel) -> Result<PlaysYearly, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        let _res = PlaysYearlyEntity::delete_many()
            .filter(Column::Isrc.eq(isrc))
            .exec(&self.db)
            .await?;
        Ok(())
    }
}
