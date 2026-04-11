use async_trait::async_trait;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::favorites::ActiveModel as FavoriteActiveModel;
use domain::repositories::favorites_repo::FavoritesRepository;

pub struct MarkFavoriteInput {
    pub user_id: String,
    pub liked_by: String,
}

#[async_trait]
pub trait MarkFavoriteUsecaseTrait: Send + Sync {
    async fn mark_favorite(&self, input: MarkFavoriteInput) -> Result<String, DomainError>;
    async fn unmark_favorite(&self, favorite_id: Uuid) -> Result<Uuid, DomainError>;
}

pub struct MarkFavoriteUsecase {
    favorites_repo: Arc<dyn FavoritesRepository>,
}

impl MarkFavoriteUsecase {
    pub fn new(favorites_repo: Arc<dyn FavoritesRepository>) -> Self {
        Self { favorites_repo }
    }
}

#[async_trait]
impl MarkFavoriteUsecaseTrait for MarkFavoriteUsecase {
    async fn mark_favorite(&self, input: MarkFavoriteInput) -> Result<String, DomainError> {
        let favorite: FavoriteActiveModel = FavoriteActiveModel {
            user_id: ActiveValue::Set(input.user_id.clone()),
            liked_by: ActiveValue::Set(input.liked_by),
            ..Default::default()
        };

        let _res = self.favorites_repo.create(favorite).await?;

        Ok(input.user_id)
    }

    async fn unmark_favorite(&self, favorite_id: Uuid) -> Result<Uuid, DomainError> {
        let _res = self.favorites_repo.delete(favorite_id).await?;
        Ok(favorite_id)
    }
}

#[cfg(test)]
#[path = "mark_favorite_usecase_tests.rs"]
mod tests;
