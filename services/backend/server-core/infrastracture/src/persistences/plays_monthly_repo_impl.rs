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
            .order_by_asc(Column::Month)
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

        // NaiveDate型に変換（時間部分を除去）
        let start_period = start_date.date_naive();
        let end_period = last_month.date_naive();

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

        // NaiveDate型に変換
        let start_period = start_date.date_naive();
        let end_period = last_month.date_naive();

        let res = PlaysMonthlyEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .filter(Column::Month.gte(start_period))
            .filter(Column::Month.lte(end_period))
            .order_by_asc(Column::Month)
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

        // NaiveDate型に変換
        let start_period = start_date.date_naive();
        let end_period = last_month.date_naive();

        let res = PlaysMonthlyEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Month.gte(start_period))
            .filter(Column::Month.lte(end_period))
            .order_by_asc(Column::Month)
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_total_play_count_all(&self) -> Result<i64, DomainError> {
        let res: Vec<PlaysMonthly> = PlaysMonthlyEntity::find().all(&self.db).await?;
        let total_play_count: i64 = res.iter().map(|play| play.sum.unwrap_or(0) as i64).sum();
        Ok(total_play_count)
    }

    async fn get_all(&self) -> Result<Vec<PlaysMonthly>, DomainError> {
        let res: Vec<PlaysMonthly> = PlaysMonthlyEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysMonthly>, DomainError> {
        // 現在の日付から前月を取得
        let now = chrono::Local::now();
        let last_month = now
            .checked_sub_months(chrono::Months::new(1))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // 指定された月数分前の年月を計算
        let start_date = last_month
            .checked_sub_months(chrono::Months::new((period - 1) as u32))
            .ok_or_else(|| DomainError::InvalidParameter("Invalid date calculation".to_string()))?;

        // NaiveDate型に変換
        let start_period = start_date.date_naive();
        let end_period = last_month.date_naive();

        let res: Vec<PlaysMonthly> = PlaysMonthlyEntity::find()
            .filter(Column::Month.gte(start_period))
            .filter(Column::Month.lte(end_period))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}
