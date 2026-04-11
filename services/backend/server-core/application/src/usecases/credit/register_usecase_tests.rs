use crate::test_support::mocks::track_credits_mock::MockMockTrackCreditsRepo;
use crate::usecases::credit::register_usecase::{
    RegisterInfo, RegisterUsecase, RegisterUsecaseInput, RegisterUsecaseTrait,
};
use domain::entities::track_credits::Model as TrackCredits;
use mockall::predicate::*;
use sea_orm::ActiveValue;
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

    mock_repo.expect_mock_create().returning({
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
        .expect_mock_create()
        .times(2)
        .returning(move |track_credits| {
            let isrc = match &track_credits.isrc {
                ActiveValue::Set(v) => v.as_str(),
                _ => "default_isrc",
            };
            let commit_user = match &track_credits.commit_user {
                ActiveValue::Set(v) => v.as_str(),
                _ => "default_user",
            };
            let credit_role = match &track_credits.credit_role {
                ActiveValue::Set(v) => v.as_str(),
                _ => "default_role",
            };
            let credit_name = match &track_credits.credit_name {
                ActiveValue::Set(v) => v.as_str(),
                _ => "default_name",
            };
            let credit_user = match &track_credits.credit_user {
                ActiveValue::Set(v) => v.as_deref().unwrap_or(""),
                _ => "",
            };
            let email = match &track_credits.email {
                ActiveValue::Set(v) => v.as_str(),
                _ => "default@email.com",
            };
            let is_invite = match &track_credits.is_invite {
                ActiveValue::Set(v) => v.unwrap_or(false),
                _ => false,
            };
            let memo = match &track_credits.memo {
                ActiveValue::Set(v) => v.as_deref(),
                _ => None,
            };

            Ok(create_test_track_credits(
                isrc,
                commit_user,
                credit_role,
                credit_name,
                credit_user,
                email,
                is_invite,
                memo,
            ))
        });

    let usecase = RegisterUsecase::new(Arc::new(mock_repo));

    // Act
    let result = usecase.register(input).await;

    // Assert
    assert!(result.is_ok());
}
