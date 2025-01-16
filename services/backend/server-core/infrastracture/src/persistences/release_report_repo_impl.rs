use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::release_report::{
    ActiveModel as ReleaseReportActiveModel, Column, Entity as ReleaseReportEntity,
    Model as ReleaseReport,
};
use domain::repositories::release_report_repo::ReleaseReportRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ReleaseReportRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl ReleaseReportRepository for ReleaseReportRepoImpl {
    async fn create(&self, model: ReleaseReportActiveModel) -> Result<ReleaseReport, DomainError> {
        let res = ReleaseReportEntity::insert(model).exec(&self.db).await?;
        let inserted_model: Option<ReleaseReport> =
            ReleaseReportEntity::find_by_id(res.last_insert_id)
                .one(&self.db)
                .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: ReleaseReportActiveModel) -> Result<ReleaseReport, DomainError> {
        let res: ReleaseReport = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        ReleaseReportEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_all(&self) -> Result<Vec<ReleaseReport>, DomainError> {
        let res: Vec<ReleaseReport> = ReleaseReportEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<ReleaseReport>, DomainError> {
        let res: Option<ReleaseReport> = ReleaseReportEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<ReleaseReport>, DomainError> {
        let res: Vec<ReleaseReport> = ReleaseReportEntity::find()
            .filter(Column::Id.is_in(ids))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}
