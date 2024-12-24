use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::artists::Model as Artist;
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, OfferStatus, UserCategory};
use domain::entities::short_notes::Model as ShortNote;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;

use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::short_notes_repo::ShortNotesRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct GetUserProfileOutput {
    pub id: String,
    pub image_url: Option<String>,
    pub name: String,
    pub last_logged_in: Option<String>,
    pub x_handle: Option<String>,
    pub instagram_handle: Option<String>,
    pub fb_handle: Option<String>,
    pub short_note: Option<String>,
    pub greeting: Option<String>,
    pub skill: Option<String>,
    pub connections: Vec<String>,
    pub interest_offer: Option<OfferCategory>,
    pub category: UserCategory,
    pub belongs_to_artists: Vec<String>,
    // pub portfolios: Vec<PortfolioData>, // 直近５つ
    pub offers: Vec<OfferData>, // 直近４つ
}

pub struct OfferData {
    pub id: i32,
    pub title: String,
    pub description: String,
    pub image_url: Option<String>,
    pub fee: i32,
    pub category: Option<String>,
}

#[async_trait]
pub trait GetUserProfileUsecaseTrait: Send + Sync {
    async fn get_user_profile(
        &self,
        viewer_id: String,
        user_id: String,
    ) -> Result<GetUserProfileOutput, anyhow::Error>;
}

pub struct GetUserProfileUsecase {
    users_repo: Arc<dyn UsersRepository>,
    user_artist_repo: Arc<dyn UserArtistRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
    offers_repo: Arc<dyn OffersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
    short_notes_repo: Arc<dyn ShortNotesRepository>,
}

impl GetUserProfileUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        user_artist_repo: Arc<dyn UserArtistRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
        offers_repo: Arc<dyn OffersRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
        short_notes_repo: Arc<dyn ShortNotesRepository>,
    ) -> Self {
        Self {
            users_repo,
            user_artist_repo,
            artists_repo,
            offers_repo,
            offer_user_repo,
            short_notes_repo,
        }
    }
}

#[async_trait]
impl GetUserProfileUsecaseTrait for GetUserProfileUsecase {
    async fn get_user_profile(
        &self,
        viewer_id: String,
        user_id: String,
    ) -> Result<GetUserProfileOutput, anyhow::Error> {
        let user: User = self.users_repo.find_by_id(&user_id).await?.unwrap();

        // artist
        let belongs_to_artists: Vec<UserArtist> =
            self.user_artist_repo.find_by_user_id(&user_id).await?;
        let artists: Vec<Artist> = self
            .artists_repo
            .find_by_ids(
                belongs_to_artists
                    .iter()
                    .map(|a| a.artist_id.as_str())
                    .collect(),
            )
            .await?;

        // offer
        let owned_offers: Vec<Offer> = self.offers_repo.get_offers_by_user(&user_id).await?;
        let offer_users: Vec<OfferUser> = self.offer_user_repo.get_by_user_id(&user_id).await?;
        let mut participated_offers: Vec<Offer> = Vec::new();
        for offer_user in offer_users {
            if offer_user.status == OfferStatus::Applied
                || offer_user.status == OfferStatus::Ongoing
                || offer_user.status == OfferStatus::Finished
            {
                let offer: Option<Offer> = self.offers_repo.get_by_id(offer_user.offer_id).await?;
                if let Some(offer) = offer {
                    participated_offers.push(offer);
                }
            }
        }

        let mut offers: Vec<Offer> = owned_offers
            .into_iter()
            .chain(participated_offers.into_iter())
            .collect();
        offers.sort_by(|a, b| b.created_at.cmp(&a.created_at));
        let latest_offers: Vec<Offer> = offers.into_iter().take(4).collect();

        // short note
        let short_note: Option<ShortNote> = self
            .short_notes_repo
            .get_by_writer_and_to_user(&viewer_id, &user_id)
            .await?;

        Ok(GetUserProfileOutput {
            id: user_id,
            image_url: user.img_url,
            name: user.username,
            last_logged_in: user.last_login_at.map(|t| t.to_string()),
            x_handle: user.x_handle,
            instagram_handle: user.instagram_handle,
            fb_handle: user.fb_handle,
            short_note: short_note.map(|s| s.comment),
            greeting: user.greeting,
            skill: user.skill,
            connections: vec![],
            interest_offer: user.interest_offer,
            category: user.category,
            belongs_to_artists: artists.iter().map(|a| a.display_name_jp.clone()).collect(),
            offers: latest_offers
                .iter()
                .map(|o| OfferData {
                    id: o.id,
                    title: o.title.clone(),
                    description: o.description.clone(),
                    image_url: o.img_url.clone(),
                    fee: o.fee,
                    category: o.category.clone().map(|c| match c {
                        OfferCategory::Creation => "Creation".to_string(),
                        OfferCategory::Event => "Event".to_string(),
                        OfferCategory::Promotion => "Promotion".to_string(),
                        OfferCategory::Other => "Other".to_string(),
                    }),
                })
                .collect(),
            // portfolios: vec![],
        })
    }
}
