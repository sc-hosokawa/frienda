use async_graphql::Object;

pub struct MutationRoot;

#[Object]
impl MutationRoot {
    async fn health(&self) -> String {
        "system is healthy".to_string()
    }
}
