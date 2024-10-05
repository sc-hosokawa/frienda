mod fetcher;
mod process;
mod save;

use fetcher::*;
use process::*;
use save::*;

fn flow() {
    todo!();
}

fn init_logger() {
    let subscriber = tracing_subscriber::fmt::Subscriber::builder()
        .with_max_level(tracing::Level::TRACE)
        .finish();
    tracing::subscriber::set_global_default(subscriber).unwrap();
}

fn main() {
    init_logger();
    flow();
}
