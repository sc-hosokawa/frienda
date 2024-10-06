use anyhow::Result;
use reqwest::Client;
use serde_json::Value;
use std::env;
use tracing;

const ARTIST_IDS: [&str; 2] = ["", ""];

async fn get_authorization_token(client: &Client) -> Result<String> {
    let client_id = env::var("CLIENT_ID").unwrap();
    let client_secret = env::var("CLIENT_SECRET").unwrap();

    let auth_data = [
        ("grant_type", "client_credentials"),
        ("client_id", &client_id),
        ("client_secret", &client_secret),
    ];

    let response = client
        .post("https://accounts.spotify.com/api/token")
        .form(&auth_data)
        .send()
        .await?;

    if response.status().is_success() {
        let json: String = response.text().await?;
        let json: Value = serde_json::from_str(&json)?;
        let access_token = json["access_token"]
            .as_str()
            .ok_or_else(|| anyhow::anyhow!("Failed to get access token"))?
            .to_string();
        Ok(access_token)
    } else {
        tracing::error!("Error: {} - {}", response.status(), response.text().await?);
        Err(anyhow::anyhow!("Failed to get authorization token"))
    }
}

pub async fn get_follower(client: &Client) -> Result<()> {
    let token = get_authorization_token(client).await?;

    let ids = ARTIST_IDS;

    let url = format!("https://api.spotify.com/v1/artists?ids={}", ids.join("%2C"));
    let response = client
        .get(&url)
        .header("Authorization", format!("Bearer {}", token))
        .send()
        .await?;
    if response.status().is_success() {
        let data: String = response.text().await?;
        let data: Value = serde_json::from_str(&data)?;
        println!("data: {}", data);
    } else {
        tracing::error!("Error: {} - {}", response.status(), response.text().await?);
    }
    Ok(())
}
