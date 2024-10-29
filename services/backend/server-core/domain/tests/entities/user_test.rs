use chrono::Utc;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::users::Model as User;
use uuid::Uuid;

#[test]
fn test_user_entity() {
    let id = Uuid::new_v4().to_string();
    let username = "test_user".to_string();
    let evm_addr = Some("0x1234567890123456789012345678901234567890".to_string());
    let invited_by = Some(Uuid::new_v4().to_string());
    let fsp = 100;
    let fsp_temp = 0;
    let credential = 50;
    let category = UserCategory::Musician;
    let now = Utc::now().naive_utc();
    let img_url = Some("https://example.com/image.jpg".to_string());
    let primary_category = UserCategory::Musician;
    let greeting = Some("Hello, world!".to_string());
    let skill = Some("Singing".to_string());
    let x_handle = Some("x_handle".to_string());
    let instagram_handle = Some("instagram_handle".to_string());
    let fb_handle = Some("fb_handle".to_string());
    let interest_offer = Some(OfferCategory::Creation);
    let email = "test@example.com".to_string();
    let id_token = Some("id_token".to_string());

    // ユーザーの作成
    let user = User {
        id: id.clone(),
        username: username.clone(),
        evm_addr: evm_addr.clone(),
        status: UserStatus::Joined,
        invited_by: invited_by.clone(),
        fsp,
        fsp_temp,
        credential,
        category: category.clone(),
        created_at: now,
        updated_at: now,
        img_url: img_url.clone(),
        primary_category: primary_category.clone(),
        greeting,
        skill,
        x_handle,
        instagram_handle,
        fb_handle,
        interest_offer,
        email: email.clone(),
        id_token: id_token.clone(),
    };

    // 全ての属性の確認
    assert_eq!(user.id, id);
    assert_eq!(user.username, username);
    assert_eq!(user.evm_addr, evm_addr);
    assert_eq!(user.status, UserStatus::Joined);
    assert_eq!(user.invited_by, invited_by);
    assert_eq!(user.fsp, fsp);
    assert_eq!(user.credential, credential);
    assert_eq!(user.category, category);
    assert_eq!(user.created_at, now);
    assert_eq!(user.updated_at, now);
    assert_eq!(user.img_url, img_url);
    assert_eq!(user.primary_category, primary_category);
    assert_eq!(user.email, email);
    assert_eq!(user.id_token, id_token);

    // ステータス変更のテスト
    let mut updated_user = user.clone();
    updated_user.status = UserStatus::Rejected;
    assert_eq!(updated_user.status, UserStatus::Rejected);

    // FSPとクレデンシャルの更新テスト
    updated_user.fsp += 50;
    updated_user.credential += 25;
    assert_eq!(updated_user.fsp, 150);
    assert_eq!(updated_user.credential, 75);

    // カテゴリー変更のテスト
    updated_user.category = UserCategory::Curator;
    assert_eq!(updated_user.category, UserCategory::Curator);

    // 画像URLの更新テスト
    let new_img_url = "https://example.com/new_image.jpg".to_string();
    updated_user.img_url = Some(new_img_url.clone());
    assert_eq!(updated_user.img_url, Some(new_img_url));

    // プライマリカテゴリーの更新テスト
    updated_user.primary_category = UserCategory::Supporter;
    assert_eq!(updated_user.primary_category, UserCategory::Supporter);

    // Noneの値のテスト
    let user_without_optionals = User {
        id: Uuid::new_v4().to_string(),
        username: "no_optionals".to_string(),
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        created_at: now,
        updated_at: now,
        img_url: None,
        primary_category: UserCategory::Musician,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: None,
        email: "".to_string(),
        id_token: None,
    };

    assert_eq!(user_without_optionals.evm_addr, None);
    assert_eq!(user_without_optionals.invited_by, None);
    assert_eq!(user_without_optionals.img_url, None);
}
