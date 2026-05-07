mod common;

use actix_web::{
    http::{header, StatusCode},
    test, App,
};
use serde::{Deserialize, Serialize};

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
async fn graphql_endpoint_returns_validation_errors_for_unknown_field() {
    let app = test::init_service(
        common::test_app()
            .with_default_schema()
            .configure(App::new()),
    )
    .await;

    let req = test::TestRequest::post()
        .uri("/graphql")
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
async fn graphql_endpoint_executes_simple_query_successfully() {
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
    assert!(schema.contains("artistId: String!"));
    assert!(schema.contains("message: String"));
    assert!(schema.contains("requests: [RequestToAccessArtistItemInput!]"));
    assert!(schema.contains("artistIds: [String!]"));
    assert!(schema.contains("resendRequestToAccessArtist(input: ResendRequestToAccessArtistInput!): ResendRequestToAccessArtistResponse!"));
    assert!(schema.contains("requestMessage: String"));
    assert!(schema.contains("isDefault: Boolean!"));
}
