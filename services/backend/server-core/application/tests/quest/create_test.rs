use crate::mocks::quest_mock::MockMockQuestsRepo;
use application::usecases::quest::create_quest_usecase::{
    CreateQuestUsecase, CreateQuestUsecaseInput, CreateQuestUsecaseTrait,
};
use domain::entities::quests::Model as Quest;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

fn create_test_quest(id: i32) -> Quest {
    Quest {
        id,
        name: format!("Quest {}", id),
        description: format!("Description for quest {}", id),
        category: Some("Onboarding".to_string()),
        point: 100,
        created_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_create_quest_success() {
    // Arrange
    let mut quests_repo = MockMockQuestsRepo::new();
    let input = CreateQuestUsecaseInput {
        name: "Test Quest".to_string(),
        description: "Test Description".to_string(),
    };

    let expected_quest = create_test_quest(1);
    let expected_quest_for_mock = expected_quest.clone();

    quests_repo
        .expect_mock_create()
        .returning(move |quest_model| {
            // 入力値の検証
            assert_eq!(quest_model.name.unwrap(), "Test Quest");
            assert_eq!(quest_model.description.unwrap(), "Test Description");
            Ok(expected_quest_for_mock.clone())
        });

    let usecase = CreateQuestUsecase::new(Arc::new(quests_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_ok());
    let created_quest = result.unwrap();
    assert_eq!(created_quest.id, expected_quest.id);
    assert_eq!(created_quest.name, expected_quest.name);
    assert_eq!(created_quest.description, expected_quest.description);
}

#[tokio::test]
async fn test_create_quest_repository_error() {
    // Arrange
    let mut quests_repo = MockMockQuestsRepo::new();
    let input = CreateQuestUsecaseInput {
        name: "Test Quest".to_string(),
        description: "Test Description".to_string(),
    };

    quests_repo
        .expect_mock_create()
        .returning(|_| Err(DomainError::DatabaseError("Database error".to_string())));

    let usecase = CreateQuestUsecase::new(Arc::new(quests_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_err());
    assert!(result.unwrap_err().to_string().contains("Database error"));
}

#[tokio::test]
async fn test_create_quest_with_long_name() {
    // Arrange
    let mut quests_repo = MockMockQuestsRepo::new();
    let input = CreateQuestUsecaseInput {
        name: "A".repeat(256), // 長すぎる名前
        description: "Test Description".to_string(),
    };

    let expected_quest = create_test_quest(1);
    let expected_quest_for_mock = expected_quest.clone();

    quests_repo
        .expect_mock_create()
        .returning(move |quest_model| {
            // 入力値の検証
            assert_eq!(quest_model.name.unwrap().len(), 256);
            Ok(expected_quest_for_mock.clone())
        });

    let usecase = CreateQuestUsecase::new(Arc::new(quests_repo));

    // Act
    let result = usecase.create(input).await;

    // Assert
    assert!(result.is_ok());
    let created_quest = result.unwrap();
    assert_eq!(created_quest.id, expected_quest.id);
}
