use std::fs::OpenOptions;
use std::io::Write;

use async_graphql::*;
use presentation::graphql::{mutations::MutationRoot, queries::QueryRoot, AppSchema};

fn main() {
    let schema: AppSchema =
        Schema::build(QueryRoot::default(), MutationRoot, EmptySubscription).finish();
    let sdl: String = schema.sdl();

    match OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open("presentation/src/graphql/schema.graphql")
    {
        Ok(mut file) => {
            if let Err(e) = file.write_all(sdl.as_bytes()) {
                eprintln!("Failed to write: {}", e);
            }
        }
        Err(e) => {
            eprintln!("Failed to create file: {}", e);
        }
    }
}
