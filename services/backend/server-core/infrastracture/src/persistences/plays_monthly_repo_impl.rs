use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::plays_monthly::{
    ActiveModel as PlaysMonthlyActiveModel, Column, Entity as PlaysMonthlyEntity,
    Model as PlaysMonthly,
};
use domain::repositories::plays_monthly_repo::PlaysMonthlyRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct PlaysMonthlyRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl PlaysMonthlyRepository for PlaysMonthlyRepoImpl {
    async fn create(&self, model: PlaysMonthlyActiveModel) -> Result<PlaysMonthly, DomainError> {
        let res = PlaysMonthlyEntity::insert(model).exec(&self.db).await?;

        let inserted_model = PlaysMonthlyEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: PlaysMonthlyActiveModel) -> Result<PlaysMonthly, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysMonthly>, DomainError> {
        let res = PlaysMonthlyEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysMonthly>, DomainError> {
        let res = PlaysMonthlyEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError> {
        // 現在の日付から前月を取得
        let now = chrono::Local::now();
        let last_month = now
            .checked_sub_months(chrono::Months::new(1))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // 指定された月数分前の年月を計算
        let start_date = last_month
            .checked_sub_months(chrono::Months::new((period - 1) as u32))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // YYYYMMの形式で期間を取得
        let start_period: i32 = start_date
            .format("%Y%m")
            .to_string()
            .parse()
            .map_err(|_| DomainError::InvalidParameter("Invalid period format".to_string()))?;
        let end_period: i32 = last_month
            .format("%Y%m")
            .to_string()
            .parse()
            .map_err(|_| DomainError::InvalidParameter("Invalid period format".to_string()))?;

        let res = PlaysMonthlyEntity::find()
            .filter(Column::Month.gte(start_period))
            .filter(Column::Month.lte(end_period))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError> {
        // 現在の日付から前月を取得
        let now = chrono::Local::now();
        let last_month = now
            .checked_sub_months(chrono::Months::new(1))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // 指定された月数分前の年月を計算
        let start_date = last_month
            .checked_sub_months(chrono::Months::new((period - 1) as u32))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // YYYYMMの形式で期間を取得
        let start_period: i32 = start_date
            .format("%Y%m")
            .to_string()
            .parse()
            .map_err(|_| DomainError::InvalidParameter("Invalid period format".to_string()))?;
        let end_period: i32 = last_month
            .format("%Y%m")
            .to_string()
            .parse()
            .map_err(|_| DomainError::InvalidParameter("Invalid period format".to_string()))?;

        let res = PlaysMonthlyEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .filter(Column::Month.gte(start_period))
            .filter(Column::Month.lte(end_period))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysMonthly>, DomainError> {
        // 現在の日付から前月を取得
        let now = chrono::Local::now();
        let last_month = now
            .checked_sub_months(chrono::Months::new(1))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // 指定された月数分前の年月を計算
        let start_date = last_month
            .checked_sub_months(chrono::Months::new((period - 1) as u32))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // YYYYMMの形式で期間を取得
        let start_period: i32 = start_date
            .format("%Y%m")
            .to_string()
            .parse()
            .map_err(|_| DomainError::InvalidParameter("Invalid period format".to_string()))?;
        let end_period: i32 = last_month
            .format("%Y%m")
            .to_string()
            .parse()
            .map_err(|_| DomainError::InvalidParameter("Invalid period format".to_string()))?;

        let res = PlaysMonthlyEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Month.gte(start_period))
            .filter(Column::Month.lte(end_period))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}
