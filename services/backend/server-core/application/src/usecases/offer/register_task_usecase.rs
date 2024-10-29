use async_trait::async_trait;
use chrono::{DateTime, Utc};
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::offer_attach::ActiveModel as OfferAttachActiveModel;
use domain::entities::offers::ActiveModel as OfferActiveModel;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use domain::repositories::offer_attach_repo::OfferAttachRepository;
use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct RegisterTaskInput {
    pub owner: String,
    pub title: String,
    pub description: String,
    pub place: String,
    pub attention: Option<String>,
    pub required_skill: Option<String>,
    pub target_role: Option<UserCategory>,
    pub fee: i32,
    pub deadline: DateTime<Utc>,
    pub image_url: Option<String>,
    pub attached_imgs: Option<Vec<String>>,
    pub attached_files: Option<Vec<String>>,
    pub raid_id: Option<i32>,
    pub category: Option<OfferCategory>,
    pub publicity: Option<bool>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait RegisterTaskUsecaseTrait: Send + Sync {
    async fn register_task(&self, input: RegisterTaskInput) -> Result<i32, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct RegisterTaskUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_attach_repo: Arc<dyn OfferAttachRepository>,
}

impl RegisterTaskUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        offer_attach_repo: Arc<dyn OfferAttachRepository>,
    ) -> Self {
        Self {
            offers_repo,
            offer_attach_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl RegisterTaskUsecaseTrait for RegisterTaskUsecase {
    async fn register_task(&self, input: RegisterTaskInput) -> Result<i32, anyhow::Error> {
        let offer: OfferActiveModel = OfferActiveModel {
            owner: ActiveValue::Set(input.owner),
            deadline: ActiveValue::Set(input.deadline.naive_utc()),
            title: ActiveValue::Set(input.title),
            description: ActiveValue::Set(input.description),
            fee: ActiveValue::Set(input.fee),
            place: ActiveValue::Set(input.place),
            attention: ActiveValue::Set(input.attention),
            required_skill: ActiveValue::Set(input.required_skill),
            target_role: ActiveValue::Set(input.target_role),
            img_url: ActiveValue::Set(input.image_url),
            publicity: ActiveValue::Set(true),
            raid_id: ActiveValue::Set(input.raid_id),
            category: ActiveValue::Set(input.category),
            ..Default::default()
        };
        let offer = self.offers_repo.create(offer).await?;

        if input.attached_imgs.is_some() || input.attached_files.is_some() {
            let attached_media: Vec<String> = input
                .attached_imgs
                .unwrap_or_default()
                .into_iter()
                .chain(input.attached_files.unwrap_or_default().into_iter())
                .collect();

            let offer_attaches: Vec<OfferAttachActiveModel> = attached_media
                .into_iter()
                .map(|media_url| OfferAttachActiveModel {
                    offer_id: ActiveValue::Set(offer.id),
                    file_uri: ActiveValue::Set(Some(media_url)),
                    image_uri: ActiveValue::Set(None),
                    ..Default::default()
                })
                .collect();

            self.offer_attach_repo.create_many(offer_attaches).await?;
        }

        Ok(offer.id)
    }
}
