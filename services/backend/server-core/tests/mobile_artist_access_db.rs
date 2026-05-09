mod common;

use actix_web::{http::StatusCode, test, App};
use application::services::{
    dsp_fetcher::{DspFetcherServiceTrait, DspsData, GenderGenData, SparseData},
    onchain_fetcher::{CredentialBalance, OnchainFetcherServiceTrait},
    push_notification::PushNotificationServiceTrait,
    request_llm::LlmServiceTrait,
    send_email::EmailServiceTrait,
};
use domain::{
    entities::{
        notification_channels::{
            Column as NotificationChannelColumn, Entity as NotificationChannelEntity,
        },
        notification_user::{Column as NotificationUserColumn, Entity as NotificationUserEntity},
        notifications::{Column as NotificationColumn, Entity as NotificationEntity},
        sea_orm_active_enums::UserArtistStatus,
        user_artist::{
            Column as UserArtistColumn, Entity as UserArtistEntity, Model as UserArtist,
        },
    },
    services::{
        email::Email,
        llm::{Answer, Question},
        notification::PushNotification,
    },
};
use presentation::graphql::context::AuthenticatedUser;
use registry::{create_repositories, create_usecases, ServicesImpl};
use sea_orm::{
    ColumnTrait, ConnectionTrait, Database, DatabaseConnection, DbBackend, EntityTrait,
    QueryFilter, Statement,
};
use serde_json::{json, Value};
use shared::db::clone_database_connection;
use std::{env, sync::Arc};

macro_rules! graphql {
    ($app:expr, $query:expr, $variables:expr) => {{
        let req = test::TestRequest::post()
            .uri("/graphql")
            .set_json(json!({
                "query": $query,
                "variables": $variables,
            }))
            .to_request();
        let resp = test::call_service(&$app, req).await;
        assert_eq!(resp.status(), StatusCode::OK);
        serde_json::from_slice::<Value>(&test::read_body(resp).await)
            .expect("GraphQL response should be valid JSON")
    }};
}

#[derive(Default)]
struct StubLlmService;

#[async_trait::async_trait]
impl LlmServiceTrait for StubLlmService {
    async fn ask_question(&self, _question: Question) -> Result<Answer, anyhow::Error> {
        Ok(Answer {
            text: "stub answer".to_string(),
        })
    }
}

#[derive(Default)]
struct StubPushNotificationService;

#[async_trait::async_trait]
impl PushNotificationServiceTrait for StubPushNotificationService {
    async fn send_push_notification(
        &self,
        _notification: PushNotification,
    ) -> Result<String, anyhow::Error> {
        Ok("stub-message-id".to_string())
    }
}

#[derive(Default)]
struct StubEmailService;

#[async_trait::async_trait]
impl EmailServiceTrait for StubEmailService {
    async fn send_email(&self, _email: Email) -> Result<(), anyhow::Error> {
        Ok(())
    }
}

#[derive(Default)]
struct StubDspFetcherService;

#[async_trait::async_trait]
impl DspFetcherServiceTrait for StubDspFetcherService {
    async fn fetch_dsps_data(
        &self,
        _start_date: Option<String>,
        _end_date: String,
    ) -> Result<Vec<DspsData>, anyhow::Error> {
        Ok(Vec::new())
    }

    async fn fetch_gender_gen_data(
        &self,
        _date: String,
    ) -> Result<Vec<GenderGenData>, anyhow::Error> {
        Ok(Vec::new())
    }

    async fn fetch_sparse_data(&self, _date: String) -> Result<Vec<SparseData>, anyhow::Error> {
        Ok(Vec::new())
    }
}

#[derive(Default)]
struct StubOnchainFetcherService;

#[async_trait::async_trait]
impl OnchainFetcherServiceTrait for StubOnchainFetcherService {
    async fn fetch_credential_balances(
        &self,
        _evm_addrs: Vec<String>,
    ) -> Result<Vec<CredentialBalance>, anyhow::Error> {
        Ok(Vec::new())
    }
}

fn stub_services() -> ServicesImpl {
    ServicesImpl {
        llm_service: Arc::new(StubLlmService),
        push_notification_service: Arc::new(StubPushNotificationService),
        email_service: Arc::new(StubEmailService),
        dsp_fetcher_service: Arc::new(StubDspFetcherService),
        onchain_fetcher_service: Arc::new(StubOnchainFetcherService),
    }
}

async fn connect_db() -> DatabaseConnection {
    let database_url = env::var("DATABASE_URL")
        .unwrap_or_else(|_| "postgres://postgres:postgres@localhost:5432/postgres".to_string());
    Database::connect(database_url)
        .await
        .expect("local Postgres should be running")
}

async fn execute_sql(db: &DatabaseConnection, sql: &str) {
    db.execute(Statement::from_string(DbBackend::Postgres, sql.to_string()))
        .await
        .expect(sql);
}

async fn cleanup_fixture(db: &DatabaseConnection) {
    execute_sql(
        db,
        r#"
DELETE FROM public.notification_user
WHERE "user" LIKE 'it_%'
   OR notification_id IN (
        SELECT id
        FROM public.notifications
        WHERE content LIKE '%Integration Artist%'
           OR title LIKE 'Integration artist access%'
    )
"#,
    )
    .await;
    execute_sql(
        db,
        r#"
DELETE FROM public.notifications
WHERE content LIKE '%Integration Artist%'
   OR title LIKE 'Integration artist access%'
"#,
    )
    .await;
    execute_sql(
        db,
        "DELETE FROM public.user_artist WHERE user_id LIKE 'it_%' OR artist_id LIKE 'it_artist_%'",
    )
    .await;
    execute_sql(
        db,
        "DELETE FROM public.artists WHERE artist_id LIKE 'it_artist_%'",
    )
    .await;
    execute_sql(db, "DELETE FROM public.users WHERE id LIKE 'it_%'").await;
}

async fn insert_fixture(db: &DatabaseConnection) {
    execute_sql(
        db,
        r#"
INSERT INTO public.users (
  id,
  username,
  email,
  status,
  category,
  primary_category,
  is_superadmin,
  realname
) VALUES
  ('it_superadmin', 'it-superadmin', 'it-superadmin@example.test', 'joined', 'musician', 'musician', true, 'Integration Superadmin'),
  ('it_admin_alpha', 'it-admin-alpha', 'it-admin-alpha@example.test', 'joined', 'musician', 'musician', false, 'Integration Alpha Admin'),
  ('it_request_new', 'it-request-new', 'it-request-new@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Request New'),
  ('it_request_legacy', 'it-request-legacy', 'it-request-legacy@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Request Legacy'),
  ('it_rejected', 'it-rejected', 'it-rejected@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Rejected'),
  ('it_accepted', 'it-accepted', 'it-accepted@example.test', 'joined', 'musician', 'musician', false, 'Integration Accepted'),
  ('it_pending_cancel', 'it-pending-cancel', 'it-pending-cancel@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Pending Cancel'),
  ('it_reject_cancel', 'it-reject-cancel', 'it-reject-cancel@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Reject Cancel'),
  ('it_leave_target_super', 'it-leave-target-super', 'it-leave-target-super@example.test', 'joined', 'musician', 'musician', false, 'Integration Leave Target Super'),
  ('it_leave_target_admin', 'it-leave-target-admin', 'it-leave-target-admin@example.test', 'joined', 'musician', 'musician', false, 'Integration Leave Target Admin'),
  ('it_leave_forbidden', 'it-leave-forbidden', 'it-leave-forbidden@example.test', 'joined', 'musician', 'musician', false, 'Integration Leave Forbidden'),
  ('it_forbidden_operator', 'it-forbidden-operator', 'it-forbidden-operator@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Forbidden Operator'),
  ('it_setdefault_user', 'it-setdefault-user', 'it-setdefault-user@example.test', 'joined', 'musician', 'musician', false, 'Integration Set Default'),
  ('it_nonaccept_default', 'it-nonaccept-default', 'it-nonaccept-default@example.test', 'joined', 'supporter', 'supporter', false, 'Integration Non Accept Default')
ON CONFLICT (id) DO UPDATE SET
  username = EXCLUDED.username,
  email = EXCLUDED.email,
  status = EXCLUDED.status,
  category = EXCLUDED.category,
  primary_category = EXCLUDED.primary_category,
  is_superadmin = EXCLUDED.is_superadmin,
  realname = EXCLUDED.realname,
  updated_at = now()
"#,
    )
    .await;

    execute_sql(
        db,
        r#"
INSERT INTO public.artists (
  id,
  display_name_jp,
  display_name_en,
  display_name_kana,
  img_url,
  fsp,
  status,
  since,
  universal_id,
  artist_id
) VALUES
  ('00000000-0000-0000-0000-00000000a001', 'Integration Artist Alpha JP', 'Integration Artist Alpha', 'integration alpha', 'https://example.test/integration-alpha.png', 111, 'visible', '2024-04-01', 'integration-alpha', 'it_artist_alpha'),
  ('00000000-0000-0000-0000-00000000a002', 'Integration Artist Beta JP', 'Integration Artist Beta', 'integration beta', 'https://example.test/integration-beta.png', 222, 'visible', '2024-04-02', 'integration-beta', 'it_artist_beta'),
  ('00000000-0000-0000-0000-00000000a003', 'Integration Artist Gamma JP', 'Integration Artist Gamma', 'integration gamma', 'https://example.test/integration-gamma.png', 333, 'visible', '2024-04-03', 'integration-gamma', 'it_artist_gamma')
ON CONFLICT (artist_id) DO UPDATE SET
  display_name_jp = EXCLUDED.display_name_jp,
  display_name_en = EXCLUDED.display_name_en,
  display_name_kana = EXCLUDED.display_name_kana,
  img_url = EXCLUDED.img_url,
  fsp = EXCLUDED.fsp,
  status = EXCLUDED.status,
  since = EXCLUDED.since,
  universal_id = EXCLUDED.universal_id
"#,
    )
    .await;

    execute_sql(
        db,
        r#"
INSERT INTO public.user_artist (
  id,
  user_id,
  artist_id,
  is_admin,
  status,
  request_message,
  is_default,
  requested_at
) VALUES
  (20001, 'it_admin_alpha', 'it_artist_alpha', true, 'accept', 'Integration alpha admin', true, now() - interval '30 days'),
  (20002, 'it_admin_alpha', 'it_artist_beta', true, 'accept', 'Integration beta admin', false, now() - interval '29 days'),
  (20003, 'it_rejected', 'it_artist_alpha', false, 'reject', 'Old rejected message', false, now() - interval '10 days'),
  (20004, 'it_accepted', 'it_artist_alpha', false, 'accept', 'Accepted message', false, now() - interval '9 days'),
  (20005, 'it_pending_cancel', 'it_artist_alpha', false, 'check', 'Pending cancel message', false, now() - interval '8 days'),
  (20006, 'it_reject_cancel', 'it_artist_alpha', false, 'reject', 'Reject cancel message', false, now() - interval '7 days'),
  (20007, 'it_leave_target_super', 'it_artist_alpha', true, 'accept', 'Leave by superadmin message', true, now() - interval '6 days'),
  (20008, 'it_leave_target_admin', 'it_artist_beta', true, 'accept', 'Leave by admin message', true, now() - interval '5 days'),
  (20009, 'it_leave_forbidden', 'it_artist_alpha', false, 'accept', 'Forbidden leave target message', false, now() - interval '4 days'),
  (20010, 'it_forbidden_operator', 'it_artist_alpha', false, 'accept', 'Forbidden operator member message', false, now() - interval '4 days'),
  (20011, 'it_setdefault_user', 'it_artist_alpha', false, 'accept', 'Existing default message', true, now() - interval '3 days'),
  (20012, 'it_setdefault_user', 'it_artist_beta', false, 'accept', 'New default message', false, now() - interval '2 days'),
  (20013, 'it_nonaccept_default', 'it_artist_alpha', false, 'check', 'Non accept default message', false, now() - interval '1 day')
ON CONFLICT (id) DO UPDATE SET
  user_id = EXCLUDED.user_id,
  artist_id = EXCLUDED.artist_id,
  is_admin = EXCLUDED.is_admin,
  status = EXCLUDED.status,
  request_message = EXCLUDED.request_message,
  is_default = EXCLUDED.is_default,
  requested_at = EXCLUDED.requested_at
"#,
    )
    .await;
}

async fn cleanup_notification_list_fixture(db: &DatabaseConnection) {
    execute_sql(
        db,
        r#"
DELETE FROM public.notification_user
WHERE "user" IN ('it_notify_user', 'it_notify_other')
   OR notification_id BETWEEN 91001 AND 91005
"#,
    )
    .await;
    execute_sql(
        db,
        "DELETE FROM public.notifications WHERE id BETWEEN 91001 AND 91005",
    )
    .await;
    execute_sql(
        db,
        "DELETE FROM public.users WHERE id IN ('it_notify_user', 'it_notify_other')",
    )
    .await;
}

async fn insert_notification_list_fixture(db: &DatabaseConnection) {
    execute_sql(
        db,
        r#"
INSERT INTO public.users (id, username, email, category, primary_category)
VALUES
  ('it_notify_user', 'notify-user', 'notify-user@example.com', 'supporter', 'supporter'),
  ('it_notify_other', 'notify-other', 'notify-other@example.com', 'supporter', 'supporter')
ON CONFLICT (id) DO UPDATE SET
  username = EXCLUDED.username,
  email = EXCLUDED.email,
  category = EXCLUDED.category,
  primary_category = EXCLUDED.primary_category
"#,
    )
    .await;

    execute_sql(
        db,
        r#"
INSERT INTO public.notifications (id, title, content, category, created_at)
VALUES
  (91001, 'Mobile unread', 'Visible unread mobile notification', 'admin', '2026-01-05 10:00:00'),
  (91002, 'Email only', 'Hidden email notification', 'admin', '2026-01-06 10:00:00'),
  (91003, 'Deleted mobile', 'Deleted mobile notification', 'admin', '2026-01-07 10:00:00'),
  (91004, 'Other user', 'Other user mobile notification', 'admin', '2026-01-08 10:00:00'),
  (91005, 'Mobile read', 'Visible read mobile notification', 'admin', '2026-01-04 10:00:00')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  category = EXCLUDED.category,
  created_at = EXCLUDED.created_at
"#,
    )
    .await;

    execute_sql(
        db,
        r#"
INSERT INTO public.notification_channels (notification_id, channel)
VALUES
  (91001, 'MOBILE_PUSH'),
  (91002, 'EMAIL'),
  (91003, 'MOBILE_PUSH'),
  (91004, 'MOBILE_PUSH'),
  (91005, 'MOBILE_PUSH')
ON CONFLICT (notification_id, channel) DO NOTHING
"#,
    )
    .await;

    execute_sql(
        db,
        r#"
INSERT INTO public.notification_user (id, notification_id, "user", is_read, is_deleted)
VALUES
  (91001, 91001, 'it_notify_user', false, false),
  (91002, 91002, 'it_notify_user', false, false),
  (91003, 91003, 'it_notify_user', false, true),
  (91004, 91004, 'it_notify_other', false, false),
  (91005, 91005, 'it_notify_user', true, false)
ON CONFLICT (id) DO UPDATE SET
  notification_id = EXCLUDED.notification_id,
  "user" = EXCLUDED."user",
  is_read = EXCLUDED.is_read,
  is_deleted = EXCLUDED.is_deleted
"#,
    )
    .await;
}

async fn find_mapping(db: &DatabaseConnection, user_id: &str, artist_id: &str) -> UserArtist {
    UserArtistEntity::find()
        .filter(UserArtistColumn::UserId.eq(user_id))
        .filter(UserArtistColumn::ArtistId.eq(artist_id))
        .one(db)
        .await
        .expect("query user_artist")
        .expect("user_artist mapping should exist")
}

fn assert_no_graphql_errors(response: &Value) {
    assert!(
        response.get("errors").is_none(),
        "GraphQL response should not contain errors: {response:#}"
    );
}

fn error_code(response: &Value) -> Option<&str> {
    response
        .pointer("/errors/0/extensions/code")
        .and_then(Value::as_str)
}

fn artist_by_id<'a>(artists: &'a [Value], artist_id: &str) -> &'a Value {
    artists
        .iter()
        .find(|artist| artist["artistId"] == artist_id)
        .unwrap_or_else(|| panic!("artist {artist_id} should be in response: {artists:#?}"))
}

#[actix_web::test]
#[ignore = "requires local Postgres container initialized by services/postgres/seeds"]
async fn mobile_artist_access_graphql_flows_work_against_local_postgres() {
    let db = connect_db().await;
    cleanup_fixture(&db).await;
    insert_fixture(&db).await;

    let repos = create_repositories(clone_database_connection(&db));
    let usecases = Arc::new(create_usecases(repos, stub_services()));
    let schema = server_core::schema_builder().data(usecases).finish();
    let app = test::init_service(
        common::test_app()
            .with_schema(schema)
            .with_db(clone_database_connection(&db))
            .configure(App::new()),
    )
    .await;

    let belonged = graphql!(
        app,
        r#"
query($userId: String!) {
  getBelongedArtists(userId: $userId) {
    artistList {
      artistId
      status
      requestMessage
      isDefault
      isAdmin
    }
  }
}
"#,
        json!({ "userId": "usr_fallback_00001" })
    );
    assert_no_graphql_errors(&belonged);
    let fallback_artists = belonged["data"]["getBelongedArtists"]["artistList"]
        .as_array()
        .expect("artistList should be an array");
    assert!(
        artist_by_id(fallback_artists, "artist_alpha_0001")["isDefault"]
            .as_bool()
            .expect("isDefault should be bool")
    );
    assert!(
        !artist_by_id(fallback_artists, "artist_beta_0001")["isDefault"]
            .as_bool()
            .expect("isDefault should be bool")
    );
    assert_eq!(
        artist_by_id(fallback_artists, "artist_alpha_0001")["requestMessage"],
        "Accepted membership without explicit default."
    );

    let canceled = graphql!(
        app,
        r#"
query($userId: String!) {
  getBelongedArtists(userId: $userId) {
    artistList {
      artistId
      status
      requestMessage
      isDefault
    }
  }
}
"#,
        json!({ "userId": "usr_canceled_00001" })
    );
    assert_no_graphql_errors(&canceled);
    let canceled_artists = canceled["data"]["getBelongedArtists"]["artistList"]
        .as_array()
        .expect("artistList should be an array");
    assert_eq!(
        artist_by_id(canceled_artists, "artist_alpha_0001")["status"],
        "Canceled"
    );
    assert_eq!(
        artist_by_id(canceled_artists, "artist_alpha_0001")["requestMessage"],
        "Canceled request that can be resent."
    );

    let user_data = graphql!(
        app,
        r#"
query($userId: String!) {
  getUserData(userId: $userId) {
    primaryArtist {
      artistId
      status
      isDefault
      requestMessage
    }
    belongsToArtists {
      artistId
      isDefault
    }
  }
}
"#,
        json!({ "userId": "usr_artist_member_01" })
    );
    assert_no_graphql_errors(&user_data);
    assert_eq!(
        user_data["data"]["getUserData"]["primaryArtist"]["artistId"],
        "artist_alpha_0001"
    );
    assert!(
        user_data["data"]["getUserData"]["primaryArtist"]["isDefault"]
            .as_bool()
            .expect("primaryArtist.isDefault should be bool")
    );
    let member_belongs = user_data["data"]["getUserData"]["belongsToArtists"]
        .as_array()
        .expect("belongsToArtists should be an array");
    assert!(
        artist_by_id(member_belongs, "artist_alpha_0001")["isDefault"]
            .as_bool()
            .expect("isDefault should be bool")
    );

    let request_with_message = graphql!(
        app,
        r#"
mutation($input: RequestToAccessArtistInput!) {
  requestToAccessArtist(input: $input) {
    createdMappings {
      artistId
      status
      requestMessage
      isAdmin
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_request_new",
                "requests": [
                    {
                        "artistId": "it_artist_gamma",
                        "message": "Integration request message"
                    }
                ]
            }
        })
    );
    assert_no_graphql_errors(&request_with_message);
    assert_eq!(
        request_with_message["data"]["requestToAccessArtist"]["createdMappings"][0]["status"],
        "Check"
    );
    assert_eq!(
        request_with_message["data"]["requestToAccessArtist"]["createdMappings"][0]
            ["requestMessage"],
        "Integration request message"
    );
    let created_request = find_mapping(&db, "it_request_new", "it_artist_gamma").await;
    assert_eq!(created_request.status, UserArtistStatus::Check);
    assert_eq!(
        created_request.request_message.as_deref(),
        Some("Integration request message")
    );
    assert!(
        created_request.requested_at.is_some(),
        "requestToAccessArtist should persist requested_at"
    );

    let legacy_request = graphql!(
        app,
        r#"
mutation($input: RequestToAccessArtistInput!) {
  requestToAccessArtist(input: $input) {
    createdMappings {
      artistId
      status
      requestMessage
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_request_legacy",
                "artistIds": ["it_artist_beta"]
            }
        })
    );
    assert_no_graphql_errors(&legacy_request);
    assert_eq!(
        legacy_request["data"]["requestToAccessArtist"]["createdMappings"][0]["status"],
        "Check"
    );
    assert!(
        legacy_request["data"]["requestToAccessArtist"]["createdMappings"][0]["requestMessage"]
            .is_null()
    );
    let legacy_mapping = find_mapping(&db, "it_request_legacy", "it_artist_beta").await;
    assert!(legacy_mapping.request_message.is_none());

    let invalid_request_input = graphql!(
        app,
        r#"
mutation($input: RequestToAccessArtistInput!) {
  requestToAccessArtist(input: $input) {
    createdMappings {
      artistId
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_request_new",
                "requests": [{"artistId": "it_artist_alpha", "message": "both"}],
                "artistIds": ["it_artist_beta"]
            }
        })
    );
    assert_eq!(error_code(&invalid_request_input), Some("BAD_USER_INPUT"));

    let rejected_before = find_mapping(&db, "it_rejected", "it_artist_alpha").await;
    let notification_users_before = NotificationUserEntity::find()
        .filter(NotificationUserColumn::User.eq("it_admin_alpha"))
        .all(&db)
        .await
        .expect("query notification_user before")
        .len();
    let resend = graphql!(
        app,
        r#"
mutation($input: ResendRequestToAccessArtistInput!) {
  resendRequestToAccessArtist(input: $input) {
    updatedMapping {
      artistId
      status
      requestMessage
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_rejected",
                "artistId": "it_artist_alpha",
                "message": "Resent integration message"
            }
        })
    );
    assert_no_graphql_errors(&resend);
    assert_eq!(
        resend["data"]["resendRequestToAccessArtist"]["updatedMapping"]["status"],
        "Check"
    );
    let rejected_after = find_mapping(&db, "it_rejected", "it_artist_alpha").await;
    assert_eq!(rejected_after.status, UserArtistStatus::Check);
    assert_eq!(
        rejected_after.request_message.as_deref(),
        Some("Resent integration message")
    );
    assert!(
        rejected_after.requested_at > rejected_before.requested_at,
        "resend should update requested_at"
    );
    let notification_users_after = NotificationUserEntity::find()
        .filter(NotificationUserColumn::User.eq("it_admin_alpha"))
        .all(&db)
        .await
        .expect("query notification_user after")
        .len();
    assert_eq!(
        notification_users_after,
        notification_users_before + 1,
        "resend should create one notification_user for the accepted artist admin"
    );
    let artist_request_notifications = NotificationEntity::find()
        .filter(NotificationColumn::Category.eq("artist_request"))
        .filter(NotificationColumn::Content.contains("Integration Artist Alpha JP"))
        .all(&db)
        .await
        .expect("query notifications");
    assert!(
        !artist_request_notifications.is_empty(),
        "resend should create an artist_request notification"
    );

    let resend_accept = graphql!(
        app,
        r#"
mutation($input: ResendRequestToAccessArtistInput!) {
  resendRequestToAccessArtist(input: $input) {
    updatedMapping {
      artistId
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_accepted",
                "artistId": "it_artist_alpha",
                "message": "Cannot resend accepted"
            }
        })
    );
    assert_eq!(error_code(&resend_accept), Some("INVALID_STATE"));

    let cancel_before = find_mapping(&db, "it_pending_cancel", "it_artist_alpha").await;
    let cancel = graphql!(
        app,
        r#"
mutation($input: CancelRequestToAccessArtistInput!) {
  cancelRequestToAccessArtist(input: $input) {
    canceledMapping {
      artistId
      status
      requestMessage
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_pending_cancel",
                "artistId": "it_artist_alpha"
            }
        })
    );
    assert_no_graphql_errors(&cancel);
    assert_eq!(
        cancel["data"]["cancelRequestToAccessArtist"]["canceledMapping"]["status"],
        "Canceled"
    );
    let cancel_after = find_mapping(&db, "it_pending_cancel", "it_artist_alpha").await;
    assert_eq!(cancel_after.status, UserArtistStatus::Canceled);
    assert_eq!(cancel_after.request_message, cancel_before.request_message);
    assert_eq!(cancel_after.requested_at, cancel_before.requested_at);

    let cancel_reject = graphql!(
        app,
        r#"
mutation($input: CancelRequestToAccessArtistInput!) {
  cancelRequestToAccessArtist(input: $input) {
    canceledMapping {
      artistId
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_reject_cancel",
                "artistId": "it_artist_alpha"
            }
        })
    );
    assert_eq!(error_code(&cancel_reject), Some("INVALID_STATE"));

    let leave_super_before = find_mapping(&db, "it_leave_target_super", "it_artist_alpha").await;
    let leave_super = graphql!(
        app,
        r#"
mutation($input: LeaveBelongedArtistInput!) {
  leaveBelongedArtist(input: $input) {
    leftArtist {
      artistId
      status
      isAdmin
      isDefault
      requestMessage
    }
  }
}
"#,
        json!({
            "input": {
                "operatorUserId": "it_superadmin",
                "userId": "it_leave_target_super",
                "artistId": "it_artist_alpha"
            }
        })
    );
    assert_no_graphql_errors(&leave_super);
    assert_eq!(
        leave_super["data"]["leaveBelongedArtist"]["leftArtist"]["status"],
        "Reject"
    );
    assert!(
        !leave_super["data"]["leaveBelongedArtist"]["leftArtist"]["isAdmin"]
            .as_bool()
            .expect("isAdmin should be bool")
    );
    assert!(
        !leave_super["data"]["leaveBelongedArtist"]["leftArtist"]["isDefault"]
            .as_bool()
            .expect("isDefault should be bool")
    );
    let leave_super_after = find_mapping(&db, "it_leave_target_super", "it_artist_alpha").await;
    assert_eq!(leave_super_after.status, UserArtistStatus::Reject);
    assert!(!leave_super_after.is_admin);
    assert!(!leave_super_after.is_default);
    assert_eq!(
        leave_super_after.request_message,
        leave_super_before.request_message
    );
    assert_eq!(
        leave_super_after.requested_at,
        leave_super_before.requested_at
    );

    let leave_admin = graphql!(
        app,
        r#"
mutation($input: LeaveBelongedArtistInput!) {
  leaveBelongedArtist(input: $input) {
    leftArtist {
      artistId
      status
      isAdmin
      isDefault
    }
  }
}
"#,
        json!({
            "input": {
                "operatorUserId": "it_admin_alpha",
                "userId": "it_leave_target_admin",
                "artistId": "it_artist_beta"
            }
        })
    );
    assert_no_graphql_errors(&leave_admin);
    assert_eq!(
        leave_admin["data"]["leaveBelongedArtist"]["leftArtist"]["status"],
        "Reject"
    );
    let leave_admin_after = find_mapping(&db, "it_leave_target_admin", "it_artist_beta").await;
    assert_eq!(leave_admin_after.status, UserArtistStatus::Reject);
    assert!(!leave_admin_after.is_admin);
    assert!(!leave_admin_after.is_default);

    let leave_forbidden = graphql!(
        app,
        r#"
mutation($input: LeaveBelongedArtistInput!) {
  leaveBelongedArtist(input: $input) {
    leftArtist {
      artistId
    }
  }
}
"#,
        json!({
            "input": {
                "operatorUserId": "it_forbidden_operator",
                "userId": "it_leave_forbidden",
                "artistId": "it_artist_alpha"
            }
        })
    );
    assert_eq!(error_code(&leave_forbidden), Some("FORBIDDEN"));

    let set_default = graphql!(
        app,
        r#"
mutation($input: SetDefaultBelongedArtistInput!) {
  setDefaultBelongedArtist(input: $input) {
    defaultArtist {
      artistId
      status
      isDefault
      requestMessage
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_setdefault_user",
                "artistId": "it_artist_beta"
            }
        })
    );
    assert_no_graphql_errors(&set_default);
    assert_eq!(
        set_default["data"]["setDefaultBelongedArtist"]["defaultArtist"]["artistId"],
        "it_artist_beta"
    );
    assert!(
        set_default["data"]["setDefaultBelongedArtist"]["defaultArtist"]["isDefault"]
            .as_bool()
            .expect("defaultArtist.isDefault should be bool")
    );
    assert!(
        !find_mapping(&db, "it_setdefault_user", "it_artist_alpha")
            .await
            .is_default
    );
    assert!(
        find_mapping(&db, "it_setdefault_user", "it_artist_beta")
            .await
            .is_default
    );

    let set_default_non_accept = graphql!(
        app,
        r#"
mutation($input: SetDefaultBelongedArtistInput!) {
  setDefaultBelongedArtist(input: $input) {
    defaultArtist {
      artistId
    }
  }
}
"#,
        json!({
            "input": {
                "userId": "it_nonaccept_default",
                "artistId": "it_artist_alpha"
            }
        })
    );
    assert_eq!(error_code(&set_default_non_accept), Some("INVALID_STATE"));

    cleanup_fixture(&db).await;
}

#[actix_web::test]
#[ignore = "requires local Postgres container initialized by services/postgres/seeds"]
async fn mobile_notification_list_filters_mobile_push_and_marks_rows_read() {
    let db = connect_db().await;
    cleanup_notification_list_fixture(&db).await;
    insert_notification_list_fixture(&db).await;

    let repos = create_repositories(clone_database_connection(&db));
    let usecases = Arc::new(create_usecases(repos, stub_services()));
    let schema = server_core::schema_builder()
        .data(usecases.clone())
        .data(AuthenticatedUser {
            user_id: "it_notify_user".to_string(),
        })
        .finish();
    let app = test::init_service(
        common::test_app()
            .with_schema(schema)
            .with_db(clone_database_connection(&db))
            .configure(App::new()),
    )
    .await;

    let first = graphql!(
        app,
        r#"
query($userId: String!, $limit: Int, $offset: Int) {
  getNotificationList(userId: $userId, limit: $limit, offset: $offset) {
    unreadCount
    hasNextPage
    notifications {
      id
      title
      content
      isRead
      createdAt
    }
  }
}
"#,
        json!({ "userId": "it_notify_user", "limit": 20, "offset": 0 })
    );
    assert_no_graphql_errors(&first);
    let first_data = &first["data"]["getNotificationList"];
    assert_eq!(first_data["unreadCount"], 1);
    assert_eq!(first_data["hasNextPage"], false);
    let first_notifications = first_data["notifications"]
        .as_array()
        .expect("notifications should be an array");
    assert_eq!(first_notifications.len(), 2);
    assert_eq!(first_notifications[0]["id"], 91001);
    assert_eq!(first_notifications[0]["title"], "Mobile unread");
    assert_eq!(
        first_notifications[0]["createdAt"],
        "2026-01-05T10:00:00+09:00"
    );
    assert_eq!(first_notifications[0]["isRead"], false);
    assert_eq!(first_notifications[1]["id"], 91005);
    assert_eq!(first_notifications[1]["isRead"], true);

    let second = graphql!(
        app,
        r#"
query($userId: String!) {
  getNotificationList(userId: $userId) {
    unreadCount
    notifications {
      id
      isRead
    }
  }
}
"#,
        json!({ "userId": "it_notify_user" })
    );
    assert_no_graphql_errors(&second);
    let second_data = &second["data"]["getNotificationList"];
    assert_eq!(second_data["unreadCount"], 0);
    let second_notifications = second_data["notifications"]
        .as_array()
        .expect("notifications should be an array");
    assert_eq!(second_notifications[0]["id"], 91001);
    assert_eq!(second_notifications[0]["isRead"], true);

    let channels = NotificationChannelEntity::find()
        .filter(NotificationChannelColumn::NotificationId.eq(91002))
        .all(&db)
        .await
        .expect("query channels");
    assert_eq!(channels.len(), 1);
    assert_eq!(channels[0].channel, "EMAIL");

    let forbidden_schema = server_core::schema_builder()
        .data(usecases)
        .data(AuthenticatedUser {
            user_id: "it_notify_other".to_string(),
        })
        .finish();
    let forbidden_app = test::init_service(
        common::test_app()
            .with_schema(forbidden_schema)
            .with_db(clone_database_connection(&db))
            .configure(App::new()),
    )
    .await;
    let forbidden = graphql!(
        forbidden_app,
        r#"
query($userId: String!) {
  getNotificationList(userId: $userId) {
    notifications {
      id
    }
  }
}
"#,
        json!({ "userId": "it_notify_user" })
    );
    assert_eq!(error_code(&forbidden), Some("FORBIDDEN"));

    cleanup_notification_list_fixture(&db).await;
}
