use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::offer_attach::{
    ActiveModel as OfferAttachActiveModel, Column, Entity as OfferAttachEntity,
    Model as OfferAttach,
};
use domain::repositories::offer_attach_repo::OfferAttachRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct OfferAttachRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl OfferAttachRepository for OfferAttachRepoImpl {
    async fn create(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError> {
        let res = OfferAttachEntity::insert(offer_attach)
            .exec(&self.db)
            .await?;

        let inserted_offer_attached = OfferAttachEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_offer_attached.unwrap())
    }

    async fn update(
        &self,
        offer_attach: OfferAttachActiveModel,
    ) -> Result<OfferAttach, DomainError> {
        let updated_offer_attach: OfferAttach = offer_attach.update(&self.db).await?;
        Ok(updated_offer_attach)
    }

    async fn create_many(
        &self,
        offer_attaches: Vec<OfferAttachActiveModel>,
    ) -> Result<(), DomainError> {
        let txn = self.db.begin().await?;
        let res = OfferAttachEntity::insert_many(offer_attaches)
            .exec(&txn)
            .await?;

        let _inserted_offers_attaches = OfferAttachEntity::find_by_id(res.last_insert_id)
            .all(&txn)
            .await?;
        txn.commit().await?;

        Ok(())
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<OfferAttach>, DomainError> {
        let offer_attach = OfferAttachEntity::find_by_id(id).one(&self.db).await?;

        Ok(offer_attach)
    }

    async fn get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError> {
        let offer_attaches = OfferAttachEntity::find()
            .filter(Column::OfferId.eq(offer_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(offer_attaches)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res = OfferAttachEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn delete_by_offer_id(&self, offer_id: i32) -> Result<(), DomainError> {
        let _res = OfferAttachEntity::delete_many()
            .filter(Column::OfferId.eq(offer_id))
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn get_images_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError> {
        let res = OfferAttachEntity::find()
            .filter(Column::OfferId.eq(offer_id))
            .filter(Column::ImageUri.is_not_null())
            .filter(Column::ImageUri.ne(""))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_files_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferAttach>, DomainError> {
        let res = OfferAttachEntity::find()
            .filter(Column::OfferId.eq(offer_id))
            .filter(Column::FileUri.is_not_null())
            .filter(Column::FileUri.ne(""))
            .all(&self.db)
            .await?;
        Ok(res)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::offer_attach_repo::OfferAttachRepository;
    use sea_orm::{ActiveValue::Set, DbBackend, MockDatabase, MockExecResult};

    fn model(id: i32) -> OfferAttach {
        OfferAttach {
            id,
            offer_id: 10,
            file_uri: Some(format!("file-{id}")),
            image_uri: None,
        }
    }

    fn active_model(id: i32) -> OfferAttachActiveModel {
        OfferAttachActiveModel {
            id: Set(id),
            offer_id: Set(10),
            file_uri: Set(Some(format!("file-{id}"))),
            image_uri: Set(None),
        }
    }

    #[tokio::test]
    async fn create_many_wraps_insert_and_select_in_one_transaction() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_exec_results([MockExecResult {
                last_insert_id: 1,
                rows_affected: 2,
            }])
            .append_query_results([[model(1)], [model(1)]])
            .into_connection();
        let repo = OfferAttachRepoImpl::new(db);

        repo.create_many(vec![active_model(1), active_model(2)])
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("BEGIN"), "{log}");
        assert!(log.contains("INSERT"), "{log}");
        assert!(log.contains("SELECT"), "{log}");
        assert!(log.contains("COMMIT"), "{log}");
        assert!(!log.contains("ROLLBACK"), "{log}");
    }
}
