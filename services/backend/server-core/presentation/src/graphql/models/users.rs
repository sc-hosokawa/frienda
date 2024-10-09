use async_graphql::{InputObject, SimpleObject};

// ===== Query =====

#[derive(SimpleObject)]
pub struct UserData {
    pub id: String,
    pub email: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのアーティスト一覧を取得する（アクセプト済みのみ）
// TODO: ユーザーのFSP残高とクレデンシャル残高を取得する
// TODO: ユーザーのロールとポリシーを取得する

#[derive(SimpleObject)]
pub struct ArtistsByUserData {
    pub id: String,
    pub name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーが所属しているアーティストの配列

#[derive(SimpleObject)]
pub struct FspBalanceData {
    pub balance: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのFSP残高を取得する

#[derive(SimpleObject)]
pub struct CredentialBalanceData {
    pub balance: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのクレデンシャル残高を取得する

#[derive(SimpleObject)]
pub struct MessageRoomsByUserData {
    pub id: String,
    pub name: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのメッセージルームの配列を取得する
// TODO: 最新のメッセージも取得する

#[derive(SimpleObject)]
pub struct RolesByUserData {
    pub id: String,
    pub name: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのロールの配列を取得する

#[derive(SimpleObject)]
pub struct PoliciesByUserData {
    pub id: String,
    pub name: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのポリシーの配列を取得する

#[derive(SimpleObject)]
pub struct ConnectingByUserData {
    pub id: String,
    pub name: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのフォローしているユーザーの配列を取得する

#[derive(SimpleObject)]
pub struct ConnectedByUserData {
    pub id: String,
    pub name: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーのフォロワーの配列を取得する

#[derive(SimpleObject)]
pub struct NotificationsByUserData {
    pub id: String,
    pub title: String,
    pub content: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーの通知の配列を取得する

#[derive(SimpleObject)]
pub struct UserInfoData {
    pub id: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
    pub created_at: String,
    pub updated_at: String,
}
// TODO: ユーザーの紹介ページで利用するデータ

// ===== Mutation =====

#[derive(InputObject)]
pub struct UsersInput {
    pub id: String,
    pub email: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
}

#[derive(InputObject)]
pub struct CreateNewUserDataInput {
    pub email: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
}

#[derive(SimpleObject)]
pub struct CreateNewUserDataResponse {
    pub id: String,
}

#[derive(InputObject)]
pub struct UpdateUserDataInput {
    pub id: String,
    pub email: String,
    pub first_name: String,
    pub last_name: String,
    pub image_url: String,
}
