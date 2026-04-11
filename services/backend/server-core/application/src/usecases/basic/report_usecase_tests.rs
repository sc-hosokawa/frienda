use crate::test_support::mocks::offer_report_mock::MockMockOfferReportRepo;
use crate::test_support::mocks::release_report_mock::MockMockReleaseReportRepo;
use crate::test_support::mocks::user_report_mock::MockMockUserReportRepo;
use crate::usecases::basic::report_usecase::{
    OfferReportInput, ReleaseReportInput, ReportUsecase, ReportUsecaseTrait, UserReportInput,
};
use domain::entities::offer_report::Model as OfferReport;
use domain::entities::release_report::Model as ReleaseReport;
use domain::entities::user_report::Model as UserReport;
use mockall::predicate::*;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

// テストデータ生成用のヘルパー関数
fn create_test_user_report(id: i32, reported_user_id: &str, reporter_user_id: &str) -> UserReport {
    UserReport {
        id,
        reported_user_id: reported_user_id.to_string(),
        reporter_user_id: reporter_user_id.to_string(),
        report_content: format!("Report content {}", id),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

fn create_test_offer_report(id: i32, offer_id: i32, reporter_user_id: &str) -> OfferReport {
    OfferReport {
        id,
        offer_id,
        reporter_user_id: reporter_user_id.to_string(),
        report_content: format!("Report content {}", id),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

fn create_test_release_report(id: i32, release: &str, reporter_user_id: &str) -> ReleaseReport {
    ReleaseReport {
        id,
        release: release.to_string(),
        reporter_user_id: reporter_user_id.to_string(),
        report_content: format!("Report content {}", id),
        created_at: chrono::Utc::now().naive_utc(),
    }
}

// ユーザー報告のテスト
#[tokio::test]
async fn test_report_user_success() {
    let mut user_report_repo = MockMockUserReportRepo::new();
    let offer_report_repo = MockMockOfferReportRepo::new();
    let release_report_repo = MockMockReleaseReportRepo::new();

    let input = UserReportInput {
        reported_user_id: "user123".to_string(),
        reporter_user_id: "reporter456".to_string(),
        report_content: "Inappropriate behavior".to_string(),
    };

    let expected_report =
        create_test_user_report(1, &input.reported_user_id, &input.reporter_user_id);

    user_report_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_report.clone()));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let result = usecase.report_user(input).await;
    assert!(result.is_ok());
}

#[tokio::test]
async fn test_report_user_duplicate() {
    let mut user_report_repo = MockMockUserReportRepo::new();
    let offer_report_repo = MockMockOfferReportRepo::new();
    let release_report_repo = MockMockReleaseReportRepo::new();

    let input = UserReportInput {
        reported_user_id: "user123".to_string(),
        reporter_user_id: "reporter456".to_string(),
        report_content: "Duplicate report".to_string(),
    };

    user_report_repo
        .expect_mock_create()
        .returning(|_| Err(DomainError::ValidationError("Duplicate report".to_string())));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let result = usecase.report_user(input).await;
    assert!(result.is_err());
}

// オファー報告のテスト
#[tokio::test]
async fn test_report_offer_success() {
    let user_report_repo = MockMockUserReportRepo::new();
    let mut offer_report_repo = MockMockOfferReportRepo::new();
    let release_report_repo = MockMockReleaseReportRepo::new();

    let input = OfferReportInput {
        offer_id: 123,
        reporter_user_id: "reporter456".to_string(),
        report_content: "Suspicious offer".to_string(),
    };

    let expected_report = create_test_offer_report(1, input.offer_id, &input.reporter_user_id);

    offer_report_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_report.clone()));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let result = usecase.report_offer(input).await;
    assert!(result.is_ok());
}

// リリース報告のテスト
#[tokio::test]
async fn test_report_release_success() {
    let user_report_repo = MockMockUserReportRepo::new();
    let offer_report_repo = MockMockOfferReportRepo::new();
    let mut release_report_repo = MockMockReleaseReportRepo::new();

    let input = ReleaseReportInput {
        release: "release123".to_string(),
        reporter_user_id: "reporter456".to_string(),
        report_content: "Copyright violation".to_string(),
    };

    let expected_report = create_test_release_report(1, &input.release, &input.reporter_user_id);

    release_report_repo
        .expect_mock_create()
        .returning(move |_| Ok(expected_report.clone()));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let result = usecase.report_release(input).await;
    assert!(result.is_ok());
}

// 全ての報告を取得するテスト
#[tokio::test]
async fn test_get_all_reports() {
    let mut user_report_repo = MockMockUserReportRepo::new();
    let mut offer_report_repo = MockMockOfferReportRepo::new();
    let mut release_report_repo = MockMockReleaseReportRepo::new();

    let user_reports = vec![
        create_test_user_report(1, "user1", "reporter1"),
        create_test_user_report(2, "user2", "reporter2"),
    ];
    let offer_reports = vec![
        create_test_offer_report(1, 101, "reporter1"),
        create_test_offer_report(2, 102, "reporter2"),
    ];
    let release_reports = vec![
        create_test_release_report(1, "release1", "reporter1"),
        create_test_release_report(2, "release2", "reporter2"),
    ];

    user_report_repo
        .expect_mock_get_all()
        .returning(move || Ok(user_reports.clone()));
    offer_report_repo
        .expect_mock_get_all()
        .returning(move || Ok(offer_reports.clone()));
    release_report_repo
        .expect_mock_get_all()
        .returning(move || Ok(release_reports.clone()));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let user_result = usecase.get_all_user_reports().await;
    let offer_result = usecase.get_all_offer_reports().await;
    let release_result = usecase.get_all_release_reports().await;

    assert!(user_result.is_ok());
    assert!(offer_result.is_ok());
    assert!(release_result.is_ok());
    assert_eq!(user_result.unwrap().len(), 2);
    assert_eq!(offer_result.unwrap().len(), 2);
    assert_eq!(release_result.unwrap().len(), 2);
}

// 報告削除のテスト
#[tokio::test]
async fn test_delete_reports() {
    let mut user_report_repo = MockMockUserReportRepo::new();
    let mut offer_report_repo = MockMockOfferReportRepo::new();
    let mut release_report_repo = MockMockReleaseReportRepo::new();

    user_report_repo
        .expect_mock_delete()
        .with(eq(1))
        .returning(|_| Ok(()));
    offer_report_repo
        .expect_mock_delete()
        .with(eq(2))
        .returning(|_| Ok(()));
    release_report_repo
        .expect_mock_delete()
        .with(eq(3))
        .returning(|_| Ok(()));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let user_result = usecase.delete_user_report(1).await;
    let offer_result = usecase.delete_offer_report(2).await;
    let release_result = usecase.delete_release_report(3).await;

    assert!(user_result.is_ok());
    assert!(offer_result.is_ok());
    assert!(release_result.is_ok());
}

// エラーケースのテスト
#[tokio::test]
async fn test_error_cases() {
    let mut user_report_repo = MockMockUserReportRepo::new();
    let mut offer_report_repo = MockMockOfferReportRepo::new();
    let mut release_report_repo = MockMockReleaseReportRepo::new();

    // 各リポジトリでエラーを返すように設定
    user_report_repo
        .expect_mock_get_all()
        .returning(|| Err(DomainError::ValidationError("Database error".to_string())));
    offer_report_repo
        .expect_mock_delete()
        .returning(|_| Err(DomainError::ValidationError("Not found".to_string())));
    release_report_repo
        .expect_mock_create()
        .returning(|_| Err(DomainError::ValidationError("Invalid input".to_string())));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    // 各エラーケースをテスト
    let get_result = usecase.get_all_user_reports().await;
    assert!(get_result.is_err());

    let delete_result = usecase.delete_offer_report(1).await;
    assert!(delete_result.is_err());

    let create_result = usecase
        .report_release(ReleaseReportInput {
            release: "test".to_string(),
            reporter_user_id: "user1".to_string(),
            report_content: "test content".to_string(),
        })
        .await;
    assert!(create_result.is_err());
}

// 空の報告リストのテスト
#[tokio::test]
async fn test_empty_reports() {
    let mut user_report_repo = MockMockUserReportRepo::new();
    let mut offer_report_repo = MockMockOfferReportRepo::new();
    let mut release_report_repo = MockMockReleaseReportRepo::new();

    user_report_repo
        .expect_mock_get_all()
        .returning(|| Ok(vec![]));
    offer_report_repo
        .expect_mock_get_all()
        .returning(|| Ok(vec![]));
    release_report_repo
        .expect_mock_get_all()
        .returning(|| Ok(vec![]));

    let usecase = ReportUsecase::new(
        Arc::new(user_report_repo),
        Arc::new(offer_report_repo),
        Arc::new(release_report_repo),
    );

    let user_result = usecase.get_all_user_reports().await;
    let offer_result = usecase.get_all_offer_reports().await;
    let release_result = usecase.get_all_release_reports().await;

    assert!(user_result.is_ok());
    assert!(offer_result.is_ok());
    assert!(release_result.is_ok());
    assert_eq!(user_result.unwrap().len(), 0);
    assert_eq!(offer_result.unwrap().len(), 0);
    assert_eq!(release_result.unwrap().len(), 0);
}
