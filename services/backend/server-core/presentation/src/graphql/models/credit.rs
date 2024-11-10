use async_graphql::{InputObject, SimpleObject};
use domain::entities::track_credits::Model as TrackCredits;

#[derive(InputObject)]
pub struct RegisterCreditInput {
    pub register_info: Vec<RegisterInfo>,
}
#[derive(InputObject)]
pub struct RegisterInfo {
    pub isrc: String,
    pub commit_user: String, // varchar(28)
    pub credit_role: String,
    pub credit_name: String,
    pub email: String,
    pub is_invite: bool,
    pub memo: Option<String>,
}

#[derive(SimpleObject)]
pub struct RegisterCreditResponse {
    pub is_success: bool,
}

#[derive(SimpleObject)]
pub struct TrackCredit {
    pub isrc: String,
    pub commit_user: String,
    pub credit_role: String,
    pub credit_name: String,
    pub email: String,
    pub is_invite: Option<bool>,
    pub memo: Option<String>,
    pub created_at: String,
}
impl From<application::usecases::credit::get_credits_usecase::SimpleTrackCredit> for TrackCredit {
    fn from(value: application::usecases::credit::get_credits_usecase::SimpleTrackCredit) -> Self {
        Self {
            isrc: value.isrc,
            commit_user: value.commit_user,
            credit_role: value.credit_role,
            credit_name: value.credit_name,
            email: value.email,
            is_invite: value.is_invite,
            memo: value.memo,
            created_at: value.created_at.to_string(),
        }
    }
}

#[derive(SimpleObject)]
pub struct GetAllCreditsOutput {
    pub credits: Vec<TrackCreditsByAdmin>,
}

#[derive(SimpleObject)]
pub struct TrackCreditsByAdmin {
    pub id: i32,
    pub isrc: String,
    pub commit_user: String,
    pub credit_role: String,
    pub credit_name: String,
    pub credit_user: Option<String>,
    pub email: String,
    pub is_invite: Option<bool>,
    pub memo: Option<String>,
    pub created_at: String,
}
impl From<TrackCredits> for TrackCreditsByAdmin {
    fn from(value: TrackCredits) -> Self {
        Self {
            id: value.id,
            isrc: value.isrc,
            commit_user: value.commit_user,
            credit_role: value.credit_role,
            credit_name: value.credit_name,
            credit_user: value.credit_user,
            email: value.email,
            is_invite: value.is_invite,
            memo: value.memo,
            created_at: value.created_at.to_string(),
        }
    }
}
