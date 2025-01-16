use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::user_report::{
    ActiveModel as UserReportActiveModel, Column, Entity as UserReportEntity, Model as UserReport,
};
use domain::repositories::user_report_repo::UserReportRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct UserReportRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl UserReportRepository for UserReportRepoImpl {
    async fn create(&self, model: UserReportActiveModel) -> Result<UserReport, DomainError> {
        let res = UserReportEntity::insert(model).exec(&self.db).await?;
        let inserted_model: Option<UserReport> = UserReportEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: UserReportActiveModel) -> Result<UserReport, DomainError> {
        let res: UserReport = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        UserReportEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_all(&self) -> Result<Vec<UserReport>, DomainError> {
        let res: Vec<UserReport> = UserReportEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<UserReport>, DomainError> {
        let res: Option<UserReport> = UserReportEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<UserReport>, DomainError> {
        let res: Vec<UserReport> = UserReportEntity::find()
            .filter(Column::Id.is_in(ids))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}
