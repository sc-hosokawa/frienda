use crate::test_support::mocks::{
    offer_attach_mock::MockMockOfferAttachRepo, offer_mock::MockMockOffersRepo,
};
use crate::usecases::offer::update_task_usecase::{
    UpdateTaskInput, UpdateTaskUsecase, UpdateTaskUsecaseTrait,
};
use chrono::Utc;
use domain::entities::offer_attach::Model as OfferAttach;
use domain::entities::offers::Model as Offer;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory};
use mockall::predicate::eq;
use sea_orm::ActiveValue;
use std::sync::Arc;

fn offer(id: i32) -> Offer {
    Offer {
        id,
        raid_id: None,
        owner: "owner-1".to_string(),
        title: "Old title".to_string(),
        description: "Old description".to_string(),
        deadline: Some("2024-01-01".to_string()),
        place: "Tokyo".to_string(),
        attention: Some("Old attention".to_string()),
        required_skill: Some("Mixing".to_string()),
        target_role: Some(UserCategory::Musician),
        img_url: Some("https://cdn.example.com/old.png".to_string()),
        publicity: true,
        category: Some(OfferCategory::Creation),
        fee: 1000,
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
    }
}

fn offer_attach(
    id: i32,
    offer_id: i32,
    file_uri: Option<&str>,
    image_uri: Option<&str>,
) -> OfferAttach {
    OfferAttach {
        id,
        offer_id,
        file_uri: file_uri.map(str::to_string),
        image_uri: image_uri.map(str::to_string),
    }
}

#[tokio::test]
async fn test_update_task_updates_offer_and_reconciles_image_attachments() {
    let offer_id = 10;
    let mut offers_repo = MockMockOffersRepo::new();
    let mut offer_attach_repo = MockMockOfferAttachRepo::new();

    offers_repo
        .expect_mock_get_by_id()
        .with(eq(offer_id))
        .times(1)
        .returning(move |_| Ok(Some(offer(offer_id))));
    offers_repo
        .expect_mock_update()
        .times(1)
        .returning(move |active| {
            assert!(matches!(
                active.title,
                ActiveValue::Set(ref value) if value == "New title"
            ));
            assert!(matches!(
                active.deadline,
                ActiveValue::Set(Some(ref value)) if value == "2025-12-31"
            ));
            assert!(matches!(active.publicity, ActiveValue::Set(false)));

            Ok(Offer {
                title: "New title".to_string(),
                deadline: Some("2025-12-31".to_string()),
                publicity: false,
                ..offer(offer_id)
            })
        });

    offer_attach_repo
        .expect_mock_get_by_offer_id()
        .with(eq(offer_id))
        .times(1)
        .returning(move |_| {
            Ok(vec![
                offer_attach(1, offer_id, None, Some("https://cdn.example.com/keep.png")),
                offer_attach(
                    2,
                    offer_id,
                    None,
                    Some("https://cdn.example.com/remove.png"),
                ),
                offer_attach(3, offer_id, Some("https://cdn.example.com/file.pdf"), None),
            ])
        });
    offer_attach_repo
        .expect_mock_create()
        .times(1)
        .returning(move |active| {
            assert!(matches!(
                active.offer_id,
                ActiveValue::Set(value) if value == offer_id
            ));
            assert!(matches!(
                active.image_uri,
                ActiveValue::Set(Some(ref value)) if value == "https://cdn.example.com/new.png"
            ));
            Ok(offer_attach(
                4,
                offer_id,
                None,
                Some("https://cdn.example.com/new.png"),
            ))
        });
    offer_attach_repo
        .expect_mock_delete()
        .with(eq(2))
        .times(1)
        .returning(|_| Ok(()));

    let usecase = UpdateTaskUsecase::new(Arc::new(offers_repo), Arc::new(offer_attach_repo));

    let result = usecase
        .update(UpdateTaskInput {
            id: offer_id,
            title: Some("New title".to_string()),
            description: None,
            fee: None,
            image_url: None,
            category: None,
            place: None,
            attention: None,
            required_skill: None,
            target_role: None,
            publicity: Some(false),
            deadline: Some("2025-12-31".to_string()),
            attached_imgs: Some(vec![
                "https://cdn.example.com/keep.png".to_string(),
                "https://cdn.example.com/new.png".to_string(),
            ]),
            attached_files: None,
        })
        .await
        .unwrap();

    assert_eq!(result.offer.title, "New title");
    assert_eq!(
        result.attached_imgs,
        Some(vec![
            "https://cdn.example.com/keep.png".to_string(),
            "https://cdn.example.com/new.png".to_string(),
        ])
    );
    assert_eq!(result.attached_files, None);
}

#[tokio::test]
async fn test_update_task_returns_not_found_before_touching_attachments() {
    let offer_id = 10;
    let mut offers_repo = MockMockOffersRepo::new();
    let mut offer_attach_repo = MockMockOfferAttachRepo::new();

    offers_repo
        .expect_mock_get_by_id()
        .with(eq(offer_id))
        .times(1)
        .returning(|_| Ok(None));
    offers_repo.expect_mock_update().times(0);
    offer_attach_repo.expect_mock_get_by_offer_id().times(0);
    offer_attach_repo.expect_mock_create().times(0);
    offer_attach_repo.expect_mock_delete().times(0);

    let usecase = UpdateTaskUsecase::new(Arc::new(offers_repo), Arc::new(offer_attach_repo));

    let result = usecase
        .update(UpdateTaskInput {
            id: offer_id,
            title: Some("New title".to_string()),
            description: None,
            fee: None,
            image_url: None,
            category: None,
            place: None,
            attention: None,
            required_skill: None,
            target_role: None,
            publicity: None,
            deadline: None,
            attached_imgs: Some(vec!["https://cdn.example.com/new.png".to_string()]),
            attached_files: None,
        })
        .await;

    assert!(result.is_err());
    let err = result.err().unwrap();
    assert_eq!(err.to_string(), "Offer not found");
}
