use actix_cors::Cors;
use actix_web::{guard, web, App, HttpResponse, HttpServer, Result};
use async_graphql::{http::GraphiQLSource, EmptySubscription, Schema};
use async_graphql_actix_web::{GraphQLRequest, GraphQLResponse};
use dotenvy::dotenv;
use infrastracture::handlers;
use presentation::graphql::{mutations::MutationRoot, queries::QueryRoot, AppSchema};
use shared::db::connect::establish_db_connection;
use shared::logger::init_logger;
use std::env;
use std::sync::Arc;
use tracing_actix_web::TracingLogger;

use application::health_check::{HealthCheckUseCase, HealthCheckUsecase};
use infrastracture::persistences::health_check_repo_impl::HealthCheckRepoImpl;

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

    let health_check_repo: Arc<HealthCheckRepoImpl> =
        Arc::new(HealthCheckRepoImpl::new(db.clone()));
    let health_check_usecase: Arc<dyn HealthCheckUseCase> =
        Arc::new(HealthCheckUsecase::new(health_check_repo));

    let schema = Schema::build(QueryRoot::default(), MutationRoot, EmptySubscription)
        .data(health_check_usecase.clone())
        .data(db.clone())
        .finish();

    tracing::info!("Starting server...");
    tracing::info!("GraphiQL IDE: http://{}:{}/graphql", host, port);

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
