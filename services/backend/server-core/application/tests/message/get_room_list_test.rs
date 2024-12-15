// services/backend/server-core/application/tests/message/get_room_list_test.rs

use crate::mocks::{
    message_room_mock::MockMockRoomsRepo, user_mock::MockMockUsersRepo,
    user_room_mock::MockMockRoomUserRepo,
};
use application::usecases::messaging::get_room_list_usecase::{
    GetRoomListInput, GetRoomListUsecase, GetRoomListUsecaseTrait,
};
use chrono::Utc;
use domain::entities::{
    room_user::Model as RoomUser,
    rooms::Model as Room,
    sea_orm_active_enums::{MessageRoomType, OfferCategory, UserCategory, UserStatus},
    users::Model as User,
};
use std::sync::Arc;
use uuid::Uuid;

// テスト用のヘルパー関数
fn create_test_room(room_id: Uuid, latest_message_id: Option<Uuid>) -> Room {
    Room {
        id: room_id,
        r#type: MessageRoomType::Dm,
        created_at: Utc::now().naive_utc(),
        latest_sent_at: Some(Utc::now().naive_utc()),
        latest_message_id,
        latest_message: Some("Latest test message".to_string()),
    }
}

fn create_test_room_user(
    room_id: Uuid,
    user_id: &str,
    last_read_message_id: Option<Uuid>,
) -> RoomUser {
    RoomUser {
        id: 1,
        room_id,
        user_id: user_id.to_string(),
        last_read_message_id,
    }
}

fn create_test_user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("profile.jpg".to_string()),
        evm_addr: Some("".to_string()),
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: Some("".to_string()),
        skill: Some("".to_string()),
        x_handle: Some("".to_string()),
        instagram_handle: Some("".to_string()),
        fb_handle: Some("".to_string()),
        interest_offer: Some(OfferCategory::Creation),
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: Some(Utc::now().naive_utc()),
    }
}

#[tokio::test]
async fn test_get_room_list_success() {
    // Arrange
    let mut room_user_repo = MockMockRoomUserRepo::new();
    let mut rooms_repo = MockMockRoomsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    let room_id = Uuid::new_v4();
    let user_id = "user1".to_string();
    let other_user_id = "user2".to_string();
    let latest_message_id = Uuid::new_v4();

    // Setup room user repo mock
    let test_room_users = vec![
        create_test_room_user(room_id, &user_id, Some(latest_message_id)),
        create_test_room_user(room_id, &other_user_id, None),
    ];

    let test_room_users_clone = test_room_users.clone();

    room_user_repo
        .expect_mock_get_by_user_id()
        .returning(move |_| Ok(vec![test_room_users[0].clone()]));

    room_user_repo
        .expect_mock_get_by_room_id()
        .returning(move |_| Ok(test_room_users_clone.clone()));

    let test_room = create_test_room(room_id, Some(latest_message_id));
    rooms_repo
        .expect_mock_get_by_id()
        .returning(move |_| Ok(Some(test_room.clone())));

    let other_user = create_test_user(&other_user_id);
    users_repo
        .expect_mock_find_by_id()
        .returning(move |_| Ok(Some(other_user.clone())));

    let usecase = GetRoomListUsecase::new(
        Arc::new(room_user_repo),
        Arc::new(rooms_repo),
        Arc::new(users_repo),
    );

    // Act
    let result = usecase
        .get_room_list(GetRoomListInput {
            user_id: user_id.clone(),
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.count_of_messages_rooms, 1);
    assert_eq!(output.rooms.len(), 1);

    let room = &output.rooms[0];
    assert_eq!(room.id, room_id.to_string());
    assert_eq!(room.category, Some(MessageRoomType::Dm));
    assert_eq!(room.latest_message_id, Some(latest_message_id));
    assert_eq!(room.latest_message, Some("Latest test message".to_string()));
    assert!(room.latest_sent_at.is_some());
    assert!(room.is_read);

    assert_eq!(room.users.len(), 1);
    let room_user = &room.users[0];
    assert_eq!(room_user.id, other_user_id);
    assert_eq!(room_user.name, format!("User {}", other_user_id));
    assert_eq!(room_user.image_url, Some("profile.jpg".to_string()));
}

#[tokio::test]
async fn test_get_active_rooms_success() {
    // Arrange
    let mut room_user_repo = MockMockRoomUserRepo::new();
    let mut rooms_repo = MockMockRoomsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    let room_id1 = Uuid::new_v4();
    let room_id2 = Uuid::new_v4();
    let user_id = "user1".to_string();
    let other_user_id1 = "user2".to_string();
    let other_user_id2 = "user3".to_string();

    // Setup room user repo mock
    let test_room_users1 = vec![
        create_test_room_user(room_id1, &user_id, None),
        create_test_room_user(room_id1, &other_user_id1, None),
    ];
    let test_room_users2 = vec![
        create_test_room_user(room_id2, &user_id, None),
        create_test_room_user(room_id2, &other_user_id2, None),
    ];

    let test_room_users1_clone = test_room_users1.clone();
    let test_room_users2_clone = test_room_users2.clone();

    room_user_repo
        .expect_mock_get_by_user_id()
        .returning(move |_| {
            Ok(vec![
                test_room_users1[0].clone(),
                test_room_users2[0].clone(),
            ])
        });

    room_user_repo
        .expect_mock_get_by_room_id()
        .returning(move |room_id| {
            Ok(if room_id == room_id1 {
                test_room_users1_clone.clone()
            } else {
                test_room_users2_clone.clone()
            })
        });

    // Setup rooms repo mock with consistent latest_message_ids
    let test_room1 = create_test_room(room_id1, Some(Uuid::new_v4()));
    let test_room2 = create_test_room(room_id2, Some(Uuid::new_v4()));
    rooms_repo.expect_mock_get_by_id().returning(move |id| {
        Ok(Some(if id == room_id1 {
            test_room1.clone()
        } else {
            test_room2.clone()
        }))
    });

    // Setup users repo mock
    let other_user1 = create_test_user(&other_user_id1);
    let other_user2 = create_test_user(&other_user_id2);
    users_repo.expect_mock_find_by_id().returning(move |id| {
        Ok(Some(if id == other_user_id1 {
            other_user1.clone()
        } else {
            other_user2.clone()
        }))
    });

    let usecase = GetRoomListUsecase::new(
        Arc::new(room_user_repo),
        Arc::new(rooms_repo),
        Arc::new(users_repo),
    );

    // Act
    let result = usecase.get_active_rooms(user_id.clone()).await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.count_of_messages_rooms, 2);
    assert_eq!(output.rooms.len(), 2);

    // Verify first room
    let room1 = &output.rooms[0];
    assert_eq!(room1.users.len(), 1);

    // Verify second room
    let room2 = &output.rooms[1];
    assert_eq!(room2.users.len(), 1);
}
