use async_trait::async_trait;
use chrono::{DateTime, Utc};
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::offer_attach::ActiveModel as OfferAttachActiveModel;
use domain::entities::offers::ActiveModel as OfferActiveModel;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use domain::repositories::offer_attach_repo::OfferAttachRepository;
use domain::repositories::offers_repo::OffersRepository;

//
// Define the input for the usecase
//
pub struct UpdateTaskInput {
    pub id: i32,
    pub title: Option<String>,
    pub description: Option<String>,
    pub fee: Option<i32>,
    pub image_url: Option<String>,
    pub category: Option<OfferCategory>,
    pub place: Option<String>,
    pub attention: Option<String>,
    pub required_skill: Option<String>,
    pub target_role: Option<UserCategory>,
    pub publicity: Option<bool>,
    pub deadline: Option<DateTime<Utc>>,
    pub attached_imgs: Option<Vec<String>>,
    pub attached_files: Option<Vec<String>>,
}

pub struct UpdateTaskOutput {
    pub offer: Offer,
    pub attached_files: Option<Vec<String>>,
    pub attached_imgs: Option<Vec<String>>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait UpdateTaskUsecaseTrait: Send + Sync {
    async fn update(&self, input: UpdateTaskInput) -> Result<UpdateTaskOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct UpdateTaskUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_attach_repo: Arc<dyn OfferAttachRepository>,
}

impl UpdateTaskUsecase {
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
impl UpdateTaskUsecaseTrait for UpdateTaskUsecase {
    async fn update(&self, input: UpdateTaskInput) -> Result<UpdateTaskOutput, anyhow::Error> {
        let offer = self
            .offers_repo
            .get_by_id(input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Offer not found"))?;

        let mut updated_offer: OfferActiveModel = offer.into();

        if let Some(title) = input.title {
            updated_offer.title = ActiveValue::Set(title);
        }
        if let Some(description) = input.description {
            updated_offer.description = ActiveValue::Set(description);
        }
        if let Some(fee) = input.fee {
            updated_offer.fee = ActiveValue::Set(fee);
        }
        if let Some(image_url) = input.image_url {
            updated_offer.img_url = ActiveValue::Set(Some(image_url));
        }
        if let Some(category) = input.category {
            updated_offer.category = ActiveValue::Set(Some(category));
        }
        if let Some(place) = input.place {
            updated_offer.place = ActiveValue::Set(place);
        }
        if let Some(attention) = input.attention {
            updated_offer.attention = ActiveValue::Set(Some(attention));
        }
        if let Some(required_skill) = input.required_skill {
            updated_offer.required_skill = ActiveValue::Set(Some(required_skill));
        }
        if let Some(target_role) = input.target_role {
            updated_offer.target_role = ActiveValue::Set(Some(target_role));
        }
        if let Some(publicity) = input.publicity {
            updated_offer.publicity = ActiveValue::Set(publicity);
        }
        if let Some(deadline) = input.deadline {
            updated_offer.deadline = ActiveValue::Set(deadline.naive_utc());
        }

        let new_offer = self.offers_repo.update(updated_offer).await?;

        // Handle attached media (images and files)
        if input.attached_imgs.is_some() || input.attached_files.is_some() {
            // Clone the values before using them in the iterator
            let attached_files = input.attached_files.clone();
            let attached_imgs = input.attached_imgs.clone();

            let attached_media: Vec<String> = attached_imgs
                .unwrap_or_default()
                .into_iter()
                .chain(attached_files.unwrap_or_default().into_iter())
                .collect();

            // Get existing attachments
            let existing_attachments = self.offer_attach_repo.get_by_offer_id(input.id).await?;

            // Create a set of existing media URLs for quick lookup
            let existing_urls: std::collections::HashSet<String> = existing_attachments
                .iter()
                .map(|attach| attach.file_uri.clone().unwrap())
                .collect();

            // Process new attachments
            for media_url in &attached_media {
                if !existing_urls.contains(media_url) {
                    // If the URL doesn't exist, create a new attachment
                    let new_attach = OfferAttachActiveModel {
                        offer_id: ActiveValue::Set(input.id),
                        file_uri: ActiveValue::Set(Some(media_url.clone())),
                        ..Default::default()
                    };
                    self.offer_attach_repo.create(new_attach).await?;
                }
            }

            // Remove attachments that are no longer in the input list
            let new_urls: std::collections::HashSet<String> = attached_media.into_iter().collect();
            for existing_attach in existing_attachments {
                if let Some(file_uri) = existing_attach.file_uri {
                    if !new_urls.contains(&file_uri) {
                        self.offer_attach_repo.delete(existing_attach.id).await?;
                    }
                }
            }
        }

        Ok(UpdateTaskOutput {
            offer: new_offer,
            attached_files: input.attached_files,
            attached_imgs: input.attached_imgs,
        })
    }
}
