use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::offers::{
    ActiveModel as OfferActiveModel, Column, Entity as OfferEntity, Model as Offer,
};
use domain::repositories::offers_repo::{OffersRepository, SearchOptions};
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

    async fn get_by_ids(&self, ids: Vec<i32>) -> Result<Vec<Offer>, DomainError> {
        let offers = OfferEntity::find()
            .filter(Column::Id.is_in(ids))
            .all(&self.db)
            .await?;
        Ok(offers)
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

    async fn search(&self, query: &str, options: SearchOptions) -> Result<Vec<Offer>, DomainError> {
        let mut condition: Condition = if query.is_empty() {
            Condition::all()
        } else {
            let search_term: String = format!("%{}%", query);
            Condition::any()
                .add(Column::Title.contains(&search_term))
                .add(Column::Description.contains(&search_term))
                .add(Column::Attention.contains(&search_term))
        };

        if let Some(category) = options.category {
            condition = condition.add(Column::Category.eq(category));
        }

        if let Some(target_role) = options.target_role {
            condition = condition.add(Column::TargetRole.eq(target_role));
        }

        if let Some(min_price) = options.min_price {
            condition = condition.add(Column::Fee.gte(min_price));
        }

        if let Some(max_price) = options.max_price {
            condition = condition.add(Column::Fee.lte(max_price));
        }

        if let Some(place) = options.place {
            condition = condition.add(Column::Place.contains(&place));
        }

        if let Some(owner) = options.owner {
            condition = condition.add(Column::Owner.eq(owner));
        }

        let mut query = OfferEntity::find().filter(condition);

        if let Some(sort_by) = options.sort_by {
            query = match sort_by.as_str() {
                "fee_asc" => query.order_by_asc(Column::Fee),
                "fee_desc" => query.order_by_desc(Column::Fee),
                _ => query.order_by_desc(Column::CreatedAt),
            };
        }

        query
            .all(&self.db)
            .await
            .map_err(|e| DomainError::DatabaseError(e.to_string()))
    }
}
