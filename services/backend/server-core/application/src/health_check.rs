use async_trait::async_trait;
use domain::repositories::health_check::HealthCheckRepository;
use std::sync::Arc;

// ユースケースのインターフェースを定義
#[async_trait]
pub trait HealthCheckUseCase: Send + Sync {
    async fn health_check(&self) -> Result<bool, anyhow::Error>;
}

// ユースケースの実装
pub struct HealthCheckUsecase {
    repo: Arc<dyn HealthCheckRepository>,
}

impl HealthCheckUsecase {
    pub fn new(repo: Arc<dyn HealthCheckRepository>) -> Self {
        Self { repo }
    }
}

// HealthCheckUsecase を HealthCheckUseCase トレイトに実装
#[async_trait]
impl HealthCheckUseCase for HealthCheckUsecase {
    async fn health_check(&self) -> Result<bool, anyhow::Error> {
        self.repo.health_check().await
    }
}
