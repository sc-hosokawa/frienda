use crate::entities::txs_fsp::{ActiveModel as TxsFspActiveModel, Model as TxsFsp};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;

#[async_trait]
pub trait TxsFspRepository {
    async fn create(&self, txs_fsp: &TxsFspActiveModel) -> Result<TxsFsp, DomainError>;
    async fn update(&self, txs_fsp: &TxsFspActiveModel) -> Result<TxsFsp, DomainError>;

    async fn find_by_id(&self, id: &str) -> Result<Option<TxsFsp>, DomainError>;
    async fn find_all(&self) -> Result<Vec<TxsFsp>, DomainError>;
    async fn delete(&self, id: &str) -> Result<(), DomainError>;
}
