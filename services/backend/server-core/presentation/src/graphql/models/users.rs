use crate::graphql::models::artists::*;
use async_graphql::{InputObject, SimpleObject};

// ===== Query ====

#[derive(SimpleObject)]
pub struct UserSimpleData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct UserBasicData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub roles: Vec<String>,
    pub primary_role: String,
    pub primary_artist: Option<ArtistByUserData>,
}

#[derive(SimpleObject)]
pub struct UserDetailData {
    pub id: String,
    pub email: String,
    pub name: String,
    pub image_url: Option<String>,
    pub fsp_balance: i32,
    pub fsp_balance_temp: i32,
    pub credential_balance: i32,
    pub roles: Vec<String>,
    pub primary_role: String,
    pub belongs_to_artists: Vec<ArtistByUserData>,
    pub primary_artist: Option<ArtistByUserData>,
}

#[derive(SimpleObject)]
pub struct UserFullData {
    pub user_info: UserDetailData,
}
// TODO: ユーザーの紹介ページで利用するデータ

#[derive(SimpleObject)]
pub struct MessageRoomByUserData {
    pub room_id: String,
    pub latest_sent_at: String,
    pub latest_message: MessageData,
}

#[derive(SimpleObject)]
pub struct MessageData {
    pub id: String,
    pub sent_by: String,
    pub message: String,
    pub created_at: String,
}

#[derive(SimpleObject)]
pub struct PoliciesByUserData {
    pub id: String,
}
// TODO: ユーザーのポリシーの配列を取得する

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
    pub name: String,
    pub image_url: Option<String>,
    pub invited_by: Option<String>,
    pub category: String,
    pub primary_category: String,
}

#[derive(SimpleObject)]
pub struct CreateNewUserDataResponse {
    pub user_id: String,
    pub name: String,
    pub image_url: Option<String>,
}

#[derive(InputObject)]
pub struct UpdateUserDataInput {
    pub id: String,
    pub email: Option<String>,
    pub name: Option<String>,
    pub image_url: Option<String>,
    pub primary_category: Option<String>,
    pub evm_addr: Option<String>,
    pub status: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdateUserDataResponse {
    pub user_info: UserDetailData,
}

#[derive(InputObject)]
pub struct UpdateBelongsToArtistStatusInput {
    pub id: String,
    pub artist_id: Option<String>,
    pub status: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdateBelongsToArtistStatusResponse {
    pub artist_list: ArtistByUserDataList,
}
