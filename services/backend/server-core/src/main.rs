use actix_web::{web, App, HttpServer};
use infrastracture::handlers;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("Starting server...");

    HttpServer::new(|| {
        App::new().route(
            "/stripe",
            web::post().to(handlers::stripe_webhook::webhook_handler),
        )
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
