use domain::repositories::health_check::HealthCheckRepository;
// use shared::error::app_err::AppError;
use async_trait::async_trait;
use derive_new::new;
use sea_orm::{ConnectionTrait, DatabaseConnection, DbBackend, Statement};

#[derive(new)]
pub struct HealthCheckRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl HealthCheckRepository for HealthCheckRepoImpl {
    async fn health_check(&self) -> Result<bool, anyhow::Error> {
        let stmt = Statement::from_string(DbBackend::Postgres, "SELECT 1");
        let result = self.db.query_one(stmt).await?;
        Ok(result.is_some())
    }
}
