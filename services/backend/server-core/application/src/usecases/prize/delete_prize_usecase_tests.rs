use crate::test_support::mocks::prize_mock::MockMockPrizesRepo;
use crate::usecases::prize::delete_prize_usecase::{
    DeletePrizeInput, DeletePrizeUsecase, DeletePrizeUsecaseTrait,
};
use mockall::predicate::eq;
use shared::error::domain_err::DomainError;
use std::sync::Arc;

#[tokio::test]
async fn test_delete_prize_deletes_requested_id() {
    let prize_id = 7;

    let mut prizes_repo = MockMockPrizesRepo::new();
    prizes_repo
        .expect_mock_delete()
        .with(eq(prize_id))
        .times(1)
        .returning(|_| Ok(()));

    let usecase = DeletePrizeUsecase::new(Arc::new(prizes_repo));

    let result = usecase.delete(DeletePrizeInput { id: prize_id }).await;

    assert!(result.is_ok());
}

#[tokio::test]
async fn test_delete_prize_propagates_repository_error() {
    let prize_id = 7;

    let mut prizes_repo = MockMockPrizesRepo::new();
    prizes_repo
        .expect_mock_delete()
        .with(eq(prize_id))
        .times(1)
        .returning(|_| Err(DomainError::DatabaseError("delete failed".to_string())));

    let usecase = DeletePrizeUsecase::new(Arc::new(prizes_repo));

    let err = usecase
        .delete(DeletePrizeInput { id: prize_id })
        .await
        .unwrap_err();

    assert_eq!(err.to_string(), "Database error: delete failed");
}
