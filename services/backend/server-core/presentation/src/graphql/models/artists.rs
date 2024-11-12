use crate::graphql::models::users::UserSimpleData;
use async_graphql::{InputObject, SimpleObject};
use domain::entities::sea_orm_active_enums::{ArtistStatus, UserArtistStatus};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct ArtistData {
    pub id: String,
    pub artist_id: String,
    pub name: String,
    pub fsp: i32,
    pub image_url: Option<String>,
}

#[derive(SimpleObject)]
pub struct ArtistsData {
    pub artist_list: Vec<ArtistData>,
}

#[derive(SimpleObject)]
pub struct ArtistByUserData {
    pub id: String,
    pub artist_id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub fsp: i32,
    pub status: String,
    pub is_admin: bool,
}

#[derive(SimpleObject)]
pub struct ArtistByUserDataWithMappingId {
    pub mapping_id: i32,
    pub id: String,
    pub artist_id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub fsp: i32,
    pub status: String,
    pub is_admin: bool,
}

#[derive(SimpleObject)]
pub struct ArtistByUserDataList {
    pub artist_list: Vec<ArtistByUserData>,
}

#[derive(SimpleObject)]
pub struct ArtistFullData {
    pub id: String,        // uuid
    pub artist_id: String, // varchar(28)
    pub name: String,      // ArtistModel.display_name_jp
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: Option<String>, // hiden, visible
    pub since: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

// ===== for Mutation =====

#[derive(InputObject)]
pub struct CreateNewArtistInput {
    pub name: String,
    pub img_url: Option<String>,
    pub fsp: i32,
    pub status: Option<String>, // hiden, visible
    pub since: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

#[derive(SimpleObject)]
pub struct CreateNewArtistResponse {
    pub artist_id: String, // varchar(28)
    pub name: String,
}

#[derive(InputObject)]
pub struct DeleteArtistInput {
    pub artist_id: String, // varchar(28)
}

#[derive(SimpleObject)]
pub struct DeleteArtistResponse {
    pub artist_id: String, // varchar(28)
}

#[derive(InputObject)]
pub struct UpdateArtistInput {
    pub artist_id: String, // varchar(28)
    pub name: Option<String>,
    pub img_url: Option<String>,
    pub fsp: Option<i32>,
    pub status: Option<String>, // hiden, visible
    pub since: Option<String>,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
}

#[derive(SimpleObject)]
pub struct UpdateArtistResponse {
    pub artist_id: String, // varchar(28)
}

#[derive(InputObject)]
pub struct RequestToAccessArtistInput {
    pub user_id: String,
    pub artist_ids: Vec<String>,
}

#[derive(SimpleObject)]
pub struct RequestToAccessArtistResponse {
    pub created_mappings: Vec<ArtistByUserDataWithMappingId>,
}

#[derive(InputObject)]
pub struct MarkAsMemberInput {
    pub member: String,
    pub artist_id: String,
    pub mapping: Vec<StatusUser>,
}
#[derive(InputObject)]
pub struct StatusUser {
    pub user_id: String,
    pub status: String,
}

#[derive(InputObject)]
pub struct MarkAsAdminInput {
    pub admin_member: String,
    pub user_id: String,
    pub artist_id: String,
}

#[derive(SimpleObject)]
pub struct MarkAsMemberResponse {
    pub checked_user_id: Vec<String>,
}

#[derive(SimpleObject)]
pub struct MarkAsAdminResponse {
    pub checked_user_id: String,
}

#[derive(SimpleObject)]
pub struct AllPendingMember {
    pub member: UserSimpleData,
    pub artist_name: String,
    pub artist_id: String,
}

impl ArtistByUserData {
    pub fn from_domain(
        domain: application::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo,
    ) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.id.to_string(), // UuidをStringに変換
            artist_id: domain.artist_id,
            name: domain.name,
            image_url: domain.img_url,
            fsp: domain.fsp,
            status: match domain.status {
                UserArtistStatus::Check => "Check".to_string(),
                UserArtistStatus::Accept => "Accept".to_string(),
                UserArtistStatus::Reject => "Reject".to_string(),
            },
            is_admin: domain.is_admin,
        })
    }
}

impl ArtistByUserDataWithMappingId {
    pub fn from_domain_on_request_to_access(
        domain: application::usecases::artist::request_to_access_usecase::ArtistSimpleInfoWithMappingId,
    ) -> Result<Self, anyhow::Error> {
        Ok(Self {
            mapping_id: domain.mapping_id,
            id: domain.id.to_string(), // UuidをStringに変換
            artist_id: domain.artist_id,
            name: domain.name,
            image_url: domain.img_url,
            fsp: domain.fsp,
            status: match domain.status {
                UserArtistStatus::Check => "Check".to_string(),
                UserArtistStatus::Accept => "Accept".to_string(),
                UserArtistStatus::Reject => "Reject".to_string(),
            },
            is_admin: domain.is_admin,
        })
    }
}

impl ArtistData {
    pub fn from_domain(domain: domain::entities::artists::Model) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.id.to_string(),
            artist_id: domain.artist_id,
            name: domain.display_name_jp,
            fsp: domain.fsp,
            image_url: domain.img_url,
        })
    }
}

impl ArtistFullData {
    pub fn from_domain(domain: domain::entities::artists::Model) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.id.to_string(),
            artist_id: domain.artist_id,
            name: domain.display_name_jp,
            img_url: domain.img_url,
            fsp: domain.fsp,
            status: match domain.status {
                ArtistStatus::Hidden => Some("hidden".to_string()),
                ArtistStatus::Visible => Some("visible".to_string()),
                ArtistStatus::Unknown => None,
            },
            since: domain.since.map(|date| date.to_string()),
            universal_id: domain.universal_id,
            apple_key: domain.apple_key,
            spotify_key: domain.spotify_key,
            line_key: domain.line_key,
            amazon_key: domain.amazon_key,
            youtube_key: domain.youtube_key,
        })
    }
}
