pub mod context;
pub mod models;
pub mod mutations;
pub mod queries;

use async_graphql::{EmptySubscription, Schema};

pub type AppSchema = Schema<queries::QueryRoot, mutations::MutationRoot, EmptySubscription>;
