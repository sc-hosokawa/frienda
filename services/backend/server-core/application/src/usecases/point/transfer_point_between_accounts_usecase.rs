use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::txs_fsp::ActiveModel as TxsFspActiveModel;
use domain::repositories::txs_fsp_repo::TxsFspRepository;

//
// Define the input for the usecase
//
pub struct TransferPointBetweenAccountsInput {
    pub from: Option<String>,
    pub to: String,
    pub amount: i32,
    pub notes: Option<String>, // abstract
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait TransferPointBetweenAccountsUsecaseTrait: Send + Sync {
    async fn transfer(&self, input: TransferPointBetweenAccountsInput)
        -> Result<(), anyhow::Error>;
    async fn bulk_transfer(
        &self,
        input: Vec<TransferPointBetweenAccountsInput>,
    ) -> Result<(), anyhow::Error>;
}

//
// Implement the usecase
//
pub struct TransferPointBetweenAccountsUsecase {
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
}

impl TransferPointBetweenAccountsUsecase {
    pub fn new(txs_fsp_repo: Arc<dyn TxsFspRepository>) -> Self {
        Self { txs_fsp_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl TransferPointBetweenAccountsUsecaseTrait for TransferPointBetweenAccountsUsecase {
    async fn transfer(
        &self,
        input: TransferPointBetweenAccountsInput,
    ) -> Result<(), anyhow::Error> {
        let tx_fsp: TxsFspActiveModel = TxsFspActiveModel {
            from: ActiveValue::Set(input.from),
            to: ActiveValue::Set(input.to),
            amount: ActiveValue::Set(input.amount),
            notes: ActiveValue::Set(input.notes),
            ..Default::default()
        };
        self.txs_fsp_repo.create(tx_fsp).await?;

        Ok(())
    }

    async fn bulk_transfer(
        &self,
        input: Vec<TransferPointBetweenAccountsInput>,
    ) -> Result<(), anyhow::Error> {
        let mut tx_fsps: Vec<TxsFspActiveModel> = Vec::with_capacity(input.len());

        for transfer in input {
            let tx_fsp = TxsFspActiveModel {
                from: ActiveValue::Set(transfer.from),
                to: ActiveValue::Set(transfer.to),
                amount: ActiveValue::Set(transfer.amount),
                notes: ActiveValue::Set(transfer.notes),
                ..Default::default()
            };
            tx_fsps.push(tx_fsp);
        }

        self.txs_fsp_repo.create_many(tx_fsps).await?;

        Ok(())
    }
}
