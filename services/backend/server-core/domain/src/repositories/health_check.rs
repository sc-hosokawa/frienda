use async_trait::async_trait;
use shared::error::app_err::AppError;

#[async_trait]
pub trait HealthCheckRepository: Send + Sync {
    async fn health_check(&self) -> Result<bool, anyhow::Error>;
}
