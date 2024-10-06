use anyhow::{Ok, Result};
use reqwest::Client;
use serde_json::Value;
use std::env;
use std::fs::File;
use std::path::PathBuf;
use tempfile::TempDir;
use tracing;
use walkdir::WalkDir;
use zip::ZipArchive;

async fn get_line_token(client: &Client) -> Result<String> {
    let credential_id = env::var("LINE_PASS").unwrap();

    let auth_data = [("grant_type", "client_credentials")];

    let res = client
        .post("https://api-music.line.me/v1/token")
        .header("Content-Type", "application/x-www-form-urlencoded")
        .header("Authorization", &format!("Basic {}", credential_id))
        .form(&auth_data)
        .send()
        .await?;
    if res.status().is_success() {
        let json: String = res.text().await?;
        let json: Value = serde_json::from_str(&json)?;
        let access_token = json["access_token"]
            .as_str()
            .ok_or_else(|| anyhow::anyhow!("Failed to get access token"))?
            .to_string();
        Ok(access_token)
    } else {
        tracing::error!("Error: {} - {}", res.status(), res.text().await?);
        Err(anyhow::anyhow!("Failed to get line token"))
    }
}

pub async fn get_line_report(client: &Client) -> Result<Vec<PathBuf>> {
    let token = get_line_token(client).await?;
    let url = format!("https://api-music.line.me/v1/reports/daily-reports?date=2024-09-29");
    let res = client
        .get(url)
        .header("Authorization", &format!("Bearer {}", token))
        .send()
        .await?;

    if res.status().is_success() {
        let json: String = res.text().await?;
        let json: Value = serde_json::from_str(&json)?;
        if let Some(reports) = json["reports"].as_array() {
            for report in reports {
                if let Some(report_url) = report["url"].as_str() {
                    let csv_files = download_and_extract_zip(client, report_url).await?;
                    println!("{:?}", csv_files);
                    return Ok(csv_files);
                }
            }
        }
        Err(anyhow::anyhow!("No report URL found"))
    } else {
        Err(anyhow::anyhow!(
            "Failed to get line report: {} - {}",
            res.status(),
            res.text().await?
        ))
    }
}

async fn download_and_extract_zip(client: &Client, url: &str) -> Result<Vec<PathBuf>> {
    // 一時ディレクトリを作成
    let temp_dir = TempDir::new()?;
    let zip_path = temp_dir.path().join("report.zip");

    // zipファイルをダウンロード
    let response = client.get(url).send().await?;
    let bytes = response.bytes().await?;
    std::fs::write(&zip_path, &bytes)?;

    // zipファイルを解凍
    let zip_file = File::open(&zip_path)?;
    let mut archive = ZipArchive::new(zip_file)?;
    archive.extract(temp_dir.path())?;

    // CSVファイルのリストを取得
    let csv_files: Vec<PathBuf> = WalkDir::new(temp_dir.path())
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|e| e.path().extension().map_or(false, |ext| ext == "csv"))
        .map(|e| e.path().to_owned())
        .collect();

    Ok(csv_files)
}
