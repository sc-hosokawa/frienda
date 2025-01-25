use application::services::dsp_fetcher::{DspFetcherServiceTrait, DspsData};
use async_trait::async_trait;

use base64;
use google_bigquery2::{hyper, hyper_rustls, oauth2, Bigquery};
use hyper::client::HttpConnector;
use hyper_rustls::HttpsConnector;
use serde_json;
use std::env;
use std::time::Instant;
use tracing;

#[derive(Debug)]
pub struct StreamingData {
    pub date: String,
    pub isrc: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub youtube: Option<i32>,
    pub amazon: Option<i32>,
}

pub struct DspFetcherService {
    client: Bigquery<HttpsConnector<HttpConnector>>,
}

impl DspFetcherService {
    pub async fn new() -> Result<Self, anyhow::Error> {
        let service_account_json: String = env::var("SERVICE_ACCOUNT_DSP")
            .expect("SERVICE_ACCOUNT_DSP environment variable not set");

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
}

#[async_trait]
impl DspFetcherServiceTrait for DspFetcherService {
    async fn fetch_dsps_data(&self, date: String) -> Result<Vec<DspsData>, anyhow::Error> {
        let start_time = Instant::now();

        let query: String = match date.len() {
            6 => {
                let encoded_template = std::env::var("DSP_QUERY_MONTHLY_TEMPLATE")
                    .map_err(|_| anyhow::anyhow!("DSP_QUERY_MONTHLY_TEMPLATE environment variable is not set"))?;
                let query_template = base64::decode(&encoded_template)
                    .map_err(|_| anyhow::anyhow!("Failed to decode DSP_QUERY_MONTHLY_TEMPLATE from base64"))?;
                let query_template = String::from_utf8(query_template)
                    .map_err(|_| anyhow::anyhow!("Failed to convert decoded template to UTF-8"))?;
                query_template.replace("{}", &date)
            }
            8 => {
                let encoded_template = std::env::var("DSP_QUERY_DAILY_TEMPLATE")
                    .map_err(|_| anyhow::anyhow!("DSP_QUERY_DAILY_TEMPLATE environment variable is not set"))?;
                let query_template = base64::decode(&encoded_template)
                    .map_err(|_| anyhow::anyhow!("Failed to decode DSP_QUERY_DAILY_TEMPLATE from base64"))?;
                let query_template = String::from_utf8(query_template)
                    .map_err(|_| anyhow::anyhow!("Failed to convert decoded template to UTF-8"))?;
                query_template.replace("{}", &date)
            }
            _ => return Err(anyhow::anyhow!("Invalid date format. Expected 6 digits (YYYYMM) for monthly or 8 digits (YYYYMMDD) for daily")),
        };
        let location = std::env::var("LOCATION")
            .map_err(|_| anyhow::anyhow!("LOCATION environment variable is not set"))?;
        let pj_id: String = std::env::var("DSP_PJ_ID")
            .map_err(|_| anyhow::anyhow!("DSP_PJ_ID environment variable is not set"))?;

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
                    let result = self
                        .client
                        .jobs()
                        .get_query_results(project_id.as_str(), job_id.as_str())
                        .location(&location)
                        .doit()
                        .await?;

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
                                    isrc: cells[1]
                                        .v
                                        .as_ref()
                                        .unwrap()
                                        .to_string()
                                        .trim_matches('"')
                                        .to_string(),
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
                                    youtube: cells.get(5).and_then(|cell| cell.v.as_ref()).map(
                                        |v| {
                                            v.to_string()
                                                .trim_matches('"')
                                                .parse::<i32>()
                                                .unwrap_or(0)
                                        },
                                    ),
                                    amazon: cells.get(6).and_then(|cell| cell.v.as_ref()).map(
                                        |v| {
                                            v.to_string()
                                                .trim_matches('"')
                                                .parse::<i32>()
                                                .unwrap_or(0)
                                        },
                                    ),
                                };
                                streaming_data.push(data);
                            }
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
}
