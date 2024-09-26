use chrono::Utc;
use domain::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use domain::entities::users::Model as User;
use uuid::Uuid;

#[test]
fn test_user_entity() {
    let id: Uuid = Uuid::new_v4();
    let username: String = "test_user".to_string();
    let now: chrono::NaiveDateTime = Utc::now().naive_utc();

    // ユーザーの作成
    let user = User {
        id,
        username: username.clone(),
        evm_addr: None,
        status: Some(UserStatus::Joined),
        invited_by: None,
        fsp: 0,
        credential: 0,
        category: UserCategory::Musician,
        created_at: now,
        updated_at: now,
    };

    // 属性の確認
    assert_eq!(user.id, id);
    assert_eq!(user.username, username);
    assert_eq!(user.status, Some(UserStatus::Joined));

    // その他のビジネスロジックのテスト (例: statusの変更)
    let mut updated_user = user.clone();
    updated_user.status = Some(UserStatus::Rejected);
    assert_eq!(updated_user.status, Some(UserStatus::Rejected));
}
