use async_trait::async_trait;
use domain::entities::txs_fsp::{ActiveModel as TxsFspActiveModel, Model as TxsFsp};
use mockall::automock;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

use domain::repositories::txs_fsp_repo::TxsFspRepository;

#[automock]
#[async_trait]
pub trait MockTxsFspRepo {
    async fn mock_create(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError>;
    async fn mock_update(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError>;
    async fn mock_create_many(
        &self,
        txs_fsps: Vec<TxsFspActiveModel>,
    ) -> Result<TxsFsp, DomainError>;
    async fn mock_get_by_user_id(
        &self,
        user_id: String,
        count: i32,
    ) -> Result<Vec<TxsFsp>, DomainError>;
    async fn mock_find_by_id(&self, id: Uuid) -> Result<Option<TxsFsp>, DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<TxsFsp>, DomainError>;
    async fn mock_delete(&self, id: Uuid) -> Result<(), DomainError>;
}

#[async_trait]
impl TxsFspRepository for MockMockTxsFspRepo {
    async fn create(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError> {
        self.mock_create(txs_fsp).await
    }

    async fn update(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError> {
        self.mock_update(txs_fsp).await
    }

    async fn create_many(&self, txs_fsps: Vec<TxsFspActiveModel>) -> Result<TxsFsp, DomainError> {
        self.mock_create_many(txs_fsps).await
    }

    async fn get_by_user_id(&self, user_id: &str, count: i32) -> Result<Vec<TxsFsp>, DomainError> {
        self.mock_get_by_user_id(user_id.to_string(), count).await
    }

    async fn find_by_id(&self, id: Uuid) -> Result<Option<TxsFsp>, DomainError> {
        self.mock_find_by_id(id).await
    }

    async fn find_all(&self) -> Result<Vec<TxsFsp>, DomainError> {
        self.mock_find_all().await
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }
}
