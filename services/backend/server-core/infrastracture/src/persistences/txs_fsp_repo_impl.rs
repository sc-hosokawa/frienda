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

    async fn create_many(&self, txs_fsps: Vec<TxsFspActiveModel>) -> Result<TxsFsp, DomainError> {
        let txn = self.db.begin().await?;
        let res = TxsFspEntity::insert_many(txs_fsps).exec(&txn).await?;
        let inserted_txs_fsps = TxsFspEntity::find_by_id(res.last_insert_id)
            .one(&txn)
            .await?;
        txn.commit().await?;

        Ok(inserted_txs_fsps.unwrap())
    }

    async fn get_by_user_id(&self, user_id: &str, count: i32) -> Result<Vec<TxsFsp>, DomainError> {
        let txs_fsps = TxsFspEntity::find()
            .filter(
                Condition::any()
                    .add(Column::From.eq(user_id))
                    .add(Column::To.eq(user_id)),
            )
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

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::NaiveDate;
    use domain::repositories::txs_fsp_repo::TxsFspRepository;
    use sea_orm::{ActiveValue::Set, DbBackend, MockDatabase, MockExecResult};

    fn tx_at() -> chrono::NaiveDateTime {
        NaiveDate::from_ymd_opt(2026, 1, 1)
            .unwrap()
            .and_hms_opt(12, 0, 0)
            .unwrap()
    }

    fn model(id: Uuid) -> TxsFsp {
        TxsFsp {
            id,
            from: Some("sender".to_string()),
            to: "receiver".to_string(),
            amount: 100,
            tx_at: tx_at(),
            notes: Some("bulk".to_string()),
        }
    }

    fn active_model(id: Uuid) -> TxsFspActiveModel {
        TxsFspActiveModel {
            id: Set(id),
            from: Set(Some("sender".to_string())),
            to: Set("receiver".to_string()),
            amount: Set(100),
            tx_at: Set(tx_at()),
            notes: Set(Some("bulk".to_string())),
        }
    }

    #[tokio::test]
    async fn create_many_wraps_insert_and_select_in_one_transaction() {
        let id = Uuid::from_u128(1);
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_exec_results([MockExecResult {
                last_insert_id: 1,
                rows_affected: 2,
            }])
            .append_query_results([[model(id)]])
            .into_connection();
        let repo = TxsFspRepoImpl::new(db);

        let created = repo
            .create_many(vec![active_model(id), active_model(Uuid::from_u128(2))])
            .await
            .unwrap();

        assert_eq!(created.id, id);
        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("BEGIN"), "{log}");
        assert!(log.contains("INSERT"), "{log}");
        assert!(log.contains("SELECT"), "{log}");
        assert!(log.contains("COMMIT"), "{log}");
        assert!(!log.contains("ROLLBACK"), "{log}");
    }
}
