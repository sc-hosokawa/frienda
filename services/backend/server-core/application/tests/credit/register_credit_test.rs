use crate::mocks::track_credits_mock::MockMockTrackCreditsRepo;
use application::usecases::credit::register_usecase::{
    RegisterInfo, RegisterUsecase, RegisterUsecaseInput, RegisterUsecaseTrait,
};
use domain::entities::track_credits::Model as TrackCredits;
use mockall::predicate::*;
use std::sync::Arc;

fn create_test_track_credits(
    isrc: &str,
    commit_user: &str,
    credit_role: &str,
    credit_name: &str,
    credit_user: &str,
    email: &str,
    is_invite: bool,
    memo: Option<&str>,
) -> TrackCredits {
    TrackCredits {
        id: 1,
        isrc: isrc.to_string(),
        commit_user: commit_user.to_string(),
        credit_role: credit_role.to_string(),
        credit_name: credit_name.to_string(),
        credit_user: Some(credit_user.to_string()),
        email: email.to_string(),
        is_invite: Some(is_invite),
        memo: memo.map(|s| s.to_string()),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_register_success() {
    // Arrange
    let mut mock_repo = MockMockTrackCreditsRepo::new();
    let input = RegisterUsecaseInput {
        register_info: vec![RegisterInfo {
            isrc: "ISRC123".to_string(),
            commit_user: "user123".to_string(),
            credit_role: "Producer".to_string(),
            credit_name: "John Doe".to_string(),
            email: "john@example.com".to_string(),
            is_invite: true,
            memo: Some("Great work!".to_string()),
        }],
    };

    let expected_track_credits = create_test_track_credits(
        "ISRC123",
        "user123",
        "Producer",
        "John Doe",
        "john@example.com",
        "john@example.com",
        true,
        Some("Great work!"),
    );

    mock_repo
        .expect_mock_create()
        .returning({
            let expected_track_credits = expected_track_credits.clone();
            move |_| Ok(expected_track_credits.clone())
        });

    let usecase = RegisterUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.register(input).await;

    // Assert
    assert!(result.is_ok());
}

#[tokio::test]
async fn test_register_multiple_credits() {
    // Arrange
    let mut mock_repo = MockMockTrackCreditsRepo::new();
    let input = RegisterUsecaseInput {
        register_info: vec![
            RegisterInfo {
                isrc: "ISRC123".to_string(),
                commit_user: "user123".to_string(),
                credit_role: "Producer".to_string(),
                credit_name: "John Doe".to_string(),
                email: "john@example.com".to_string(),
                is_invite: true,
                memo: Some("Great work!".to_string()),
            },
            RegisterInfo {
                isrc: "ISRC456".to_string(),
                commit_user: "user456".to_string(),
                credit_role: "Engineer".to_string(),
                credit_name: "Jane Smith".to_string(),
                email: "jane@example.com".to_string(),
                is_invite: false,
                memo: None,
            },
        ],
    };

    mock_repo
        .expect_create()
        .times(2)
        .returning(move |track_credits| {
            Ok(create_test_track_credits(
                &track_credits.isrc.as_ref().unwrap(),
                &track_credits.commit_user.as_ref().unwrap(),
                &track_credits.credit_role.as_ref().unwrap(),
                &track_credits.credit_name.as_ref().unwrap(),
                &track_credits.email.as_ref().unwrap(),
                track_credits.is_invite.as_ref().unwrap().unwrap(),
                track_credits.memo.as_ref().map(|v| v.as_ref()).unwrap_or(None),
            ))
        });

    let usecase = RegisterUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.register(input).await;

    // Assert
    assert!(result.is_ok());
}