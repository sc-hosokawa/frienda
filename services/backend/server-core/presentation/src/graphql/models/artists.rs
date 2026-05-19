use async_graphql::{InputObject, SimpleObject};
use domain::entities::sea_orm_active_enums::{ArtistStatus, UserArtistStatus};

// ===== for Query =====

#[derive(SimpleObject)]
pub struct ArtistData {
    pub id: String,
    pub artist_id: String,
    pub name: String,
    pub display_name_en: String,
    pub display_name_kana: Option<String>,
    pub fsp: i32,
    pub image_url: Option<String>,
    pub status: String,
    pub universal_id: Option<String>,
    pub apple_key: Option<String>,
    pub spotify_key: Option<String>,
    pub line_key: Option<String>,
    pub amazon_key: Option<String>,
    pub youtube_key: Option<String>,
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
    pub request_message: Option<String>,
    pub is_default: bool,
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
    pub request_message: Option<String>,
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
    pub display_name_jp: String,
    pub display_name_en: String,
    pub display_name_kana: Option<String>,
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
pub struct CreateNewArtistData {
    pub artist_id: String, // varchar(28)
    pub display_name_jp: String,
}

#[derive(SimpleObject)]
pub struct CreateNewArtistsResponse {
    pub added_artists: Vec<CreateNewArtistData>,
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
    pub artist_id: String,
    pub display_name_jp: Option<String>,
    pub display_name_en: Option<String>,
    pub display_name_kana: Option<String>,
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
pub struct RequestToAccessArtistItemInput {
    pub artist_id: String,
    pub message: Option<String>,
}

#[derive(InputObject)]
pub struct RequestToAccessArtistInput {
    pub user_id: String,
    pub requests: Option<Vec<RequestToAccessArtistItemInput>>,
    pub artist_ids: Option<Vec<String>>,
}

#[derive(SimpleObject)]
pub struct RequestToAccessArtistResponse {
    pub created_mappings: Vec<ArtistByUserDataWithMappingId>,
}

#[derive(InputObject)]
pub struct ResendRequestToAccessArtistInput {
    pub user_id: String,
    pub artist_id: String,
    pub message: Option<String>,
}

#[derive(SimpleObject)]
pub struct ResendRequestToAccessArtistResponse {
    pub updated_mapping: ArtistByUserDataWithMappingId,
}

#[derive(InputObject)]
pub struct CancelRequestToAccessArtistInput {
    pub user_id: String,
    pub artist_id: String,
}

#[derive(SimpleObject)]
pub struct CancelRequestToAccessArtistResponse {
    pub canceled_mapping: ArtistByUserDataWithMappingId,
}

#[derive(InputObject)]
pub struct LeaveBelongedArtistInput {
    pub operator_user_id: String,
    pub user_id: String,
    pub artist_id: String,
}

#[derive(SimpleObject)]
pub struct LeaveBelongedArtistResponse {
    pub left_artist: ArtistByUserData,
}

#[derive(InputObject)]
pub struct SetDefaultBelongedArtistInput {
    pub user_id: String,
    pub artist_id: String,
}

#[derive(SimpleObject)]
pub struct SetDefaultBelongedArtistResponse {
    pub default_artist: ArtistByUserData,
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
    pub member: PendingMember,
    pub artist_name: String,
    pub artist_id: String,
    pub request_message: Option<String>,
}
#[derive(SimpleObject)]
pub struct PendingMember {
    pub id: String,
    pub name: String,
    pub realname: String,
    pub email: String,
    pub image_url: Option<String>,
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
                UserArtistStatus::Canceled => "Canceled".to_string(),
            },
            is_admin: domain.is_admin,
            request_message: domain.request_message,
            is_default: domain.is_default,
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
                UserArtistStatus::Canceled => "Canceled".to_string(),
            },
            is_admin: domain.is_admin,
            request_message: domain.request_message,
        })
    }
}

impl ArtistData {
    pub fn from_domain(domain: domain::entities::artists::Model) -> Result<Self, anyhow::Error> {
        Ok(Self {
            id: domain.id.to_string(),
            artist_id: domain.artist_id,
            name: domain.display_name_jp,
            display_name_en: domain.display_name_en,
            display_name_kana: domain.display_name_kana,
            fsp: domain.fsp,
            image_url: domain.img_url,
            status: match domain.status {
                ArtistStatus::Hidden => "hidden".to_string(),
                ArtistStatus::Visible => "visible".to_string(),
                ArtistStatus::Unknown => "unknown".to_string(),
            },
            universal_id: domain.universal_id,
            apple_key: domain.apple_key,
            spotify_key: domain.spotify_key,
            line_key: domain.line_key,
            amazon_key: domain.amazon_key,
            youtube_key: domain.youtube_key,
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

#[cfg(test)]
mod tests {
    use super::*;
    use application::usecases::artist::request_to_access_usecase::ArtistSimpleInfoWithMappingId;
    use application::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo;
    use uuid::Uuid;

    #[test]
    fn artist_by_user_data_from_domain_maps_api_44_fields() {
        let data = ArtistByUserData::from_domain(ArtistSimpleInfo {
            id: Uuid::new_v4(),
            artist_id: "artist-1".to_string(),
            name: "Band One".to_string(),
            img_url: Some("https://cdn.example.com/artist.png".to_string()),
            fsp: 99,
            status: UserArtistStatus::Canceled,
            is_admin: true,
            request_message: Some("キャンセル前の申請メッセージ".to_string()),
            is_default: true,
        })
        .expect("artist data should map");

        assert_eq!(data.artist_id, "artist-1");
        assert_eq!(data.status, "Canceled");
        assert_eq!(
            data.request_message,
            Some("キャンセル前の申請メッセージ".to_string())
        );
        assert!(data.is_default);
    }

    #[test]
    fn artist_by_user_data_with_mapping_id_maps_canceled_request_message() {
        let data = ArtistByUserDataWithMappingId::from_domain_on_request_to_access(
            ArtistSimpleInfoWithMappingId {
                mapping_id: 7,
                id: Uuid::new_v4(),
                artist_id: "artist-1".to_string(),
                name: "Band One".to_string(),
                img_url: None,
                fsp: 12,
                status: UserArtistStatus::Canceled,
                is_admin: false,
                request_message: Some("キャンセルした申請".to_string()),
            },
        )
        .expect("artist data should map");

        assert_eq!(data.mapping_id, 7);
        assert_eq!(data.status, "Canceled");
        assert_eq!(data.request_message, Some("キャンセルした申請".to_string()));
    }

    #[test]
    fn artist_by_user_data_from_domain_maps_left_artist_fields() {
        let data = ArtistByUserData::from_domain(ArtistSimpleInfo {
            id: Uuid::new_v4(),
            artist_id: "artist-1".to_string(),
            name: "Band One".to_string(),
            img_url: None,
            fsp: 12,
            status: UserArtistStatus::Reject,
            is_admin: false,
            request_message: Some("所属時の申請".to_string()),
            is_default: false,
        })
        .expect("artist data should map");

        assert_eq!(data.status, "Reject");
        assert!(!data.is_admin);
        assert!(!data.is_default);
        assert_eq!(data.request_message, Some("所属時の申請".to_string()));
    }

    #[test]
    fn artist_by_user_data_from_domain_maps_default_artist_fields() {
        let data = ArtistByUserData::from_domain(ArtistSimpleInfo {
            id: Uuid::new_v4(),
            artist_id: "artist-1".to_string(),
            name: "Band One".to_string(),
            img_url: None,
            fsp: 12,
            status: UserArtistStatus::Accept,
            is_admin: true,
            request_message: Some("所属時の申請".to_string()),
            is_default: true,
        })
        .expect("artist data should map");

        assert_eq!(data.status, "Accept");
        assert!(data.is_admin);
        assert!(data.is_default);
        assert_eq!(data.request_message, Some("所属時の申請".to_string()));
    }
}
