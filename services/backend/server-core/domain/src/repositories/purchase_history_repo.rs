use crate::entities::purchase_history::{
    ActiveModel as PurchaseHistoryActiveModel, Model as PurchaseHistory,
};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait PurchaseHistoryRepository {
    async fn create(
        &self,
        purchase: &PurchaseHistoryActiveModel,
    ) -> Result<PurchaseHistory, DomainError>;
    async fn update(
        &self,
        purchase: &PurchaseHistoryActiveModel,
    ) -> Result<PurchaseHistory, DomainError>;

    async fn get_by_id(&self, purchase_id: Uuid) -> Result<Option<PurchaseHistory>, DomainError>;
    async fn get_by_user_id(&self, user_id: Uuid) -> Result<Vec<PurchaseHistory>, DomainError>;
}
