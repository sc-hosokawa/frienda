use crate::test_support::mocks::user_room_mock::MockMockRoomUserRepo;
use crate::usecases::messaging::mark_as_read_usecase::{
    MarkAsReadInput, MarkAsReadUsecase, MarkAsReadUsecaseTrait,
};
use domain::entities::room_user::Model as RoomUser;
use mockall::predicate::eq;
use sea_orm::ActiveValue;
use std::sync::Arc;
use uuid::Uuid;

fn room_user(
    id: i32,
    room_id: Uuid,
    user_id: &str,
    last_read_message_id: Option<Uuid>,
) -> RoomUser {
    RoomUser {
        id,
        room_id,
        user_id: user_id.to_string(),
        last_read_message_id,
    }
}

#[tokio::test]
async fn test_mark_as_read_updates_last_read_message_id() {
    let room_id = Uuid::new_v4();
    let message_id = Uuid::new_v4();
    let user_id = "user-1";

    let mut room_user_repo = MockMockRoomUserRepo::new();
    room_user_repo
        .expect_mock_get_by_room_id_and_user_id()
        .with(eq(room_id), eq(user_id.to_string()))
        .times(1)
        .returning(move |_, _| Ok(Some(room_user(1, room_id, user_id, None))));
    room_user_repo
        .expect_mock_update()
        .times(1)
        .returning(move |active| {
            assert!(matches!(
                active.last_read_message_id,
                ActiveValue::Set(Some(value)) if value == message_id
            ));
            Ok(room_user(1, room_id, user_id, Some(message_id)))
        });

    let usecase = MarkAsReadUsecase::new(Arc::new(room_user_repo));

    let result = usecase
        .mark_as_read(MarkAsReadInput {
            message_room_id: room_id,
            user_id: user_id.to_string(),
            message_id,
        })
        .await;

    assert!(result.is_ok());
}

#[tokio::test]
async fn test_mark_as_read_returns_not_found_when_room_user_is_missing() {
    let room_id = Uuid::new_v4();
    let message_id = Uuid::new_v4();
    let user_id = "user-1";

    let mut room_user_repo = MockMockRoomUserRepo::new();
    room_user_repo
        .expect_mock_get_by_room_id_and_user_id()
        .with(eq(room_id), eq(user_id.to_string()))
        .times(1)
        .returning(|_, _| Ok(None));
    room_user_repo.expect_mock_update().times(0);

    let usecase = MarkAsReadUsecase::new(Arc::new(room_user_repo));

    let err = usecase
        .mark_as_read(MarkAsReadInput {
            message_room_id: room_id,
            user_id: user_id.to_string(),
            message_id,
        })
        .await
        .unwrap_err();

    assert_eq!(err.to_string(), "Room user not found");
}
