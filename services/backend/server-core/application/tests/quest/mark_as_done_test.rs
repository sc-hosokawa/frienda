use crate::mocks::quest_user_mock::MockMockQuestUserRepo;
use application::usecases::quest::mark_as_done_usecase::{
    MarkAsDoneUsecase, MarkAsDoneUsecaseInput, MarkAsDoneUsecaseTrait,
};
use domain::entities::quest_user::Model as QuestUser;
use mockall::predicate::*;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

// テストデータ生成用のヘルパー関数
fn create_test_quest_user(quest_id: i32, user_id: &str, is_done: bool) -> QuestUser {
    QuestUser {
        id: 1, // テスト用のID
        quest: quest_id,
        user: user_id.to_string(),
        is_done,
    }
}

#[tokio::test]
async fn test_mark_as_done_success() {
    // Arrange
    let mut quest_user_repo = MockMockQuestUserRepo::new();
    let input = MarkAsDoneUsecaseInput {
        quest_id: 1,
        user_id: "user123".to_string(),
    };

    let expected_quest_user = create_test_quest_user(1, "user123", true);

    quest_user_repo.expect_mock_create().returning({
        let expected_quest_user = expected_quest_user.clone();
        move |quest_user_model| {
            // 入力値の検証
            assert_eq!(quest_user_model.quest.unwrap(), 1);
            assert_eq!(quest_user_model.user.unwrap(), "user123");
            assert_eq!(quest_user_model.is_done.unwrap(), true);
            Ok(expected_quest_user.clone())
        }
    });

    let usecase = MarkAsDoneUsecase::new(Arc::new(quest_user_repo));

    // Act
    let result = usecase.mark_as_done(input).await;

    // Assert
    assert!(result.is_ok());
    let quest_user = result.unwrap();
    assert_eq!(quest_user.quest, 1);
    assert_eq!(quest_user.user, "user123");
    assert!(quest_user.is_done);
}

#[tokio::test]
async fn test_mark_as_done_repository_error() {
    // Arrange
    let mut quest_user_repo = MockMockQuestUserRepo::new();
    let input = MarkAsDoneUsecaseInput {
        quest_id: 1,
        user_id: "user123".to_string(),
    };

    quest_user_repo
        .expect_mock_create()
        .returning(|_| Err(DomainError::DatabaseError("Database error".to_string())));

    let usecase = MarkAsDoneUsecase::new(Arc::new(quest_user_repo));

    // Act
    let result = usecase.mark_as_done(input).await;

    // Assert
    assert!(result.is_err());
    assert!(result.unwrap_err().to_string().contains("Database error"));
}
