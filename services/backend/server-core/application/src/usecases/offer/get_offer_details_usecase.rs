use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, OfferStatus, UserCategory};
use domain::repositories::offer_attach_repo::OfferAttachRepository;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct GetOfferDetailsUsecaseInput {
    pub offer_id: i32,
    pub user_id: String,
}

//
// Define the output for the usecase
//
pub struct GetOfferDetailsUsecaseOutput {
    pub id: i32,
    pub status: Option<OfferStatus>,
    pub raid_id: Option<i32>,
    pub owner: crate::usecases::basic::get_all_users_usecase::UserSimpleData,
    pub title: String,
    pub description: String,
    pub deadline: Option<String>,
    pub place: String,
    pub attention: Option<String>,
    pub required_skill: Option<String>,
    pub target_role: Option<UserCategory>,
    pub img_url: Option<String>,
    pub publicity: bool,
    pub category: Option<OfferCategory>,
    pub fee: i32,
    pub created_at: String,
    pub updated_at: String,
    pub attached_imgs: Vec<String>,
    pub attached_files: Vec<String>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetOfferDetailsUsecaseTrait: Send + Sync {
    async fn get_offer_details(
        &self,
        input: GetOfferDetailsUsecaseInput,
    ) -> Result<GetOfferDetailsUsecaseOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetOfferDetailsUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    users_repo: Arc<dyn UsersRepository>,
    offer_attach_repo: Arc<dyn OfferAttachRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
}

impl GetOfferDetailsUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        users_repo: Arc<dyn UsersRepository>,
        offer_attach_repo: Arc<dyn OfferAttachRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
    ) -> Self {
        Self {
            offers_repo,
            users_repo,
            offer_attach_repo,
            offer_user_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetOfferDetailsUsecaseTrait for GetOfferDetailsUsecase {
    async fn get_offer_details(
        &self,
        input: GetOfferDetailsUsecaseInput,
    ) -> Result<GetOfferDetailsUsecaseOutput, anyhow::Error> {
        let offer: Offer = self
            .offers_repo
            .get_by_id(input.offer_id)
            .await?
            .ok_or(anyhow::anyhow!("Offer not found"))?;

        // get owner's simple data
        let owner_simple_data = self
            .users_repo
            .find_by_id(&offer.owner)
            .await?
            .ok_or(anyhow::anyhow!("User not found"))?;

        // get attached resources
        let attached_imgs = self
            .offer_attach_repo
            .get_images_by_offer_id(offer.id)
            .await?;

        let attached_files = self
            .offer_attach_repo
            .get_files_by_offer_id(offer.id)
            .await?;

        // オファーユーザーマッピングを取得（存在しない場合はNone）
        let offer_status = self
            .offer_user_repo
            .get_by_user_id_and_offer_id(&input.user_id, offer.id)
            .await?
            .map(|mapping| mapping.status); // マッピングが存在する場合はそのステータスを使用

        Ok(GetOfferDetailsUsecaseOutput {
            id: offer.id,
            raid_id: offer.raid_id,
            status: offer_status, // Option<OfferStatus>型として設定
            owner: crate::usecases::basic::get_all_users_usecase::UserSimpleData {
                id: owner_simple_data.id,
                name: owner_simple_data.username,
                image_url: owner_simple_data.img_url,
            },
            title: offer.title,
            description: offer.description,
            deadline: offer.deadline,
            place: offer.place,
            attention: offer.attention,
            required_skill: offer.required_skill,
            target_role: offer.target_role,
            img_url: offer.img_url,
            publicity: offer.publicity,
            category: offer.category,
            fee: offer.fee,
            created_at: offer.created_at.to_string(),
            updated_at: offer.updated_at.to_string(),
            attached_imgs: attached_imgs
                .iter()
                .filter_map(|a| a.image_uri.clone())
                .collect(),
            attached_files: attached_files
                .iter()
                .filter_map(|a| a.file_uri.clone())
                .collect(),
        })
    }
}
