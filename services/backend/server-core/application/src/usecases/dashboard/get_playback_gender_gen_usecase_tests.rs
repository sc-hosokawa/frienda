use crate::test_support::mocks::{
    gender_gen_playback_mock::MockMockGenderGenPlaybackRepo,
    product_track_mock::MockMockProductTrackRepo, products_mock::MockMockProductsRepo,
};
use crate::usecases::dashboard::get_playback_gender_gen_usecase::{
    GetPlaybackGenderGenUsecase, GetPlaybackGenderGenUsecaseInput, GetPlaybackGenderGenUsecaseTrait,
};
use chrono::NaiveDate;
use domain::entities::gender_gen_playback::Model as GenderGenPlayback;
use domain::entities::product_track::Model as ProductTrack;
use domain::entities::products::Model as Product;
use mockall::predicate::eq;
use std::sync::Arc;

fn playback(
    id: i32,
    isrc: &str,
    gender: Option<&str>,
    age: Option<&str>,
    play_count: i32,
) -> GenderGenPlayback {
    GenderGenPlayback {
        id,
        isrc: isrc.to_string(),
        date: NaiveDate::from_ymd_opt(2025, 1, 1).unwrap(),
        gender: gender.map(str::to_string),
        age: age.map(str::to_string),
        play_count,
    }
}

#[tokio::test]
async fn test_get_playback_gender_gen_uses_upc_path_and_computes_percentages() {
    // UPC と ISRC が同時指定された場合は、リリース単位の UI 表示を優先して UPC path を使う仕様を固定する。
    let mut gender_repo = MockMockGenderGenPlaybackRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let mut products_repo = MockMockProductsRepo::new();

    product_track_repo
        .expect_mock_get_by_upc()
        .with(eq("UPC1".to_string()))
        .times(1)
        .returning(|_| {
            Ok(vec![
                ProductTrack {
                    id: 1,
                    upc: "UPC1".to_string(),
                    isrc: "ISRC1".to_string(),
                    track_no: Some(1),
                },
                ProductTrack {
                    id: 2,
                    upc: "UPC1".to_string(),
                    isrc: "ISRC2".to_string(),
                    track_no: Some(2),
                },
            ])
        });
    gender_repo
        .expect_mock_find_by_isrcs()
        .with(eq(vec!["ISRC1".to_string(), "ISRC2".to_string()]))
        .times(1)
        .returning(|_| {
            Ok(vec![
                playback(1, "ISRC1", Some("male"), Some("0-17"), 10),
                playback(2, "ISRC1", Some("female"), Some("18-22"), 30),
                playback(3, "ISRC2", None, Some("unknown"), 10),
            ])
        });
    products_repo.expect_mock_find_by_artist_id().times(0);

    let usecase = GetPlaybackGenderGenUsecase::new(
        Arc::new(gender_repo),
        Arc::new(product_track_repo),
        Arc::new(products_repo),
    );

    let result = usecase
        .get_playback_gender_gen(GetPlaybackGenderGenUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            isrc: Some("IGNORED".to_string()),
            upc: Some("UPC1".to_string()),
        })
        .await
        .unwrap();

    assert_eq!(result.gender_rate.male_count, 20);
    assert_eq!(result.gender_rate.female_count, 60);
    assert_eq!(result.gender_rate.unknown_count, 20);
    assert_eq!(result.gen_rate.under_17, 20);
    assert_eq!(result.gen_rate._18_22, 60);
    assert_eq!(result.gen_rate.unknown, 20);
}

#[tokio::test]
async fn test_get_playback_gender_gen_uses_artist_products_when_upc_and_isrc_are_missing() {
    // artist 全体表示では product -> product_track から対象 ISRC を解決し、空データは全て 0% にする。
    let mut gender_repo = MockMockGenderGenPlaybackRepo::new();
    let mut product_track_repo = MockMockProductTrackRepo::new();
    let mut products_repo = MockMockProductsRepo::new();

    products_repo
        .expect_mock_find_by_artist_id()
        .with(eq("artist-1".to_string()))
        .times(1)
        .returning(|_| {
            Ok(vec![Product {
                upc: "UPC1".to_string(),
                title: "Album".to_string(),
                img_url: None,
                r#type: Some("album".to_string()),
                distributed_at: None,
                artist_id: Some("artist-1".to_string()),
            }])
        });
    product_track_repo
        .expect_mock_get_by_upcs()
        .with(eq(vec!["UPC1".to_string()]))
        .times(1)
        .returning(|_| Ok(vec![]));
    gender_repo
        .expect_mock_find_by_isrcs()
        .with(eq(Vec::<String>::new()))
        .times(1)
        .returning(|_| Ok(vec![]));

    let usecase = GetPlaybackGenderGenUsecase::new(
        Arc::new(gender_repo),
        Arc::new(product_track_repo),
        Arc::new(products_repo),
    );

    let result = usecase
        .get_playback_gender_gen(GetPlaybackGenderGenUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            isrc: None,
            upc: None,
        })
        .await
        .unwrap();

    assert_eq!(result.gender_rate.male_count, 0);
    assert_eq!(result.gender_rate.female_count, 0);
    assert_eq!(result.gen_rate.under_17, 0);
    assert_eq!(result.gen_rate.unknown, 0);
}

#[tokio::test]
async fn test_get_playback_gender_gen_isrc_path_ignores_products_and_handles_unknowns() {
    // ISRC 単体表示は product 系 repo に依存せず、負数を除外しつつ NULL gender/age を unknown として扱う。
    let mut gender_repo = MockMockGenderGenPlaybackRepo::new();
    let product_track_repo = MockMockProductTrackRepo::new();
    let products_repo = MockMockProductsRepo::new();

    gender_repo
        .expect_mock_find_by_isrcs()
        .with(eq(vec!["ISRC1".to_string()]))
        .times(1)
        .returning(|_| {
            Ok(vec![
                playback(1, "ISRC1", Some("male"), Some("0-17"), 10),
                playback(2, "ISRC1", None, None, 30),
                playback(3, "ISRC1", Some("female"), Some("18-22"), -999),
            ])
        });

    let usecase = GetPlaybackGenderGenUsecase::new(
        Arc::new(gender_repo),
        Arc::new(product_track_repo),
        Arc::new(products_repo),
    );

    let result = usecase
        .get_playback_gender_gen(GetPlaybackGenderGenUsecaseInput {
            artist_id: "artist-1".to_string(),
            user_id: "user-1".to_string(),
            isrc: Some("ISRC1".to_string()),
            upc: None,
        })
        .await
        .unwrap();

    assert_eq!(result.gender_rate.male_count, 25);
    assert_eq!(result.gender_rate.unknown_count, 75);
    assert_eq!(result.gender_rate.female_count, 0);
    assert_eq!(result.gen_rate.under_17, 25);
    assert_eq!(result.gen_rate.unknown, 75);
    assert_eq!(result.gen_rate._18_22, 0);
}
