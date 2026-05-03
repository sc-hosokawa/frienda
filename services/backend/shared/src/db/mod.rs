pub mod connect;

use sea_orm::DatabaseConnection;

pub fn clone_database_connection(db: &DatabaseConnection) -> DatabaseConnection {
    match db {
        DatabaseConnection::SqlxPostgresPoolConnection(conn) => {
            DatabaseConnection::SqlxPostgresPoolConnection(conn.clone())
        }
        DatabaseConnection::Disconnected => DatabaseConnection::Disconnected,
        #[allow(unreachable_patterns)]
        _ => unreachable!(
            "clone_database_connection only supports Postgres database connections in this workspace"
        ),
    }
}
