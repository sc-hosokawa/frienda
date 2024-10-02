use crate::graphql::models;
use application::health_check::HealthCheckUseCase;
use async_graphql::{Context, Object, Result};
use std::sync::Arc;

pub struct QueryRoot;

#[Object]
impl QueryRoot {
    async fn health_check(&self, ctx: &Context<'_>) -> Result<models::health_check::HealthCheck> {
        let health_check_usecase = ctx.data_unchecked::<Arc<dyn HealthCheckUseCase>>();

        let is_healthy = health_check_usecase.health_check().await?;
        Ok(models::health_check::HealthCheck {
            status: if is_healthy {
                "system is healthy"
            } else {
                "system is not healthy"
            }
            .to_string(),
        })
    }
}
