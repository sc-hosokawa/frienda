use crate::mocks::{
    message_attach_mock::MockMockMessageAttachRepo, messages_mock::MockMockMessagesRepo,
    user_mock::MockMockUsersRepo, user_room_mock::MockMockRoomUserRepo,
};
use application::usecases::messaging::get_messages_usecase::{
    GetMessagesInput, GetMessagesUsecase, GetMessagesUsecaseTrait,
};
use chrono::Utc;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::{
    message_attach::Model as MessageAttach, messages::Model as Message,
    room_user::Model as RoomUser, users::Model as User,
};
use std::sync::Arc;
use uuid::Uuid;

fn create_test_message(message_id: Uuid) -> Message {
    Message {
        id: message_id,
        room_id: Uuid::new_v4(),
        message: "Test message".to_string(),
        send_by: "user1".to_string(),
        created_at: Utc::now().naive_utc(),
    }
}

fn create_test_message_attach(message_id: Uuid) -> MessageAttach {
    MessageAttach {
        id: 1,
        message_id: Some(message_id),
        attached_file_url: Some("file.pdf".to_string()),
        attached_img_url: Some("image.jpg".to_string()),
        sender: Some("user1".to_string()),
        deleted_at: None,
        created_at: Utc::now().naive_utc(),
    }
}

fn create_test_user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("user{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("".to_string()),
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
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}

#[tokio::test]
async fn test_get_messages_success() {
    // Arrange
    let mut messages_repo = MockMockMessagesRepo::new();
    let mut user_repo = MockMockUsersRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();
    let mut message_attach_repo = MockMockMessageAttachRepo::new();

    let room_id = Uuid::new_v4();
    let user_id = "user1".to_string();
    let other_user_id = "user2".to_string();
    let message_id = Uuid::new_v4();

    // Setup mock messages
    let test_message = create_test_message(message_id);

    messages_repo
        .expect_mock_get_latest_by_room_id()
        .returning(move |_room_id, _limit| Ok(vec![test_message.clone()]));

    // Setup mock message attachments
    let test_attachment = create_test_message_attach(message_id);

    message_attach_repo
        .expect_mock_get_by_message_ids()
        .returning(move |_| Ok(vec![test_attachment.clone()]));

    // Setup mock room users
    let room_users = vec![
        RoomUser {
            id: 1,
            room_id,
            user_id: user_id.clone(),
            last_read_message_id: None,
        },
        RoomUser {
            id: 2,
            room_id,
            user_id: other_user_id.clone(),
            last_read_message_id: None,
        },
    ];

    room_user_repo
        .expect_mock_get_by_room_id()
        .returning(move |_| Ok(room_users.clone()));

    // Setup mock other user
    let other_user = create_test_user(&other_user_id);

    user_repo
        .expect_mock_find_by_id()
        .returning(move |_| Ok(Some(other_user.clone())));

    let usecase = GetMessagesUsecase::new(
        Arc::new(messages_repo),
        Arc::new(user_repo),
        Arc::new(room_user_repo),
        Arc::new(message_attach_repo),
    );

    // Act
    let result = usecase
        .get_messages_on_dm(GetMessagesInput {
            user_id: user_id.clone(),
            room_id,
        })
        .await;

    // Assert
    assert!(result.is_ok());
    let output = result.unwrap();
    assert_eq!(output.id, room_id.to_string());
    assert_eq!(output.user.id, other_user_id);
    assert_eq!(output.user.name, format!("User {}", other_user_id));
    assert_eq!(output.user.image_url, Some("".to_string()));
    assert_eq!(output.message_list.len(), 1);

    let message = &output.message_list[0];
    assert_eq!(message.id, message_id.to_string());
    assert_eq!(message.content, "Test message");
    assert_eq!(message.sent_by, "user1");
    assert_eq!(message.attached_file_url, Some("file.pdf".to_string()));
    assert_eq!(message.attached_img_url, Some("image.jpg".to_string()));
}

/*
#[tokio::test]
async fn test_get_messages_no_other_user() {
    // Arrange
    let messages_repo = MockMockMessagesRepo::new();
    let user_repo = MockMockUsersRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();
    let message_attach_repo = MockMockMessageAttachRepo::new();

    let room_id = Uuid::new_v4();
    let user_id = "user1".to_string();

    // Setup mock room users with only the requesting user
    room_user_repo
        .expect_mock_get_by_room_id()
        .returning(move |_| {
            Ok(vec![RoomUser {
                id: 1,
                room_id,
                user_id: user_id.clone(),
                last_read_message_id: None,
            }])
        });

    let usecase = GetMessagesUsecase::new(
        Arc::new(messages_repo),
        Arc::new(user_repo),
        Arc::new(room_user_repo),
        Arc::new(message_attach_repo),
    );

    // Act
    let result = usecase
        .get_messages_on_dm(GetMessagesInput {
            user_id: user_id.clone(),
            room_id,
        })
        .await;

    assert!(result.is_err());
    let err = result;
    assert_eq!(err, "Other user not found in the room");
}
*/
