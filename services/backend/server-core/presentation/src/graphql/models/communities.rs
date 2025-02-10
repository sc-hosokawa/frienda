use crate::graphql::models::offers::OfferData;
use async_graphql::SimpleObject;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};

// ===== Query =====

#[derive(SimpleObject)]
pub struct ConnectedUsersData {
    pub community: Vec<UserConnectionData>,
}

#[derive(SimpleObject)]
pub struct UserConnectionData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub category: String,
    pub favorite_id: Option<String>,
    pub short_note_id: Option<String>,
    pub short_note: Option<String>,
    pub last_logged_in: Option<String>,
    pub connections: Vec<String>,
    pub weight: i32,
}

#[derive(SimpleObject)]
pub struct UserDataOnDetailPage {
    pub id: String,
    pub image_url: Option<String>,
    pub name: String,
    pub last_logged_in: Option<String>,
    pub x_handle: Option<String>,
    pub instagram_handle: Option<String>,
    pub fb_handle: Option<String>,
    pub short_note: Option<String>,
    pub short_note_id: Option<String>,
    pub greeting: Option<String>,
    pub skill: Option<String>,
    pub connections: Vec<String>,
    pub interest_offer: Option<String>,
    pub category: String,
    pub belongs_to_artists: Vec<String>,
    pub portfolios: Vec<PortfolioData>, // 直近５つ
    pub offers: Vec<OfferData>,         // 直近４つ
}

#[derive(SimpleObject)]
pub struct PortfolioData {
    pub id: String,
    pub title: String,
    pub description: String,
    pub image_url: Option<String>,
    pub ref_link: Vec<String>,
    pub created_at: String,
}

// ===== Mutation =====
#[derive(SimpleObject)]
pub struct AddShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct EditShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct DeleteShortnoteResponse {
    pub id: String, // uuid
}

#[derive(SimpleObject)]
pub struct MarkFavoriteResponse {
    pub id: String, // uuid
}

impl From<application::usecases::community::get_user_connections_usecase::UserConnection>
    for UserConnectionData
{
    fn from(
        user_connection: application::usecases::community::get_user_connections_usecase::UserConnection,
    ) -> Self {
        Self {
            id: user_connection.id,
            name: user_connection.name,
            image_url: user_connection.image_url,
            category: match user_connection.category {
                UserCategory::Musician => "musician".to_string(),
                UserCategory::Creator => "creator".to_string(),
                UserCategory::Curator => "curator".to_string(),
                UserCategory::Supporter => "supporter".to_string(),
            },
            favorite_id: user_connection.favorite_id.map(|id| id.to_string()),
            short_note_id: user_connection.short_note_id.map(|id| id.to_string()),
            short_note: user_connection.short_note,
            last_logged_in: user_connection.last_logged_in,
            connections: user_connection.connections,
            weight: user_connection.weight,
        }
    }
}

impl From<application::usecases::community::user_profile_usecase::GetUserProfileOutput>
    for UserDataOnDetailPage
{
    fn from(
        user_profile: application::usecases::community::user_profile_usecase::GetUserProfileOutput,
    ) -> Self {
        Self {
            id: user_profile.id,
            image_url: user_profile.image_url,
            name: user_profile.name,
            last_logged_in: user_profile.last_logged_in,
            x_handle: user_profile.x_handle,
            instagram_handle: user_profile.instagram_handle,
            fb_handle: user_profile.fb_handle,
            short_note: user_profile.short_note,
            short_note_id: user_profile.short_note_id.map(|id| id.to_string()),
            greeting: user_profile.greeting,
            skill: user_profile.skill,
            connections: user_profile.connections,
            interest_offer: match user_profile.interest_offer {
                Some(offer) => Some(match offer {
                    OfferCategory::Creation => "creation".to_string(),
                    OfferCategory::Event => "event".to_string(),
                    OfferCategory::Promotion => "promotion".to_string(),
                    OfferCategory::Other => "other".to_string(),
                }),
                None => None,
            },
            category: match user_profile.category {
                UserCategory::Musician => "musician".to_string(),
                UserCategory::Creator => "creator".to_string(),
                UserCategory::Curator => "curator".to_string(),
                UserCategory::Supporter => "supporter".to_string(),
            },
            belongs_to_artists: user_profile.belongs_to_artists,
            portfolios: vec![],
            offers: user_profile
                .offers
                .into_iter()
                .map(|o| OfferData {
                    id: o.id,
                    title: o.title.clone(),
                    description: o.description.clone(),
                    image_url: o.image_url.clone(),
                    fee: o.fee,
                    category: o.category.clone(),
                    place: o.place,
                })
                .collect(),
        }
    }
}
