use anyhow::Error;
use application::usecases::offer::register_task_usecase;
use async_graphql::{InputObject, SimpleObject};
use domain::entities::sea_orm_active_enums::{OfferCategory, OfferStatus, UserCategory};

// ===== Query =====

#[derive(SimpleObject)]
pub struct OfferStatsData {
    pub total_offers: i32,
    pub ongoing_offers: i32,
    pub applied_offers: i32,
    pub completed_offers: i32,
    pub total_earnings: i32,
}

#[derive(SimpleObject)]
pub struct OfferStatsByUserData {
    pub total_offers: i32,
    pub ongoing_offers: i32,
    pub applied_offers: i32,
    pub completed_offers: i32,
    pub total_earnings: i32,
}

#[derive(SimpleObject)]
pub struct OfferData {
    pub id: i32,
    pub title: String,
    pub description: String,
    pub image_url: Option<String>,
    pub fee: i32,
    pub category: Option<String>,
}

#[derive(SimpleObject)]
pub struct OfferDetailData {
    pub id: i32,
    pub raid_id: Option<i32>,
    pub status: Option<String>,
    pub title: String,
    pub description: String,
    pub image_url: Option<String>,
    pub fee: i32,
    pub category: Option<String>,
    pub place: String,
    pub attention: Option<String>,
    pub required_skill: Option<String>,
    pub target_role: Option<String>,
    pub publicity: Option<bool>,
    pub attached_imgs: Option<Vec<String>>,
    pub attached_files: Option<Vec<String>>,
    pub created_at: String,
    pub updated_at: String,
    pub owner: crate::graphql::models::users::UserSimpleData,
}

#[derive(SimpleObject)]
pub struct OffersData {
    pub offer_list: Vec<OfferData>,
}

#[derive(SimpleObject)]
pub struct OfferByStatusData {
    pub inprogress_offers: Vec<OfferData>,
    pub applied_offers: Vec<OfferData>,
}

#[derive(SimpleObject)]
pub struct UsersInOfferData {
    pub users: Vec<UserInOfferData>,
}

#[derive(SimpleObject)]
pub struct UserInOfferData {
    pub user_id: String,
    pub username: String,
    pub img_url: String,
    pub email: String,
    pub category: String,
    pub status_in_offer: String,
}

// ===== Mutation =====

#[derive(InputObject)]
pub struct CreateNewOfferInput {
    pub owner: String,
    pub deadline: Option<String>,
    pub title: String,
    pub description: String,
    pub fee: i32,
    pub image_url: Option<String>,
    pub raid_id: Option<i32>,
    pub category: Option<String>, // カテゴリー
    pub place: String,
    pub attention: Option<String>,
    pub required_skill: Option<String>,
    pub target_role: Option<String>, // ターゲットロール
    pub publicity: Option<bool>,
    pub attached_imgs: Option<Vec<String>>,
    pub attached_files: Option<Vec<String>>,
}

#[derive(InputObject)]
pub struct UpdateOfferInput {
    pub id: i32,
    pub title: Option<String>,
    pub description: Option<String>,
    pub fee: Option<i32>,
    pub image_url: Option<String>,
    pub category: Option<String>,
    pub place: Option<String>,
    pub attention: Option<String>,
    pub required_skill: Option<String>,
    pub target_role: Option<String>,
    pub attached_media: Option<Vec<String>>,
    pub publicity: Option<bool>,
}

#[derive(InputObject)]
pub struct UpdateOfferStatusInput {
    pub id: i32,
    pub user_id: String,
    pub status: String,
}

#[derive(SimpleObject)]
pub struct UpdateOfferStatusResponse {
    pub id: i32,
    pub offer_id: i32,
}

#[derive(InputObject)]
pub struct DeleteOfferInput {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct CreateNewOfferResponse {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct UpdateOfferResponse {
    pub id: i32,
}

#[derive(SimpleObject)]
pub struct DeleteOfferResponse {
    pub id: i32,
}

// ===== Convert to usecase input =====
impl CreateNewOfferInput {
    pub fn into_usecase_input(self) -> Result<register_task_usecase::RegisterTaskInput, Error> {
        Ok(register_task_usecase::RegisterTaskInput {
            owner: self.owner,
            title: self.title,
            description: self.description,
            fee: self.fee,
            deadline: self.deadline,
            image_url: self.image_url,
            attached_imgs: self.attached_imgs,
            attached_files: self.attached_files,
            raid_id: self.raid_id,
            category: self
                .category
                .map(|c| from_string_to_offer_category(&c).map_err(Error::msg))
                .transpose()?,
            place: self.place,
            attention: self.attention,
            required_skill: self.required_skill,
            publicity: self.publicity,
            target_role: self
                .target_role
                .map(|r| from_string_to_user_category(&r).map_err(Error::msg))
                .transpose()?,
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

pub fn from_user_category_to_string(c: Option<UserCategory>) -> Option<String> {
    match c {
        Some(UserCategory::Musician) => Some("Musician".to_string()),
        Some(UserCategory::Creator) => Some("Creator".to_string()),
        Some(UserCategory::Curator) => Some("Curator".to_string()),
        Some(UserCategory::Supporter) => Some("Supporter".to_string()),
        None => None,
    }
}

pub fn from_string_to_offer_category(s: &str) -> Result<OfferCategory, String> {
    match s {
        "Creation" => Ok(OfferCategory::Creation),
        "Event" => Ok(OfferCategory::Event),
        "Promotion" => Ok(OfferCategory::Promotion),
        "Other" => Ok(OfferCategory::Other),
        _ => Err(format!("Invalid OfferCategory: {}", s)),
    }
}

pub fn from_offer_category_to_string(c: Option<OfferCategory>) -> Option<String> {
    match c {
        Some(OfferCategory::Creation) => Some("Creation".to_string()),
        Some(OfferCategory::Event) => Some("Event".to_string()),
        Some(OfferCategory::Promotion) => Some("Promotion".to_string()),
        Some(OfferCategory::Other) => Some("Other".to_string()),
        None => None,
    }
}

pub fn from_string_to_offer_status(s: &str) -> Result<OfferStatus, String> {
    match s {
        "Applied" => Ok(OfferStatus::Applied),
        "Finished" => Ok(OfferStatus::Finished),
        "Canceled" => Ok(OfferStatus::Canceled),
        "Ongoing" => Ok(OfferStatus::Ongoing),
        "Rejected" => Ok(OfferStatus::Rejected),
        "Suspend" => Ok(OfferStatus::Suspend),
        _ => Err(format!("Invalid OfferStatus: {}", s)),
    }
}

pub fn from_offer_status_to_string(s: Option<OfferStatus>) -> Option<String> {
    match s {
        Some(OfferStatus::Applied) => Some("Applied".to_string()),
        Some(OfferStatus::Finished) => Some("Finished".to_string()),
        Some(OfferStatus::Canceled) => Some("Canceled".to_string()),
        Some(OfferStatus::Ongoing) => Some("Ongoing".to_string()),
        Some(OfferStatus::Rejected) => Some("Rejected".to_string()),
        Some(OfferStatus::Suspend) => Some("Suspend".to_string()),
        None => None,
    }
}

impl From<application::usecases::offer::get_offer_stats_usecase::GetOfferStatsOutput>
    for OfferStatsByUserData
{
    fn from(
        output: application::usecases::offer::get_offer_stats_usecase::GetOfferStatsOutput,
    ) -> Self {
        OfferStatsByUserData {
            total_offers: output.total_offers,
            ongoing_offers: output.ongoing_offers,
            applied_offers: output.applied_offers,
            completed_offers: output.completed_offers,
            total_earnings: output.total_earnings,
        }
    }
}

impl From<domain::entities::offers::Model> for OfferData {
    fn from(offer: domain::entities::offers::Model) -> Self {
        OfferData {
            id: offer.id,
            title: offer.title,
            description: offer.description,
            image_url: offer.img_url,
            fee: offer.fee,
            category: offer.category.map(|c| match c {
                OfferCategory::Creation => "Creation".to_string(),
                OfferCategory::Event => "Event".to_string(),
                OfferCategory::Promotion => "Promotion".to_string(),
                OfferCategory::Other => "Other".to_string(),
            }),
        }
    }
}

impl From<application::usecases::offer::manage_users_in_offer_usecase::GetUsersInOfferOutput>
    for UserInOfferData
{
    fn from(
        output: application::usecases::offer::manage_users_in_offer_usecase::GetUsersInOfferOutput,
    ) -> Self {
        UserInOfferData {
            user_id: output.user_id,
            username: output.username,
            img_url: output.img_url.unwrap_or("".to_string()),
            email: output.email,
            category: match output.category {
                UserCategory::Musician => "Musician".to_string(),
                UserCategory::Creator => "Creator".to_string(),
                UserCategory::Curator => "Curator".to_string(),
                UserCategory::Supporter => "Supporter".to_string(),
            },
            status_in_offer: match output.status_in_offer {
                OfferStatus::Applied => "Applied".to_string(),
                OfferStatus::Finished => "Finished".to_string(),
                OfferStatus::Canceled => "Canceled".to_string(),
                OfferStatus::Ongoing => "Ongoing".to_string(),
                OfferStatus::Rejected => "Rejected".to_string(),
                OfferStatus::Suspend => "Suspend".to_string(),
            },
        }
    }
}
