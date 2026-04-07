use crate::test_support::mocks::{
    email_mock::MockMockEmailService, invitations_mock::MockMockInvitationsRepo,
    track_credits_mock::MockMockTrackCreditsRepo, user_mock::MockMockUsersRepo,
};
use crate::usecases::credit::invitation_usecase::{InvitationUsecase, InvitationUsecaseTrait};
use chrono::Utc;
use domain::entities::invitations::Model as Invitation;
use domain::entities::sea_orm_active_enums::{OfferCategory, UserCategory, UserStatus};
use domain::entities::track_credits::Model as TrackCredits;
use domain::entities::users::Model as User;
use sea_orm::ActiveValue;
use std::sync::Arc;

fn track_credit(id: i32, commit_user: &str, email: &str) -> TrackCredits {
    TrackCredits {
        id,
        isrc: format!("ISRC-{id}"),
        commit_user: commit_user.to_string(),
        credit_role: "Composer".to_string(),
        credit_name: format!("Credit {id}"),
        credit_user: None,
        email: email.to_string(),
        is_invite: Some(true),
        memo: None,
        created_at: Utc::now().naive_utc(),
    }
}

fn invitation(
    id: i32,
    invitee: &str,
    inviter_email: &str,
    digest_code: &str,
    is_joined: bool,
) -> Invitation {
    Invitation {
        id,
        invitee: invitee.to_string(),
        inviter_email: inviter_email.to_string(),
        digest_code: Some(digest_code.to_string()),
        invited_at: Utc::now().naive_utc(),
        is_joined,
        joined_email: None,
        joined_at: None,
    }
}

fn user(user_id: &str, invited_by: Option<&str>) -> User {
    User {
        id: user_id.to_string(),
        email: format!("{user_id}@example.com"),
        is_superadmin: Some(false),
        id_token: Some(user_id.to_string()),
        fcm_token: None,
        username: user_id.to_string(),
        realname: user_id.to_string(),
        img_url: None,
        evm_addr: None,
        status: UserStatus::Joined,
        invited_by: invited_by.map(str::to_string),
        fsp: 0,
        fsp_temp: 0,
        credential: 0,
        category: UserCategory::Musician,
        primary_category: UserCategory::Musician,
        publicity: true,
        greeting: None,
        skill: None,
        x_handle: None,
        instagram_handle: None,
        fb_handle: None,
        interest_offer: Some(OfferCategory::Creation),
        created_at: Utc::now().naive_utc(),
        updated_at: Utc::now().naive_utc(),
        last_login_at: None,
    }
}

#[tokio::test]
async fn test_invite_rejects_invalid_password_before_hitting_repositories() {
    let mut track_credits_repo = MockMockTrackCreditsRepo::new();
    track_credits_repo.expect_mock_count_credits().times(0);

    let usecase = InvitationUsecase::new(
        Arc::new(MockMockInvitationsRepo::new()),
        Arc::new(MockMockUsersRepo::new()),
        Arc::new(track_credits_repo),
        Arc::new(MockMockEmailService::new()),
    );

    let result = usecase.invite("wrong-password".to_string()).await;

    assert!(result.is_err());
    let err = result.err().unwrap();
    assert_eq!(err.to_string(), "Invalid password");
}

#[tokio::test]
async fn test_invite_creates_and_sends_only_for_uninvited_emails() {
    let mut invitations_repo = MockMockInvitationsRepo::new();
    let users_repo = MockMockUsersRepo::new();
    let mut track_credits_repo = MockMockTrackCreditsRepo::new();
    let mut email_service = MockMockEmailService::new();

    track_credits_repo
        .expect_mock_count_credits()
        .times(1)
        .returning(|| Ok(3));
    track_credits_repo
        .expect_mock_all_credits()
        .times(1)
        .returning(|_| {
            Ok(vec![
                track_credit(1, "commit-1", "fresh@example.com"),
                track_credit(2, "commit-2", "existing@example.com"),
                track_credit(3, "commit-3", "fresh@example.com"),
            ])
        });
    invitations_repo
        .expect_mock_find_all()
        .times(1)
        .returning(|| {
            Ok(vec![invitation(
                9,
                "commit-2",
                "existing@example.com",
                "used",
                false,
            )])
        });
    invitations_repo
        .expect_mock_create()
        .times(1)
        .returning(|active| {
            assert!(matches!(
                active.invitee,
                ActiveValue::Set(ref value) if value == "commit-1"
            ));
            assert!(matches!(
                active.inviter_email,
                ActiveValue::Set(ref value) if value == "fresh@example.com"
            ));
            assert!(matches!(
                active.digest_code,
                ActiveValue::Set(Some(ref value)) if !value.is_empty()
            ));
            Ok(invitation(
                10,
                "commit-1",
                "fresh@example.com",
                "generated",
                false,
            ))
        });
    email_service
        .expect_mock_send_email()
        .times(1)
        .returning(|email| {
            assert_eq!(email.to, "fresh@example.com");
            assert!(email
                .body
                .contains("https://app.friendshipdao.xyz/signin?code="));
            Ok(())
        });

    let usecase = InvitationUsecase::new(
        Arc::new(invitations_repo),
        Arc::new(users_repo),
        Arc::new(track_credits_repo),
        Arc::new(email_service),
    );

    let result = usecase.invite("friendshipdao".to_string()).await.unwrap();

    assert_eq!(result.invitation.len(), 1);
    assert_eq!(result.invitation[0].inviter_email, "fresh@example.com");
}

#[tokio::test]
async fn test_join_with_code_updates_user_and_marks_invitation_joined() {
    let digest_code = "digest-1";
    let joined_user_id = "joined-user";
    let joined_email = "joined@example.com";

    let mut invitations_repo = MockMockInvitationsRepo::new();
    let mut users_repo = MockMockUsersRepo::new();

    invitations_repo
        .expect_mock_find_by_digest_code()
        .times(1)
        .returning(move |_| {
            Ok(Some(invitation(
                1,
                "inviter-1",
                "fresh@example.com",
                digest_code,
                false,
            )))
        });
    users_repo
        .expect_mock_update()
        .times(1)
        .returning(move |active| {
            assert!(matches!(
                active.id,
                ActiveValue::Set(ref value) if value == joined_user_id
            ));
            assert!(matches!(
                active.invited_by,
                ActiveValue::Set(Some(ref value)) if value == "inviter-1"
            ));
            Ok(user(joined_user_id, Some("inviter-1")))
        });
    invitations_repo
        .expect_mock_update()
        .times(1)
        .returning(move |active| {
            assert!(matches!(active.is_joined, ActiveValue::Set(true)));
            assert!(matches!(
                active.joined_email,
                ActiveValue::Set(Some(ref value)) if value == joined_email
            ));
            Ok(Invitation {
                is_joined: true,
                joined_email: Some(joined_email.to_string()),
                ..invitation(1, "inviter-1", "fresh@example.com", digest_code, true)
            })
        });

    let usecase = InvitationUsecase::new(
        Arc::new(invitations_repo),
        Arc::new(users_repo),
        Arc::new(MockMockTrackCreditsRepo::new()),
        Arc::new(MockMockEmailService::new()),
    );

    let result = usecase
        .join_with_code(
            digest_code.to_string(),
            joined_user_id.to_string(),
            joined_email.to_string(),
        )
        .await;

    assert!(result.is_ok());
}
