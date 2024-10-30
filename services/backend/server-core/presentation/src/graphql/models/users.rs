use crate::graphql::models::artists::*;
use anyhow::Error;
use application::usecases::basic::create_user_usecase;
use async_graphql::{InputObject, SimpleObject};
use domain::entities::sea_orm_active_enums::{UserArtistStatus, UserCategory};

// ===== Query ====

#[derive(SimpleObject)]
pub struct UserSimpleData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct AllUsersData {
    pub users: Vec<UserSimpleData>,
}

#[derive(SimpleObject)]
pub struct UserBasicData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub role: String,
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
    //    pub fsp_balance_temp: i32,
    pub credential_balance: i32,
    pub role: String,
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
    pub id: String,
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
}

#[derive(SimpleObject)]
pub struct UpdateUserDataResponse {
    pub user_info: UserDetailData,
}

#[derive(InputObject)]
pub struct UpdateBelongsToArtistStatusInput {
    pub user_id: String,
    pub artist_id: String,
    pub next_status: Option<String>,
    pub next_status_is_admin: Option<bool>,
}

#[derive(SimpleObject)]
pub struct UpdateBelongsToArtistStatusResponse {
    pub updated_user_artist: ArtistByUserData,
}

// ===== Convert to usecase input =====
impl CreateNewUserDataInput {
    pub fn into_usecase_input(self) -> Result<create_user_usecase::CreateUserInput, Error> {
        Ok(create_user_usecase::CreateUserInput {
            id: self.id,
            email: self.email,
            name: self.name,
            image_url: self.image_url,
            invited_by: self.invited_by,
            category: from_string_to_user_category(&self.category).map_err(Error::msg)?,
            primary_category: from_string_to_user_category(&self.primary_category)
                .map_err(Error::msg)?,
        })
    }
}

pub fn from_string_to_user_category(s: &str) -> Result<UserCategory, String> {
    match s {
        "Musician" => Ok(UserCategory::Musician),
        "Creator" => Ok(UserCategory::Creator),
        "Curator" => Ok(UserCategory::Curator),
        "Supporter" => Ok(UserCategory::Supporter),
        _ => Err(format!("Invalid UserCategory: {}", s)),
    }
}

pub fn from_user_category_to_string(category: &UserCategory) -> String {
    match category {
        UserCategory::Musician => "Musician".to_string(),
        UserCategory::Creator => "Creator".to_string(),
        UserCategory::Curator => "Curator".to_string(),
        UserCategory::Supporter => "Supporter".to_string(),
    }
}

pub fn from_string_to_user_artist_status(s: &str) -> Result<UserArtistStatus, String> {
    match s {
        "Check" => Ok(UserArtistStatus::Check),
        "Accept" => Ok(UserArtistStatus::Accept),
        "Reject" => Ok(UserArtistStatus::Reject),
        _ => Err(format!("Invalid UserArtistStatus: {}", s)),
    }
}

impl UserDetailData {
    pub fn from_domain(
        domain: application::usecases::basic::get_user_basic_info_usecase::GetUserBasicInfoOutput,
    ) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.user.id,
            email: domain.user.email,
            name: domain.user.username,
            image_url: domain.user.img_url,
            fsp_balance: domain.user.fsp,
            // fsp_balance_temp: domain.user.fsp,
            credential_balance: domain.user.credential,
            role: match domain.user.category {
                UserCategory::Musician => "Musician".to_string(),
                UserCategory::Creator => "Creator".to_string(),
                UserCategory::Curator => "Curator".to_string(),
                UserCategory::Supporter => "Supporter".to_string(),
            },
            primary_role: match domain.user.primary_category {
                UserCategory::Musician => "Musician".to_string(),
                UserCategory::Creator => "Creator".to_string(),
                UserCategory::Curator => "Curator".to_string(),
                UserCategory::Supporter => "Supporter".to_string(),
            },
            belongs_to_artists: domain
                .belongs_to_artists
                .into_iter()
                .map(|a| ArtistByUserData::from_domain(a).unwrap())
                .collect(),
            primary_artist: None,
        })
    }
}
