use async_trait::async_trait;
use std::sync::Arc;

#[derive(Debug)]
pub struct CredentialBalance {
    pub evm_addr: String,
    pub balance: i64,
}

#[async_trait]
pub trait OnchainFetcherServiceTrait: Send + Sync {
    async fn fetch_credential_balances(
        &self,
        evm_addrs: Vec<String>,
    ) -> Result<Vec<CredentialBalance>, anyhow::Error>;
}

pub struct OnchainFetcherService {
    onchain_fetcher_service: Arc<dyn OnchainFetcherServiceTrait>,
}

impl OnchainFetcherService {
    pub fn new(onchain_fetcher_service: Arc<dyn OnchainFetcherServiceTrait>) -> Self {
        Self {
            onchain_fetcher_service,
        }
    }
}

#[async_trait]
impl OnchainFetcherServiceTrait for OnchainFetcherService {
    async fn fetch_credential_balances(
        &self,
        evm_addrs: Vec<String>,
    ) -> Result<Vec<CredentialBalance>, anyhow::Error> {
        let res: Vec<CredentialBalance> = self
            .onchain_fetcher_service
            .fetch_credential_balances(evm_addrs)
            .await?;
        Ok(res)
    }
}
