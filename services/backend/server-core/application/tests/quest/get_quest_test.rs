use crate::mocks::quest_mock::MockMockQuestsRepo;
use crate::mocks::quest_user_mock::MockMockQuestUserRepo;
use application::usecases::quest::get_quests_usecase::{GetQuestsUsecase, GetQuestsUsecaseTrait};
use domain::entities::quest_user::Model as QuestUser;
use domain::entities::quests::Model as Quest;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_quest(id: i32) -> Quest {
    Quest {
        id,
        name: format!("Quest {}", id),
        description: format!("Description for quest {}", id),
        category: Some("".to_string()),
        point: 100,
        created_at: chrono::Utc::now().naive_utc(),
    }
}

fn create_test_quest_user(quest_id: i32, user_id: &str) -> QuestUser {
    QuestUser {
        id: 1,
        user: user_id.to_string(),
        quest: quest_id,
        is_done: true,
    }
}

#[tokio::test]
async fn test_get_all_quests_success() {
    // Arrange
    let mut mock_quests_repo = MockMockQuestsRepo::new();
    let mock_quest_user_repo = MockMockQuestUserRepo::new();

    let expected_quests = vec![
        create_test_quest(1),
        create_test_quest(2),
        create_test_quest(3),
    ];

    mock_quests_repo
        .expect_mock_find_all()
        .returning(move || Ok(expected_quests.clone()));

    let usecase = GetQuestsUsecase::new(
        Arc::new(mock_quests_repo),
        Arc::new(mock_quest_user_repo),
    );

    // Act
    let result = usecase.get_all().await;

    // Assert
    assert!(result.is_ok());
    let quests = result.unwrap();
    assert_eq!(quests.len(), 3);
    assert_eq!(quests[0].id, 1);
    assert_eq!(quests[1].id, 2);
    assert_eq!(quests[2].id, 3);
}

#[tokio::test]
async fn test_get_by_user_returns_uncompleted_quests() {
    // Arrange
    let mut mock_quests_repo = MockMockQuestsRepo::new();
    let mut mock_quest_user_repo = MockMockQuestUserRepo::new();
    
    let user_id = "test_user";
    let completed_quest = create_test_quest(1);
    let uncompleted_quest = create_test_quest(2);
    let uncompleted_quest_clone = uncompleted_quest.clone();
    
    let quest_user = create_test_quest_user(completed_quest.id, user_id);
    
    mock_quest_user_repo
        .expect_mock_get_by_user_and_status()
        .with(eq(user_id.to_string()), eq(true))
        .returning(move |_, _| Ok(vec![quest_user.clone()]));

    mock_quests_repo
        .expect_mock_find_all()
        .returning(move || Ok(vec![completed_quest.clone(), uncompleted_quest_clone.clone()]));

    let usecase = GetQuestsUsecase::new(
        Arc::new(mock_quests_repo),
        Arc::new(mock_quest_user_repo),
    );

    // Act
    let result = usecase.get_by_user(user_id).await;

    // Assert
    assert!(result.is_ok());
    let quests = result.unwrap();
    assert_eq!(quests.len(), 1);
    assert_eq!(quests[0].id, uncompleted_quest.id);
}

#[tokio::test]
async fn test_get_by_user_with_no_completed_quests() {
    // Arrange
    let mut mock_quests_repo = MockMockQuestsRepo::new();
    let mut mock_quest_user_repo = MockMockQuestUserRepo::new();
    
    let user_id = "test_user";
    let all_quests = vec![
        create_test_quest(1),
        create_test_quest(2),
        create_test_quest(3),
    ];
    
    mock_quest_user_repo
        .expect_mock_get_by_user_and_status()
        .with(eq(user_id.to_string()), eq(true))
        .returning(|_, _| Ok(vec![]));

    mock_quests_repo
        .expect_mock_find_all()
        .returning(move || Ok(all_quests.clone()));

    let usecase = GetQuestsUsecase::new(
        Arc::new(mock_quests_repo),
        Arc::new(mock_quest_user_repo),
    );

    // Act
    let result = usecase.get_by_user(user_id).await;

    // Assert
    assert!(result.is_ok());
    let quests = result.unwrap();
    assert_eq!(quests.len(), 3);
}