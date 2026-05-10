use actix_cors::Cors;
use actix_web::{web, App, HttpServer, Result};
use dotenvy::dotenv;
use server_core::{auth, configure_app, schema_builder};
use shared::db::{clone_database_connection, connect::establish_db_connection};
use shared::logger::init_logger;
use std::{env, sync::Arc, time::Duration};
use tracing_actix_web::TracingLogger;

use registry::*;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    match dotenv() {
        Ok(_) => tracing::info!("Loaded .env file"),
        Err(e) => tracing::error!("Failed to load .env file: {}", e),
    }
    init_logger().expect("Failed to initialize logger");
    bootstrap().await
}

async fn bootstrap() -> Result<(), std::io::Error> {
    let host: String = env::var("HOST").unwrap_or_else(|_| "0.0.0.0".to_string());
    let port: String = env::var("PORT").unwrap_or_else(|_| "8080".to_string());
    let port: u16 = port.parse().expect("PORT must be a number");
    let db_url: String = env::var("DATABASE_URL").expect("DATABASE_URL must be set");

    let db = establish_db_connection(db_url)
        .await
        .expect("Failed to connect to database");

    let repos = create_repositories(clone_database_connection(&db));
    let services = create_services().await;
    let usecases = std::sync::Arc::new(create_usecases(repos, services));

    let schema = schema_builder()
        .data(usecases.clone())
        .data(clone_database_connection(&db))
        .finish();
    let token_validator: Arc<dyn auth::TokenValidator> =
        Arc::new(auth::JwksTokenValidator::from_env().expect("Failed to configure JWT validator"));

    tracing::info!("Starting server...");

    HttpServer::new(move || {
        let cors = Cors::default()
            .allow_any_origin()
            .allow_any_method()
            .allow_any_header()
            .max_age(3600);
        App::new()
            .wrap(cors)
            .wrap(TracingLogger::default())
            .app_data(web::Data::new(schema.clone()))
            .app_data(web::Data::new(usecases.clone()))
            .app_data(web::Data::new(token_validator.clone()))
            .configure(configure_app)
    })
    .client_request_timeout(Duration::from_secs(300))
    .bind((host, port))?
    .run()
    .await?;

    Ok(())
}
