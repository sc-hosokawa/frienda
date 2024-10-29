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
        let res = OfferAttachEntity::insert_many(offer_attaches)
            .exec(&self.db)
            .await?;

        let _inserted_offers_attaches = OfferAttachEntity::find_by_id(res.last_insert_id)
            .all(&self.db)
            .await?;

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
}
