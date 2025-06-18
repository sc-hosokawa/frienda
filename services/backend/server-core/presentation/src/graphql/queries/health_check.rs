use crate::graphql::models;
use async_graphql::{Context, Object, Result};
use registry::Usecases;
use std::sync::Arc;

#[derive(Default)]
pub struct HealthCheckQuery;

#[Object]
impl HealthCheckQuery {
    async fn health_check(&self, ctx: &Context<'_>) -> Result<models::health_check::HealthCheck> {
        let usecases = ctx.data::<Arc<Usecases>>()?;

        let is_healthy = usecases.health_check.health_check().await?;
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
