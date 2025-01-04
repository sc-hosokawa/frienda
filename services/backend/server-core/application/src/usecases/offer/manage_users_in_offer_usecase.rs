use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferStatus, UserCategory};
use domain::entities::users::Model as User;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct GetUsersInOfferOutput {
    pub user_id: String,
    pub username: String,
    pub img_url: Option<String>,
    pub email: String,
    pub category: UserCategory,
    pub status_in_offer: OfferStatus,
}

#[async_trait]
pub trait ManageUsersInOfferUsecaseTrait: Send + Sync {
    async fn get_users_in_offer(
        &self,
        offer_id: i32,
        user_id: String,
    ) -> Result<Vec<GetUsersInOfferOutput>, anyhow::Error>;
}

pub struct ManageUsersInOfferUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    users_repo: Arc<dyn UsersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
}

impl ManageUsersInOfferUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        users_repo: Arc<dyn UsersRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
    ) -> Self {
        Self {
            offers_repo,
            users_repo,
            offer_user_repo,
        }
    }
}

#[async_trait]
impl ManageUsersInOfferUsecaseTrait for ManageUsersInOfferUsecase {
    async fn get_users_in_offer(
        &self,
        offer_id: i32,
        user_id: String,
    ) -> Result<Vec<GetUsersInOfferOutput>, anyhow::Error> {
        let offer: Option<Offer> = self.offers_repo.get_by_id(offer_id).await?;
        if offer.unwrap().owner != user_id {
            return Err(anyhow::anyhow!("You are not the owner of this offer"));
        }

        let users_in_offer: Vec<OfferUser> = self.offer_user_repo.get_by_offer_id(offer_id).await?;

        let priority_users: Vec<OfferUser> = users_in_offer
            .iter()
            .filter(|user| matches!(user.status, OfferStatus::Ongoing | OfferStatus::Finished))
            .cloned()
            .collect();

        if !priority_users.is_empty() {
            let priority_user_ids: Vec<String> = priority_users
                .iter()
                .map(|user| user.user_id.clone())
                .collect();

            let priority_users_data: Vec<User> = self
                .users_repo
                .find_by_ids(priority_user_ids.iter().map(|id| id.as_str()).collect())
                .await?;

            let mut priority_users_output: Vec<GetUsersInOfferOutput> = Vec::new();
            for user in priority_users_data {
                let status = priority_users
                    .iter()
                    .find(|u| u.user_id == user.id)
                    .map(|u| u.status.clone())
                    .unwrap_or(OfferStatus::Applied);

                priority_users_output.push(GetUsersInOfferOutput {
                    user_id: user.id,
                    username: user.username,
                    img_url: user.img_url,
                    email: user.email,
                    category: user.category,
                    status_in_offer: status,
                });
            }
            return Ok(priority_users_output);
        }

        let users_in_offer_ids: Vec<String> = users_in_offer
            .iter()
            .map(|user| user.user_id.clone())
            .collect();

        let users: Vec<User> = self
            .users_repo
            .find_by_ids(users_in_offer_ids.iter().map(|id| id.as_str()).collect())
            .await?;

        let mut users_in_offer_output: Vec<GetUsersInOfferOutput> = Vec::new();
        for user in users {
            let status_in_offer: OfferStatus = users_in_offer
                .iter()
                .find(|offer_user| offer_user.user_id == user.id)
                .map(|offer_user| offer_user.status.clone())
                .unwrap_or(OfferStatus::Applied);

            users_in_offer_output.push(GetUsersInOfferOutput {
                user_id: user.id,
                username: user.username,
                img_url: user.img_url,
                email: user.email,
                category: user.category,
                status_in_offer,
            });
        }

        Ok(users_in_offer_output)
    }
}
