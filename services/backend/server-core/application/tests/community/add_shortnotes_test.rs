use crate::mocks::shortnote_mock::MockMockShortNotesRepo;
use application::usecases::community::add_shortnote_usecase::{
    AddShortnoteInput, AddShortnoteUsecase, AddShortnoteUsecaseTrait,
};
use domain::entities::short_notes::{ActiveModel as ShortNoteActiveModel, Model as ShortNote};
use domain::repositories::short_notes_repo::ShortNotesRepository;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::sync::Arc;
use uuid::Uuid;

fn create_test_shortnote(favorite_id: Uuid, comment: &str) -> ShortNote {
    ShortNote {
        id: Uuid::new_v4(),
        favorite_id,
        comment: comment.to_string(),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_add_shortnote_success() {
    let mut mock_repo = MockMockShortNotesRepo::new();

    let favorite_id = Uuid::new_v4();
    let comment = "This is a test comment".to_string();

    let input = AddShortnoteInput {
        favorite_id,
        comment: comment.clone(),
    };

    let short_note = create_test_shortnote(favorite_id, &comment);

    let comment_clone = comment.clone();

    mock_repo
        .expect_mock_create()
        .withf(move |short_note: &ShortNoteActiveModel| {
            short_note.favorite_id == ActiveValue::Set(favorite_id)
                && short_note.comment == ActiveValue::Set(comment_clone.clone())
        })
        .returning(move |_| Ok(short_note.clone()));

    let usecase = AddShortnoteUsecase::new(Arc::new(mock_repo) as Arc<dyn ShortNotesRepository>);

    let result = usecase.add_shortnote(input).await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap(), comment);
}

#[tokio::test]
async fn test_add_shortnote_failure() {
    let mut mock_repo = MockMockShortNotesRepo::new();

    let favorite_id = Uuid::new_v4();
    let comment = "This is a test comment".to_string();

    let input = AddShortnoteInput {
        favorite_id,
        comment: comment.clone(),
    };

    mock_repo.expect_mock_create().returning(|_| {
        Err(DomainError::ValidationError(
            "Failed to create short note".to_string(),
        ))
    });

    let usecase = AddShortnoteUsecase::new(Arc::new(mock_repo) as Arc<dyn ShortNotesRepository>);

    let result = usecase.add_shortnote(input).await;

    assert!(result.is_err());
    assert_eq!(
        result.unwrap_err().to_string(),
        "Validation error: Failed to create short note"
    );
}
