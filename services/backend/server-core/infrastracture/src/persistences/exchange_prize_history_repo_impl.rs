use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::exchange_prize_history::{
    ActiveModel as ExchangePrizeHistoryActiveModel, Column, Entity as ExchangePrizeHistoryEntity,
    Model as ExchangePrizeHistory,
};
use domain::repositories::exchange_prize_history_repo::ExchangePrizeHistoryRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ExchangePrizeHistoryRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl ExchangePrizeHistoryRepository for ExchangePrizeHistoryRepoImpl {
    async fn create(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError> {
        let res: InsertResult<ExchangePrizeHistoryActiveModel> =
            ExchangePrizeHistoryEntity::insert(history)
                .exec(&self.db)
                .await?;

        let created_history: Option<ExchangePrizeHistory> =
            ExchangePrizeHistoryEntity::find_by_id(res.last_insert_id)
                .one(&self.db)
                .await?;

        Ok(created_history.unwrap())
    }

    async fn update(
        &self,
        history: ExchangePrizeHistoryActiveModel,
    ) -> Result<ExchangePrizeHistory, DomainError> {
        let updated_history: ExchangePrizeHistory = history.update(&self.db).await?;
        Ok(updated_history)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res = ExchangePrizeHistoryEntity::delete_by_id(id)
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<ExchangePrizeHistory>, DomainError> {
        let history = ExchangePrizeHistoryEntity::find_by_id(id)
            .one(&self.db)
            .await?;
        Ok(history)
    }

    async fn get_by_user_id(
        &self,
        user_id: &str,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        let histories = ExchangePrizeHistoryEntity::find()
            .filter(Column::User.eq(user_id))
            .order_by_desc(Column::ExchangedAt)
            .all(&self.db)
            .await?;
        Ok(histories)
    }

    async fn get_by_prize_id(
        &self,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        let histories = ExchangePrizeHistoryEntity::find()
            .filter(Column::PrizeId.eq(prize_id))
            .order_by_desc(Column::ExchangedAt)
            .all(&self.db)
            .await?;
        Ok(histories)
    }

    async fn get_recent(&self, limit: i32) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        let histories = ExchangePrizeHistoryEntity::find()
            .order_by_desc(Column::ExchangedAt)
            .limit(limit as u64)
            .all(&self.db)
            .await?;
        Ok(histories)
    }

    async fn get_by_user_id_and_prize_id(
        &self,
        user_id: &str,
        prize_id: i32,
    ) -> Result<Vec<ExchangePrizeHistory>, DomainError> {
        let history: Vec<ExchangePrizeHistory> = ExchangePrizeHistoryEntity::find()
            .filter(Column::User.eq(user_id))
            .filter(Column::PrizeId.eq(prize_id))
            .all(&self.db)
            .await?;
        Ok(history)
    }
}
