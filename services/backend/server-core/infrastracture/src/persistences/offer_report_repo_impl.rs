use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::offer_report::{
    ActiveModel as OfferReportActiveModel, Column, Entity as OfferReportEntity,
    Model as OfferReport,
};
use domain::repositories::offer_report_repo::OfferReportRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct OfferReportRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl OfferReportRepository for OfferReportRepoImpl {
    async fn create(&self, model: OfferReportActiveModel) -> Result<OfferReport, DomainError> {
        let res = OfferReportEntity::insert(model).exec(&self.db).await?;
        let inserted_model: Option<OfferReport> = OfferReportEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: OfferReportActiveModel) -> Result<OfferReport, DomainError> {
        let res: OfferReport = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        OfferReportEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_all(&self) -> Result<Vec<OfferReport>, DomainError> {
        let res: Vec<OfferReport> = OfferReportEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<OfferReport>, DomainError> {
        let res: Option<OfferReport> = OfferReportEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<OfferReport>, DomainError> {
        let res: Vec<OfferReport> = OfferReportEntity::find()
            .filter(Column::Id.is_in(ids))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}
