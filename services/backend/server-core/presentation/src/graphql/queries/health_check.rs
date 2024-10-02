use crate::graphql::models::health_check::HealthCheck;
use application::health_check::HealthCheckUsecase;
use infrastracture::persistences::health_check_repo_impl::HealthCheckRepoImpl;

pub async fn health_check(
) -> HealthCheck {
    let health_check_repo = HealthCheckRepoImpl::new();
    let health_check_usecase: HealthCheckUsecase = HealthCheckUsecase::new(health_check_repo);
    let health_check = health_check_usecase.health_check().await.unwrap();
    HealthCheck {
        status: health_check.to_string()
    }
}
