use async_trait::async_trait;
use std::sync::Arc;

#[derive(Debug, Clone)]
pub struct DspsData {
    pub isrc: String,
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub youtube: Option<i32>,
    pub amazon: Option<i32>,
}

#[derive(Debug, Clone)]
pub struct GenderGenData {
    pub isrc: String,
    pub date: String,
    pub gender: String,
    pub age: String,
    pub play_count: i64,
}

#[async_trait]
pub trait DspFetcherServiceTrait: Send + Sync {
    async fn fetch_dsps_data(&self, date: String) -> Result<Vec<DspsData>, anyhow::Error>;
    async fn fetch_gender_gen_data(
        &self,
        date: String,
    ) -> Result<Vec<GenderGenData>, anyhow::Error>;
}

pub struct DspFetcherService {
    dsp_fetcher_service: Arc<dyn DspFetcherServiceTrait>,
}

impl DspFetcherService {
    pub fn new(dsp_fetcher_service: Arc<dyn DspFetcherServiceTrait>) -> Self {
        Self {
            dsp_fetcher_service,
        }
    }
}

#[async_trait]
impl DspFetcherServiceTrait for DspFetcherService {
    async fn fetch_dsps_data(&self, date: String) -> Result<Vec<DspsData>, anyhow::Error> {
        let res: Vec<DspsData> = self.dsp_fetcher_service.fetch_dsps_data(date).await?;
        Ok(res)
    }

    async fn fetch_gender_gen_data(
        &self,
        date: String,
    ) -> Result<Vec<GenderGenData>, anyhow::Error> {
        let res: Vec<GenderGenData> = self.dsp_fetcher_service.fetch_gender_gen_data(date).await?;
        Ok(res)
    }
}
