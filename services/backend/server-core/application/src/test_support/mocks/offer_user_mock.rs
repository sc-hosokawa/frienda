use async_trait::async_trait;
use domain::entities::offer_user::{ActiveModel as OfferUserActiveModel, Model as OfferUser};
use domain::entities::sea_orm_active_enums::OfferStatus;
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::offer_user_repo::{OfferStatsAggregate, OfferUserRepository};

#[automock]
#[async_trait]
pub trait MockOfferUserRepo {
    async fn mock_create(&self, offer_user: OfferUserActiveModel)
        -> Result<OfferUser, DomainError>;
    async fn mock_update(&self, offer_user: OfferUserActiveModel)
        -> Result<OfferUser, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_delete_by_offer_id(&self, offer_id: i32) -> Result<(), DomainError>;
    async fn mock_get_by_id(&self, id: i32) -> Result<Option<OfferUser>, DomainError>;
    async fn mock_get_by_user_id(&self, user_id: String) -> Result<Vec<OfferUser>, DomainError>;
    async fn mock_get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferUser>, DomainError>;
    async fn mock_get_by_offer_ids(
        &self,
        offer_ids: Vec<i32>,
    ) -> Result<Vec<OfferUser>, DomainError>;
    async fn mock_get_by_user_id_and_offer_id(
        &self,
        user_id: String,
        offer_id: i32,
    ) -> Result<Option<OfferUser>, DomainError>;
    async fn mock_get_by_user_id_and_status(
        &self,
        user_id: String,
        status: OfferStatus,
    ) -> Result<Vec<OfferUser>, DomainError>;
    async fn mock_aggregate_stats_by_user_id(
        &self,
        user_id: String,
    ) -> Result<OfferStatsAggregate, DomainError>;
    async fn mock_cancel_other_applications(
        &self,
        offer_id: i32,
        except_user_id: &str,
    ) -> Result<(), DomainError>;
}

#[async_trait]
impl OfferUserRepository for MockMockOfferUserRepo {
    async fn create(&self, offer_user: OfferUserActiveModel) -> Result<OfferUser, DomainError> {
        self.mock_create(offer_user).await
    }

    async fn update(&self, offer_user: OfferUserActiveModel) -> Result<OfferUser, DomainError> {
        self.mock_update(offer_user).await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn delete_by_offer_id(&self, offer_id: i32) -> Result<(), DomainError> {
        self.mock_delete_by_offer_id(offer_id).await
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<OfferUser>, DomainError> {
        self.mock_get_by_id(id).await
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<OfferUser>, DomainError> {
        self.mock_get_by_user_id(user_id.to_string()).await
    }

    async fn get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferUser>, DomainError> {
        self.mock_get_by_offer_id(offer_id).await
    }

    async fn get_by_offer_ids(&self, offer_ids: Vec<i32>) -> Result<Vec<OfferUser>, DomainError> {
        self.mock_get_by_offer_ids(offer_ids).await
    }

    async fn get_by_user_id_and_offer_id(
        &self,
        user_id: &str,
        offer_id: i32,
    ) -> Result<Option<OfferUser>, DomainError> {
        self.mock_get_by_user_id_and_offer_id(user_id.to_string(), offer_id)
            .await
    }

    async fn get_by_user_id_and_status(
        &self,
        user_id: &str,
        status: OfferStatus,
    ) -> Result<Vec<OfferUser>, DomainError> {
        self.mock_get_by_user_id_and_status(user_id.to_string(), status)
            .await
    }

    async fn aggregate_stats_by_user_id(
        &self,
        user_id: &str,
    ) -> Result<OfferStatsAggregate, DomainError> {
        self.mock_aggregate_stats_by_user_id(user_id.to_string())
            .await
    }

    async fn cancel_other_applications(
        &self,
        offer_id: i32,
        except_user_id: &str,
    ) -> Result<(), DomainError> {
        self.mock_cancel_other_applications(offer_id, except_user_id)
            .await
    }
}
