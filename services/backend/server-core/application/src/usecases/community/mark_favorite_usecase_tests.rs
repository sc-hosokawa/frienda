use crate::test_support::mocks::favorites_mock::MockMockFavoritesRepo;
use crate::usecases::community::mark_favorite_usecase::{
    MarkFavoriteInput, MarkFavoriteUsecase, MarkFavoriteUsecaseTrait,
};
use domain::entities::favorites::{ActiveModel as FavoriteActiveModel, Model as Favorite};
use mockall::predicate::*;
use shared::error::domain_err::DomainError;
use std::sync::Arc;
use uuid::Uuid;

#[tokio::test]
async fn test_mark_favorite_success() {
    // Arrange
    let mut mock_repo = MockMockFavoritesRepo::new();
    let input = MarkFavoriteInput {
        user_id: "user123".to_string(),
        liked_by: "fan456".to_string(),
    };

    mock_repo
        .expect_mock_create()
        .returning(move |favorite: FavoriteActiveModel| {
            Ok(Favorite {
                id: Uuid::new_v4(),
                user_id: favorite.user_id.unwrap().to_string(),
                liked_by: favorite.liked_by.unwrap().to_string(),
                created_at: chrono::Utc::now().naive_utc(),
            })
        });

    let usecase = MarkFavoriteUsecase::new(Arc::new(mock_repo));

    // Act
    let user_id = usecase
        .mark_favorite(input)
        .await
        .expect("favorite creation should succeed");

    // Assert
    assert_eq!(user_id, "user123");
}

#[tokio::test]
async fn test_unmark_favorite_success() {
    // Arrange
    let mut mock_repo = MockMockFavoritesRepo::new();
    let favorite_id = Uuid::new_v4();

    mock_repo
        .expect_mock_delete()
        .with(eq(favorite_id))
        .returning(|_| Ok(()));

    let usecase = MarkFavoriteUsecase::new(Arc::new(mock_repo));

    // Act
    let deleted_id = usecase
        .unmark_favorite(favorite_id)
        .await
        .expect("favorite deletion should succeed");

    // Assert
    assert_eq!(deleted_id, favorite_id);
}

#[tokio::test]
async fn test_mark_favorite_repository_error() {
    // Arrange
    let mut mock_repo = MockMockFavoritesRepo::new();
    let input = MarkFavoriteInput {
        user_id: "user123".to_string(),
        liked_by: "fan456".to_string(),
    };

    mock_repo
        .expect_mock_create()
        .returning(|_| Err(DomainError::ValidationError("Test error".to_string())));

    let usecase = MarkFavoriteUsecase::new(Arc::new(mock_repo));

    // Act
    let error = match usecase.mark_favorite(input).await {
        Ok(_) => panic!("repository errors should be propagated"),
        Err(error) => error,
    };

    // Assert
    assert_eq!(error.to_string(), "Validation error: Test error");
}

#[tokio::test]
async fn test_unmark_favorite_repository_error() {
    // Arrange
    let mut mock_repo = MockMockFavoritesRepo::new();
    let favorite_id = Uuid::new_v4();

    mock_repo
        .expect_mock_delete()
        .with(eq(favorite_id))
        .returning(|_| Err(DomainError::ValidationError("Test error".to_string())));

    let usecase = MarkFavoriteUsecase::new(Arc::new(mock_repo));

    // Act
    let error = match usecase.unmark_favorite(favorite_id).await {
        Ok(_) => panic!("repository errors should be propagated"),
        Err(error) => error,
    };

    // Assert
    assert_eq!(error.to_string(), "Validation error: Test error");
}
