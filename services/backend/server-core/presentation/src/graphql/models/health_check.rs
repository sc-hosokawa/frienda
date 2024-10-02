use async_graphql::SimpleObject;

#[derive(SimpleObject)]
pub struct HealthCheck {
    pub status: String,
}
