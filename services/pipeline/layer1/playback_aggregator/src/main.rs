mod fetcher;
mod process;
mod save;
mod utils;

use fetcher::*;
use process::*;
use save::exec::save_playback;
use utils::logger;

async fn flow() {
    todo!();
}

#[tokio::main]
async fn main() {
    logger::init_logger();
    flow().await;
}
