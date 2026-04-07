use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, llm_service_mock::MockMockLlmService,
    offer_mock::MockMockOffersRepo, plays_daily_mock::MockMockPlaysDailyRepo,
    plays_monthly_mock::MockMockPlaysMonthlyRepo, product_track_mock::MockMockProductTrackRepo,
    products_mock::MockMockProductsRepo, tracks_mock::MockMockTracksRepo,
    user_artist_mock::MockMockUserArtistRepo, user_mock::MockMockUsersRepo,
};
use crate::usecases::messaging::request_llm_usecase::{
    RequestLlmInput, RequestLlmUsecase, RequestLlmUsecaseTrait,
};
use chrono::{NaiveDate, Utc};
use domain::entities::artists::Model as Artist;
use domain::entities::offers::Model as Offer;
use domain::entities::plays_daily::Model as PlaysDaily;
use domain::entities::plays_monthly::Model as PlaysMonthly;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use domain::entities::sea_orm_active_enums::{
    ArtistStatus, OfferCategory, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::tracks::Model as Track;
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use domain::services::llm::Answer;
use std::sync::Arc;
use uuid::Uuid;

fn user(id: &str) -> User {
    User {
        id: id.to_string(),
        id_token: None,
        fcm_token: None,
        username: "Listener".to_string(),
        realname: "Listener".to_string(),
        email: "listener@example.com".to_string(),
        img_url: None,
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
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: None,
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: None,
    }
}

#[tokio::test]
async fn test_request_llm_formats_context_and_returns_answer() {
    let mut llm_service = MockMockLlmService::new();
    let mut users_repo = MockMockUsersRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut offers_repo = MockMockOffersRepo::new();
    let mut plays_daily_repo = MockMockPlaysDailyRepo::new();
    let mut plays_monthly_repo = MockMockPlaysMonthlyRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();

    users_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(user(&id))));

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
            }])
        });

    artists_repo
        .expect_mock_find_by_ids()
        .times(1)
        .returning(|ids| {
            assert_eq!(ids, vec!["artist-1".to_string()]);
            Ok(vec![Artist {
                id: Uuid::new_v4(),
                artist_id: "artist-1".to_string(),
                display_name_jp: "The Artist".to_string(),
                display_name_en: "The Artist".to_string(),
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
        .expect_mock_get_active_offers()
        .times(1)
        .returning(|| {
            Ok(vec![
                Offer {
                    id: 1,
                    raid_id: None,
                    owner: "other-user".to_string(),
                    title: "Mixing Help".to_string(),
                    description: "Need an engineer".to_string(),
                    deadline: None,
                    place: "Tokyo".to_string(),
                    attention: None,
                    required_skill: None,
                    target_role: Some(UserCategory::Creator),
                    img_url: None,
                    publicity: true,
                    category: Some(OfferCategory::Creation),
                    fee: 5000,
                    created_at: Utc::now().naive_utc(),
                    updated_at: Utc::now().naive_utc(),
                },
                Offer {
                    id: 2,
                    raid_id: None,
                    owner: "user-1".to_string(),
                    title: "Own offer".to_string(),
                    description: "Should be filtered".to_string(),
                    deadline: None,
                    place: "Osaka".to_string(),
                    attention: None,
                    required_skill: None,
                    target_role: Some(UserCategory::Creator),
                    img_url: None,
                    publicity: true,
                    category: Some(OfferCategory::Creation),
                    fee: 1000,
                    created_at: Utc::now().naive_utc(),
                    updated_at: Utc::now().naive_utc(),
                },
            ])
        });

    products_repo
        .expect_mock_find_by_artist_id()
        .times(1)
        .returning(|_| {
            Ok(vec![Product {
                upc: "UPC1".to_string(),
                title: "Release One".to_string(),
                img_url: None,
                r#type: Some("single".to_string()),
                distributed_at: Some(NaiveDate::from_ymd_opt(2024, 1, 1).unwrap()),
                artist_id: Some("artist-1".to_string()),
            }])
        });

    product_track_repo
        .expect_mock_get_by_upcs()
        .times(1)
        .returning(|upcs| {
            assert_eq!(upcs, vec!["UPC1".to_string()]);
            Ok(vec![ProductTrack {
                id: 1,
                upc: "UPC1".to_string(),
                isrc: "ISRC1".to_string(),
                track_no: Some(1),
            }])
        });

    tracks_repo
        .expect_mock_get_by_isrcs()
        .times(1)
        .returning(|isrcs| {
            assert_eq!(isrcs, vec!["ISRC1".to_string()]);
            Ok(vec![Track {
                isrc: "ISRC1".to_string(),
                img_url: None,
                title: "First Track".to_string(),
                artist_id: Some("artist-1".to_string()),
            }])
        });

    plays_daily_repo
        .expect_mock_find_by_isrc_and_period()
        .times(1)
        .returning(|isrc, period| {
            assert_eq!(isrc, "ISRC1");
            assert_eq!(period, 7);
            Ok(vec![PlaysDaily {
                id: 1,
                isrc: Some("ISRC1".to_string()),
                date: Some(NaiveDate::from_ymd_opt(2024, 6, 1).unwrap()),
                spotify: 10,
                apple: 5,
                line: 3,
                amazon: Some(0),
                youtube: Some(0),
                sum: Some(18),
            }])
        });

    plays_monthly_repo
        .expect_mock_find_by_isrc_and_period()
        .times(1)
        .returning(|isrc, period| {
            assert_eq!(isrc, "ISRC1");
            assert_eq!(period, 6);
            Ok(vec![PlaysMonthly {
                id: 1,
                isrc: Some("ISRC1".to_string()),
                month: Some(NaiveDate::from_ymd_opt(2024, 5, 1).unwrap()),
                spotify: 100,
                apple: 20,
                line: 10,
                amazon: 5,
                youtube: 15,
                sum: Some(150),
            }])
        });

    llm_service
        .expect_mock_ask_question()
        .times(1)
        .returning(|question| {
            assert!(question.text.contains("The Artist"));
            assert!(question.text.contains("Mixing Help"));
            assert!(question.text.contains("First Track"));
            assert!(question.text.contains("2024-05月:150回"));
            Ok(Answer {
                text: "answer".to_string(),
            })
        });

    let usecase = RequestLlmUsecase::new(
        Arc::new(llm_service),
        Arc::new(users_repo),
        Arc::new(artists_repo),
        Arc::new(user_artist_repo),
        Arc::new(offers_repo),
        Arc::new(plays_daily_repo),
        Arc::new(plays_monthly_repo),
        Arc::new(products_repo),
        Arc::new(product_track_repo),
        Arc::new(tracks_repo),
    );

    let result = usecase
        .request_llm(RequestLlmInput {
            user_id: "user-1".to_string(),
            question: "何を優先すべき？".to_string(),
        })
        .await
        .expect("llm request succeeds");

    assert_eq!(result.answer, "answer");
}
