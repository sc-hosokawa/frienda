use async_graphql::{InputObject, SimpleObject};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct HealthCheck {
    pub status: String,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct HealthCheckInput {
    pub message: String,
}

#[derive(SimpleObject)]
pub struct HealthCheckResponse {
    pub message: String,
    pub timestamp: String,
}
