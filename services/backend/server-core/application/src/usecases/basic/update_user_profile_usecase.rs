use async_trait::async_trait;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserArtistStatus, UserCategory};
use domain::entities::user_artist::ActiveModel as UserArtistActiveModel;
use domain::entities::users::ActiveModel as UserActiveModel;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;
use sea_orm::ActiveValue;
use std::sync::Arc;

//
// Define the input for the usecase
//
pub struct UpdateUserProfileInput {
    pub id: String,
    pub email: Option<String>,
    pub name: Option<String>,
    pub image_url: Option<String>,
    pub primary_category: Option<UserCategory>,
    pub evm_addr: Option<String>,
    pub greeting: Option<String>,
    pub skill: Option<String>,
    pub x_handle: Option<String>,
    pub instagram_handle: Option<String>,
    pub fb_handle: Option<String>,
    pub fcm_token: Option<String>,
    pub interest_offer: Option<OfferCategory>,
    // pub status: Option<UserStatus>,
}

pub struct UpdateBelongsToArtistStatusInput {
    pub user_id: String,   // varchar(28)
    pub artist_id: String, // varchar(28)
    pub next_status_is_admin: Option<bool>,
    pub next_status: Option<UserArtistStatus>,
}

//
// Define the output for the usecase
//
pub struct UpdateUserProfileOutput {
    pub updated_user: domain::entities::users::Model,
    pub artists: RelatedArtists,
}
pub struct RelatedArtists {
    pub belongs_to_artists:
        Vec<crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo>,
    pub primary_artist:
        Option<crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo>,
}

pub struct UpdateBelongsToArtistStatusOutput {
    pub updated_user_artist: crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait UpdateUserProfileUsecaseTrait: Send + Sync {
    async fn update(
        &self,
        input: UpdateUserProfileInput,
    ) -> Result<UpdateUserProfileOutput, anyhow::Error>;
    async fn update_belongs_to_artist_status(
        &self,
        input: UpdateBelongsToArtistStatusInput,
    ) -> Result<UpdateBelongsToArtistStatusOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct UpdateUserProfileUsecase {
    users_repo: Arc<dyn UsersRepository>,
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl UpdateUserProfileUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            users_repo,
            user_artist_repo,
            artists_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl UpdateUserProfileUsecaseTrait for UpdateUserProfileUsecase {
    async fn update(
        &self,
        input: UpdateUserProfileInput,
    ) -> Result<UpdateUserProfileOutput, anyhow::Error> {
        let user = self
            .users_repo
            .find_by_id(&input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found"))?;

        let mut updated_user: UserActiveModel = user.into();

        if let Some(name) = input.name {
            updated_user.username = ActiveValue::Set(name);
        }
        if let Some(image_url) = input.image_url {
            updated_user.img_url = ActiveValue::Set(Some(image_url));
        }
        if let Some(primary_category) = input.primary_category {
            updated_user.primary_category = ActiveValue::Set(primary_category);
        }
        if let Some(evm_addr) = input.evm_addr {
            updated_user.evm_addr = ActiveValue::Set(Some(evm_addr));
        }
        if let Some(greeting) = input.greeting {
            updated_user.greeting = ActiveValue::Set(Some(greeting));
        }
        if let Some(skill) = input.skill {
            updated_user.skill = ActiveValue::Set(Some(skill));
        }
        if let Some(x_handle) = input.x_handle {
            updated_user.x_handle = ActiveValue::Set(Some(x_handle));
        }
        if let Some(instagram_handle) = input.instagram_handle {
            updated_user.instagram_handle = ActiveValue::Set(Some(instagram_handle));
        }
        if let Some(fb_handle) = input.fb_handle {
            updated_user.fb_handle = ActiveValue::Set(Some(fb_handle));
        }
        if let Some(fcm_token) = input.fcm_token {
            updated_user.fcm_token = ActiveValue::Set(Some(fcm_token));
        }
        if let Some(interest_offer) = input.interest_offer {
            updated_user.interest_offer = ActiveValue::Set(Some(interest_offer));
        }

        let updated_user = self.users_repo.update(updated_user).await?;

        let belongs_to_artists = self.user_artist_repo.find_by_user_id(&input.id).await?;

        let artists = self
            .artists_repo
            .find_by_ids(
                belongs_to_artists
                    .iter()
                    .map(|a| a.artist_id.as_str())
                    .collect(),
            )
            .await?;

        let artist_info = artists
            .into_iter()
            .map(|artist| {
                let user_artist = belongs_to_artists
                    .iter()
                    .find(|ua| ua.artist_id == artist.artist_id)
                    .expect("UserArtist should exist for this artist");

                crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo {
                    id: artist.id,
                    artist_id: artist.artist_id,
                    name: artist.display_name_jp,
                    img_url: artist.img_url,
                    fsp: artist.fsp,
                    is_admin: user_artist.is_admin,
                    status: user_artist.status.clone(),
                    request_message: user_artist.request_message.clone(),
                    is_default: user_artist.is_default,
                }
            })
            .collect();

        Ok(UpdateUserProfileOutput {
            updated_user,
            artists: RelatedArtists {
                belongs_to_artists: artist_info,
                primary_artist: None,
            },
        })
    }

    async fn update_belongs_to_artist_status(
        &self,
        input: UpdateBelongsToArtistStatusInput,
    ) -> Result<UpdateBelongsToArtistStatusOutput, anyhow::Error> {
        let user_artist = self
            .user_artist_repo
            .find_by_artist_id_and_user_id(&input.artist_id, &input.user_id)
            .await?;
        let mut updated_user_artist: UserArtistActiveModel = user_artist.unwrap().into();

        if let Some(next_status) = input.next_status {
            updated_user_artist.status = ActiveValue::Set(next_status);
        }
        if let Some(next_status_is_admin) = input.next_status_is_admin {
            updated_user_artist.is_admin = ActiveValue::Set(next_status_is_admin);
        }

        let updated_user_artist = self
            .user_artist_repo
            .update_status(updated_user_artist)
            .await?;

        let artist = self
            .artists_repo
            .find_by_id(&input.artist_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Artist not found"))?;
        let artist_info = crate::usecases::basic::get_user_basic_info_usecase::ArtistSimpleInfo {
            id: artist.id,
            artist_id: artist.artist_id,
            name: artist.display_name_jp,
            img_url: artist.img_url,
            fsp: artist.fsp,
            is_admin: updated_user_artist.is_admin,
            status: updated_user_artist.status,
            request_message: updated_user_artist.request_message,
            is_default: updated_user_artist.is_default,
        };

        Ok(UpdateBelongsToArtistStatusOutput {
            updated_user_artist: artist_info,
        })
    }
}

#[cfg(test)]
#[path = "update_user_profile_usecase_tests.rs"]
mod tests;
