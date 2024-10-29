use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::offers::{
    ActiveModel as OfferActiveModel, Column, Entity as OfferEntity, Model as Offer,
};
use domain::repositories::offers_repo::OffersRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct OffersRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl OffersRepository for OffersRepoImpl {
    async fn create(&self, offer: OfferActiveModel) -> Result<Offer, DomainError> {
        let res: InsertResult<OfferActiveModel> = OfferEntity::insert(offer).exec(&self.db).await?;

        let inserted_offer = OfferEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_offer.unwrap())
    }

    async fn update(&self, offer: OfferActiveModel) -> Result<Offer, DomainError> {
        let updated_offer: Offer = offer.update(&self.db).await?;
        Ok(updated_offer)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Offer>, DomainError> {
        let offer = OfferEntity::find_by_id(id).one(&self.db).await?;
        Ok(offer)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res = OfferEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn list(&self, limit: u32, offset: u32) -> Result<Vec<Offer>, DomainError> {
        let offers = OfferEntity::find()
            .limit(limit as u64)
            .offset(offset as u64)
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;

        Ok(offers)
    }

    async fn get_active_offers(&self) -> Result<Vec<Offer>, DomainError> {
        let offers = OfferEntity::find()
            .filter(Column::Publicity.eq(true))
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;

        Ok(offers)
    }

    async fn get_offers_by_user(&self, user_id: &str) -> Result<Vec<Offer>, DomainError> {
        let offers = OfferEntity::find()
            .filter(Column::Owner.eq(user_id))
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;

        Ok(offers)
    }

    async fn get_offers_by_category(&self, category_id: &str) -> Result<Vec<Offer>, DomainError> {
        let offers = OfferEntity::find()
            .filter(Column::Category.eq(category_id))
            .order_by_desc(Column::CreatedAt)
            .all(&self.db)
            .await?;

        Ok(offers)
    }
}
