use crate::test_support::mocks::{
    email_mock::MockMockEmailService, message_attach_mock::MockMockMessageAttachRepo,
    message_room_mock::MockMockRoomsRepo, messages_mock::MockMockMessagesRepo,
    notification_mock::MockMockNotificationsRepo,
    notification_user_mock::MockMockNotificationUserRepo,
    push_notification_mock::MockMockPushNotificationService, user_mock::MockMockUsersRepo,
    user_room_mock::MockMockRoomUserRepo,
};
use crate::usecases::messaging::send_message_usecase::{
    SendMessageInput, SendMessageUsecase, SendMessageUsecaseTrait,
};
use chrono::Utc;
use domain::entities::message_attach::Model as MessageAttach;
use domain::entities::messages::Model as Message;
use domain::entities::notification_user::Model as NotificationUser;
use domain::entities::notifications::Model as Notification;
use domain::entities::room_user::Model as RoomUser;
use domain::entities::rooms::Model as Room;
use domain::entities::sea_orm_active_enums::{MessageRoomType, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use sea_orm::ActiveValue;
use std::sync::Arc;
use tokio::time::{sleep, Duration};
use uuid::Uuid;

fn user(id: &str, username: &str, fcm_token: Option<&str>) -> User {
    User {
        id: id.to_string(),
        id_token: None,
        fcm_token: fcm_token.map(str::to_string),
        username: username.to_string(),
        realname: username.to_string(),
        email: format!("{id}@example.com"),
        img_url: None,
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Creator,
        primary_category: UserCategory::Creator,
        is_superadmin: Some(false),
        publicity: true,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: None,
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: None,
    }
}

fn room(room_id: Uuid, latest_message_id: Option<Uuid>, latest_message: Option<&str>) -> Room {
    Room {
        id: room_id,
        r#type: MessageRoomType::Dm,
        created_at: Utc::now().naive_utc(),
        latest_sent_at: Some(Utc::now().naive_utc()),
        latest_message_id,
        latest_message: latest_message.map(str::to_string),
    }
}

fn room_user(id: i32, room_id: Uuid, user_id: &str) -> RoomUser {
    RoomUser {
        id,
        room_id,
        user_id: user_id.to_string(),
        last_read_message_id: None,
    }
}

#[tokio::test]
async fn test_send_message_creates_attachments_notifications_and_async_side_effects() {
    let mut messages_repo = MockMockMessagesRepo::new();
    let mut message_attach_repo = MockMockMessageAttachRepo::new();
    let mut rooms_repo = MockMockRoomsRepo::new();
    let mut push_service = MockMockPushNotificationService::new();
    let mut users_repo = MockMockUsersRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();
    let mut email_service = MockMockEmailService::new();
    let mut notifications_repo = MockMockNotificationsRepo::new();
    let mut notification_user_repo = MockMockNotificationUserRepo::new();

    let room_id = Uuid::new_v4();
    let message_id = Uuid::new_v4();

    messages_repo
        .expect_mock_create()
        .times(1)
        .returning(move |active| {
            assert!(matches!(
                active.room_id,
                ActiveValue::Set(value) if value == room_id
            ));
            assert!(matches!(
                active.send_by,
                ActiveValue::Set(ref value) if value == "sender"
            ));
            assert!(matches!(
                active.message,
                ActiveValue::Set(ref value) if value == "hello"
            ));
            Ok(Message {
                id: message_id,
                room_id,
                send_by: "sender".to_string(),
                message: "hello".to_string(),
                created_at: Utc::now().naive_utc(),
            })
        });

    rooms_repo
        .expect_mock_update()
        .times(1)
        .returning(move |active| {
            assert!(matches!(
                active.latest_message_id,
                ActiveValue::Set(Some(value)) if value == message_id
            ));
            assert!(matches!(
                active.latest_message,
                ActiveValue::Set(Some(ref value)) if value == "hello"
            ));
            Ok(room(room_id, Some(message_id), Some("hello")))
        });

    message_attach_repo
        .expect_mock_create_many()
        .times(1)
        .returning(move |attachments| {
            assert_eq!(attachments.len(), 2);
            assert!(attachments.iter().any(|attachment| matches!(
                attachment.attached_file_url,
                ActiveValue::Set(Some(ref value)) if value == "file.pdf"
            )));
            assert!(attachments.iter().any(|attachment| matches!(
                attachment.attached_img_url,
                ActiveValue::Set(Some(ref value)) if value == "img.png"
            )));

            Ok(vec![MessageAttach {
                id: 1,
                sender: None,
                message_id: Some(message_id),
                attached_img_url: Some("img.png".to_string()),
                attached_file_url: Some("file.pdf".to_string()),
                created_at: Utc::now().naive_utc(),
                deleted_at: None,
            }])
        });

    room_user_repo
        .expect_mock_get_by_room_id()
        .times(1)
        .returning(move |_| {
            Ok(vec![
                room_user(1, room_id, "sender"),
                room_user(2, room_id, "receiver"),
            ])
        });

    users_repo
        .expect_mock_find_by_id()
        .times(2)
        .returning(|id| match id.as_str() {
            "sender" => Ok(Some(user("sender", "Alice", None))),
            "receiver" => Ok(Some(user("receiver", "Bob", Some("fcm-1")))),
            _ => Ok(None),
        });

    push_service
        .expect_mock_send_push_notification()
        .times(1)
        .returning(|notification| {
            assert_eq!(notification.token, "fcm-1");
            assert!(notification.body.contains("Alice"));
            Ok("sent".to_string())
        });

    email_service
        .expect_mock_send_email()
        .times(1)
        .returning(|email| {
            assert_eq!(email.to, "receiver@example.com");
            assert!(email.body.contains("Alice"));
            Ok(())
        });

    notifications_repo
        .expect_mock_create()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.title,
                ActiveValue::Set(ref value) if value == "新着メッセージがあります"
            ));
            Ok(Notification {
                id: 10,
                title: "新着メッセージがあります".to_string(),
                content: "Aliceさんからメッセージが届きました".to_string(),
                category: Some("message".to_string()),
                created_at: Utc::now().naive_utc(),
            })
        });

    notification_user_repo
        .expect_mock_create()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.notification_id,
                ActiveValue::Set(value) if value == 10
            ));
            assert!(matches!(
                active.user,
                ActiveValue::Set(ref value) if value == "receiver"
            ));
            Ok(NotificationUser {
                id: 11,
                notification_id: 10,
                user: "receiver".to_string(),
                is_read: false,
                is_deleted: false,
            })
        });

    let usecase = SendMessageUsecase::new(
        Arc::new(messages_repo),
        Arc::new(message_attach_repo),
        Arc::new(rooms_repo),
        Arc::new(push_service),
        Arc::new(users_repo),
        Arc::new(room_user_repo),
        Arc::new(email_service),
        Arc::new(notifications_repo),
        Arc::new(notification_user_repo),
    );

    let result = usecase
        .send_message(SendMessageInput {
            room_id,
            sent_by: "sender".to_string(),
            message: "hello".to_string(),
            attached_file: Some(vec!["file.pdf".to_string()]),
            attached_img: Some(vec!["img.png".to_string()]),
        })
        .await
        .expect("send message succeeds");

    sleep(Duration::from_millis(20)).await;

    assert_eq!(result.room_id, room_id);
    assert_eq!(result.message.id, message_id);
    assert_eq!(result.attached_files, Some(vec!["file.pdf".to_string()]));
    assert_eq!(result.attached_imgs, Some(vec!["img.png".to_string()]));
}

#[tokio::test]
async fn test_send_message_returns_error_when_sender_is_missing() {
    let mut messages_repo = MockMockMessagesRepo::new();
    let mut message_attach_repo = MockMockMessageAttachRepo::new();
    let mut rooms_repo = MockMockRoomsRepo::new();
    let push_service = MockMockPushNotificationService::new();
    let mut users_repo = MockMockUsersRepo::new();
    let mut room_user_repo = MockMockRoomUserRepo::new();
    let email_service = MockMockEmailService::new();
    let notifications_repo = MockMockNotificationsRepo::new();
    let notification_user_repo = MockMockNotificationUserRepo::new();

    let room_id = Uuid::new_v4();
    let message_id = Uuid::new_v4();

    messages_repo
        .expect_mock_create()
        .times(1)
        .returning(move |_| {
            Ok(Message {
                id: message_id,
                room_id,
                send_by: "sender".to_string(),
                message: "hello".to_string(),
                created_at: Utc::now().naive_utc(),
            })
        });

    rooms_repo
        .expect_mock_update()
        .times(1)
        .returning(move |_| Ok(room(room_id, Some(message_id), Some("hello"))));

    message_attach_repo.expect_mock_create_many().times(0);

    room_user_repo
        .expect_mock_get_by_room_id()
        .times(1)
        .returning(move |_| {
            Ok(vec![
                room_user(1, room_id, "sender"),
                room_user(2, room_id, "receiver"),
            ])
        });

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|_| Ok(None));

    let usecase = SendMessageUsecase::new(
        Arc::new(messages_repo),
        Arc::new(message_attach_repo),
        Arc::new(rooms_repo),
        Arc::new(push_service),
        Arc::new(users_repo),
        Arc::new(room_user_repo),
        Arc::new(email_service),
        Arc::new(notifications_repo),
        Arc::new(notification_user_repo),
    );

    let error = match usecase
        .send_message(SendMessageInput {
            room_id,
            sent_by: "sender".to_string(),
            message: "hello".to_string(),
            attached_file: None,
            attached_img: None,
        })
        .await
    {
        Ok(_) => panic!("missing sender should fail"),
        Err(error) => error,
    };

    assert!(error.to_string().contains("User not found"));
}
