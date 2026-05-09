use crate::test_support::mocks::{
    favorites_mock::MockMockFavoritesRepo, offer_mock::MockMockOffersRepo,
    offer_user_mock::MockMockOfferUserRepo, shortnote_mock::MockMockShortNotesRepo,
    track_credits_mock::MockMockTrackCreditsRepo, txs_fsp_mock::MockMockTxsFspRepo,
    user_artist_mock::MockMockUserArtistRepo, user_mock::MockMockUsersRepo,
};
use crate::usecases::community::get_user_connections_usecase::{
    GetUserConnectionsUsecase, GetUserConnectionsUsecaseTrait,
};
use chrono::Utc;
use domain::entities::favorites::Model as Favorite;
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{
    OfferCategory, OfferStatus, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::short_notes::Model as ShortNote;
use domain::entities::txs_fsp::Model as TxsFsp;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use mockall::predicate::eq;
use std::sync::Arc;
use uuid::Uuid;

fn user(user_id: &str, username: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("{user_id}@example.com"),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: None,
        username: username.to_string(),
        realname: username.to_string(),
        img_url: Some(format!("https://cdn.example.com/{user_id}.png")),
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: Some(OfferCategory::Creation),
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: Some(Utc::now().naive_utc()),
    }
}

fn tx(from: Option<&str>, to: &str, amount: i32) -> TxsFsp {
    TxsFsp {
        id: Uuid::new_v4(),
        from: from.map(str::to_string),
        to: to.to_string(),
        amount,
        tx_at: Utc::now().naive_utc(),
        notes: None,
    }
}

fn user_artist(user_id: &str, artist_id: &str) -> UserArtist {
    UserArtist {
        id: 1,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin: false,
        status: UserArtistStatus::Check,
        request_message: None,
        is_default: false,
        requested_at: None,
    }
}

fn offer(id: i32, owner: &str) -> Offer {
    Offer {
        id,
        raid_id: None,
        owner: owner.to_string(),
        title: format!("Offer {id}"),
        description: "desc".to_string(),
        deadline: None,
        place: "Tokyo".to_string(),
        attention: None,
        required_skill: None,
        target_role: Some(UserCategory::Musician),
        img_url: None,
        publicity: true,
        category: Some(OfferCategory::Creation),
        fee: 100,
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
    }
}

fn offer_user(offer_id: i32, user_id: &str, status: OfferStatus) -> OfferUser {
    OfferUser {
        id: offer_id,
        offer_id,
        user_id: user_id.to_string(),
        status,
    }
}

fn favorite(source_user: &str, target_user: &str) -> Favorite {
    Favorite {
        id: Uuid::new_v4(),
        user_id: target_user.to_string(),
        liked_by: source_user.to_string(),
        created_at: Utc::now().naive_utc(),
    }
}

fn short_note(writer: &str, to_user: &str, comment: &str) -> ShortNote {
    ShortNote {
        id: Uuid::new_v4(),
        writer: writer.to_string(),
        to_user: to_user.to_string(),
        comment: comment.to_string(),
        created_at: Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_get_own_community_aggregates_reasons_and_sorts_connections() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut offer_user_repo = MockMockOfferUserRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let track_credits_repo = MockMockTrackCreditsRepo::new();
    let mut favorites_repo = MockMockFavoritesRepo::new();
    let mut short_notes_repo = MockMockShortNotesRepo::new();
    let mut offers_repo = MockMockOffersRepo::new();

    txs_fsp_repo
        .expect_mock_get_by_user_id()
        .with(eq("owner".to_string()), eq(100))
        .times(1)
        .returning(|_, _| Ok(vec![tx(Some("friend-b"), "owner", 1)]));
    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq("owner".to_string()))
        .times(1)
        .returning(|_| Ok(vec![user_artist("owner", "artist-1")]));
    user_artist_repo
        .expect_mock_find_by_artist_ids()
        .with(eq(vec!["artist-1".to_string()]))
        .times(1)
        .returning(|_| {
            Ok(vec![
                user_artist("owner", "artist-1"),
                user_artist("friend-a", "artist-1"),
            ])
        });
    offer_user_repo
        .expect_mock_get_by_user_id()
        .with(eq("owner".to_string()))
        .times(1)
        .returning(|_| Ok(vec![]));
    offers_repo
        .expect_mock_get_offers_by_user()
        .with(eq("owner".to_string()))
        .times(1)
        .returning(|_| Ok(vec![offer(10, "owner")]));
    offer_user_repo
        .expect_mock_get_by_offer_ids()
        .with(eq(vec![10]))
        .times(1)
        .returning(|_| {
            Ok(vec![
                offer_user(10, "owner", OfferStatus::Ongoing),
                offer_user(10, "friend-a", OfferStatus::Finished),
            ])
        });
    users_repo
        .expect_mock_find_by_id()
        .times(2)
        .returning(|id| match id.as_str() {
            "friend-a" => Ok(Some(user("friend-a", "Alice"))),
            "friend-b" => Ok(Some(user("friend-b", "Bob"))),
            _ => Ok(None),
        });
    favorites_repo
        .expect_mock_exists()
        .times(2)
        .returning(|source, target| match (source, target) {
            ("owner", "friend-a") => Ok(Some(favorite("owner", "friend-a"))),
            ("owner", "friend-b") => Ok(None),
            _ => Ok(None),
        });
    short_notes_repo
        .expect_mock_get_by_writer_and_to_user()
        .times(2)
        .returning(|writer, to_user| match (writer, to_user) {
            ("owner", "friend-a") => Ok(Some(short_note("owner", "friend-a", "great partner"))),
            ("owner", "friend-b") => Ok(None),
            _ => Ok(None),
        });

    let usecase = GetUserConnectionsUsecase::new(
        Arc::new(users_repo),
        Arc::new(txs_fsp_repo),
        Arc::new(offer_user_repo),
        Arc::new(user_artist_repo),
        Arc::new(track_credits_repo),
        Arc::new(favorites_repo),
        Arc::new(short_notes_repo),
        Arc::new(offers_repo),
    );

    let result = usecase
        .get_own_community("owner".to_string())
        .await
        .unwrap();

    assert_eq!(result.community.len(), 2);
    assert_eq!(result.community[0].id, "friend-a");
    assert_eq!(result.community[0].connections.len(), 2);
    assert!(result.community[0]
        .connections
        .contains(&"Artist".to_string()));
    assert!(result.community[0]
        .connections
        .contains(&"Offer".to_string()));
    assert_eq!(result.community[0].weight, 2);
    assert_eq!(
        result.community[0].short_note.as_deref(),
        Some("great partner")
    );
    assert!(result.community[0].favorite_id.is_some());
    assert_eq!(result.community[1].id, "friend-b");
    assert_eq!(
        result.community[1].connections,
        vec!["FSP Transaction".to_string()]
    );
}

#[tokio::test]
async fn test_get_other_user_community_uses_viewer_context_for_favorites_and_notes() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut offer_user_repo = MockMockOfferUserRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let track_credits_repo = MockMockTrackCreditsRepo::new();
    let mut favorites_repo = MockMockFavoritesRepo::new();
    let mut short_notes_repo = MockMockShortNotesRepo::new();
    let mut offers_repo = MockMockOffersRepo::new();

    txs_fsp_repo
        .expect_mock_get_by_user_id()
        .with(eq("target".to_string()), eq(100))
        .times(1)
        .returning(|_, _| Ok(vec![tx(Some("friend-c"), "target", 1)]));
    user_artist_repo
        .expect_mock_find_by_user_id()
        .with(eq("target".to_string()))
        .times(1)
        .returning(|_| Ok(vec![]));
    user_artist_repo
        .expect_mock_find_by_artist_ids()
        .with(eq(Vec::<String>::new()))
        .times(1)
        .returning(|_| Ok(vec![]));
    offer_user_repo
        .expect_mock_get_by_user_id()
        .with(eq("target".to_string()))
        .times(1)
        .returning(|_| Ok(vec![]));
    offers_repo
        .expect_mock_get_offers_by_user()
        .with(eq("target".to_string()))
        .times(1)
        .returning(|_| Ok(vec![]));
    offer_user_repo
        .expect_mock_get_by_offer_ids()
        .with(eq(Vec::<i32>::new()))
        .times(1)
        .returning(|_| Ok(vec![]));
    users_repo
        .expect_mock_find_by_id()
        .with(eq("friend-c".to_string()))
        .times(1)
        .returning(|_| Ok(Some(user("friend-c", "Carol"))));
    favorites_repo
        .expect_mock_exists()
        .with(eq("viewer".to_string()), eq("friend-c".to_string()))
        .times(1)
        .returning(|_, _| Ok(Some(favorite("viewer", "friend-c"))));
    short_notes_repo
        .expect_mock_get_by_writer_and_to_user()
        .with(eq("viewer"), eq("friend-c"))
        .times(1)
        .returning(|_, _| Ok(Some(short_note("viewer", "friend-c", "viewer memo"))));

    let usecase = GetUserConnectionsUsecase::new(
        Arc::new(users_repo),
        Arc::new(txs_fsp_repo),
        Arc::new(offer_user_repo),
        Arc::new(user_artist_repo),
        Arc::new(track_credits_repo),
        Arc::new(favorites_repo),
        Arc::new(short_notes_repo),
        Arc::new(offers_repo),
    );

    let result = usecase
        .get_other_user_community("viewer".to_string(), "target".to_string())
        .await
        .unwrap();

    assert_eq!(result.community.len(), 1);
    assert_eq!(result.community[0].id, "friend-c");
    assert!(result.community[0].favorite_id.is_some());
    assert_eq!(
        result.community[0].short_note.as_deref(),
        Some("viewer memo")
    );
    assert_eq!(
        result.community[0].connections,
        vec!["FSP Transaction".to_string()]
    );
}
