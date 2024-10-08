mod health_check;

use async_graphql::MergedObject;
use health_check::HealthCheckQuery;

#[derive(MergedObject, Default)]
pub struct QueryRoot(HealthCheckQuery);
