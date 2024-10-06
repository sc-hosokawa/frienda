pub mod amazon;
pub mod apple;
pub mod line;
pub mod spotify;
pub mod youtube;

use anyhow::Result;
use reqwest::Client;
use tokio;

pub async fn fetch_all(client: &Client) -> Result<()> {
    let (spotify_result, line_result) = tokio::join!(
        spotify::get_follower(&client),
        line::get_line_report(&client)
    );

    spotify_result?;
    line_result?;

    Ok(())
}
