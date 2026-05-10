mod common;

use actix_web::{
    http::{header, StatusCode},
    test, App,
};
use presentation::graphql::context::AuthenticatedUser;
use serde::{Deserialize, Serialize};
use server_core::auth::{AuthError, TokenValidator};
use std::sync::Arc;

#[derive(Serialize)]
struct GraphqlRequestBody<'a> {
    query: &'a str,
}

#[derive(Deserialize)]
struct GraphqlTypenameData {
    #[serde(rename = "__typename")]
    typename: String,
}

#[derive(Deserialize)]
struct GraphqlSuccessResponse {
    data: GraphqlTypenameData,
}

#[derive(Deserialize)]
struct GraphqlError {
    message: String,
}

#[derive(Deserialize)]
struct GraphqlErrorResponse {
    errors: Vec<GraphqlError>,
}

struct TestTokenValidator;

#[async_trait::async_trait]
impl TokenValidator for TestTokenValidator {
    async fn validate(&self, token: &str) -> Result<AuthenticatedUser, AuthError> {
        match token {
            "valid-test-token" => Ok(AuthenticatedUser {
                user_id: "test-user".to_string(),
            }),
            _ => Err(AuthError::InvalidToken),
        }
    }
}

fn test_token_validator() -> Arc<dyn TokenValidator> {
    Arc::new(TestTokenValidator)
}

#[actix_web::test]
async fn graphiql_endpoint_returns_html() {
    let app = test::init_service(common::test_app().configure(App::new())).await;

    let req = test::TestRequest::get().uri("/graphql").to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::OK);

    let content_type = resp
        .headers()
        .get(header::CONTENT_TYPE)
        .and_then(|value| value.to_str().ok())
        .expect("content-type header");
    assert!(content_type.starts_with("text/html"));

    let body = String::from_utf8(test::read_body(resp).await.to_vec()).expect("utf-8 response");
    assert!(body.contains("GraphiQL IDE"));
}

#[actix_web::test]
async fn graphql_endpoint_requires_bearer_token_for_protected_queries() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .set_json(GraphqlRequestBody {
            query: "{ __typename }",
        })
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::UNAUTHORIZED);
}

#[actix_web::test]
async fn graphql_endpoint_executes_protected_query_with_valid_bearer_token() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .with_token_validator(test_token_validator())
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .insert_header((header::AUTHORIZATION, "Bearer valid-test-token"))
        .set_json(GraphqlRequestBody {
            query: "{ __typename }",
        })
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::OK);

    let content_type = resp
        .headers()
        .get(header::CONTENT_TYPE)
        .and_then(|value| value.to_str().ok())
        .expect("content-type header");
    assert!(content_type.contains("json"));

    let body: GraphqlSuccessResponse = test::read_body_json(resp).await;
    assert_eq!(body.data.typename, "QueryRoot");
}

#[actix_web::test]
async fn graphql_endpoint_returns_validation_errors_for_unknown_field_with_valid_bearer_token() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .with_token_validator(test_token_validator())
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .insert_header((header::AUTHORIZATION, "Bearer valid-test-token"))
        .set_json(GraphqlRequestBody {
            query: "{ unknownField }",
        })
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::OK);

    let body: GraphqlErrorResponse = test::read_body_json(resp).await;
    assert_eq!(body.errors.len(), 1);
    assert!(body.errors[0].message.contains("unknownField"));
}

#[actix_web::test]
async fn graphql_endpoint_allows_current_admin_fields_without_bearer_token() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .set_json(GraphqlRequestBody {
            query: "query GetAllArtists { getAllArtists { artistList { id } } }",
        })
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::OK);
}

#[actix_web::test]
async fn graphql_endpoint_does_not_trust_operation_name_for_admin_bypass() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .set_json(GraphqlRequestBody {
            query: r#"query GetAllArtists { getUserData(userId: "test-user") { id } }"#,
        })
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::UNAUTHORIZED);
}

#[actix_web::test]
async fn graphql_endpoint_rejects_mixed_admin_and_protected_fields_without_bearer_token() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .set_json(GraphqlRequestBody {
            query: r#"query Mixed { getAllArtists { artistList { id } } getUserData(userId: "test-user") { id } }"#,
        })
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::UNAUTHORIZED);
}

#[actix_web::test]
async fn graphql_endpoint_rejects_malformed_json() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
        .insert_header((header::CONTENT_TYPE, "application/json"))
        .set_payload("not-json")
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}

#[actix_web::test]
async fn graphql_schema_exposes_request_to_access_artist_message_fields() {
    let schema = server_core::schema_builder().finish().sdl();

    assert!(schema.contains("input RequestToAccessArtistItemInput"));
    assert!(schema.contains("input ResendRequestToAccessArtistInput"));
    assert!(schema.contains("type ResendRequestToAccessArtistResponse"));
    assert!(schema.contains("input CancelRequestToAccessArtistInput"));
    assert!(schema.contains("type CancelRequestToAccessArtistResponse"));
    assert!(schema.contains("input LeaveBelongedArtistInput"));
    assert!(schema.contains("type LeaveBelongedArtistResponse"));
    assert!(schema.contains("input SetDefaultBelongedArtistInput"));
    assert!(schema.contains("type SetDefaultBelongedArtistResponse"));
    assert!(schema.contains("artistId: String!"));
    assert!(schema.contains("operatorUserId: String!"));
    assert!(schema.contains("message: String"));
    assert!(schema.contains("requests: [RequestToAccessArtistItemInput!]"));
    assert!(schema.contains("artistIds: [String!]"));
    assert!(schema.contains("resendRequestToAccessArtist(input: ResendRequestToAccessArtistInput!): ResendRequestToAccessArtistResponse!"));
    assert!(schema.contains("cancelRequestToAccessArtist(input: CancelRequestToAccessArtistInput!): CancelRequestToAccessArtistResponse!"));
    assert!(schema.contains(
        "leaveBelongedArtist(input: LeaveBelongedArtistInput!): LeaveBelongedArtistResponse!"
    ));
    assert!(schema.contains(
        "setDefaultBelongedArtist(input: SetDefaultBelongedArtistInput!): SetDefaultBelongedArtistResponse!"
    ));
    assert!(schema.contains("requestMessage: String"));
    assert!(schema.contains("isDefault: Boolean!"));
}

#[actix_web::test]
async fn graphql_schema_exposes_notification_list_fields() {
    let schema = server_core::schema_builder().finish().sdl();

    assert!(schema.contains("type NotificationListItem"));
    assert!(schema.contains("type NotificationListData"));
    assert!(schema.contains("id: Int!"));
    assert!(schema.contains("title: String!"));
    assert!(schema.contains("content: String!"));
    assert!(schema.contains("isRead: Boolean!"));
    assert!(schema.contains("createdAt: String!"));
    assert!(schema.contains("notifications: [NotificationListItem!]!"));
    assert!(schema.contains("unreadCount: Int!"));
    assert!(schema.contains("hasNextPage: Boolean!"));
    assert!(schema.contains(
        "getNotificationList(userId: String!, limit: Int! = 20, offset: Int! = 0): NotificationListData!"
    ));
}
