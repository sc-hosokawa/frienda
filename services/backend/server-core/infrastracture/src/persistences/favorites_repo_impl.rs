use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::favorites::{
    ActiveModel as FavoriteActiveModel, Column, Entity as FavoriteEntity, Model as Favorite,
};
use domain::repositories::favorites_repo::FavoritesRepository;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[derive(new)]
pub struct FavoritesRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl FavoritesRepository for FavoritesRepoImpl {
    async fn create(&self, model: FavoriteActiveModel) -> Result<Favorite, DomainError> {
        let res = FavoriteEntity::insert(model).exec(&self.db).await?;
        let inserted_model = FavoriteEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(&self, model: FavoriteActiveModel) -> Result<Favorite, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        FavoriteEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_source_user_id(
        &self,
        source_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError> {
        let res = FavoriteEntity::find()
            .filter(Column::LikedBy.eq(source_user_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_target_user_id(
        &self,
        target_user_id: &str,
    ) -> Result<Vec<Favorite>, DomainError> {
        let res = FavoriteEntity::find()
            .filter(Column::UserId.eq(target_user_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn get_by_source_user_id_and_target_user_id(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError> {
        let res = FavoriteEntity::find()
            .filter(Column::LikedBy.eq(source_user_id))
            .filter(Column::UserId.eq(target_user_id))
            .one(&self.db)
            .await?;
        Ok(res)
    }

    async fn exists(
        &self,
        source_user_id: &str,
        target_user_id: &str,
    ) -> Result<Option<Favorite>, DomainError> {
        let res = FavoriteEntity::find()
            .filter(Column::LikedBy.eq(source_user_id))
            .filter(Column::UserId.eq(target_user_id))
            .one(&self.db)
            .await?;
        Ok(res)
    }
}
