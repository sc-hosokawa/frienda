//! NoOp implementations for local development.
//! Used as fallbacks when external service credentials are not configured.

use async_trait::async_trait;

use application::services::{
    dsp_fetcher::DspFetcherServiceTrait, onchain_fetcher::OnchainFetcherServiceTrait,
    push_notification::PushNotificationServiceTrait, request_llm::LlmServiceTrait,
};

pub(crate) struct NoOpLlmService;
#[async_trait]
impl LlmServiceTrait for NoOpLlmService {
    async fn ask_question(
        &self,
        _question: domain::services::llm::Question,
    ) -> Result<domain::services::llm::Answer, anyhow::Error> {
        Err(anyhow::anyhow!("LlmService is not configured"))
    }
}

pub(crate) struct NoOpDspFetcherService;
#[async_trait]
impl DspFetcherServiceTrait for NoOpDspFetcherService {
    async fn fetch_dsps_data(
        &self,
        _start_date: Option<String>,
        _end_date: String,
    ) -> Result<Vec<application::services::dsp_fetcher::DspsData>, anyhow::Error> {
        Err(anyhow::anyhow!("DspFetcherService is not configured"))
    }
    async fn fetch_gender_gen_data(
        &self,
        _date: String,
    ) -> Result<Vec<application::services::dsp_fetcher::GenderGenData>, anyhow::Error> {
        Err(anyhow::anyhow!("DspFetcherService is not configured"))
    }
    async fn fetch_sparse_data(
        &self,
        _date: String,
    ) -> Result<Vec<application::services::dsp_fetcher::SparseData>, anyhow::Error> {
        Err(anyhow::anyhow!("DspFetcherService is not configured"))
    }
}

// Push通知はサイドエフェクトのみで戻り値に依存するフローがないため、
// Errを返すと呼び出し元の主処理（メッセージ送信等）が巻き添えで失敗する。
// データ取得系(DSP, Onchain, LLM)はErrを返し、呼び出し元に明示的に伝える。
pub(crate) struct NoOpPushNotificationService;
#[async_trait]
impl PushNotificationServiceTrait for NoOpPushNotificationService {
    async fn send_push_notification(
        &self,
        _notification: domain::services::notification::PushNotification,
    ) -> Result<String, anyhow::Error> {
        tracing::warn!("PushNotificationService is not configured, skipping notification");
        Ok("noop".to_string())
    }
}

pub(crate) struct NoOpOnchainFetcherService;
#[async_trait]
impl OnchainFetcherServiceTrait for NoOpOnchainFetcherService {
    async fn fetch_credential_balances(
        &self,
        _evm_addrs: Vec<String>,
    ) -> Result<Vec<application::services::onchain_fetcher::CredentialBalance>, anyhow::Error> {
        Err(anyhow::anyhow!("OnchainFetcherService is not configured"))
    }
}
