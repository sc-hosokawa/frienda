use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::notifications::{
    ActiveModel as NotificationActiveModel, Column, Entity as NotificationEntity,
    Model as Notification,
};
use domain::repositories::notifications_repo::{
    AdminNotificationDetailRecord, AdminNotificationListRecord,
    AdminNotificationRecipientRecord, NotificationListRecord, NotificationsRepository,
};
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct NotificationsRepoImpl {
    db: DatabaseConnection,
}

#[derive(Debug, FromQueryResult)]
struct NotificationListQueryRow {
    notification_id: i32,
    notification_user_id: i32,
    title: String,
    content: String,
    is_read: bool,
    created_at: sea_orm::entity::prelude::DateTime,
}

#[derive(Debug, FromQueryResult)]
struct CountQueryRow {
    count: i64,
}

#[derive(Debug, FromQueryResult)]
struct NotificationUserIdQueryRow {
    notification_user_id: i32,
}

#[derive(Debug, FromQueryResult)]
struct AdminNotificationQueryRow {
    id: i32,
    title: String,
    content: String,
    category: Option<String>,
    channel_csv: String,
    recipient_count: i64,
    created_at: sea_orm::entity::prelude::DateTime,
}

#[derive(Debug, FromQueryResult)]
struct AdminNotificationRecipientQueryRow {
    user_id: String,
    username: String,
    email: String,
    mobile_push_is_read: Option<bool>,
    mobile_push_is_deleted: Option<bool>,
}

impl From<NotificationListQueryRow> for NotificationListRecord {
    fn from(row: NotificationListQueryRow) -> Self {
        Self {
            notification_id: row.notification_id,
            notification_user_id: row.notification_user_id,
            title: row.title,
            content: row.content,
            is_read: row.is_read,
            created_at: row.created_at,
        }
    }
}

fn parse_channels(channel_csv: String) -> Vec<String> {
    channel_csv
        .split(',')
        .filter(|channel| !channel.is_empty())
        .map(ToString::to_string)
        .collect()
}

impl From<AdminNotificationQueryRow> for AdminNotificationListRecord {
    fn from(row: AdminNotificationQueryRow) -> Self {
        Self {
            id: row.id,
            title: row.title,
            content: row.content,
            category: row.category,
            channels: parse_channels(row.channel_csv),
            recipient_count: row.recipient_count,
            created_at: row.created_at,
        }
    }
}

impl From<AdminNotificationRecipientQueryRow> for AdminNotificationRecipientRecord {
    fn from(row: AdminNotificationRecipientQueryRow) -> Self {
        Self {
            user_id: row.user_id,
            username: row.username,
            email: row.email,
            mobile_push_is_read: row.mobile_push_is_read,
            mobile_push_is_deleted: row.mobile_push_is_deleted,
        }
    }
}

const MOBILE_PUSH_CHANNEL: &str = "MOBILE_PUSH";

fn mobile_push_list_statement(user_id: &str, limit: u64, offset: u64) -> Statement {
    Statement::from_sql_and_values(
        DbBackend::Postgres,
        r#"
        SELECT
            n.id AS notification_id,
            nu.id AS notification_user_id,
            n.title,
            n.content,
            nu.is_read,
            n.created_at
        FROM notifications n
        INNER JOIN notification_user nu ON nu.notification_id = n.id
        INNER JOIN notification_channels nc ON nc.notification_id = n.id
        WHERE nu."user" = $1
          AND nc.channel = $2
          AND nu.is_deleted = false
        ORDER BY n.created_at DESC
        LIMIT $3 OFFSET $4
        "#,
        vec![
            user_id.into(),
            MOBILE_PUSH_CHANNEL.into(),
            (limit as i64).into(),
            (offset as i64).into(),
        ],
    )
}

fn mobile_push_count_statement(user_id: &str, unread_only: bool) -> Statement {
    let unread_filter = if unread_only {
        " AND nu.is_read = false"
    } else {
        ""
    };

    Statement::from_sql_and_values(
        DbBackend::Postgres,
        format!(
            r#"
        SELECT COUNT(*) AS count
        FROM notifications n
        INNER JOIN notification_user nu ON nu.notification_id = n.id
        INNER JOIN notification_channels nc ON nc.notification_id = n.id
        WHERE nu."user" = $1
          AND nc.channel = $2
          AND nu.is_deleted = false
          {unread_filter}
        "#
        ),
        vec![user_id.into(), MOBILE_PUSH_CHANNEL.into()],
    )
}

fn mobile_push_notification_user_ids_statement(user_id: &str) -> Statement {
    Statement::from_sql_and_values(
        DbBackend::Postgres,
        r#"
        SELECT nu.id AS notification_user_id
        FROM notification_user nu
        INNER JOIN notification_channels nc ON nc.notification_id = nu.notification_id
        WHERE nu."user" = $1
          AND nc.channel = $2
          AND nu.is_deleted = false
        "#,
        vec![user_id.into(), MOBILE_PUSH_CHANNEL.into()],
    )
}

fn admin_notification_list_statement(limit: u64, offset: u64) -> Statement {
    Statement::from_sql_and_values(
        DbBackend::Postgres,
        r#"
        SELECT
            n.id,
            n.title,
            n.content,
            n.category,
            COALESCE((
                SELECT string_agg(nc.channel, ',' ORDER BY nc.channel)
                FROM notification_channels nc
                WHERE nc.notification_id = n.id
            ), '') AS channel_csv,
            COALESCE((
                SELECT COUNT(*)
                FROM notification_recipients nr
                WHERE nr.notification_id = n.id
            ), 0) AS recipient_count,
            n.created_at
        FROM notifications n
        ORDER BY n.created_at DESC, n.id DESC
        LIMIT $1 OFFSET $2
        "#,
        vec![(limit as i64).into(), (offset as i64).into()],
    )
}

fn admin_notification_count_statement() -> Statement {
    Statement::from_string(
        DbBackend::Postgres,
        r#"
        SELECT COUNT(*) AS count
        FROM notifications
        "#
        .to_string(),
    )
}

fn admin_notification_detail_statement(notification_id: i32) -> Statement {
    Statement::from_sql_and_values(
        DbBackend::Postgres,
        r#"
        SELECT
            n.id,
            n.title,
            n.content,
            n.category,
            COALESCE((
                SELECT string_agg(nc.channel, ',' ORDER BY nc.channel)
                FROM notification_channels nc
                WHERE nc.notification_id = n.id
            ), '') AS channel_csv,
            COALESCE((
                SELECT COUNT(*)
                FROM notification_recipients nr
                WHERE nr.notification_id = n.id
            ), 0) AS recipient_count,
            n.created_at
        FROM notifications n
        WHERE n.id = $1
        "#,
        vec![notification_id.into()],
    )
}

fn admin_notification_recipients_statement(notification_id: i32) -> Statement {
    Statement::from_sql_and_values(
        DbBackend::Postgres,
        r#"
        SELECT
            nr.user_id,
            u.username,
            u.email,
            CASE
                WHEN EXISTS (
                    SELECT 1
                    FROM notification_channels nc
                    WHERE nc.notification_id = nr.notification_id
                      AND nc.channel = $2
                )
                THEN nu.is_read
                ELSE NULL
            END AS mobile_push_is_read,
            CASE
                WHEN EXISTS (
                    SELECT 1
                    FROM notification_channels nc
                    WHERE nc.notification_id = nr.notification_id
                      AND nc.channel = $2
                )
                THEN nu.is_deleted
                ELSE NULL
            END AS mobile_push_is_deleted
        FROM notification_recipients nr
        INNER JOIN users u ON u.id = nr.user_id
        LEFT JOIN notification_user nu
          ON nu.notification_id = nr.notification_id
         AND nu."user" = nr.user_id
        WHERE nr.notification_id = $1
        ORDER BY nr.created_at ASC, nr.user_id ASC
        "#,
        vec![notification_id.into(), MOBILE_PUSH_CHANNEL.into()],
    )
}

#[async_trait]
impl NotificationsRepository for NotificationsRepoImpl {
    async fn create(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError> {
        let res = NotificationEntity::insert(notification)
            .exec(&self.db)
            .await?;

        let inserted_notification = NotificationEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_notification.unwrap())
    }

    async fn update(
        &self,
        notification: NotificationActiveModel,
    ) -> Result<Notification, DomainError> {
        let updated_notification: Notification = notification.update(&self.db).await?;
        Ok(updated_notification)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Notification>, DomainError> {
        let notification = NotificationEntity::find_by_id(id).one(&self.db).await?;
        Ok(notification)
    }

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Notification>, DomainError> {
        let notifications = NotificationEntity::find()
            .filter(Column::Id.is_in(ids))
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;
        Ok(notifications)
    }

    async fn get_by_category(&self, category: &str) -> Result<Vec<Notification>, DomainError> {
        let notifications: Vec<Notification> = NotificationEntity::find()
            .filter(Column::Category.eq(category))
            .all(&self.db)
            .await?;
        Ok(notifications)
    }

    async fn list_mobile_push_by_user(
        &self,
        user_id: &str,
        limit: u64,
        offset: u64,
    ) -> Result<Vec<NotificationListRecord>, DomainError> {
        let rows = NotificationListQueryRow::find_by_statement(mobile_push_list_statement(
            user_id, limit, offset,
        ))
        .all(&self.db)
        .await?;

        Ok(rows.into_iter().map(NotificationListRecord::from).collect())
    }

    async fn count_mobile_push_by_user(&self, user_id: &str) -> Result<i64, DomainError> {
        let row = CountQueryRow::find_by_statement(mobile_push_count_statement(user_id, false))
            .one(&self.db)
            .await?;

        Ok(row.map(|row| row.count).unwrap_or(0))
    }

    async fn count_unread_mobile_push_by_user(&self, user_id: &str) -> Result<i64, DomainError> {
        let row = CountQueryRow::find_by_statement(mobile_push_count_statement(user_id, true))
            .one(&self.db)
            .await?;

        Ok(row.map(|row| row.count).unwrap_or(0))
    }

    async fn get_mobile_push_notification_user_ids(
        &self,
        user_id: &str,
    ) -> Result<Vec<i32>, DomainError> {
        let rows = NotificationUserIdQueryRow::find_by_statement(
            mobile_push_notification_user_ids_statement(user_id),
        )
        .all(&self.db)
        .await?;

        Ok(rows
            .into_iter()
            .map(|row| row.notification_user_id)
            .collect())
    }

    async fn list_admin_notifications(
        &self,
        limit: u64,
        offset: u64,
    ) -> Result<Vec<AdminNotificationListRecord>, DomainError> {
        let rows =
            AdminNotificationQueryRow::find_by_statement(admin_notification_list_statement(
                limit, offset,
            ))
            .all(&self.db)
            .await?;

        Ok(rows
            .into_iter()
            .map(AdminNotificationListRecord::from)
            .collect())
    }

    async fn count_admin_notifications(&self) -> Result<i64, DomainError> {
        let row = CountQueryRow::find_by_statement(admin_notification_count_statement())
            .one(&self.db)
            .await?;

        Ok(row.map(|row| row.count).unwrap_or(0))
    }

    async fn get_admin_notification_detail(
        &self,
        notification_id: i32,
    ) -> Result<Option<AdminNotificationDetailRecord>, DomainError> {
        let notification =
            AdminNotificationQueryRow::find_by_statement(admin_notification_detail_statement(
                notification_id,
            ))
            .one(&self.db)
            .await?;

        let Some(notification) = notification else {
            return Ok(None);
        };

        let recipients = AdminNotificationRecipientQueryRow::find_by_statement(
            admin_notification_recipients_statement(notification_id),
        )
        .all(&self.db)
        .await?;

        Ok(Some(AdminNotificationDetailRecord {
            id: notification.id,
            title: notification.title,
            content: notification.content,
            category: notification.category,
            channels: parse_channels(notification.channel_csv),
            recipients: recipients
                .into_iter()
                .map(AdminNotificationRecipientRecord::from)
                .collect(),
            created_at: notification.created_at,
        }))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::NaiveDate;
    use domain::repositories::notifications_repo::NotificationsRepository;
    use sea_orm::{DbBackend, MockDatabase, Value};
    use std::collections::BTreeMap;

    fn row(values: Vec<(&str, Value)>) -> BTreeMap<String, Value> {
        values
            .into_iter()
            .map(|(key, value)| (key.to_string(), value))
            .collect()
    }

    fn created_at() -> chrono::NaiveDateTime {
        NaiveDate::from_ymd_opt(2026, 1, 1)
            .expect("date")
            .and_hms_opt(12, 0, 0)
            .expect("time")
    }

    #[tokio::test]
    async fn list_mobile_push_by_user_filters_channel_deleted_state_and_paginates() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("notification_id", Into::<Value>::into(10_i32)),
                ("notification_user_id", Into::<Value>::into(100_i32)),
                ("title", Into::<Value>::into("Title")),
                ("content", Into::<Value>::into("Body")),
                ("is_read", Into::<Value>::into(false)),
                ("created_at", Into::<Value>::into(created_at())),
            ])]])
            .into_connection();
        let repo = NotificationsRepoImpl::new(db);

        let rows = repo
            .list_mobile_push_by_user("user-1", 20, 5)
            .await
            .expect("list query succeeds");

        assert_eq!(rows.len(), 1);
        assert_eq!(rows[0].notification_id, 10);
        assert_eq!(rows[0].notification_user_id, 100);
        assert!(!rows[0].is_read);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("notifications"), "{log}");
        assert!(log.contains("notification_user"), "{log}");
        assert!(log.contains("notification_channels"), "{log}");
        assert!(log.contains("MOBILE_PUSH"), "{log}");
        assert!(log.contains("is_deleted"), "{log}");
        assert!(log.contains("created_at"), "{log}");
        assert!(log.contains("ORDER BY"), "{log}");
        assert!(log.contains("LIMIT"), "{log}");
        assert!(log.contains("OFFSET"), "{log}");
        assert!(log.contains("20"), "{log}");
        assert!(log.contains("5"), "{log}");
    }

    #[tokio::test]
    async fn count_and_unread_mobile_push_by_user_use_same_filters() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![("count", Into::<Value>::into(3_i64))])]])
            .append_query_results([[row(vec![("count", Into::<Value>::into(2_i64))])]])
            .into_connection();
        let repo = NotificationsRepoImpl::new(db);

        assert_eq!(repo.count_mobile_push_by_user("user-1").await.unwrap(), 3);
        assert_eq!(
            repo.count_unread_mobile_push_by_user("user-1")
                .await
                .unwrap(),
            2
        );

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert_eq!(log.matches("COUNT").count(), 2, "{log}");
        assert_eq!(log.matches("notification_channels").count(), 2, "{log}");
        assert_eq!(log.matches("MOBILE_PUSH").count(), 2, "{log}");
        assert!(log.contains("is_read"), "{log}");
        assert!(log.contains("false"), "{log}");
    }

    #[tokio::test]
    async fn get_mobile_push_notification_user_ids_uses_mobile_push_and_deleted_filters() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![("notification_user_id", Into::<Value>::into(
                100_i32,
            ))])]])
            .into_connection();
        let repo = NotificationsRepoImpl::new(db);

        let ids = repo
            .get_mobile_push_notification_user_ids("user-1")
            .await
            .expect("ids query succeeds");

        assert_eq!(ids, vec![100]);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("notification_user"), "{log}");
        assert!(log.contains("notification_channels"), "{log}");
        assert!(log.contains("MOBILE_PUSH"), "{log}");
        assert!(log.contains("is_deleted"), "{log}");
    }

    #[tokio::test]
    async fn list_admin_notifications_reads_channels_and_recipient_count() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("id", Into::<Value>::into(10_i32)),
                ("title", Into::<Value>::into("Title")),
                ("content", Into::<Value>::into("Body")),
                ("category", Into::<Value>::into(Some("admin".to_string()))),
                ("channel_csv", Into::<Value>::into("EMAIL,MOBILE_PUSH")),
                ("recipient_count", Into::<Value>::into(2_i64)),
                ("created_at", Into::<Value>::into(created_at())),
            ])]])
            .append_query_results([[row(vec![("count", Into::<Value>::into(3_i64))])]])
            .into_connection();
        let repo = NotificationsRepoImpl::new(db);

        let rows = repo
            .list_admin_notifications(20, 0)
            .await
            .expect("admin list query succeeds");
        let count = repo
            .count_admin_notifications()
            .await
            .expect("admin count query succeeds");

        assert_eq!(rows.len(), 1);
        assert_eq!(rows[0].id, 10);
        assert_eq!(
            rows[0].channels,
            vec!["EMAIL".to_string(), "MOBILE_PUSH".to_string()]
        );
        assert_eq!(rows[0].recipient_count, 2);
        assert_eq!(count, 3);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("notification_channels"), "{log}");
        assert!(log.contains("notification_recipients"), "{log}");
        assert!(log.contains("ORDER BY n.created_at DESC"), "{log}");
        assert!(log.contains("LIMIT"), "{log}");
        assert!(log.contains("OFFSET"), "{log}");
    }

    #[tokio::test]
    async fn get_admin_notification_detail_reads_recipients_and_mobile_push_state() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([[row(vec![
                ("id", Into::<Value>::into(10_i32)),
                ("title", Into::<Value>::into("Title")),
                ("content", Into::<Value>::into("Body")),
                ("category", Into::<Value>::into(Some("admin".to_string()))),
                ("channel_csv", Into::<Value>::into("MOBILE_PUSH")),
                ("recipient_count", Into::<Value>::into(1_i64)),
                ("created_at", Into::<Value>::into(created_at())),
            ])]])
            .append_query_results([[row(vec![
                ("user_id", Into::<Value>::into("user-1")),
                ("username", Into::<Value>::into("user")),
                ("email", Into::<Value>::into("user@example.com")),
                ("mobile_push_is_read", Into::<Value>::into(Some(true))),
                (
                    "mobile_push_is_deleted",
                    Into::<Value>::into(Some(false)),
                ),
            ])]])
            .into_connection();
        let repo = NotificationsRepoImpl::new(db);

        let detail = repo
            .get_admin_notification_detail(10)
            .await
            .expect("admin detail query succeeds")
            .expect("detail exists");

        assert_eq!(detail.id, 10);
        assert_eq!(detail.channels, vec!["MOBILE_PUSH".to_string()]);
        assert_eq!(detail.recipients.len(), 1);
        assert_eq!(detail.recipients[0].user_id, "user-1");
        assert_eq!(detail.recipients[0].mobile_push_is_read, Some(true));
        assert_eq!(detail.recipients[0].mobile_push_is_deleted, Some(false));

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("notification_recipients"), "{log}");
        assert!(log.contains("INNER JOIN users"), "{log}");
        assert!(log.contains("LEFT JOIN notification_user"), "{log}");
        assert!(log.contains("MOBILE_PUSH"), "{log}");
    }
}
