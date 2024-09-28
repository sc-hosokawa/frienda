use actix_web::{web, App, HttpServer};
use infrastracture::handlers;
use std::env;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("Starting server...");

    let host = env::var("HOST").unwrap_or_else(|_| "0.0.0.0".to_string());
    let port = env::var("PORT").unwrap_or_else(|_| "8080".to_string());
    let port: u16 = port.parse().expect("PORT must be a number");

    HttpServer::new(|| {
        App::new().route(
            "/stripe",
            web::post().to(handlers::stripe_webhook::webhook_handler),
        )
    })
    .bind((host, port))?
    .run()
    .await
}
