use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::prizes::{
    ActiveModel as PrizeActiveModel, Column, Entity as PrizeEntity, Model as Prize,
};
use domain::repositories::prizes_repo::PrizesRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct PrizesRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl PrizesRepository for PrizesRepoImpl {
    async fn create(&self, prize: PrizeActiveModel) -> Result<Prize, DomainError> {
        let res: InsertResult<PrizeActiveModel> = PrizeEntity::insert(prize).exec(&self.db).await?;

        let inserted_prize = PrizeEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_prize.unwrap())
    }

    async fn update(&self, prize: PrizeActiveModel) -> Result<Prize, DomainError> {
        let updated_prize: Prize = prize.update(&self.db).await?;
        Ok(updated_prize)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Prize>, DomainError> {
        let prize = PrizeEntity::find_by_id(id).one(&self.db).await?;
        Ok(prize)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res: DeleteResult = PrizeEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Prize>, DomainError> {
        let prizes = PrizeEntity::find()
            .limit(limit as u64)
            .offset(offset as u64)
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(prizes)
    }

    async fn get_by_condition(&self, condition: &str) -> Result<Vec<Prize>, DomainError> {
        let prizes = PrizeEntity::find()
            .filter(Column::Condition.eq(condition))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(prizes)
    }

    async fn get_available(&self) -> Result<Vec<Prize>, DomainError> {
        let prizes = PrizeEntity::find()
            .filter(Column::Publicity.eq(true))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(prizes)
    }
}
