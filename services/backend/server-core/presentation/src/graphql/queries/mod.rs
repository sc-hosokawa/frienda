use async_graphql::Object;

pub struct QueryRoot;

#[Object]
impl QueryRoot {
    async fn health(&self) -> String {
        "system is healthy".to_string()
    }
}
