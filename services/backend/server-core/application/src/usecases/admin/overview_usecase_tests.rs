use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, plays_monthly_mock::MockMockPlaysMonthlyRepo,
    track_credits_mock::MockMockTrackCreditsRepo, tracks_mock::MockMockTracksRepo,
    txs_fsp_mock::MockMockTxsFspRepo, user_mock::MockMockUsersRepo,
};
use crate::usecases::admin::overview_usecase::{OverviewUsecase, OverviewUsecaseTrait};
use chrono::Utc;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::track_credits::Model as TrackCredits;
use domain::entities::tracks::Model as Track;
use domain::entities::txs_fsp::Model as TxsFsp;
use domain::entities::users::Model as User;
use mockall::predicate::eq;
use std::sync::Arc;
use uuid::Uuid;

fn user(user_id: &str, username: &str, fsp: i32, fcm_token: Option<&str>) -> User {
    User {
        id: user_id.to_string(),
        email: format!("{user_id}@example.com"),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: fcm_token.map(str::to_string),
        username: username.to_string(),
        realname: username.to_string(),
        img_url: None,
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: None,
        fsp,
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

fn track_credit(id: i32, isrc: &str, commit_user: &str, email: &str) -> TrackCredits {
    TrackCredits {
        id,
        isrc: isrc.to_string(),
        commit_user: commit_user.to_string(),
        credit_role: "Composer".to_string(),
        credit_name: format!("Credit {id}"),
        credit_user: None,
        email: email.to_string(),
        is_invite: Some(false),
        memo: None,
        created_at: Utc::now().naive_utc(),
    }
}

fn track(isrc: &str, title: &str) -> Track {
    Track {
        isrc: isrc.to_string(),
        img_url: None,
        title: title.to_string(),
        artist_id: Some("artist-1".to_string()),
    }
}

fn tx(id: Uuid, from: Option<&str>, to: &str, amount: i32, notes: Option<&str>) -> TxsFsp {
    TxsFsp {
        id,
        from: from.map(str::to_string),
        to: to.to_string(),
        amount,
        tx_at: Utc::now().naive_utc(),
        notes: notes.map(str::to_string),
    }
}

#[tokio::test]
async fn test_get_system_overview_summarizes_users_artists_and_play_count() {
    let mut users_repo = MockMockUsersRepo::new();
    let mut artists_repo = MockMockArtistsRepo::new();
    let track_credits_repo = MockMockTrackCreditsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let txs_fsp_repo = MockMockTxsFspRepo::new();
    let mut plays_monthly_repo = MockMockPlaysMonthlyRepo::new();

    users_repo.expect_mock_count().times(1).returning(|| Ok(2));
    users_repo
        .expect_mock_sum_fsp()
        .times(1)
        .returning(|| Ok(30));
    users_repo
        .expect_mock_count_mobile_app_users()
        .times(1)
        .returning(|| Ok(1));
    artists_repo
        .expect_mock_count()
        .times(1)
        .returning(|| Ok(3));
    plays_monthly_repo
        .expect_mock_get_total_play_count_all()
        .times(1)
        .returning(|| Ok(9876));

    let usecase = OverviewUsecase::new(
        Arc::new(users_repo),
        Arc::new(artists_repo),
        Arc::new(track_credits_repo),
        Arc::new(tracks_repo),
        Arc::new(txs_fsp_repo),
        Arc::new(plays_monthly_repo),
    );

    let result = usecase.get_system_overview().await.unwrap();

    assert_eq!(result.total_users, 2);
    assert_eq!(result.total_artists, 3);
    assert_eq!(result.total_fsp, 30);
    assert_eq!(result.total_play_count, 9876);
    assert_eq!(result.mobile_app_users_count, 1);
}

#[tokio::test]
async fn test_get_all_credits_maps_related_user_and_track_data() {
    let mut users_repo = MockMockUsersRepo::new();
    let artists_repo = MockMockArtistsRepo::new();
    let mut track_credits_repo = MockMockTrackCreditsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let txs_fsp_repo = MockMockTxsFspRepo::new();
    let plays_monthly_repo = MockMockPlaysMonthlyRepo::new();

    track_credits_repo
        .expect_mock_all_credits()
        .with(eq(2))
        .times(1)
        .returning(|_| {
            Ok(vec![track_credit(
                1,
                "ISRC-1",
                "user-1",
                "credit@example.com",
            )])
        });
    users_repo
        .expect_mock_find_by_id()
        .with(eq("user-1".to_string()))
        .times(1)
        .returning(|_| Ok(Some(user("user-1", "Alice", 0, None))));
    tracks_repo
        .expect_mock_get_by_isrc()
        .with(eq("ISRC-1".to_string()))
        .times(1)
        .returning(|_| Ok(Some(track("ISRC-1", "Song Title"))));

    let usecase = OverviewUsecase::new(
        Arc::new(users_repo),
        Arc::new(artists_repo),
        Arc::new(track_credits_repo),
        Arc::new(tracks_repo),
        Arc::new(txs_fsp_repo),
        Arc::new(plays_monthly_repo),
    );

    let result = usecase.get_all_credits(2).await.unwrap();

    assert_eq!(result.len(), 1);
    assert_eq!(result[0].title, "Song Title");
    assert_eq!(result[0].user, "Alice");
    assert_eq!(result[0].email, "credit@example.com");
}

#[tokio::test]
async fn test_get_fsp_history_maps_usernames_and_skips_missing_sender() {
    let mut users_repo = MockMockUsersRepo::new();
    let artists_repo = MockMockArtistsRepo::new();
    let track_credits_repo = MockMockTrackCreditsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let mut txs_fsp_repo = MockMockTxsFspRepo::new();
    let plays_monthly_repo = MockMockPlaysMonthlyRepo::new();

    let tx1 = tx(Uuid::new_v4(), Some("user-1"), "user-2", 50, Some("thanks"));
    let tx2 = tx(Uuid::new_v4(), None, "user-2", 30, None);

    txs_fsp_repo
        .expect_mock_find_all()
        .times(1)
        .returning(move || Ok(vec![tx1.clone(), tx2.clone()]));
    users_repo
        .expect_mock_find_by_id()
        .times(2)
        .returning(|id| match id.as_str() {
            "user-1" => Ok(Some(user("user-1", "Alice", 0, None))),
            "user-2" => Ok(Some(user("user-2", "Bob", 0, None))),
            _ => Ok(None),
        });

    let usecase = OverviewUsecase::new(
        Arc::new(users_repo),
        Arc::new(artists_repo),
        Arc::new(track_credits_repo),
        Arc::new(tracks_repo),
        Arc::new(txs_fsp_repo),
        Arc::new(plays_monthly_repo),
    );

    let result = usecase.get_fsp_history(10).await.unwrap();

    assert_eq!(result.len(), 1);
    assert_eq!(result[0].from, "Alice");
    assert_eq!(result[0].to, "Bob");
    assert_eq!(result[0].amount, 50);
    assert_eq!(result[0].notes.as_deref(), Some("thanks"));
}
