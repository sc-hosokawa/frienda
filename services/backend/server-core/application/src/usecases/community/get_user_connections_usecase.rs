use async_trait::async_trait;
use std::sync::Arc;
use uuid::Uuid;

use domain::entities::favorites::Model as Favorite;
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferStatus, UserCategory};
use domain::entities::track_credits::Model as TrackCredits;
use domain::entities::txs_fsp::Model as TxsFsp;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use domain::repositories::favorites_repo::FavoritesRepository;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::short_notes_repo::ShortNotesRepository;
use domain::repositories::track_credits_repo::TrackCreditsRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::user_artist_repo::UserArtistRepository;
use domain::repositories::users_repo::UsersRepository;

pub struct UserConnectionsOutput {
    pub community: Vec<UserConnection>,
}

pub struct UserConnection {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
    pub category: UserCategory,
    pub favorite_id: Option<Uuid>,
    pub short_note: Option<String>,
    pub last_logged_in: Option<String>,
    pub connections: Vec<String>,
    pub weight: i32,
}

pub struct UserConnectionAtom {
    pub user_id: String,
    pub reason: String,
}

#[async_trait]
pub trait GetUserConnectionsUsecaseTrait: Send + Sync {
    async fn get_own_community(
        &self,
        user_id: String,
    ) -> Result<UserConnectionsOutput, anyhow::Error>;
    async fn get_other_user_community(
        &self,
        viewer_id: String,
        target_user_id: String,
    ) -> Result<UserConnectionsOutput, anyhow::Error>;
}

pub struct GetUserConnectionsUsecase {
    users_repo: Arc<dyn UsersRepository>,
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
    user_artist_repo: Arc<dyn UserArtistRepository>,
    track_credits_repo: Arc<dyn TrackCreditsRepository>,
    favorites_repo: Arc<dyn FavoritesRepository>,
    short_notes_repo: Arc<dyn ShortNotesRepository>,
    offers_repo: Arc<dyn OffersRepository>,
}

impl GetUserConnectionsUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
        user_artist_repo: Arc<dyn UserArtistRepository>,
        track_credits_repo: Arc<dyn TrackCreditsRepository>,
        favorites_repo: Arc<dyn FavoritesRepository>,
        short_notes_repo: Arc<dyn ShortNotesRepository>,
        offers_repo: Arc<dyn OffersRepository>,
    ) -> Self {
        Self {
            users_repo,
            txs_fsp_repo,
            offer_user_repo,
            user_artist_repo,
            track_credits_repo,
            favorites_repo,
            short_notes_repo,
            offers_repo,
        }
    }
}

#[async_trait]
impl GetUserConnectionsUsecaseTrait for GetUserConnectionsUsecase {
    async fn get_own_community(
        &self,
        user_id: String,
    ) -> Result<UserConnectionsOutput, anyhow::Error> {
        // FSPの履歴を取得
        let fsp_history: Vec<TxsFsp> = self.txs_fsp_repo.get_by_user_id(&user_id, 100).await?;
        let users_connected_via_fsp: Vec<String> = fsp_history
            .iter()
            .filter_map(|tx| {
                if tx.from == Some(user_id.clone()) {
                    Some(tx.to.clone())
                } else if tx.to == user_id {
                    tx.from.clone()
                } else {
                    None
                }
            })
            .collect();
        let user_connection_fsp_atoms: Vec<UserConnectionAtom> = users_connected_via_fsp
            .iter()
            .map(|user_id| UserConnectionAtom {
                user_id: user_id.clone(),
                reason: "FSP Transaction".to_string(),
            })
            .collect();

        // 所属するアーティストの自分以外のユーザーを取得
        let user_artists: Vec<UserArtist> = self.user_artist_repo.find_by_user_id(&user_id).await?;
        let artist_belonged_to_user: Vec<&str> = user_artists
            .iter()
            .map(|user_artist| user_artist.artist_id.as_str())
            .collect();
        let users_connected_via_artist_models: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_artist_ids(artist_belonged_to_user)
            .await?
            .into_iter()
            .filter(|user_artist| user_artist.user_id.as_str() != user_id)
            .collect();
        let users_connected_via_artist: Vec<String> = users_connected_via_artist_models
            .iter()
            .map(|user_artist| user_artist.user_id.as_str().to_string())
            .collect();
        let user_connection_artist_atoms: Vec<UserConnectionAtom> = users_connected_via_artist
            .iter()
            .map(|user_id| UserConnectionAtom {
                user_id: user_id.clone(),
                reason: "Artist".to_string(),
            })
            .collect();

        // OfferUserでステータスがOngoingかFinishedのものを取得
        let offer_users: Vec<OfferUser> = self.offer_user_repo.get_by_user_id(&user_id).await?;
        let users_participated_in_offer: Vec<String> = offer_users
            .iter()
            .filter(|offer_user| {
                offer_user.status == OfferStatus::Ongoing
                    || offer_user.status == OfferStatus::Finished
            })
            .filter(|offer_user| offer_user.user_id.as_str() != user_id)
            .map(|offer_user| offer_user.user_id.as_str().to_string())
            .collect();
        let offers: Vec<Offer> = self.offers_repo.get_offers_by_user(&user_id).await?;
        let users_participants_own_offers: Vec<String> = self
            .offer_user_repo
            .get_by_offer_ids(offers.iter().map(|offer| offer.id).collect())
            .await?
            .iter()
            .filter(|offer_user| {
                offer_user.status == OfferStatus::Ongoing
                    || offer_user.status == OfferStatus::Finished
            })
            .filter(|offer_user| offer_user.user_id.as_str() != user_id)
            .map(|offer_user| offer_user.user_id.as_str().to_string())
            .collect();

        let users_connected_via_offer: Vec<String> = users_participated_in_offer
            .into_iter()
            .chain(users_participants_own_offers)
            .collect();
        let user_connection_offer_atoms: Vec<UserConnectionAtom> = users_connected_via_offer
            .iter()
            .map(|user_id| UserConnectionAtom {
                user_id: user_id.clone(),
                reason: "Offer".to_string(),
            })
            .collect();

        let mut user_connection_atoms: Vec<UserConnectionAtom> = vec![];
        user_connection_atoms.extend(user_connection_fsp_atoms);
        user_connection_atoms.extend(user_connection_artist_atoms);
        user_connection_atoms.extend(user_connection_offer_atoms);

        let mut grouped_connections: std::collections::HashMap<String, Vec<String>> =
            std::collections::HashMap::new();
        for atom in user_connection_atoms {
            grouped_connections
                .entry(atom.user_id)
                .or_default()
                .push(atom.reason);
        }

        let deduplicated_connections: Vec<(String, Vec<String>)> =
            grouped_connections.into_iter().collect();

        let mut community = Vec::new();

        for (connected_user_id, reasons) in deduplicated_connections {
            if connected_user_id == user_id {
                continue;
            }
            let connected_user: User = self
                .users_repo
                .find_by_id(&connected_user_id)
                .await?
                .unwrap();
            let favorite: Option<Favorite> = self
                .favorites_repo
                .exists(&user_id, &connected_user_id)
                .await?;
            let favorite_id = favorite.map(|favorite| favorite.id);
            let short_note = if let Some(favorite_id) = favorite_id {
                self.short_notes_repo.get_by_id(favorite_id).await?
            } else {
                None
            };
            let last_logged_in: Option<String> = connected_user.last_login_at.map(|date| date.to_string());
            let connections: Vec<String> = reasons;
            let weight: i32 = connections.len() as i32;

            let user_connection = UserConnection {
                id: connected_user_id,
                name: connected_user.username,
                image_url: connected_user.img_url,
                category: connected_user.category,
                favorite_id,
                short_note: short_note.map(|short_note| short_note.comment),
                last_logged_in,
                connections,
                weight,
            };
            community.push(user_connection);
        }

        Ok(UserConnectionsOutput { community })
    }

    async fn get_other_user_community(
        &self,
        viewer_id: String,
        target_user_id: String,
    ) -> Result<UserConnectionsOutput, anyhow::Error> {
        // FSPの履歴を取得
        let fsp_history: Vec<TxsFsp> = self
            .txs_fsp_repo
            .get_by_user_id(&target_user_id, 100)
            .await?;
        let users_connected_via_fsp: Vec<String> = fsp_history
            .iter()
            .filter_map(|tx| {
                if tx.from == Some(target_user_id.clone()) {
                    Some(tx.to.clone())
                } else if tx.to == target_user_id {
                    tx.from.clone()
                } else {
                    None
                }
            })
            .collect();
        let user_connection_fsp_atoms: Vec<UserConnectionAtom> = users_connected_via_fsp
            .iter()
            .map(|user_id| UserConnectionAtom {
                user_id: user_id.clone(),
                reason: "FSP Transaction".to_string(),
            })
            .collect();

        // 所属するアーティストの対象ユーザー以外のユーザーを取得
        let user_artists: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_user_id(&target_user_id)
            .await?;
        let artist_belonged_to_user: Vec<&str> = user_artists
            .iter()
            .map(|user_artist| user_artist.artist_id.as_str())
            .collect();
        let users_connected_via_artist_models: Vec<UserArtist> = self
            .user_artist_repo
            .find_by_artist_ids(artist_belonged_to_user)
            .await?
            .into_iter()
            .filter(|user_artist| user_artist.user_id.as_str() != target_user_id)
            .collect();
        let users_connected_via_artist: Vec<String> = users_connected_via_artist_models
            .iter()
            .map(|user_artist| user_artist.user_id.as_str().to_string())
            .collect();
        let user_connection_artist_atoms: Vec<UserConnectionAtom> = users_connected_via_artist
            .iter()
            .map(|user_id| UserConnectionAtom {
                user_id: user_id.clone(),
                reason: "Artist".to_string(),
            })
            .collect();

        // オファー関連のユーザーを取得
        let offer_users: Vec<OfferUser> =
            self.offer_user_repo.get_by_user_id(&target_user_id).await?;
        let users_participated_in_offer: Vec<String> = offer_users
            .iter()
            .filter(|offer_user| {
                offer_user.status == OfferStatus::Ongoing
                    || offer_user.status == OfferStatus::Finished
            })
            .filter(|offer_user| offer_user.user_id.as_str() != target_user_id)
            .map(|offer_user| offer_user.user_id.as_str().to_string())
            .collect();
        let offers: Vec<Offer> = self.offers_repo.get_offers_by_user(&target_user_id).await?;
        let users_participants_own_offers: Vec<String> = self
            .offer_user_repo
            .get_by_offer_ids(offers.iter().map(|offer| offer.id).collect())
            .await?
            .iter()
            .filter(|offer_user| {
                offer_user.status == OfferStatus::Ongoing
                    || offer_user.status == OfferStatus::Finished
            })
            .filter(|offer_user| offer_user.user_id.as_str() != target_user_id)
            .map(|offer_user| offer_user.user_id.as_str().to_string())
            .collect();

        let users_connected_via_offer: Vec<String> = users_participated_in_offer
            .into_iter()
            .chain(users_participants_own_offers)
            .collect();
        let user_connection_offer_atoms: Vec<UserConnectionAtom> = users_connected_via_offer
            .iter()
            .map(|user_id| UserConnectionAtom {
                user_id: user_id.clone(),
                reason: "Offer".to_string(),
            })
            .collect();

        let mut user_connection_atoms: Vec<UserConnectionAtom> = vec![];
        user_connection_atoms.extend(user_connection_fsp_atoms);
        user_connection_atoms.extend(user_connection_artist_atoms);
        user_connection_atoms.extend(user_connection_offer_atoms);

        let mut grouped_connections: std::collections::HashMap<String, Vec<String>> =
            std::collections::HashMap::new();
        for atom in user_connection_atoms {
            grouped_connections
                .entry(atom.user_id)
                .or_default()
                .push(atom.reason);
        }

        let deduplicated_connections: Vec<(String, Vec<String>)> =
            grouped_connections.into_iter().collect();

        let mut community = Vec::new();

        for (connected_user_id, reasons) in deduplicated_connections {
            if connected_user_id == target_user_id {
                continue;
            }
            let connected_user: User = self
                .users_repo
                .find_by_id(&connected_user_id)
                .await?
                .unwrap();
            // お気に入りとショートノートは閲覧者(viewer)の視点から取得
            let favorite: Option<Favorite> = self
                .favorites_repo
                .exists(&viewer_id, &connected_user_id)
                .await?;
            let favorite_id = favorite.map(|favorite| favorite.id);
            let short_note = if let Some(favorite_id) = favorite_id {
                self.short_notes_repo.get_by_id(favorite_id).await?
            } else {
                None
            };
            let last_logged_in: Option<String> = connected_user.last_login_at.map(|date| date.to_string());
            let connections: Vec<String> = reasons;
            let weight: i32 = connections.len() as i32;

            let user_connection = UserConnection {
                id: connected_user_id,
                name: connected_user.username,
                image_url: connected_user.img_url,
                category: connected_user.category,
                favorite_id,
                short_note: short_note.map(|short_note| short_note.comment),
                last_logged_in,
                connections,
                weight,
            };
            community.push(user_connection);
        }

        Ok(UserConnectionsOutput { community })
    }
}
