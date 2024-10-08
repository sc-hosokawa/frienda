use application::health_check::*;
use infrastracture::persistences::health_check_repo_impl::HealthCheckRepoImpl;
use sea_orm::DatabaseConnection;
use std::sync::Arc;
use tracing;

pub struct RepositoriesImpl {
    pub health_check: Arc<HealthCheckRepoImpl>,
}
pub struct Usecases {
    pub health_check: Arc<dyn HealthCheckUseCase>,
}

pub fn create_repositories(db: DatabaseConnection) -> RepositoriesImpl {
    tracing::info!("Creating Repositories...");
    RepositoriesImpl {
        health_check: Arc::new(HealthCheckRepoImpl::new(db)),
    }
}

pub fn create_usecases(repos: RepositoriesImpl) -> Usecases {
    tracing::info!("Creating Usecases...");
    Usecases {
        health_check: Arc::new(HealthCheckUsecase::new(repos.health_check)),
    }
}
