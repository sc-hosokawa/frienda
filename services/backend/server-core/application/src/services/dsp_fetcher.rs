use async_trait::async_trait;
use std::sync::Arc;

#[derive(Debug, Clone)]
pub struct DspsData {
    pub isrc: String,
    pub date: String,
    pub spotify: i32,
    pub apple: i32,
    pub line: i32,
    pub youtube: i32,
    pub amazon: i32,
}

#[derive(Debug, Clone)]
pub struct GenderGenData {
    pub isrc: String,
    pub date: String,
    pub gender: String,
    pub age: String,
    pub play_count: i64,
}

#[derive(Debug, Clone)]
pub struct SparseData {
    pub isrc: String,
    pub date: String,
    pub spotify: Option<i32>,
    pub apple: Option<i32>,
    pub line: Option<i32>,
    pub amazon: Option<i32>,
    pub youtube: Option<i32>,
}

#[async_trait]
pub trait DspFetcherServiceTrait: Send + Sync {
    async fn fetch_dsps_data(
        &self,
        start_date: Option<String>,
        end_date: String,
    ) -> Result<Vec<DspsData>, anyhow::Error>;
    async fn fetch_gender_gen_data(
        &self,
        date: String,
    ) -> Result<Vec<GenderGenData>, anyhow::Error>;
    async fn fetch_sparse_data(&self, date: String) -> Result<Vec<SparseData>, anyhow::Error>;
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
    async fn fetch_dsps_data(
        &self,
        start_date: Option<String>,
        end_date: String,
    ) -> Result<Vec<DspsData>, anyhow::Error> {
        let res: Vec<DspsData> = self
            .dsp_fetcher_service
            .fetch_dsps_data(start_date, end_date)
            .await?;
        Ok(res)
    }

    async fn fetch_gender_gen_data(
        &self,
        date: String,
    ) -> Result<Vec<GenderGenData>, anyhow::Error> {
        let res: Vec<GenderGenData> = self.dsp_fetcher_service.fetch_gender_gen_data(date).await?;
        Ok(res)
    }

    async fn fetch_sparse_data(&self, date: String) -> Result<Vec<SparseData>, anyhow::Error> {
        let res: Vec<SparseData> = self.dsp_fetcher_service.fetch_sparse_data(date).await?;
        Ok(res)
    }
}
