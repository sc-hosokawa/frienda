use async_trait::async_trait;
use chrono::{Duration, NaiveDate, Utc};
use derive_new::new;
use sea_orm::*;

use domain::entities::plays_daily::{
    ActiveModel as PlaysDailyActiveModel, Column, Entity as PlaysDailyEntity, Model as PlaysDaily,
};
use domain::repositories::plays_daily_repo::{
    OverviewPlayCountAggregate, PlayCountAggregate, PlaysDailyRepository,
};
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct PlaysDailyRepoImpl {
    db: DatabaseConnection,
}

#[derive(Debug, FromQueryResult)]
struct PlayCountAggregateRow {
    isrc: Option<String>,
    total: Option<i64>,
    spotify: Option<i64>,
    apple: Option<i64>,
    line: Option<i64>,
    amazon: Option<i64>,
    youtube: Option<i64>,
}

#[derive(Debug, Default, FromQueryResult)]
struct OverviewPlayCountAggregateRow {
    total: Option<i64>,
    weekly: Option<i64>,
}

impl OverviewPlayCountAggregateRow {
    fn into_aggregate(self) -> OverviewPlayCountAggregate {
        OverviewPlayCountAggregate {
            total: self.total.unwrap_or(0),
            weekly: self.weekly.unwrap_or(0),
        }
    }
}

impl PlayCountAggregateRow {
    fn into_aggregate(self) -> Option<PlayCountAggregate> {
        self.isrc.map(|isrc| PlayCountAggregate {
            isrc,
            total: self.total.unwrap_or(0),
            spotify: self.spotify.unwrap_or(0),
            apple: self.apple.unwrap_or(0),
            line: self.line.unwrap_or(0),
            amazon: self.amazon.unwrap_or(0),
            youtube: self.youtube.unwrap_or(0),
        })
    }
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
        if models.is_empty() {
            return Ok(());
        }

        let txn = self.db.begin().await?;
        for model in models {
            let _res: PlaysDaily = model.update(&txn).await?;
        }
        txn.commit().await?;

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

    async fn sum_by_isrcs_until(
        &self,
        isrcs: Vec<String>,
        end_date: sea_orm::prelude::Date,
    ) -> Result<i64, DomainError> {
        if isrcs.is_empty() {
            return Ok(0);
        }

        let total = PlaysDailyEntity::find()
            .select_only()
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .filter(Column::Date.lte(end_date))
            .column_as(sea_orm::sea_query::Expr::col(Column::Sum).sum(), "total")
            .into_tuple::<Option<i64>>()
            .one(&self.db)
            .await?;

        Ok(total.flatten().unwrap_or(0))
    }

    async fn sum_by_isrcs_between(
        &self,
        isrcs: Vec<String>,
        start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
    ) -> Result<i64, DomainError> {
        if isrcs.is_empty() {
            return Ok(0);
        }

        let total = PlaysDailyEntity::find()
            .select_only()
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .column_as(sea_orm::sea_query::Expr::col(Column::Sum).sum(), "total")
            .into_tuple::<Option<i64>>()
            .one(&self.db)
            .await?;

        Ok(total.flatten().unwrap_or(0))
    }

    async fn aggregate_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<sea_orm::prelude::Date>,
        end_date: Option<sea_orm::prelude::Date>,
        limit: Option<u64>,
    ) -> Result<Vec<PlayCountAggregate>, DomainError> {
        if isrcs.is_empty() {
            return Ok(vec![]);
        }

        let mut query = PlaysDailyEntity::find()
            .select_only()
            .column(Column::Isrc)
            .column_as(sea_orm::sea_query::Expr::col(Column::Sum).sum(), "total")
            .column_as(
                sea_orm::sea_query::Expr::col(Column::Spotify).sum(),
                "spotify",
            )
            .column_as(sea_orm::sea_query::Expr::col(Column::Apple).sum(), "apple")
            .column_as(sea_orm::sea_query::Expr::col(Column::Line).sum(), "line")
            .column_as(
                sea_orm::sea_query::Expr::col(Column::Amazon).sum(),
                "amazon",
            )
            .column_as(
                sea_orm::sea_query::Expr::col(Column::Youtube).sum(),
                "youtube",
            )
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .group_by(Column::Isrc);

        if let Some(start_date) = start_date {
            query = query.filter(Column::Date.gte(start_date));
        }

        if let Some(end_date) = end_date {
            query = query.filter(Column::Date.lte(end_date));
        }

        if let Some(limit) = limit {
            query = query
                .order_by_desc(sea_orm::sea_query::Expr::col(
                    sea_orm::sea_query::Alias::new("total"),
                ))
                .limit(limit);
        }

        let rows: Vec<PlayCountAggregateRow> = query
            .into_model::<PlayCountAggregateRow>()
            .all(&self.db)
            .await?;

        Ok(rows
            .into_iter()
            .filter_map(PlayCountAggregateRow::into_aggregate)
            .collect())
    }

    async fn aggregate_overview_by_artist_id(
        &self,
        artist_id: &str,
        weekly_start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError> {
        let row = OverviewPlayCountAggregateRow::find_by_statement(Statement::from_sql_and_values(
            DbBackend::Postgres,
            r#"
            SELECT
                COALESCE(SUM(COALESCE(pd."sum", 0)), 0)::BIGINT AS total,
                COALESCE(SUM(
                    CASE
                        WHEN pd."date" >= $2 THEN COALESCE(pd."sum", 0)
                        ELSE 0
                    END
                ), 0)::BIGINT AS weekly
            FROM products p
            INNER JOIN product_track pt ON pt.upc = p.upc
            INNER JOIN plays_daily pd ON pd.isrc = pt.isrc
            WHERE p.artist_id = $1
                AND pd.isrc IS NOT NULL
                AND pd."date" IS NOT NULL
                AND pd."date" <= $3
            "#,
            vec![artist_id.into(), weekly_start_date.into(), end_date.into()],
        ))
        .one(&self.db)
        .await?;

        Ok(row.unwrap_or_default().into_aggregate())
    }

    async fn aggregate_overview_by_upc(
        &self,
        upc: &str,
        weekly_start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
    ) -> Result<OverviewPlayCountAggregate, DomainError> {
        let row = OverviewPlayCountAggregateRow::find_by_statement(Statement::from_sql_and_values(
            DbBackend::Postgres,
            r#"
            SELECT
                COALESCE(SUM(COALESCE(pd."sum", 0)), 0)::BIGINT AS total,
                COALESCE(SUM(
                    CASE
                        WHEN pd."date" >= $2 THEN COALESCE(pd."sum", 0)
                        ELSE 0
                    END
                ), 0)::BIGINT AS weekly
            FROM product_track pt
            INNER JOIN plays_daily pd ON pd.isrc = pt.isrc
            WHERE pt.upc = $1
                AND pd.isrc IS NOT NULL
                AND pd."date" IS NOT NULL
                AND pd."date" <= $3
            "#,
            vec![upc.into(), weekly_start_date.into(), end_date.into()],
        ))
        .one(&self.db)
        .await?;

        Ok(row.unwrap_or_default().into_aggregate())
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

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::plays_daily_repo::PlaysDailyRepository;
    use sea_orm::{ActiveValue::Set, DbBackend, DbErr, MockDatabase, MockExecResult, Value};
    use std::collections::BTreeMap;

    fn row(values: Vec<(&str, Value)>) -> BTreeMap<String, Value> {
        values
            .into_iter()
            .map(|(key, value)| (key.to_string(), value))
            .collect()
    }

    fn model(id: i32) -> PlaysDaily {
        PlaysDaily {
            id,
            isrc: Some(format!("ISRC{id}")),
            date: Some(NaiveDate::from_ymd_opt(2026, 1, id as u32).unwrap()),
            spotify: 10,
            apple: 20,
            line: 30,
            amazon: Some(40),
            youtube: Some(50),
            sum: Some(150),
        }
    }

    fn active_model(id: i32) -> PlaysDailyActiveModel {
        PlaysDailyActiveModel {
            id: Set(id),
            isrc: Set(Some(format!("ISRC{id}"))),
            date: Set(Some(NaiveDate::from_ymd_opt(2026, 1, id as u32).unwrap())),
            spotify: Set(10),
            apple: Set(20),
            line: Set(30),
            amazon: Set(Some(40)),
            youtube: Set(Some(50)),
            sum: Set(Some(150)),
        }
    }

    fn assert_transaction_contains(log: String, expected: &[&str]) {
        for expected_statement in expected {
            assert!(
                log.contains(expected_statement),
                "transaction log did not contain {expected_statement}: {log}"
            );
        }
    }

    #[tokio::test]
    async fn update_many_wraps_all_updates_in_one_transaction() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_exec_results([
                MockExecResult {
                    last_insert_id: 0,
                    rows_affected: 1,
                },
                MockExecResult {
                    last_insert_id: 0,
                    rows_affected: 1,
                },
            ])
            .append_query_results([[model(1)], [model(2)]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);

        repo.update_many(vec![active_model(1), active_model(2)])
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert_transaction_contains(log.clone(), &["BEGIN", "UPDATE", "COMMIT"]);
        assert_eq!(log.matches("UPDATE").count(), 2);
        assert!(!log.contains("ROLLBACK"));
    }

    #[tokio::test]
    async fn update_many_rolls_back_when_an_update_fails() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_exec_results([MockExecResult {
                last_insert_id: 0,
                rows_affected: 1,
            }])
            .append_exec_errors([DbErr::Custom("second update failed".to_string())])
            .append_query_results([[model(1)]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);

        let result = repo
            .update_many(vec![active_model(1), active_model(2)])
            .await;

        assert!(result.is_err());
        let log = format!("{:?}", repo.db.into_transaction_log());
        assert_transaction_contains(log.clone(), &["BEGIN", "UPDATE", "ROLLBACK"]);
        assert_eq!(log.matches("UPDATE").count(), 2);
        assert!(!log.contains("COMMIT"));
    }

    #[tokio::test]
    async fn update_many_empty_input_does_not_start_transaction() {
        let db = MockDatabase::new(DbBackend::Postgres).into_connection();
        let repo = PlaysDailyRepoImpl::new(db);

        repo.update_many(vec![]).await.unwrap();

        assert!(repo.db.into_transaction_log().is_empty());
    }

    #[tokio::test]
    async fn aggregate_by_isrcs_maps_null_sums_to_zero_and_skips_null_isrc() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[
                row(vec![
                    ("isrc", Into::<Value>::into("ISRC1")),
                    ("total", Into::<Value>::into(70_i64)),
                    ("spotify", Into::<Value>::into(30_i64)),
                    ("apple", Into::<Value>::into(20_i64)),
                    ("line", Into::<Value>::into(20_i64)),
                    ("amazon", Into::<Value>::into(Option::<i64>::None)),
                    ("youtube", Into::<Value>::into(Option::<i64>::None)),
                ]),
                row(vec![
                    ("isrc", Into::<Value>::into(Option::<String>::None)),
                    ("total", Into::<Value>::into(99_i64)),
                    ("spotify", Into::<Value>::into(99_i64)),
                    ("apple", Into::<Value>::into(0_i64)),
                    ("line", Into::<Value>::into(0_i64)),
                    ("amazon", Into::<Value>::into(0_i64)),
                    ("youtube", Into::<Value>::into(0_i64)),
                ]),
            ]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 1).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .aggregate_by_isrcs(
                vec!["ISRC1".to_string(), "ISRC2".to_string()],
                Some(start),
                Some(end),
                Some(5),
            )
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].isrc, "ISRC1");
        assert_eq!(result[0].total, 70);
        assert_eq!(result[0].spotify, 30);
        assert_eq!(result[0].amazon, 0);
        assert_eq!(result[0].youtube, 0);
    }

    #[tokio::test]
    async fn sum_by_isrcs_until_returns_zero_when_database_sum_is_null() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![(
                "total",
                Into::<Value>::into(Option::<i64>::None),
            )])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .sum_by_isrcs_until(vec!["ISRC1".to_string()], end)
            .await
            .unwrap();

        assert_eq!(result, 0);
    }

    #[tokio::test]
    async fn aggregate_overview_by_artist_id_maps_null_sums_to_zero_and_joins_release_tables() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("total", Into::<Value>::into(Option::<i64>::None)),
                ("weekly", Into::<Value>::into(Option::<i64>::None)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 22).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 28).unwrap();

        let result = repo
            .aggregate_overview_by_artist_id("artist-1", start, end)
            .await
            .unwrap();

        assert_eq!(result.total, 0);
        assert_eq!(result.weekly, 0);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("FROM products p"), "{log}");
        assert!(log.contains("INNER JOIN product_track pt"), "{log}");
        assert!(log.contains("INNER JOIN plays_daily pd"), "{log}");
        assert!(log.contains("p.artist_id = $1"), "{log}");
    }

    #[tokio::test]
    async fn aggregate_overview_by_upc_returns_total_and_weekly_from_one_query() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("total", Into::<Value>::into(250_i64)),
                ("weekly", Into::<Value>::into(90_i64)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 22).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 28).unwrap();

        let result = repo
            .aggregate_overview_by_upc("UPC1", start, end)
            .await
            .unwrap();

        assert_eq!(result.total, 250);
        assert_eq!(result.weekly, 90);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("FROM product_track pt"), "{log}");
        assert!(log.contains("INNER JOIN plays_daily pd"), "{log}");
        assert!(log.contains("pt.upc = $1"), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }
}
