use async_trait::async_trait;
use chrono::{Duration, NaiveDate, Utc};
use derive_new::new;
use sea_orm::*;

use domain::entities::plays_daily::{
    ActiveModel as PlaysDailyActiveModel, Column, Entity as PlaysDailyEntity, Model as PlaysDaily,
};
use domain::repositories::plays_daily_repo::PlaysDailyRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct PlaysDailyRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl PlaysDailyRepository for PlaysDailyRepoImpl {
    async fn create(&self, model: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError> {
        let res: InsertResult<PlaysDailyActiveModel> =
            PlaysDailyEntity::insert(model).exec(&self.db).await?;

        let inserted_model = PlaysDailyEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: PlaysDailyActiveModel) -> Result<PlaysDaily, DomainError> {
        let res: PlaysDaily = model.update(&self.db).await?;
        Ok(res)
    }

    async fn update_many(&self, models: Vec<PlaysDailyActiveModel>) -> Result<(), DomainError> {
        for model in models {
            let _res: PlaysDaily = model.update(&self.db).await?;
        }
        Ok(())
    }

    async fn insert_many(&self, models: Vec<PlaysDailyActiveModel>) -> Result<(), DomainError> {
        let _res = PlaysDailyEntity::insert_many(models).exec(&self.db).await?;
        Ok(())
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<PlaysDaily>, DomainError> {
        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<PlaysDaily>, DomainError> {
        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError> {
        // Calculate date range
        let end_date = (Utc::now() - Duration::days(2)).date_naive();
        let start_date = end_date - Duration::days(period as i64);

        // Query records within date range
        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .all(&self.db)
            .await?;

        Ok(res)
    }

    async fn find_by_isrc_and_period(
        &self,
        isrc: &str,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError> {
        // Calculate date range
        let end_date = (Utc::now() - Duration::days(2)).date_naive();
        let start_date = end_date - Duration::days(period as i64);

        // Query records within date range and ISRC
        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .all(&self.db)
            .await?;

        Ok(res)
    }

    async fn find_by_isrcs_and_period(
        &self,
        isrcs: Vec<String>,
        period: i32,
    ) -> Result<Vec<PlaysDaily>, DomainError> {
        // Calculate date range
        let end_date = (Utc::now() - Duration::days(2)).date_naive();
        let start_date = end_date - Duration::days(period as i64);

        // Query records within date range and ISRCs
        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .all(&self.db)
            .await?;

        Ok(res)
    }

    async fn get_all_by_period(&self, period: i32) -> Result<Vec<PlaysDaily>, DomainError> {
        let end_date = (Utc::now() - Duration::days(2)).date_naive();
        let start_date = end_date - Duration::days(period as i64);

        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_lastest_id(&self) -> Result<i32, DomainError> {
        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .order_by(Column::Id, Order::Desc)
            .limit(1)
            .all(&self.db)
            .await?;

        Ok(res.first().map_or(0, |record| record.id))
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        let _res = PlaysDailyEntity::delete_many()
            .filter(Column::Isrc.eq(isrc))
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn find_by_date(&self, date: &str) -> Result<Vec<PlaysDaily>, DomainError> {
        let target_date = parse_date_flexible(date)?;

        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Date.eq(target_date))
            .all(&self.db)
            .await
            .map_err(|e| DomainError::DatabaseError(e.to_string()))?;
        Ok(res)
    }

    async fn find_between_start_and_end(
        &self,
        start_date: &str,
        end_date: &str,
    ) -> Result<Vec<PlaysDaily>, DomainError> {
        let start_date = parse_date_flexible(start_date)?;
        let end_date = parse_date_flexible(end_date)?;

        tracing::trace!("Query data between {} and {}", start_date, end_date);

        let res: Vec<PlaysDaily> = PlaysDailyEntity::find()
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .all(&self.db)
            .await?;

        Ok(res)
    }
}

fn parse_flexible_date_from_str(date: &str) -> Result<NaiveDate, DomainError> {
    tracing::info!("Attempting to parse date: {}", date);

    let normalized_date = date.replace("/", "-");

    // Try YYYY-MM-DD (also handles YYYY/MM/DD after normalization)
    if let Ok(d) = NaiveDate::parse_from_str(&normalized_date, "%Y-%m-%d") {
        return Ok(d);
    }

    // Try YYYYMMDD
    if let Ok(d) = NaiveDate::parse_from_str(&normalized_date, "%Y%m%d") {
        return Ok(d);
    }

    tracing::error!(
        "Date parse error: input contains invalid characters or format for input: {}",
        normalized_date
    );
    Err(DomainError::DatabaseError(format!(
        "Invalid date format: {}",
        normalized_date
    )))
}

fn parse_date_flexible(date: &str) -> Result<NaiveDate, DomainError> {
    parse_flexible_date_from_str(date)
}
