use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::txs_fsp::{
    ActiveModel as TxsFspActiveModel, Column, Entity as TxsFspEntity, Model as TxsFsp,
};
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct TxsFspRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl TxsFspRepository for TxsFspRepoImpl {
    async fn create(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError> {
        let res: InsertResult<TxsFspActiveModel> =
            TxsFspEntity::insert(txs_fsp).exec(&self.db).await?;

        let inserted_txs_fsp = TxsFspEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_txs_fsp.unwrap())
    }

    async fn update(&self, txs_fsp: TxsFspActiveModel) -> Result<TxsFsp, DomainError> {
        let res = TxsFspEntity::update(txs_fsp).exec(&self.db).await?;
        Ok(res)
    }

    async fn create_many(&self, txs_fsps: Vec<TxsFspActiveModel>) -> Result<(), DomainError> {
        let _res: InsertResult<TxsFspActiveModel> =
            TxsFspEntity::insert_many(txs_fsps).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_user_id(&self, user_id: &str, count: i32) -> Result<Vec<TxsFsp>, DomainError> {
        let txs_fsps = TxsFspEntity::find()
            .filter(Column::From.eq(user_id))
            .limit(count as u64)
            .order_by_desc(Column::TxAt)
            .all(&self.db)
            .await?;
        Ok(txs_fsps)
    }

    async fn find_by_id(&self, id: Uuid) -> Result<Option<TxsFsp>, DomainError> {
        let txs_fsp = TxsFspEntity::find_by_id(id).one(&self.db).await?;
        Ok(txs_fsp)
    }

    async fn find_all(&self) -> Result<Vec<TxsFsp>, DomainError> {
        let txs_fsps = TxsFspEntity::find()
            .order_by_desc(Column::TxAt)
            .all(&self.db)
            .await?;
        Ok(txs_fsps)
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        let _res: DeleteResult = TxsFspEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }
}
