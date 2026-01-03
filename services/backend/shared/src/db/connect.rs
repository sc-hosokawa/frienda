use sea_orm::{ConnectOptions, Database, DatabaseConnection, DbErr};

pub async fn establish_db_connection(db_url: String) -> Result<DatabaseConnection, DbErr> {
    tracing::info!("Connecting to database...");
    let mut opt: ConnectOptions = ConnectOptions::new(db_url);
    opt.sqlx_logging(false);

    let db: DatabaseConnection = Database::connect(opt).await?;
    tracing::info!("Connected to database");
    Ok(db)
}
