use crate::test_support::mocks::track_credits_mock::MockMockTrackCreditsRepo;
use crate::usecases::credit::manage_credit_usecase::{
    DeleteCreditUsecaseInput, ManageCreditUsecase, ManageCreditUsecaseTrait,
    UpdateCreditUsecaseInput,
};
use chrono::Utc;
use domain::entities::track_credits::Model as TrackCredits;
use mockall::predicate::eq;
use sea_orm::ActiveValue;
use std::sync::Arc;

fn track_credit(id: i32) -> TrackCredits {
    TrackCredits {
        id,
        isrc: "ISRC-1".to_string(),
        commit_user: "commit-user".to_string(),
        credit_role: "Composer".to_string(),
        credit_name: "Credit Name".to_string(),
        credit_user: None,
        email: "old@example.com".to_string(),
        is_invite: Some(false),
        memo: Some("memo".to_string()),
        created_at: Utc::now().naive_utc(),
    }
}

#[tokio::test]
async fn test_update_credit_sets_only_provided_fields() {
    let mut track_credits_repo = MockMockTrackCreditsRepo::new();
    track_credits_repo
        .expect_mock_update()
        .times(1)
        .returning(|active| {
            assert!(matches!(active.id, ActiveValue::Set(5)));
            assert!(matches!(
                active.commit_user,
                ActiveValue::Set(ref value) if value == "commit-user"
            ));
            assert!(matches!(
                active.credit_role,
                ActiveValue::Set(ref value) if value == "Arranger"
            ));
            assert!(matches!(active.credit_name, ActiveValue::NotSet));
            assert!(matches!(
                active.email,
                ActiveValue::Set(ref value) if value == "new@example.com"
            ));
            assert!(matches!(active.is_invite, ActiveValue::Set(Some(true))));
            assert!(matches!(active.memo, ActiveValue::NotSet));

            Ok(track_credit(5))
        });

    let usecase = ManageCreditUsecase::new(Arc::new(track_credits_repo));

    let result = usecase
        .update_credit(UpdateCreditUsecaseInput {
            credit_id: 5,
            commit_user: "commit-user".to_string(),
            credit_role: Some("Arranger".to_string()),
            credit_name: None,
            email: Some("new@example.com".to_string()),
            is_invite: Some(true),
            memo: None,
        })
        .await;

    assert!(result.is_ok());
}

#[tokio::test]
async fn test_delete_credit_forwards_id_to_repository() {
    let mut track_credits_repo = MockMockTrackCreditsRepo::new();
    track_credits_repo
        .expect_mock_delete()
        .with(eq(12))
        .times(1)
        .returning(|_| Ok(()));

    let usecase = ManageCreditUsecase::new(Arc::new(track_credits_repo));

    let result = usecase
        .delete_credit(DeleteCreditUsecaseInput { credit_id: 12 })
        .await;

    assert!(result.is_ok());
}
