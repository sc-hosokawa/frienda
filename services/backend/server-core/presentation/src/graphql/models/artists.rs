use async_graphql::{InputObject, SimpleObject};
use domain::entities::sea_orm_active_enums::{ArtistStatus, UserArtistStatus};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct ArtistData {
    pub id: String,
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
    pub id: String, // uuid
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
    pub id: String, // uuid
    pub name: String,
}

#[derive(InputObject)]
pub struct DeleteArtistInput {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct DeleteArtistResponse {
    pub id: String, // uuid
}

#[derive(InputObject)]
pub struct UpdateArtistInput {
    pub id: String, // uuid
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
    pub id: String, // uuid
}

impl ArtistByUserData {
    pub fn from_domain(
        domain: application::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo,
    ) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.id.to_string(), // UuidをStringに変換
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
            name: domain.name,
            fsp: domain.fsp,
            image_url: domain.img_url,
        })
    }
}

impl ArtistFullData {
    pub fn from_domain(domain: domain::entities::artists::Model) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.id.to_string(),
            name: domain.name,
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
