use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::favorites::{
    ActiveModel as FavoriteActiveModel, Entity as FavoriteEntity, Model as Favorite,
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
}
