use sea_orm::{Database, DatabaseConnection, DbErr};

pub async fn establish_connection() -> Result<DatabaseConnection, DbErr> {
    let db_url = std::env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let db = Database::connect(&db_url).await?;
    tracing::info!("Connected to database");
    Ok(db)
}
