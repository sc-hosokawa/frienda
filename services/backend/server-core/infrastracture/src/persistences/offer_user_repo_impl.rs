use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::offer_user::{
    ActiveModel as OfferUserActiveModel, Column, Entity as OfferUserEntity, Model as OfferUser,
};
use domain::entities::sea_orm_active_enums::OfferStatus;
use domain::repositories::offer_user_repo::OfferUserRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct OfferUserRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl OfferUserRepository for OfferUserRepoImpl {
    async fn create(&self, offer_user: OfferUserActiveModel) -> Result<OfferUser, DomainError> {
        let res: InsertResult<OfferUserActiveModel> =
            OfferUserEntity::insert(offer_user).exec(&self.db).await?;

        let inserted_offer_user = OfferUserEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_offer_user.unwrap())
    }

    async fn update(&self, offer_user: OfferUserActiveModel) -> Result<OfferUser, DomainError> {
        let updated_offer_user: OfferUser = offer_user.update(&self.db).await?;
        Ok(updated_offer_user)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res = OfferUserEntity::delete_many()
            .filter(Column::Id.eq(id))
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<OfferUser>, DomainError> {
        let offer_user = OfferUserEntity::find_by_id(id).one(&self.db).await?;
        Ok(offer_user)
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<OfferUser>, DomainError> {
        let offer_users = OfferUserEntity::find()
            .filter(Column::UserId.eq(user_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(offer_users)
    }

    async fn get_by_offer_id(&self, offer_id: i32) -> Result<Vec<OfferUser>, DomainError> {
        let offer_users = OfferUserEntity::find()
            .filter(Column::OfferId.eq(offer_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(offer_users)
    }

    async fn get_by_user_id_and_offer_id(
        &self,
        user_id: &str,
        offer_id: i32,
    ) -> Result<Option<OfferUser>, DomainError> {
        let offer_user = OfferUserEntity::find()
            .filter(Column::UserId.eq(user_id))
            .filter(Column::OfferId.eq(offer_id))
            .one(&self.db)
            .await?;

        Ok(offer_user)
    }

    async fn get_by_user_id_and_status(
        &self,
        user_id: &str,
        status: OfferStatus,
    ) -> Result<Vec<OfferUser>, DomainError> {
        let offer_users = OfferUserEntity::find()
            .filter(Column::UserId.eq(user_id))
            .filter(Column::Status.eq(status))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(offer_users)
    }
}
