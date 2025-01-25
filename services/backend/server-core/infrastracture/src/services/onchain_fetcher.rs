use async_trait::async_trait;

use alloy::{
    primitives::{address, Address, U256},
    providers::{Provider, ProviderBuilder},
    rpc::types::{Filter, Log},
};
use anyhow;
use tracing;

use application::services::onchain_fetcher::{CredentialBalance, OnchainFetcherServiceTrait};

#[derive(Debug)]
pub struct TransferEvent {
    pub from: String,
    pub to: String,
    pub value: U256,
}

pub struct OnchainFetcherService {}

impl OnchainFetcherService {
    pub async fn new() -> Result<Self, anyhow::Error> {
        Ok(Self {})
    }
}

#[async_trait]
impl OnchainFetcherServiceTrait for OnchainFetcherService {
    async fn fetch_credential_balances(
        &self,
        evm_addrs: Vec<String>,
    ) -> Result<Vec<CredentialBalance>, anyhow::Error> {
        let start_block = 21699451;
        let rpc_url = std::env::var("ETH_RPC_URL")
            .map_err(|_| anyhow::anyhow!("ETH_RPC_URL environment variable not set"))?
            .parse()
            .map_err(|e| anyhow::anyhow!("{}", e))?;
        let provider = ProviderBuilder::new().on_http(rpc_url);

        let latest_block: u64 = provider
            .get_block_number()
            .await
            .map_err(|e| anyhow::anyhow!("{}", e))?;
        tracing::info!("Latest block: {latest_block}");

        let cred_address: Address = std::env::var("CREDENTIAL_CONTRACT_ADDRESS")
            .map_err(|_| {
                anyhow::anyhow!("CREDENTIAL_CONTRACT_ADDRESS environment variable not set")
            })?
            .parse()
            .map_err(|e| anyhow::anyhow!("Invalid address format: {}", e))?;
        let filter: Filter = Filter::new()
            .address(cred_address)
            .event("Transfer(address,address,uint256)")
            .from_block(start_block);
        let logs: Vec<Log> = provider
            .get_logs(&filter)
            .await
            .map_err(|e| anyhow::anyhow!("{}", e))?;

        let transfer_events: Vec<TransferEvent> = logs
            .iter()
            .map(|log| {
                let topics = log.topics();
                let from = format!("0x{}", &topics[1].to_string()[26..]);
                let to = format!("0x{}", &topics[2].to_string()[26..]);

                let mut bytes = [0u8; 32];
                bytes.copy_from_slice(log.data().data.as_ref());
                let value = U256::from_be_bytes(bytes);

                let transfer_event: TransferEvent = TransferEvent { from, to, value };
                Ok(transfer_event)
            })
            .collect::<Result<Vec<TransferEvent>, _>>()
            .map_err(|e: anyhow::Error| anyhow::anyhow!("{}", e))?;

        tracing::info!("transfer_events: {:?}", transfer_events);

        let mut balances: Vec<CredentialBalance> = Vec::new();
        for addr in evm_addrs {
            let total_amount: U256 = transfer_events
                .iter()
                .filter(|event| event.to == addr)
                .map(|event| event.value)
                .sum();

            balances.push(CredentialBalance {
                evm_addr: addr,
                balance: total_amount
                    .try_into()
                    .map_err(|_| anyhow::anyhow!("Value too large for i64"))?,
            });
        }

        tracing::info!("balances: {:?}", balances);

        Ok(balances)
    }
}
