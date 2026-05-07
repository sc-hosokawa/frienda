use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, offer_mock::MockMockOffersRepo,
    offer_user_mock::MockMockOfferUserRepo, shortnote_mock::MockMockShortNotesRepo,
    user_artist_mock::MockMockUserArtistRepo, user_mock::MockMockUsersRepo,
};
use crate::usecases::community::user_profile_usecase::{
    GetUserProfileUsecase, GetUserProfileUsecaseTrait,
};
use chrono::Utc;
use domain::entities::artists::Model as Artist;
use domain::entities::offer_user::Model as OfferUser;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, OfferStatus, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::short_notes::Model as ShortNote;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use std::sync::Arc;
use uuid::Uuid;

fn user(id: &str) -> User {
    User {
        id: id.to_string(),
        id_token: None,
        fcm_token: None,
        username: "Profile User".to_string(),
        realname: "Profile User".to_string(),
        email: "profile@example.com".to_string(),
        img_url: Some("avatar.png".to_string()),
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Creator,
        primary_category: UserCategory::Creator,
        is_superadmin: Some(false),
        publicity: true,
        greeting: Some("hi".to_string()),
        skill: Some("mixing".to_string()),
        x_handle: Some("@profile".to_string()),
        instagram_handle: None,
        fb_handle: None,
        interest_offer: Some(OfferCategory::Creation),
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: Some(Utc::now().naive_utc()),
    }
}

fn offer(id: i32, owner: &str, status_order: i64) -> Offer {
    Offer {
        id,
        raid_id: None,
        owner: owner.to_string(),
        title: format!("Offer {id}"),
        description: format!("Desc {id}"),
        deadline: None,
        place: "Tokyo".to_string(),
        attention: None,
        required_skill: None,
        target_role: Some(UserCategory::Creator),
        img_url: None,
        publicity: true,
        category: Some(OfferCategory::Creation),
        fee: 1000,
        created_at: Utc::now().naive_utc() + chrono::Duration::seconds(status_order),
        updated_at: Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_get_user_profile_combines_recent_owned_and_participated_offers() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();
    let mut offers_repo = MockMockOffersRepo::new();
    let mut offer_user_repo = MockMockOfferUserRepo::new();
    let mut short_notes_repo = MockMockShortNotesRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|_| Ok(Some(user("user-1"))));

    user_artist_repo
        .expect_mock_find_by_user_id()
        .times(1)
        .returning(|_| {
            Ok(vec![UserArtist {
                id: 1,
                user_id: "user-1".to_string(),
                artist_id: "artist-1".to_string(),
                is_admin: true,
                status: UserArtistStatus::Accept,
                request_message: None,
                is_default: false,
            }])
        });

    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|_| {
            Ok(vec![Artist {
                id: Uuid::new_v4(),
                artist_id: "artist-1".to_string(),
                display_name_jp: "Artist One".to_string(),
                display_name_en: "Artist One".to_string(),
                display_name_kana: None,
                img_url: None,
                fsp: 0,
                status: ArtistStatus::Visible,
                since: None,
                universal_id: None,
                apple_key: None,
                spotify_key: None,
                line_key: None,
                amazon_key: None,
                youtube_key: None,
            }])
        });

    offers_repo
        .expect_mock_get_offers_by_user()
        .times(1)
        .returning(|_| Ok(vec![offer(1, "user-1", 1), offer(2, "user-1", 2)]));

    offer_user_repo
        .expect_mock_get_by_user_id()
        .times(1)
        .returning(|_| {
            Ok(vec![
                OfferUser {
                    id: 1,
                    offer_id: 3,
                    user_id: "user-1".to_string(),
                    status: OfferStatus::Applied,
                },
                OfferUser {
                    id: 2,
                    offer_id: 4,
                    user_id: "user-1".to_string(),
                    status: OfferStatus::Rejected,
                },
            ])
        });

    offers_repo
        .expect_mock_get_by_id()
        .times(1)
        .returning(|id| {
            assert_eq!(id, 3);
            Ok(Some(offer(3, "owner-2", 3)))
        });

    short_notes_repo
        .expect_mock_get_by_writer_and_to_user()
        .times(1)
        .returning(|writer, to_user| {
            assert_eq!(writer, "viewer-1");
            assert_eq!(to_user, "user-1");
            Ok(Some(ShortNote {
                id: Uuid::new_v4(),
                writer: writer.to_string(),
                to_user: to_user.to_string(),
                comment: "great collaborator".to_string(),
                created_at: Utc::now().naive_utc(),
            }))
        });

    let usecase = GetUserProfileUsecase::new(
        Arc::new(users_repo),
        Arc::new(user_artist_repo),
        Arc::new(artists_repo),
        Arc::new(offers_repo),
        Arc::new(offer_user_repo),
        Arc::new(short_notes_repo),
    );

    let result = usecase
        .get_user_profile("viewer-1".to_string(), "user-1".to_string())
        .await
        .expect("profile succeeds");

    assert_eq!(result.name, "Profile User");
    assert_eq!(result.belongs_to_artists, vec!["Artist One".to_string()]);
    assert_eq!(result.short_note.as_deref(), Some("great collaborator"));
    assert_eq!(result.offers.len(), 3);
    assert_eq!(result.offers[0].id, 3);
    assert_eq!(result.offers[1].id, 2);
    assert_eq!(result.offers[2].id, 1);
}
