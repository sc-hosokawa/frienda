mod common;

use actix_web::{http::StatusCode, test, App};

#[actix_web::test]
async fn health_check_echoes_request_body() {
    let app = test::init_service(common::test_app().configure(App::new())).await;

    let req = test::TestRequest::post()
        .uri("/health_check")
        .set_payload("ping")
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::OK);

    let body = String::from_utf8(test::read_body(resp).await.to_vec()).expect("utf-8 response");
    assert_eq!(body, "ping");
}

#[actix_web::test]
async fn health_check_rejects_empty_body() {
    let app = test::init_service(common::test_app().configure(App::new())).await;

    let req = test::TestRequest::post().uri("/health_check").to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}

#[actix_web::test]
async fn health_check_rejects_invalid_utf8_body() {
    let app = test::init_service(common::test_app().configure(App::new())).await;

    let req = test::TestRequest::post()
        .uri("/health_check")
        .set_payload(vec![0xff, 0xfe, 0xfd])
        .to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::BAD_REQUEST);
}

#[actix_web::test]
async fn health_check_rejects_get_requests() {
    let app = test::init_service(common::test_app().configure(App::new())).await;

    let req = test::TestRequest::get().uri("/health_check").to_request();
    let resp = test::call_service(&app, req).await;

    assert_eq!(resp.status(), StatusCode::NOT_FOUND);
}
