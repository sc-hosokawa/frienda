use actix_cors::Cors;
use actix_web::{dev::ServiceRequest, guard, web, App, Error, HttpResponse, HttpServer, Result};
use actix_web_httpauth::extractors::bearer::{BearerAuth, Config};
use actix_web_httpauth::extractors::AuthenticationError;
use actix_web_httpauth::middleware::HttpAuthentication;
use async_graphql::{http::GraphiQLSource, EmptySubscription, Schema};
use async_graphql_actix_web::{GraphQLRequest, GraphQLResponse};
use dotenvy::dotenv;
use presentation::graphql::{mutations::MutationRoot, queries::QueryRoot, AppSchema};
use presentation::handlers;
use shared::db::connect::establish_db_connection;
use shared::logger::init_logger;
use std::env;
use std::time::Duration;
use tracing_actix_web::TracingLogger;

use registry::*;

mod auth;

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

    let repos = create_repositories(db.clone());
    let services = create_services().await;
    let usecases = std::sync::Arc::new(create_usecases(repos, services));

    let schema = Schema::build(
        QueryRoot::default(),
        MutationRoot::default(),
        EmptySubscription,
    )
    .data(usecases.clone())
    .data(db.clone())
    .finish();

    tracing::info!("Starting server...");
    tracing::info!("GraphiQL IDE: http://{}:{}/graphql", host, port);

    HttpServer::new(move || {
        // let auth = HttpAuthentication::bearer(validator);
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
            .service(web::resource("/graphql").guard(guard::Post()).to(index))
            .service(
                web::resource("/graphql")
                    .guard(guard::Get())
                    .to(index_graphiql),
            )
            .route(
                "/health_check",
                web::post().to(handlers::health_check::health_check),
            )
            .route(
                "/stripe",
                web::post().to(handlers::stripe_webhook::webhook_handler),
            )
    })
    .client_request_timeout(Duration::from_secs(30))
    .bind((host, port))?
    .run()
    .await?;

    Ok(())
}

async fn index(schema: web::Data<AppSchema>, req: GraphQLRequest) -> GraphQLResponse {
    schema.execute(req.into_inner()).await.into()
}

async fn index_graphiql() -> Result<HttpResponse> {
    Ok(HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(GraphiQLSource::build().endpoint("/graphql").finish()))
}

async fn validator(
    req: ServiceRequest,
    credentials: BearerAuth,
) -> Result<ServiceRequest, (Error, ServiceRequest)> {
    let config = req.app_data::<Config>().cloned().unwrap_or_default();

    println!("req.app_data::<Config>():{:?}", req.app_data::<Config>());
    println!("credentials.token():{}", credentials.token());

    match auth::validate_token(credentials.token()).await {
        Ok(res) => {
            if res {
                Ok(req)
            } else {
                Err((AuthenticationError::from(config).into(), req))
            }
        }
        Err(_) => Err((AuthenticationError::from(config).into(), req)),
    }
}
