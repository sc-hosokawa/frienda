use crate::entities::txs_fsp::{ActiveModel as TxsFspActiveModel, Model as TxsFsp};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait TxsFspRepository: Send + Sync {
    async fn create(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError>;
    async fn update(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError>;
    async fn create_many(&self, txs_fsps: Vec<TxsFspActiveModel>) -> Result<TxsFsp, DomainError>;

    async fn get_by_user_id(&self, user_id: &str, count: i32) -> Result<Vec<TxsFsp>, DomainError>;
    async fn find_by_id(&self, id: Uuid) -> Result<Option<TxsFsp>, DomainError>;
    async fn find_all(&self) -> Result<Vec<TxsFsp>, DomainError>;
    async fn delete(&self, id: Uuid) -> Result<(), DomainError>;
}
