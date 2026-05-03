use crate::test_support::mocks::user_artist_mock::MockMockUserArtistRepo;
use crate::test_support::mocks::user_mock::MockMockUsersRepo;
use crate::usecases::artist::mark_as_member_usecase::{
    MarkAsMemberUsecase, MarkAsMemberUsecaseInput, MarkAsMemberUsecaseTrait,
    UserStatus as StatusByUser,
};
use domain::entities::sea_orm_active_enums::{
    OfferCategory, UserArtistStatus, UserCategory, UserStatus,
};
use domain::entities::user_artist::Model as UserArtist;
use domain::entities::users::Model as User;
use shared::error::domain_err::DomainError;
use std::sync::Arc;
use tokio;

fn create_test_user(user_id: &str) -> User {
    User {
        id: user_id.to_string(),
        email: format!("user{}@example.com", user_id),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: Some("".to_string()),
        username: format!("User {}", user_id),
        realname: "".to_string(),
        img_url: Some("".to_string()),
        evm_addr: Some("".to_string()),
        status: UserStatus::Joined,
        invited_by: None,
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: Some("".to_string()),
        skill: Some("".to_string()),
        x_handle: Some("".to_string()),
        instagram_handle: Some("".to_string()),
        fb_handle: Some("".to_string()),
        interest_offer: Some(OfferCategory::Creation),
        created_at: chrono::Utc::now().naive_utc(),
        updated_at: chrono::Utc::now().naive_utc(),
        last_login_at: Some(chrono::Utc::now().naive_utc()),
    }
}

fn create_test_user_artist(user_id: &str, artist_id: &str, is_admin: bool) -> UserArtist {
    UserArtist {
        id: 1,
        user_id: user_id.to_string(),
        artist_id: artist_id.to_string(),
        is_admin,
        status: UserArtistStatus::Check,
    }
}

#[tokio::test]
async fn test_mark_as_member_success() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut user_repo = MockMockUsersRepo::new();

    // Mock the behavior of user_repo.find_by_id
    user_repo
        .expect_mock_find_by_id()
        .returning(|_| Ok(Some(create_test_user("user_id"))));

    // Mock the behavior of user_artist_repo.find_by_artist_id_and_user_id
    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .returning(|_, _| Ok(Some(create_test_user_artist("user_id", "artist_id", true))));

    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_ids()
        .with(
            mockall::predicate::eq("artist_id".to_string()),
            mockall::predicate::eq(vec!["user_id".to_string()]),
        )
        .returning(|_, _| Ok(vec![create_test_user_artist("user_id", "artist_id", false)]));

    // Mock the behavior of user_artist_repo.update
    user_artist_repo
        .expect_mock_update()
        .returning(|_| Ok(create_test_user_artist("user_id", "artist_id", true)));

    let usecase = MarkAsMemberUsecase::new(Arc::new(user_artist_repo), Arc::new(user_repo));

    let input = MarkAsMemberUsecaseInput {
        member: "user_id".to_string(),
        artist_id: "artist_id".to_string(),
        mapping: vec![StatusByUser {
            user_id: "user_id".to_string(),
            status: UserArtistStatus::Accept,
        }],
    };

    let result = usecase.mark_as_member(input).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap().len(), 1);
}

#[tokio::test]
async fn test_mark_as_member_not_found() {
    let mut user_artist_repo = MockMockUserArtistRepo::new();
    let mut user_repo = MockMockUsersRepo::new();

    // Mock the behavior of user_repo.find_by_id
    user_repo
        .expect_mock_find_by_id()
        .returning(|_| Ok(Some(create_test_user("user_id"))));

    // Mock the behavior of user_artist_repo.find_by_artist_id_and_user_id
    user_artist_repo
        .expect_mock_find_by_artist_id_and_user_id()
        .returning(|_, _| Ok(None));

    let usecase = MarkAsMemberUsecase::new(Arc::new(user_artist_repo), Arc::new(user_repo));

    let input = MarkAsMemberUsecaseInput {
        member: "user_id".to_string(),
        artist_id: "artist_id".to_string(),
        mapping: vec![StatusByUser {
            user_id: "user_id".to_string(),
            status: UserArtistStatus::Accept,
        }],
    };

    let result = usecase.mark_as_member(input).await;
    assert!(matches!(result, Err(DomainError::NotFound)));
}
