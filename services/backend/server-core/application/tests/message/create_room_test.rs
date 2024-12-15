use crate::mocks::{message_room_mock::MockMockRoomsRepo, user_room_mock::MockMockRoomUserRepo};
use application::usecases::messaging::create_message_room_usecase::{
    CreateMessageRoomInput, CreateMessageRoomUsecase, CreateMessageRoomUsecaseTrait,
};
use domain::entities::room_user::Model as RoomUser;
use domain::entities::rooms::Model as Room;
use domain::entities::sea_orm_active_enums::MessageRoomType;
use std::sync::Arc;
use uuid::Uuid;

fn create_test_room(room_id: Uuid) -> Room {
    Room {
        id: room_id,
        r#type: MessageRoomType::Group,
        created_at: chrono::Utc::now().naive_utc(),
        latest_sent_at: None,
        latest_message_id: None,
        latest_message: None,
    }
}

fn create_test_room_user(room_id: Uuid, user_id: &str) -> RoomUser {
    RoomUser {
        id: 1,
        room_id: room_id,
        user_id: user_id.to_string(),
        last_read_message_id: None,
    }
}

#[tokio::test]
async fn test_create_new_message_room() {
    // Arrange
    let mut rooms_repo = MockMockRoomsRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();

    let room_id = Uuid::new_v4();
    let creator_id = "creator123".to_string();
    let user_list = vec!["user1".to_string(), "user2".to_string()];

    // Setup rooms_repo mock
    rooms_repo
        .expect_mock_create()
        .returning(move |_| Ok(create_test_room(room_id)));

    // Setup room_user_repo mocks
    room_user_repo
        .expect_mock_find_by_user_ids()
        .returning(|_| Ok(vec![]));

    room_user_repo
        .expect_mock_create_many()
        .returning(|_| Ok(()));

    let usecase = CreateMessageRoomUsecase::new(Arc::new(rooms_repo), Arc::new(room_user_repo));

    // Act
    let result = usecase
        .create(CreateMessageRoomInput {
            category: MessageRoomType::Group,
            created_by: creator_id.clone(),
            user_list: user_list.clone(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), room_id);
}

#[tokio::test]
async fn test_return_existing_room_if_found() {
    // Arrange
    let rooms_repo = MockMockRoomsRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();

    let existing_room_id = Uuid::new_v4();
    let creator_id = "creator123".to_string();
    let user_list = vec!["user1".to_string()];

    // Setup room_user_repo mock to return existing room mapping
    room_user_repo
        .expect_mock_find_by_user_ids()
        .returning(move |_| {
            Ok(vec![
                create_test_room_user(existing_room_id, "creator123"),
                create_test_room_user(existing_room_id, "user1"),
            ])
        });

    let usecase = CreateMessageRoomUsecase::new(Arc::new(rooms_repo), Arc::new(room_user_repo));

    // Act
    let result = usecase
        .create(CreateMessageRoomInput {
            category: MessageRoomType::Dm,
            created_by: creator_id.clone(),
            user_list: user_list.clone(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), existing_room_id);
}

#[tokio::test]
async fn test_create_room_with_duplicate_users() {
    // Arrange
    let mut rooms_repo = MockMockRoomsRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();

    let room_id = Uuid::new_v4();
    let creator_id = "creator123".to_string();
    let user_list = vec![
        "user1".to_string(),
        "user1".to_string(), // Duplicate user
        "user2".to_string(),
    ];

    // Setup rooms_repo mock
    rooms_repo
        .expect_mock_create()
        .returning(move |_| Ok(create_test_room(room_id)));

    // Setup room_user_repo mocks
    room_user_repo
        .expect_mock_find_by_user_ids()
        .returning(|_| Ok(vec![]));

    room_user_repo
        .expect_mock_create_many()
        .returning(|room_users| {
            let user_ids: Vec<String> = room_users
                .iter()
                .map(|ru| ru.user_id.clone().unwrap())
                .collect();

            let expected_users = vec![
                "creator123".to_string(),
                "user1".to_string(),
                "user1".to_string(),
                "user2".to_string(),
            ];

            assert_eq!(user_ids.len(), expected_users.len());
            for expected_user in expected_users {
                assert!(
                    user_ids.contains(&expected_user),
                    "Expected user {} not found",
                    expected_user
                );
            }
            Ok(())
        });

    let usecase = CreateMessageRoomUsecase::new(Arc::new(rooms_repo), Arc::new(room_user_repo));

    let result = usecase
        .create(CreateMessageRoomInput {
            category: MessageRoomType::Group,
            created_by: creator_id.clone(),
            user_list: user_list.clone(),
        })
        .await;

    assert!(result.is_ok());
    assert_eq!(result.unwrap(), room_id);
}
