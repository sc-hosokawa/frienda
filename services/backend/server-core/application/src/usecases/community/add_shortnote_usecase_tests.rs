use crate::test_support::mocks::shortnote_mock::MockMockShortNotesRepo;
use crate::usecases::community::add_shortnote_usecase::{
    AddShortnoteInput, AddShortnoteUsecase, AddShortnoteUsecaseTrait,
};
use domain::entities::short_notes::{ActiveModel as ShortNoteActiveModel, Model as ShortNote};
use domain::repositories::short_notes_repo::ShortNotesRepository;
use sea_orm::ActiveValue;
use shared::error::domain_err::DomainError;
use std::sync::Arc;
use uuid::Uuid;

fn create_test_shortnote(writer: &str, to_user: &str, comment: &str) -> ShortNote {
    ShortNote {
        id: Uuid::new_v4(),
        writer: writer.to_string(),
        to_user: to_user.to_string(),
        comment: comment.to_string(),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_add_shortnote_success() {
    let mut mock_repo = MockMockShortNotesRepo::new();

    let writer = "test_writer".to_string();
    let to_user = "test_to_user".to_string();
    let comment = "This is a test comment".to_string();

    let input = AddShortnoteInput {
        writer: writer.clone(),
        to_user: to_user.clone(),
        comment: comment.clone(),
    };

    let short_note = create_test_shortnote(&writer, &to_user, &comment);

    let comment_clone = comment.clone();

    mock_repo
        .expect_mock_create()
        .withf(move |short_note: &ShortNoteActiveModel| {
            short_note.writer == ActiveValue::Set(writer.clone())
                && short_note.to_user == ActiveValue::Set(to_user.clone())
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

    let writer: String = "test_writer".to_string();
    let to_user: String = "test_to_user".to_string();
    let comment: String = "This is a test comment".to_string();

    let input = AddShortnoteInput {
        writer: writer.clone(),
        to_user: to_user.clone(),
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
