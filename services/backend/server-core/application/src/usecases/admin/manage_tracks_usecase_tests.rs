use crate::test_support::mocks::{
    artist_mock::MockMockArtistsRepo, plays_daily_mock::MockMockPlaysDailyRepo,
    plays_monthly_mock::MockMockPlaysMonthlyRepo, plays_yearly_mock::MockMockPlaysYearlyRepo,
    product_track_mock::MockMockProductTrackRepo, products_mock::MockMockProductsRepo,
    track_credits_mock::MockMockTrackCreditsRepo, tracks_mock::MockMockTracksRepo,
};
use crate::usecases::admin::manage_tracks_usecase::{
    ManageTracksUsecase, ManageTracksUsecaseTrait, RegisterReleasesInput, Release,
};
use chrono::NaiveDate;
use domain::entities::artists::Model as Artist;
use domain::entities::sea_orm_active_enums::ArtistStatus;
use sea_orm::{ActiveValue, InsertResult};
use std::sync::Arc;
use uuid::Uuid;

fn artist(artist_id: &str, fsp: i32) -> Artist {
    Artist {
        id: Uuid::new_v4(),
        artist_id: artist_id.to_string(),
        display_name_jp: "Artist".to_string(),
        display_name_en: "Artist".to_string(),
        display_name_kana: None,
        img_url: None,
        fsp,
        status: ArtistStatus::Visible,
        since: None,
        universal_id: None,
        apple_key: None,
        spotify_key: None,
        line_key: None,
        amazon_key: None,
        youtube_key: None,
    }
}

fn usecase(
    artists_repo: MockMockArtistsRepo,
    tracks_repo: MockMockTracksRepo,
    products_repo: MockMockProductsRepo,
    product_track_repo: MockMockProductTrackRepo,
) -> ManageTracksUsecase {
    ManageTracksUsecase::new(
        Arc::new(tracks_repo),
        Arc::new(products_repo),
        Arc::new(artists_repo),
        Arc::new(product_track_repo),
        Arc::new(MockMockTrackCreditsRepo::new()),
        Arc::new(MockMockPlaysDailyRepo::new()),
        Arc::new(MockMockPlaysMonthlyRepo::new()),
        Arc::new(MockMockPlaysYearlyRepo::new()),
    )
}

#[tokio::test]
async fn test_register_releases_deduplicates_products_and_updates_artist_fsp() {
    let mut artists_repo = MockMockArtistsRepo::new();
    let mut tracks_repo = MockMockTracksRepo::new();
    let mut products_repo = MockMockProductsRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();

    product_track_repo
        .expect_mock_get_max_id()
        .times(1)
        .returning(|| Ok(Some(7)));

    products_repo
        .expect_mock_create_many()
        .times(1)
        .returning(|products| {
            assert_eq!(products.len(), 1);
            assert!(matches!(
                products[0].upc,
                ActiveValue::Set(ref value) if value == "UPC1"
            ));
            assert!(matches!(
                products[0].distributed_at,
                ActiveValue::Set(Some(value)) if value == NaiveDate::from_ymd_opt(2024, 5, 1).unwrap()
            ));
            Ok(true)
        });

    tracks_repo
        .expect_mock_create_many()
        .times(1)
        .returning(|tracks| {
            assert_eq!(tracks.len(), 2);
            Ok(true)
        });

    product_track_repo
        .expect_mock_create_many()
        .times(1)
        .returning(|product_tracks| {
            assert_eq!(product_tracks.len(), 2);
            assert!(matches!(product_tracks[0].id, ActiveValue::Set(8)));
            assert!(matches!(product_tracks[1].id, ActiveValue::Set(9)));
            Ok(InsertResult { last_insert_id: 9 })
        });

    artists_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(artist(&id, 15))));

    artists_repo
        .expect_mock_update()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.fsp,
                ActiveValue::Set(value) if value == 35
            ));
            Ok(artist("artist-1", 35))
        });

    let usecase = usecase(artists_repo, tracks_repo, products_repo, product_track_repo);

    let result = usecase
        .register_releases(RegisterReleasesInput {
            releases: vec![
                Release {
                    upc: "UPC1".to_string(),
                    format: "single".to_string(),
                    track_count: 2,
                    title: "Release".to_string(),
                    release_date: "2024/05/01".to_string(),
                    isrc: "ISRC1".to_string(),
                    track_no: 1,
                    track_title: "Track 1".to_string(),
                    track_title_version: "".to_string(),
                    artist_id: "artist-1".to_string(),
                    image_url: Some("cover.png".to_string()),
                },
                Release {
                    upc: "UPC1".to_string(),
                    format: "single".to_string(),
                    track_count: 2,
                    title: "Release".to_string(),
                    release_date: "2024/05/01".to_string(),
                    isrc: "ISRC2".to_string(),
                    track_no: 2,
                    track_title: "Track 2".to_string(),
                    track_title_version: "".to_string(),
                    artist_id: "artist-1".to_string(),
                    image_url: Some("cover.png".to_string()),
                },
            ],
        })
        .await
        .expect("register releases succeeds");

    assert!(result);
}

#[tokio::test]
async fn test_increase_artists_fsp_caps_bonus_at_one_hundred() {
    let mut artists_repo = MockMockArtistsRepo::new();
    let tracks_repo = MockMockTracksRepo::new();
    let products_repo = MockMockProductsRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();

    artists_repo
        .expect_mock_find_by_id()
        .times(1)
        .returning(|id| Ok(Some(artist(&id, 50))));

    artists_repo
        .expect_mock_update()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.fsp,
                ActiveValue::Set(value) if value == 150
            ));
            Ok(artist("artist-1", 150))
        });

    let usecase = usecase(artists_repo, tracks_repo, products_repo, product_track_repo);

    usecase
        ._increase_artists_fsp(vec!["artist-1".to_string(); 11])
        .await
        .expect("bonus update succeeds");
}
