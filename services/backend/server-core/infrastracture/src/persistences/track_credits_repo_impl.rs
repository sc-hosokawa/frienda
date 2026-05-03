use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::track_credits::{
    ActiveModel as TrackCreditsActiveModel, Column, Entity as TrackCreditsEntity,
    Model as TrackCredits,
};
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use shared::error::domain_err::DomainError;
use shared::numeric::checked_u64_to_i64;

#[derive(new)]
pub struct TrackCreditsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl TrackCreditsRepository for TrackCreditsRepoImpl {
    async fn create(&self, model: TrackCreditsActiveModel) -> Result<TrackCredits, DomainError> {
        let res: InsertResult<TrackCreditsActiveModel> =
            TrackCreditsEntity::insert(model).exec(&self.db).await?;
        let inserted_model: Option<TrackCredits> =
            TrackCreditsEntity::find_by_id(res.last_insert_id)
                .one(&self.db)
                .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: TrackCreditsActiveModel) -> Result<TrackCredits, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        TrackCreditsEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn find_all(&self) -> Result<Vec<TrackCredits>, DomainError> {
        let res = TrackCreditsEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<TrackCredits>, DomainError> {
        let res = TrackCreditsEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<TrackCredits>, DomainError> {
        let res = TrackCreditsEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_is_invite(&self, is_invite: bool) -> Result<Vec<TrackCredits>, DomainError> {
        let res = TrackCreditsEntity::find()
            .filter(Column::IsInvite.eq(is_invite))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn all_credits(&self, count: i32) -> Result<Vec<TrackCredits>, DomainError> {
        let res: Vec<TrackCredits> = TrackCreditsEntity::find()
            .order_by_desc(Column::CreatedAt)
            .limit(count as u64)
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn count_credits(&self) -> Result<i64, DomainError> {
        let res: u64 = TrackCreditsEntity::find().count(&self.db).await?;
        checked_u64_to_i64(res, "track_credits_count").map_err(DomainError::UnexpectedError)
    }

    async fn delete_by_isrc(&self, isrc: &str) -> Result<(), DomainError> {
        let _res = TrackCreditsEntity::delete_many()
            .filter(Column::Isrc.eq(isrc))
            .exec(&self.db)
            .await?;
        Ok(())
    }
}
