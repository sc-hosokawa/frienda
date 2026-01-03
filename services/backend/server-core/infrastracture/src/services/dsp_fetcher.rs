use application::services::dsp_fetcher::{
    DspFetcherServiceTrait, DspsData, GenderGenData, SparseData,
};
use async_trait::async_trait;

use base64;
use google_bigquery2::{hyper, hyper_rustls, oauth2, Bigquery};
use hyper::client::HttpConnector;
use hyper_rustls::HttpsConnector;
use serde_json;
use std::env;
use std::time::Instant;
use tracing;

use flate2::read::GzDecoder;
use reqwest::Client;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use std::fs::File;
use std::io::{self, BufReader, BufWriter, Write};

#[derive(Debug)]
pub struct StreamingData {
    pub date: String,
    pub isrc: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub youtube: i32,
    pub amazon: i32,
}

#[derive(Debug, Clone)]
pub struct PartialSparseData {
    pub isrc: String,
    pub date: String,
    pub spotify: Option<i32>,
    pub apple: Option<i32>,
    pub line: Option<i32>,
    pub youtube: Option<i32>,
    pub amazon: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
struct AuthResponse {
    access_token: String,
    token_type: String,
    expires_in: i32,
}

#[derive(Debug, Serialize, Deserialize)]
struct FileInfo {
    description: String,
    uri: String,
}

pub struct DspFetcherService {
    client: Bigquery<HttpsConnector<HttpConnector>>,
}

impl DspFetcherService {
    pub async fn new() -> Result<Self, anyhow::Error> {
        let service_account_json: String = env::var("SCR_SERVICE_ACCOUNT_DSP")
            .expect("SCR_SERVICE_ACCOUNT_DSP environment variable not set");

        let decoded: Vec<u8> = base64::decode(service_account_json)?;
        let secret: oauth2::ServiceAccountKey = serde_json::from_slice(&decoded)?;
        let auth = oauth2::ServiceAccountAuthenticator::builder(secret)
            .build()
            .await?;

        let hub = Bigquery::new(
            hyper::Client::builder().build(
                hyper_rustls::HttpsConnectorBuilder::new()
                    .with_native_roots()
                    .https_only()
                    .enable_http1()
                    .build(),
            ),
            auth,
        );
        tracing::info!("DSPFetcherService initialized");
        Ok(Self { client: hub })
    }

    // Spotify Authorization
    async fn get_authorization_token(client: &Client) -> Result<String, anyhow::Error> {
        let client_id: String =
            std::env::var("CLIENT_ID").expect("CLIENT_ID environment variable not set");
        let client_secret: String =
            std::env::var("CLIENT_SECRET").expect("CLIENT_SECRET environment variable not set");
        let auth_url: String = std::env::var("GENDER_GEN_AUTH_URL")
            .expect("GENDER_GEN_AUTH_URL environment variable not set");

        let params = [
            ("grant_type", "client_credentials"),
            ("client_id", client_id.as_str()),
            ("client_secret", client_secret.as_str()),
        ];

        tracing::info!("PIPELINE::DSPFetcherService:: Auth URL: {}", auth_url);

        let response = client.post(auth_url).form(&params).send().await?;

        if response.status().is_success() {
            let auth_response: AuthResponse = response.json().await?;
            println!("Access Token: {}", auth_response.access_token);
            Ok(auth_response.access_token)
        } else {
            Err(anyhow::anyhow!(
                "Failed to get token: {} - {}",
                response.status(),
                response.text().await?
            ))
        }
    }

    async fn get_data(client: &Client, token: &str, date: &str) -> Result<String, anyhow::Error> {
        let url: String = std::env::var("GENDER_GEN_PLAYBACK_URL")
            .expect("GENDER_GEN_PLAYBACK_URL environment variable not set");
        let prefix: String = std::env::var("GENDER_GEN_PLAYBACK_PREFIX")
            .expect("GENDER_GEN_PLAYBACK_PREFIX environment variable not set");
        let gender_gen_source_url = format!("{}{}{}", url, date, prefix);
        tracing::info!(
            "PIPELINE::DSPFetcherService:: GenderGen Source URL: {}",
            gender_gen_source_url
        );

        let response = client
            .get(gender_gen_source_url)
            .header("Authorization", format!("Bearer {}", token))
            .send()
            .await?;

        if response.status().is_success() {
            Ok(response.text().await?)
        } else {
            Err(anyhow::anyhow!(
                "Failed to get data: {} - {}",
                response.status(),
                response.text().await?
            ))
        }
    }

    async fn combine_downloaded_files(
        client: &Client,
        jsonl_text: &str,
        output_filename: &str,
    ) -> Result<(), anyhow::Error> {
        let output_file = File::create(output_filename)?;
        let mut writer = BufWriter::new(output_file);

        for line in jsonl_text.lines() {
            let file_info: FileInfo = serde_json::from_str(line)
                .map_err(|_| anyhow::anyhow!("Failed to parse file info"))?;

            println!(
                "Downloading and decompressing '{}' from {}",
                file_info.description, file_info.uri
            );

            let response = client.get(&file_info.uri).send().await?;

            if response.status().is_success() {
                let content = response.bytes().await?;
                let decompressed_text = Self::decompress_gz_content(&content)?;

                writer.write_all(decompressed_text.as_bytes())?;
                writer.write_all(b"\n")?;

                println!("Appended content from {}", file_info.description);
            } else {
                println!(
                    "Download failed for {}: HTTP {}",
                    file_info.description,
                    response.status()
                );
            }
        }

        writer.flush()?;
        Ok(())
    }

    fn decompress_gz_content(content: &[u8]) -> Result<String, anyhow::Error> {
        let mut decoder = GzDecoder::new(content);
        let mut decompressed = String::new();
        io::Read::read_to_string(&mut decoder, &mut decompressed)?;
        Ok(decompressed)
    }
}

#[async_trait]
impl DspFetcherServiceTrait for DspFetcherService {
    async fn fetch_dsps_data(
        &self,
        start_date: Option<String>,
        end_date: String,
    ) -> Result<Vec<DspsData>, anyhow::Error> {
        let start_time = Instant::now();

        let query: String = match end_date.len() {
            6 => {
                let encoded_template = std::env::var("DSP_QUERY_MONTHLY_TEMPLATE")
                    .map_err(|_| anyhow::anyhow!("DSP_QUERY_MONTHLY_TEMPLATE environment variable is not set"))?;
                let query_template = base64::decode(&encoded_template)
                    .map_err(|_| anyhow::anyhow!("Failed to decode DSP_QUERY_MONTHLY_TEMPLATE from base64"))?;
                let query_template = String::from_utf8(query_template)
                    .map_err(|_| anyhow::anyhow!("Failed to convert decoded template to UTF-8"))?;
                query_template.replace("{}", &end_date)
            }
            8 => {
                let start_date = start_date
                    .as_deref()
                    .ok_or_else(|| anyhow::anyhow!("start_date is required for daily query"))?;
                let encoded_template = std::env::var("SCR_DSP_QUERY_DAILY_TEMPLATE")
                    .map_err(|_| anyhow::anyhow!("DSP_QUERY_DAILY_TEMPLATE environment variable is not set"))?;
                let query_template = base64::decode(&encoded_template)
                    .map_err(|_| anyhow::anyhow!("Failed to decode SCR_DSP_QUERY_DAILY_TEMPLATE from base64"))?;
                let query_template = String::from_utf8(query_template)
                    .map_err(|_| anyhow::anyhow!("Failed to convert decoded template to UTF-8"))?;
                query_template
                    .replace("{start_date}", start_date)
                    .replace("{end_date}", &end_date)
            }
            _ => return Err(anyhow::anyhow!("Invalid date format. Expected 6 digits (YYYYMM) for monthly or 8 digits (YYYYMMDD) for daily")),
        };
        let location = std::env::var("SCR_LOCATION")
            .map_err(|_| anyhow::anyhow!("SCR_LOCATION environment variable is not set"))?;
        let pj_id: String = std::env::var("SCR_DSP_PJ_ID")
            .map_err(|_| anyhow::anyhow!("SCR_DSP_PJ_ID environment variable is not set"))?;

        tracing::info!("PIPELINE::DSPFetcherService:: Query: {}", query);

        let mut req = google_bigquery2::api::QueryRequest::default();
        req.query = Some(query);
        req.use_legacy_sql = Some(false);
        req.location = Some(location.clone());

        let result = self.client.jobs().query(req, pj_id.as_str()).doit().await?;
        let query_res = result.1;

        let mut streaming_data: Vec<StreamingData> = Vec::new();

        if let Some(job_ref) = query_res.job_reference {
            let job_id = job_ref.job_id.unwrap();
            let project_id = job_ref.project_id.unwrap();
            let location = job_ref
                .location
                .unwrap_or_else(|| "asia-northeast1".to_string());

            tracing::info!("PIPELINE::DSPFetcherService:: Job started. Waiting for completion...");
            tokio::time::sleep(tokio::time::Duration::from_secs(30)).await;

            loop {
                let job_status = self
                    .client
                    .jobs()
                    .get(project_id.as_str(), job_id.as_str())
                    .location(&location)
                    .doit()
                    .await?;

                if job_status.1.status.unwrap().state.unwrap() == "DONE" {
                    let mut page_token: Option<String> = None;

                    loop {
                        let mut query_results_call = self
                            .client
                            .jobs()
                            .get_query_results(project_id.as_str(), job_id.as_str())
                            .location(&location)
                            .max_results(1000);

                        if let Some(ref token) = page_token {
                            query_results_call = query_results_call.page_token(token);
                        }

                        let result = query_results_call.doit().await?;

                        if let Some(rows) = result.1.rows {
                            for row in rows {
                                if let Some(cells) = row.f {
                                    let data = StreamingData {
                                        date: cells[0]
                                            .v
                                            .as_ref()
                                            .unwrap()
                                            .to_string()
                                            .trim_matches('"')
                                            .to_string(),
                                        isrc: match cells[1].v.as_ref() {
                                            Some(v)
                                                if v.to_string() != "null"
                                                    && !v
                                                        .to_string()
                                                        .trim_matches('"')
                                                        .is_empty() =>
                                            {
                                                v.to_string().trim_matches('"').to_string()
                                            }
                                            _ => continue, // Skip this record if ISRC is null or empty
                                        },
                                        spotify: cells[2]
                                            .v
                                            .as_ref()
                                            .unwrap()
                                            .to_string()
                                            .trim_matches('"')
                                            .to_string()
                                            .parse::<i32>()
                                            .unwrap_or(0),
                                        apple: cells[3]
                                            .v
                                            .as_ref()
                                            .unwrap()
                                            .to_string()
                                            .trim_matches('"')
                                            .to_string()
                                            .parse::<i32>()
                                            .unwrap_or(0),
                                        line: cells[4]
                                            .v
                                            .as_ref()
                                            .unwrap()
                                            .to_string()
                                            .trim_matches('"')
                                            .to_string()
                                            .parse::<i32>()
                                            .unwrap_or(0),
                                        youtube: cells[5]
                                            .v
                                            .as_ref()
                                            .unwrap()
                                            .to_string()
                                            .trim_matches('"')
                                            .to_string()
                                            .parse::<i32>()
                                            .unwrap_or(0),
                                        amazon: cells[6]
                                            .v
                                            .as_ref()
                                            .unwrap()
                                            .to_string()
                                            .trim_matches('"')
                                            .to_string()
                                            .parse::<i32>()
                                            .unwrap_or(0),
                                    };
                                    streaming_data.push(data);
                                }
                            }
                        }

                        match result.1.page_token {
                            Some(token) => page_token = Some(token),
                            None => break,
                        }
                    }

                    break;
                }

                tokio::time::sleep(tokio::time::Duration::from_secs(30)).await;
            }
        }

        let elapsed = start_time.elapsed();
        tracing::info!(
            "PIPELINE::DSPFetcherService:: Query execution time: {:.2?}",
            elapsed
        );
        tracing::info!(
            "PIPELINE::DSPFetcherService:: Retrieved {} records",
            streaming_data.len()
        );

        let dsps_data: Vec<DspsData> = streaming_data
            .into_iter()
            .map(|data| DspsData {
                date: data.date,
                isrc: data.isrc,
                spotify: data.spotify,
                apple: data.apple,
                line: data.line,
                youtube: data.youtube,
                amazon: data.amazon,
            })
            .collect();

        Ok(dsps_data)
    }

    async fn fetch_gender_gen_data(
        &self,
        date: String,
    ) -> Result<Vec<GenderGenData>, anyhow::Error> {
        tracing::info!(
            "PIPELINE::DSPFetcherService:: Fetching gender gen data for {}",
            date
        );

        let client: Client = Client::new();
        let token: String = Self::get_authorization_token(&client).await?;
        let jsonl_data: String = Self::get_data(&client, &token, &date).await?;
        let formatted_date: String = date.replace("/", "");
        let output_file: String = format!("combined_output_{}.jsonl", formatted_date);
        Self::combine_downloaded_files(&client, &jsonl_data, output_file.as_str()).await?;

        tracing::info!("Combined data saved to {}", output_file);

        let file = File::open(output_file)?;
        let reader = BufReader::new(file);
        let mut records = Vec::new();

        for line in io::BufRead::lines(reader) {
            let line = line?;
            if line.trim().is_empty() {
                continue;
            }

            let data: Value = match serde_json::from_str(&line) {
                Ok(v) => v,
                Err(e) => {
                    tracing::error!("JSON parse error: {} \nLine: {}", e, line);
                    continue;
                }
            };

            let isrc = match data.get("trackv2").and_then(|t| t.get("isrc")) {
                Some(isrc) => isrc.as_str().unwrap_or("").to_string(),
                None => {
                    tracing::error!("Missing ISRC");
                    continue;
                }
            };

            let date = match data.get("date") {
                Some(date) => date.as_str().unwrap_or("").to_string(),
                None => {
                    tracing::error!("Missing date");
                    continue;
                }
            };

            if let Some(streams) = data.get("streams") {
                if let Some(countries) = streams.get("country").and_then(|c| c.as_object()) {
                    for country_info in countries.values() {
                        if let Some(sex_info) = country_info.get("sex").and_then(|s| s.as_object())
                        {
                            for (gender, gender_info) in sex_info {
                                if let Some(age_info) =
                                    gender_info.get("age").and_then(|a| a.as_object())
                                {
                                    for (age_group, count) in age_info {
                                        if let Some(play_count) = count.as_i64() {
                                            records.push(GenderGenData {
                                                isrc: isrc.clone(),
                                                date: date.clone(),
                                                gender: gender.clone(),
                                                age: age_group.clone(),
                                                play_count,
                                            });
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        for record in &records {
            tracing::info!("PIPELINE::DSPFetcherService:: GenderGenData: {:?}", record);
        }

        Ok(records)
    }

    async fn fetch_sparse_data(&self, date: String) -> Result<Vec<SparseData>, anyhow::Error> {
        tracing::info!(
            "PIPELINE::DSPFetcherService:: Fetching sparse data for {}",
            date
        );

        let client: Client = Client::new();
        let token: String = Self::get_authorization_token(&client).await?;
        let jsonl_data: String = Self::get_data(&client, &token, &date).await?;
        let formatted_date: String = date.replace("/", "");
        let output_file: String = format!("combined_output_{}.jsonl", formatted_date);
        Self::combine_downloaded_files(&client, &jsonl_data, output_file.as_str()).await?;

        tracing::info!("Combined data saved to {}", output_file);

        let file = File::open(output_file)?;
        let reader = BufReader::new(file);
        let mut sparse_records = Vec::new();

        for line in io::BufRead::lines(reader) {
            let line: String = line?;
            if line.trim().is_empty() {
                continue;
            }

            let data: Value = match serde_json::from_str(&line) {
                Ok(v) => v,
                Err(e) => {
                    tracing::error!("JSON parse error: {} \nLine: {}", e, line);
                    continue;
                }
            };

            let stream_count: i32 = data
                .get("streams")
                .and_then(|streams| streams.get("total"))
                .and_then(|total| total.as_i64())
                .unwrap_or(0) as i32;

            let isrc = match data.get("trackv2").and_then(|t| t.get("isrc")) {
                Some(isrc) => isrc.as_str().unwrap_or("").to_string(),
                None => {
                    tracing::error!("Missing ISRC");
                    continue;
                }
            };

            let date = match data.get("date") {
                Some(date) => date.as_str().unwrap_or("").to_string(),
                None => {
                    tracing::error!("Missing date");
                    continue;
                }
            };

            sparse_records.push(SparseData {
                isrc,
                date,
                spotify: Some(stream_count),
                apple: None,
                line: None,
                youtube: None,
                amazon: None,
            });
        }

        tracing::info!(
            "PIPELINE::DSPFetcherService:: Found {} sparse records",
            sparse_records.len()
        );

        Ok(sparse_records)
    }
}
