use crate::test_support::mocks::track_credits_mock::{
    MockMockTrackCreditsRepo, MockTrackCreditsRepo,
};
use domain::entities::track_credits::{
    ActiveModel as TrackCreditsActiveModel, Model as TrackCredits,
};
use mockall::predicate::*;
use sea_orm::ActiveValue;

fn create_test_track_credits(isrc: &str) -> TrackCredits {
    TrackCredits {
        id: 1,
        isrc: isrc.to_string(),
        commit_user: "test_user".to_string(),
        credit_role: "test_role".to_string(),
        credit_name: "test_name".to_string(),
        credit_user: Some("test_user".to_string()),
        email: "test@example.com".to_string(),
        is_invite: Some(false),
        memo: Some("test_memo".to_string()),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_create_track_credits() {
    let mut mock_repo = MockMockTrackCreditsRepo::new();

    let track_credits = TrackCreditsActiveModel {
        id: ActiveValue::Set(1),
        isrc: ActiveValue::Set("test_isrc".to_string()),
        commit_user: ActiveValue::Set("test_user".to_string()),
        credit_role: ActiveValue::Set("test_role".to_string()),
        credit_name: ActiveValue::Set("test_name".to_string()),
        credit_user: ActiveValue::Set(Some("test_user".to_string())),
        email: ActiveValue::Set("test@example.com".to_string()),
        is_invite: ActiveValue::Set(Some(false)),
        memo: ActiveValue::Set(Some("test_memo".to_string())),
        created_at: ActiveValue::Set(chrono::Utc::now().naive_utc()),
    };

    let expected_result = create_test_track_credits("test_isrc");

    let expected_result_pre = expected_result.clone();

    mock_repo
        .expect_mock_create()
        .with(eq(track_credits.clone()))
        .returning(move |_| Ok(expected_result_pre.clone()));

    let result = mock_repo.mock_create(track_credits).await;
    let result = result.unwrap();
    assert_eq!(result, expected_result);
}

#[tokio::test]
async fn test_find_by_isrc() {
    let mut mock_repo = MockMockTrackCreditsRepo::new();

    let isrc = "test_isrc";
    let expected_credits = vec![create_test_track_credits(isrc)];

    let expected_credits_pre = expected_credits.clone();

    mock_repo
        .expect_mock_find_by_isrc()
        .with(eq(isrc))
        .returning(move |_| Ok(expected_credits_pre.clone()));

    let result = mock_repo.mock_find_by_isrc(isrc).await;
    let result = result.unwrap();
    assert_eq!(result, expected_credits);
}
