mod fetcher;
mod process;
mod save;
mod utils;

use fetcher::fetch_all;
// use process::*;
use reqwest::Client;
// use save::exec::save_playback;
use dotenvy::dotenv;
use utils::logger;

async fn flow() {
    let client: Client = Client::new();
    fetch_all(&client).await.unwrap();
}

#[tokio::main]
async fn main() {
    match dotenv() {
        Ok(_) => tracing::info!("Loaded .env file"),
        Err(e) => tracing::error!("Failed to load .env file: {}", e),
    }
    logger::init_logger();
    flow().await;
}
