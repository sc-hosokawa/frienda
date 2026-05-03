use async_trait::async_trait;
use chrono::{Duration, NaiveDate, Utc};
use derive_new::new;
use sea_orm::*;

use domain::entities::plays_daily::{
    ActiveModel as PlaysDailyActiveModel, Column, Entity as PlaysDailyEntity, Model as PlaysDaily,
};
use domain::entities::tracks::{Column as TracksColumn, Entity as TracksEntity};
use domain::repositories::plays_daily_repo::{
    OverviewPlayCountAggregate, PlayCountAggregate, PlayCountDspHistoryAggregate,
    PlayCountTrackHistoryAggregate, PlaysDailyRepository, TrendingTrackAggregate,
};
use shared::error::domain_err::DomainError;
use shared::numeric::checked_u64_to_i64;

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

#[derive(Debug, Default, FromQueryResult)]
struct TrendingTrackAggregateRow {
    isrc: Option<String>,
    track_title: Option<String>,
    upc_title: Option<String>,
    image_url: Option<String>,
    total: Option<i64>,
    weekly: Option<i64>,
    total_spotify: Option<i64>,
    total_apple: Option<i64>,
    total_line: Option<i64>,
    total_amazon: Option<i64>,
    total_youtube: Option<i64>,
    weekly_spotify: Option<i64>,
    weekly_apple: Option<i64>,
    weekly_line: Option<i64>,
    weekly_amazon: Option<i64>,
    weekly_youtube: Option<i64>,
}

#[derive(Debug, FromQueryResult)]
struct DspHistoryAggregateRow {
    date: Option<NaiveDate>,
    spotify: Option<i64>,
    apple: Option<i64>,
    line: Option<i64>,
    amazon: Option<i64>,
    youtube: Option<i64>,
}

#[derive(Debug, FromQueryResult)]
struct DspMonthlyHistoryAggregateRow {
    date: Option<String>,
    spotify: Option<i64>,
    apple: Option<i64>,
    line: Option<i64>,
    amazon: Option<i64>,
    youtube: Option<i64>,
}

#[derive(Debug, FromQueryResult)]
struct TrackHistoryAggregateRow {
    date: Option<NaiveDate>,
    track_title: Option<String>,
    total: Option<i64>,
}

#[derive(Debug, FromQueryResult)]
struct TrackMonthlyHistoryAggregateRow {
    date: Option<String>,
    track_title: Option<String>,
    total: Option<i64>,
}

impl OverviewPlayCountAggregateRow {
    fn into_aggregate(self) -> OverviewPlayCountAggregate {
        OverviewPlayCountAggregate {
            total: self.total.unwrap_or(0),
            weekly: self.weekly.unwrap_or(0),
        }
    }
}

impl TrendingTrackAggregateRow {
    fn into_aggregate(self) -> Option<TrendingTrackAggregate> {
        self.isrc.map(|isrc| TrendingTrackAggregate {
            isrc,
            track_title: self.track_title,
            upc_title: self.upc_title,
            image_url: self.image_url,
            total: self.total.unwrap_or(0),
            weekly: self.weekly.unwrap_or(0),
            total_spotify: self.total_spotify.unwrap_or(0),
            total_apple: self.total_apple.unwrap_or(0),
            total_line: self.total_line.unwrap_or(0),
            total_amazon: self.total_amazon.unwrap_or(0),
            total_youtube: self.total_youtube.unwrap_or(0),
            weekly_spotify: self.weekly_spotify.unwrap_or(0),
            weekly_apple: self.weekly_apple.unwrap_or(0),
            weekly_line: self.weekly_line.unwrap_or(0),
            weekly_amazon: self.weekly_amazon.unwrap_or(0),
            weekly_youtube: self.weekly_youtube.unwrap_or(0),
        })
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

impl DspHistoryAggregateRow {
    fn into_aggregate(self) -> Option<PlayCountDspHistoryAggregate> {
        self.date.map(|date| PlayCountDspHistoryAggregate {
            date: date.format("%Y-%m-%d").to_string(),
            spotify: self.spotify.unwrap_or(0),
            apple: self.apple.unwrap_or(0),
            line: self.line.unwrap_or(0),
            amazon: self.amazon.unwrap_or(0),
            youtube: self.youtube.unwrap_or(0),
        })
    }
}

impl DspMonthlyHistoryAggregateRow {
    fn into_aggregate(self) -> Option<PlayCountDspHistoryAggregate> {
        self.date.map(|date| PlayCountDspHistoryAggregate {
            date,
            spotify: self.spotify.unwrap_or(0),
            apple: self.apple.unwrap_or(0),
            line: self.line.unwrap_or(0),
            amazon: self.amazon.unwrap_or(0),
            youtube: self.youtube.unwrap_or(0),
        })
    }
}

impl TrackHistoryAggregateRow {
    fn into_aggregate(self) -> Option<PlayCountTrackHistoryAggregate> {
        Some(PlayCountTrackHistoryAggregate {
            date: self.date?.format("%Y-%m-%d").to_string(),
            track_title: self.track_title?,
            total: self.total.unwrap_or(0),
        })
    }
}

impl TrackMonthlyHistoryAggregateRow {
    fn into_aggregate(self) -> Option<PlayCountTrackHistoryAggregate> {
        Some(PlayCountTrackHistoryAggregate {
            date: self.date?,
            track_title: self.track_title?,
            total: self.total.unwrap_or(0),
        })
    }
}

fn coalesced_sum(column: &str) -> sea_orm::sea_query::SimpleExpr {
    sea_orm::sea_query::Expr::cust(format!(
        "COALESCE(SUM(COALESCE(\"plays_daily\".\"{}\", 0)), 0)",
        column
    ))
}

fn month_key_expr() -> sea_orm::sea_query::SimpleExpr {
    sea_orm::sea_query::Expr::cust("TO_CHAR(\"plays_daily\".\"date\", 'YYYY-MM')")
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
            WITH artist_isrcs AS (
                SELECT DISTINCT pt.isrc
                FROM products p
                INNER JOIN product_track pt ON pt.upc = p.upc
                WHERE p.artist_id = $1
                    AND pt.isrc IS NOT NULL
            )
            SELECT
                COALESCE(SUM(COALESCE(pd."sum", 0)), 0)::BIGINT AS total,
                COALESCE(SUM(
                    CASE
                        WHEN pd."date" >= $2 THEN COALESCE(pd."sum", 0)
                        ELSE 0
                    END
                ), 0)::BIGINT AS weekly
            FROM artist_isrcs ai
            INNER JOIN plays_daily pd ON pd.isrc = ai.isrc
            WHERE pd.isrc IS NOT NULL
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

    async fn aggregate_trending_by_artist_id(
        &self,
        artist_id: &str,
        weekly_start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
        limit: u64,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError> {
        let rows = TrendingTrackAggregateRow::find_by_statement(Statement::from_sql_and_values(
            DbBackend::Postgres,
            r#"
            WITH artist_tracks AS (
                SELECT DISTINCT ON (pt.isrc)
                    pt.isrc,
                    t.title AS track_title,
                    p.title AS upc_title,
                    p.img_url AS image_url,
                    pt.id AS product_track_id
                FROM products p
                INNER JOIN product_track pt ON pt.upc = p.upc
                INNER JOIN tracks t ON t.isrc = pt.isrc
                WHERE p.artist_id = $1
                ORDER BY pt.isrc, pt.id ASC
            ),
            play_counts AS (
                SELECT
                    pd.isrc,
                    COALESCE(SUM(COALESCE(pd."sum", 0)), 0)::BIGINT AS total,
                    COALESCE(SUM(
                        CASE WHEN pd."date" >= $2 THEN COALESCE(pd."sum", 0) ELSE 0 END
                    ), 0)::BIGINT AS weekly,
                    COALESCE(SUM(COALESCE(pd.spotify, 0)), 0)::BIGINT AS total_spotify,
                    COALESCE(SUM(COALESCE(pd.apple, 0)), 0)::BIGINT AS total_apple,
                    COALESCE(SUM(COALESCE(pd.line, 0)), 0)::BIGINT AS total_line,
                    COALESCE(SUM(COALESCE(pd.amazon, 0)), 0)::BIGINT AS total_amazon,
                    COALESCE(SUM(COALESCE(pd.youtube, 0)), 0)::BIGINT AS total_youtube,
                    COALESCE(SUM(
                        CASE WHEN pd."date" >= $2 THEN COALESCE(pd.spotify, 0) ELSE 0 END
                    ), 0)::BIGINT AS weekly_spotify,
                    COALESCE(SUM(
                        CASE WHEN pd."date" >= $2 THEN COALESCE(pd.apple, 0) ELSE 0 END
                    ), 0)::BIGINT AS weekly_apple,
                    COALESCE(SUM(
                        CASE WHEN pd."date" >= $2 THEN COALESCE(pd.line, 0) ELSE 0 END
                    ), 0)::BIGINT AS weekly_line,
                    COALESCE(SUM(
                        CASE WHEN pd."date" >= $2 THEN COALESCE(pd.amazon, 0) ELSE 0 END
                    ), 0)::BIGINT AS weekly_amazon,
                    COALESCE(SUM(
                        CASE WHEN pd."date" >= $2 THEN COALESCE(pd.youtube, 0) ELSE 0 END
                    ), 0)::BIGINT AS weekly_youtube
                FROM plays_daily pd
                INNER JOIN artist_tracks atr ON atr.isrc = pd.isrc
                WHERE pd.isrc IS NOT NULL
                    AND pd."date" IS NOT NULL
                    AND pd."date" <= $3
                GROUP BY pd.isrc
            )
            SELECT
                atr.isrc,
                atr.track_title,
                atr.upc_title,
                atr.image_url,
                pc.total,
                pc.weekly,
                pc.total_spotify,
                pc.total_apple,
                pc.total_line,
                pc.total_amazon,
                pc.total_youtube,
                pc.weekly_spotify,
                pc.weekly_apple,
                pc.weekly_line,
                pc.weekly_amazon,
                pc.weekly_youtube
            FROM artist_tracks atr
            INNER JOIN play_counts pc ON pc.isrc = atr.isrc
            ORDER BY pc.total DESC, atr.isrc ASC
            LIMIT $4
            "#,
            vec![
                artist_id.into(),
                weekly_start_date.into(),
                end_date.into(),
                checked_u64_to_i64(limit, "trending_limit")
                    .map_err(DomainError::InvalidParameter)?
                    .into(),
            ],
        ))
        .all(&self.db)
        .await?;

        Ok(rows
            .into_iter()
            .filter_map(TrendingTrackAggregateRow::into_aggregate)
            .collect())
    }

    async fn aggregate_trending_by_upc(
        &self,
        upc: &str,
        weekly_start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
    ) -> Result<Vec<TrendingTrackAggregate>, DomainError> {
        let rows = TrendingTrackAggregateRow::find_by_statement(Statement::from_sql_and_values(
            DbBackend::Postgres,
            r#"
            SELECT
                pt.isrc,
                t.title AS track_title,
                NULL::VARCHAR AS upc_title,
                NULL::VARCHAR AS image_url,
                COALESCE(SUM(COALESCE(pd."sum", 0)), 0)::BIGINT AS total,
                COALESCE(SUM(
                    CASE WHEN pd."date" >= $2 THEN COALESCE(pd."sum", 0) ELSE 0 END
                ), 0)::BIGINT AS weekly,
                COALESCE(SUM(COALESCE(pd.spotify, 0)), 0)::BIGINT AS total_spotify,
                COALESCE(SUM(COALESCE(pd.apple, 0)), 0)::BIGINT AS total_apple,
                COALESCE(SUM(COALESCE(pd.line, 0)), 0)::BIGINT AS total_line,
                COALESCE(SUM(COALESCE(pd.amazon, 0)), 0)::BIGINT AS total_amazon,
                COALESCE(SUM(COALESCE(pd.youtube, 0)), 0)::BIGINT AS total_youtube,
                COALESCE(SUM(
                    CASE WHEN pd."date" >= $2 THEN COALESCE(pd.spotify, 0) ELSE 0 END
                ), 0)::BIGINT AS weekly_spotify,
                COALESCE(SUM(
                    CASE WHEN pd."date" >= $2 THEN COALESCE(pd.apple, 0) ELSE 0 END
                ), 0)::BIGINT AS weekly_apple,
                COALESCE(SUM(
                    CASE WHEN pd."date" >= $2 THEN COALESCE(pd.line, 0) ELSE 0 END
                ), 0)::BIGINT AS weekly_line,
                COALESCE(SUM(
                    CASE WHEN pd."date" >= $2 THEN COALESCE(pd.amazon, 0) ELSE 0 END
                ), 0)::BIGINT AS weekly_amazon,
                COALESCE(SUM(
                    CASE WHEN pd."date" >= $2 THEN COALESCE(pd.youtube, 0) ELSE 0 END
                ), 0)::BIGINT AS weekly_youtube
            FROM product_track pt
            INNER JOIN tracks t ON t.isrc = pt.isrc
            LEFT JOIN plays_daily pd
                ON pd.isrc = pt.isrc
                AND pd.isrc IS NOT NULL
                AND pd."date" IS NOT NULL
                AND pd."date" <= $3
            WHERE pt.upc = $1
            GROUP BY pt.id, pt.isrc, t.title, pt.track_no
            ORDER BY pt.track_no ASC NULLS LAST, pt.id ASC
            "#,
            vec![upc.into(), weekly_start_date.into(), end_date.into()],
        ))
        .all(&self.db)
        .await?;

        Ok(rows
            .into_iter()
            .filter_map(TrendingTrackAggregateRow::into_aggregate)
            .collect())
    }

    async fn aggregate_daily_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError> {
        if isrcs.is_empty() {
            return Ok(vec![]);
        }

        let rows: Vec<DspHistoryAggregateRow> = PlaysDailyEntity::find()
            .select_only()
            .column(Column::Date)
            .column_as(coalesced_sum("spotify"), "spotify")
            .column_as(coalesced_sum("apple"), "apple")
            .column_as(coalesced_sum("line"), "line")
            .column_as(coalesced_sum("amazon"), "amazon")
            .column_as(coalesced_sum("youtube"), "youtube")
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .group_by(Column::Date)
            .order_by_asc(Column::Date)
            .into_model::<DspHistoryAggregateRow>()
            .all(&self.db)
            .await?;

        Ok(rows
            .into_iter()
            .filter_map(DspHistoryAggregateRow::into_aggregate)
            .collect())
    }

    async fn aggregate_monthly_dsp_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<sea_orm::prelude::Date>,
        end_date: Option<sea_orm::prelude::Date>,
    ) -> Result<Vec<PlayCountDspHistoryAggregate>, DomainError> {
        if isrcs.is_empty() {
            return Ok(vec![]);
        }

        let mut query = PlaysDailyEntity::find()
            .select_only()
            .column_as(month_key_expr(), "date")
            .column_as(coalesced_sum("spotify"), "spotify")
            .column_as(coalesced_sum("apple"), "apple")
            .column_as(coalesced_sum("line"), "line")
            .column_as(coalesced_sum("amazon"), "amazon")
            .column_as(coalesced_sum("youtube"), "youtube")
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .group_by(month_key_expr())
            .order_by_asc(month_key_expr());

        if let Some(start_date) = start_date {
            query = query.filter(Column::Date.gte(start_date));
        }
        if let Some(end_date) = end_date {
            query = query.filter(Column::Date.lte(end_date));
        }

        let rows: Vec<DspMonthlyHistoryAggregateRow> = query
            .into_model::<DspMonthlyHistoryAggregateRow>()
            .all(&self.db)
            .await?;

        Ok(rows
            .into_iter()
            .filter_map(DspMonthlyHistoryAggregateRow::into_aggregate)
            .collect())
    }

    async fn aggregate_daily_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: sea_orm::prelude::Date,
        end_date: sea_orm::prelude::Date,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError> {
        if isrcs.is_empty() {
            return Ok(vec![]);
        }

        let rows: Vec<TrackHistoryAggregateRow> = PlaysDailyEntity::find()
            .select_only()
            .column(Column::Date)
            .column_as(
                sea_orm::sea_query::Expr::col((TracksEntity, TracksColumn::Title)),
                "track_title",
            )
            .column_as(coalesced_sum("sum"), "total")
            .join(
                JoinType::InnerJoin,
                domain::entities::plays_daily::Relation::Tracks.def(),
            )
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .filter(Column::Date.gte(start_date))
            .filter(Column::Date.lte(end_date))
            .group_by(Column::Date)
            .group_by(sea_orm::sea_query::Expr::col((
                TracksEntity,
                TracksColumn::Title,
            )))
            .order_by_asc(Column::Date)
            .order_by_asc(sea_orm::sea_query::Expr::col((
                TracksEntity,
                TracksColumn::Title,
            )))
            .into_model::<TrackHistoryAggregateRow>()
            .all(&self.db)
            .await?;

        Ok(rows
            .into_iter()
            .filter_map(TrackHistoryAggregateRow::into_aggregate)
            .collect())
    }

    async fn aggregate_monthly_track_history_by_isrcs(
        &self,
        isrcs: Vec<String>,
        start_date: Option<sea_orm::prelude::Date>,
        end_date: Option<sea_orm::prelude::Date>,
    ) -> Result<Vec<PlayCountTrackHistoryAggregate>, DomainError> {
        if isrcs.is_empty() {
            return Ok(vec![]);
        }

        let mut query = PlaysDailyEntity::find()
            .select_only()
            .column_as(month_key_expr(), "date")
            .column_as(
                sea_orm::sea_query::Expr::col((TracksEntity, TracksColumn::Title)),
                "track_title",
            )
            .column_as(coalesced_sum("sum"), "total")
            .join(
                JoinType::InnerJoin,
                domain::entities::plays_daily::Relation::Tracks.def(),
            )
            .filter(Column::Isrc.is_in(isrcs))
            .filter(Column::Isrc.is_not_null())
            .filter(Column::Date.is_not_null())
            .group_by(month_key_expr())
            .group_by(sea_orm::sea_query::Expr::col((
                TracksEntity,
                TracksColumn::Title,
            )))
            .order_by_asc(month_key_expr())
            .order_by_asc(sea_orm::sea_query::Expr::col((
                TracksEntity,
                TracksColumn::Title,
            )));

        if let Some(start_date) = start_date {
            query = query.filter(Column::Date.gte(start_date));
        }
        if let Some(end_date) = end_date {
            query = query.filter(Column::Date.lte(end_date));
        }

        let rows: Vec<TrackMonthlyHistoryAggregateRow> = query
            .into_model::<TrackMonthlyHistoryAggregateRow>()
            .all(&self.db)
            .await?;

        Ok(rows
            .into_iter()
            .filter_map(TrackMonthlyHistoryAggregateRow::into_aggregate)
            .collect())
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
        // 集計 DTO では DB の NULL 集計結果を 0 に寄せ、ISRC がない行を dashboard 集計から除外する。
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
        // 対象再生がない SUM は NULL になり得るため、overview では 0 として扱うことを固定する。
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
        // artist overview は product_track 重複で同じ ISRC を二重集計しないよう、ISRC を先に dedupe する。
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
        assert!(log.contains("WITH artist_isrcs AS"), "{log}");
        assert!(log.contains("SELECT DISTINCT pt.isrc"), "{log}");
        assert!(log.contains("FROM products p"), "{log}");
        assert!(log.contains("INNER JOIN product_track pt"), "{log}");
        assert!(log.contains("INNER JOIN plays_daily pd"), "{log}");
        assert!(log.contains("p.artist_id = $1"), "{log}");
    }

    #[tokio::test]
    async fn aggregate_overview_by_upc_returns_total_and_weekly_from_one_query() {
        // UPC overview は total/weekly を 1 query で取得し、期間違いの二重 scan を避ける。
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

    #[tokio::test]
    async fn aggregate_trending_by_artist_id_joins_and_limits_in_one_query() {
        // artist trending は ISRC 単位で集計し、top5 制限と total desc の並びを DB 側で保証する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("isrc", Into::<Value>::into("ISRC1")),
                ("track_title", Into::<Value>::into("Track One")),
                ("upc_title", Into::<Value>::into("Release")),
                ("image_url", Into::<Value>::into("cover.png")),
                ("total", Into::<Value>::into(100_i64)),
                ("weekly", Into::<Value>::into(30_i64)),
                ("total_spotify", Into::<Value>::into(40_i64)),
                ("total_apple", Into::<Value>::into(30_i64)),
                ("total_line", Into::<Value>::into(20_i64)),
                ("total_amazon", Into::<Value>::into(5_i64)),
                ("total_youtube", Into::<Value>::into(5_i64)),
                ("weekly_spotify", Into::<Value>::into(12_i64)),
                ("weekly_apple", Into::<Value>::into(9_i64)),
                ("weekly_line", Into::<Value>::into(6_i64)),
                ("weekly_amazon", Into::<Value>::into(2_i64)),
                ("weekly_youtube", Into::<Value>::into(1_i64)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 22).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 28).unwrap();

        let result = repo
            .aggregate_trending_by_artist_id("artist-1", start, end, 5)
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].isrc, "ISRC1");
        assert_eq!(result[0].track_title.as_deref(), Some("Track One"));
        assert_eq!(result[0].upc_title.as_deref(), Some("Release"));
        assert_eq!(result[0].total, 100);
        assert_eq!(result[0].weekly, 30);
        assert_eq!(result[0].weekly_youtube, 1);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("WITH artist_tracks AS"), "{log}");
        assert!(log.contains("SELECT DISTINCT ON (pt.isrc)"), "{log}");
        assert!(log.contains("INNER JOIN product_track pt"), "{log}");
        assert!(log.contains("INNER JOIN tracks t"), "{log}");
        assert!(log.contains("FROM plays_daily pd"), "{log}");
        assert!(log.contains("ORDER BY pc.total DESC"), "{log}");
        assert!(log.contains("LIMIT $4"), "{log}");
        assert_eq!(log.matches("SELECT").count(), 3);
    }

    #[tokio::test]
    async fn aggregate_trending_by_upc_left_joins_play_counts_and_maps_nulls_to_zero() {
        // UPC trending は再生行がない track も表示対象なので、LEFT JOIN と NULL->0 mapping を守る。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("isrc", Into::<Value>::into("ISRC1")),
                ("track_title", Into::<Value>::into("Track One")),
                ("upc_title", Into::<Value>::into(Option::<String>::None)),
                ("image_url", Into::<Value>::into(Option::<String>::None)),
                ("total", Into::<Value>::into(Option::<i64>::None)),
                ("weekly", Into::<Value>::into(Option::<i64>::None)),
                ("total_spotify", Into::<Value>::into(Option::<i64>::None)),
                ("total_apple", Into::<Value>::into(Option::<i64>::None)),
                ("total_line", Into::<Value>::into(Option::<i64>::None)),
                ("total_amazon", Into::<Value>::into(Option::<i64>::None)),
                ("total_youtube", Into::<Value>::into(Option::<i64>::None)),
                ("weekly_spotify", Into::<Value>::into(Option::<i64>::None)),
                ("weekly_apple", Into::<Value>::into(Option::<i64>::None)),
                ("weekly_line", Into::<Value>::into(Option::<i64>::None)),
                ("weekly_amazon", Into::<Value>::into(Option::<i64>::None)),
                ("weekly_youtube", Into::<Value>::into(Option::<i64>::None)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 22).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 28).unwrap();

        let result = repo
            .aggregate_trending_by_upc("UPC1", start, end)
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].isrc, "ISRC1");
        assert_eq!(result[0].track_title.as_deref(), Some("Track One"));
        assert_eq!(result[0].total, 0);
        assert_eq!(result[0].weekly, 0);
        assert_eq!(result[0].total_amazon, 0);
        assert_eq!(result[0].weekly_youtube, 0);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("FROM product_track pt"), "{log}");
        assert!(log.contains("LEFT JOIN plays_daily pd"), "{log}");
        assert!(log.contains("ORDER BY pt.track_no ASC NULLS LAST"), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }

    #[tokio::test]
    async fn aggregate_daily_dsp_history_by_isrcs_groups_by_date_and_maps_null_dsp_to_zero() {
        // dashboard history は日次行を API へ全転送せず、DB 側の日付集計で nullable DSP 値を 0 に寄せる。
        let date = NaiveDate::from_ymd_opt(2026, 1, 10).unwrap();
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("date", Into::<Value>::into(Some(date))),
                ("spotify", Into::<Value>::into(10_i64)),
                ("apple", Into::<Value>::into(20_i64)),
                ("line", Into::<Value>::into(30_i64)),
                ("amazon", Into::<Value>::into(Option::<i64>::None)),
                ("youtube", Into::<Value>::into(Option::<i64>::None)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 1).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .aggregate_daily_dsp_history_by_isrcs(vec!["ISRC1".to_string()], start, end)
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].date, "2026-01-10");
        assert_eq!(result[0].spotify, 10);
        assert_eq!(result[0].amazon, 0);
        assert_eq!(result[0].youtube, 0);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("GROUP BY"), "{log}");
        assert!(log.contains("plays_daily"), "{log}");
        assert!(log.contains("date"), "{log}");
        assert!(log.contains("isrc"), "{log}");
        assert!(log.contains("IS NOT NULL"), "{log}");
        assert!(log.contains(">="), "{log}");
        assert!(log.contains("<="), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }

    #[tokio::test]
    async fn aggregate_monthly_dsp_history_by_isrcs_groups_by_month_with_optional_bounds() {
        // 月次 history は全日次行を Rust で畳み込まず、DB の YYYY-MM 集計と inclusive 境界を使う。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("date", Into::<Value>::into("2026-01")),
                ("spotify", Into::<Value>::into(10_i64)),
                ("apple", Into::<Value>::into(20_i64)),
                ("line", Into::<Value>::into(30_i64)),
                ("amazon", Into::<Value>::into(40_i64)),
                ("youtube", Into::<Value>::into(50_i64)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 1).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .aggregate_monthly_dsp_history_by_isrcs(
                vec!["ISRC1".to_string(), "ISRC2".to_string()],
                Some(start),
                Some(end),
            )
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].date, "2026-01");
        assert_eq!(result[0].youtube, 50);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("TO_CHAR"), "{log}");
        assert!(log.contains("YYYY-MM"), "{log}");
        assert!(log.contains("GROUP BY TO_CHAR"), "{log}");
        assert!(log.contains(">="), "{log}");
        assert!(log.contains("<="), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }

    #[tokio::test]
    async fn aggregate_daily_track_history_by_isrcs_joins_tracks_and_groups_by_title() {
        // UPC history は title 解決不能な行を落とす必要があるため、tracks INNER JOIN で date/title 単位に集計する。
        let date = NaiveDate::from_ymd_opt(2026, 1, 10).unwrap();
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("date", Into::<Value>::into(Some(date))),
                ("track_title", Into::<Value>::into("Track One")),
                ("total", Into::<Value>::into(99_i64)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 1).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .aggregate_daily_track_history_by_isrcs(vec!["ISRC1".to_string()], start, end)
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].date, "2026-01-10");
        assert_eq!(result[0].track_title, "Track One");
        assert_eq!(result[0].total, 99);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("INNER JOIN"), "{log}");
        assert!(log.contains("tracks"), "{log}");
        assert!(log.contains("GROUP BY"), "{log}");
        assert!(log.contains("title"), "{log}");
        assert!(log.contains("SUM(COALESCE"), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }

    #[tokio::test]
    async fn aggregate_monthly_track_history_by_isrcs_joins_tracks_and_groups_by_month_title() {
        // UPC 月次 history は track title を維持したまま、月/track 単位の集計を DB 側で完結させる。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("date", Into::<Value>::into("2026-01")),
                ("track_title", Into::<Value>::into("Track One")),
                ("total", Into::<Value>::into(120_i64)),
            ])]])
            .into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 1).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .aggregate_monthly_track_history_by_isrcs(
                vec!["ISRC1".to_string()],
                Some(start),
                Some(end),
            )
            .await
            .unwrap();

        assert_eq!(result.len(), 1);
        assert_eq!(result[0].date, "2026-01");
        assert_eq!(result[0].track_title, "Track One");
        assert_eq!(result[0].total, 120);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("TO_CHAR"), "{log}");
        assert!(log.contains("YYYY-MM"), "{log}");
        assert!(log.contains("INNER JOIN"), "{log}");
        assert!(log.contains("tracks"), "{log}");
        assert!(log.contains("GROUP BY TO_CHAR"), "{log}");
        assert_eq!(log.matches("SELECT").count(), 1);
    }

    #[tokio::test]
    async fn aggregate_history_methods_skip_database_when_isrc_list_is_empty() {
        // 対象 track が 0 件の dashboard では、空の IN query を発行せず即空配列を返す。
        let db = MockDatabase::new(DbBackend::Postgres).into_connection();
        let repo = PlaysDailyRepoImpl::new(db);
        let start = NaiveDate::from_ymd_opt(2026, 1, 1).unwrap();
        let end = NaiveDate::from_ymd_opt(2026, 1, 31).unwrap();

        let result = repo
            .aggregate_daily_dsp_history_by_isrcs(vec![], start, end)
            .await
            .unwrap();

        assert!(result.is_empty());
        assert!(repo.db.into_transaction_log().is_empty());
    }
}
