use crate::test_support::mocks::{
    offer_attach_mock::MockMockOfferAttachRepo, offer_mock::MockMockOffersRepo,
    offer_user_mock::MockMockOfferUserRepo,
};
use crate::usecases::offer::delete_offer_usecase::{
    DeleteOfferInput, DeleteOfferUsecase, DeleteOfferUsecaseTrait,
};
use mockall::{predicate::eq, Sequence};
use shared::error::domain_err::DomainError;
use std::sync::Arc;

#[tokio::test]
async fn test_delete_offer_deletes_children_before_offer() {
    let offer_id = 42;

    let mut offers_repo = MockMockOffersRepo::new();
    let mut offer_attach_repo = MockMockOfferAttachRepo::new();
    let mut offer_user_repo = MockMockOfferUserRepo::new();
    let mut seq = Sequence::new();

    offer_attach_repo
        .expect_mock_delete_by_offer_id()
        .with(eq(offer_id))
        .times(1)
        .in_sequence(&mut seq)
        .returning(|_| Ok(()));
    offer_user_repo
        .expect_mock_delete_by_offer_id()
        .with(eq(offer_id))
        .times(1)
        .in_sequence(&mut seq)
        .returning(|_| Ok(()));
    offers_repo
        .expect_mock_delete()
        .with(eq(offer_id))
        .times(1)
        .in_sequence(&mut seq)
        .returning(|_| Ok(()));

    let usecase = DeleteOfferUsecase::new(
        Arc::new(offers_repo),
        Arc::new(offer_attach_repo),
        Arc::new(offer_user_repo),
    );

    let result = usecase.delete(DeleteOfferInput { id: offer_id }).await;

    assert_eq!(result.unwrap(), offer_id);
}

#[tokio::test]
async fn test_delete_offer_stops_when_attachment_delete_fails() {
    let offer_id = 42;

    let offers_repo = MockMockOffersRepo::new();
    let mut offer_attach_repo = MockMockOfferAttachRepo::new();
    let offer_user_repo = MockMockOfferUserRepo::new();

    offer_attach_repo
        .expect_mock_delete_by_offer_id()
        .with(eq(offer_id))
        .times(1)
        .returning(|_| {
            Err(DomainError::DatabaseError(
                "attach delete failed".to_string(),
            ))
        });

    let usecase = DeleteOfferUsecase::new(
        Arc::new(offers_repo),
        Arc::new(offer_attach_repo),
        Arc::new(offer_user_repo),
    );

    let err = usecase
        .delete(DeleteOfferInput { id: offer_id })
        .await
        .unwrap_err();

    assert_eq!(err.to_string(), "Database error: attach delete failed");
}
