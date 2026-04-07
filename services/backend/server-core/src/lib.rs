use actix_web::{guard, web, HttpResponse, Result};
use async_graphql::{http::GraphiQLSource, EmptySubscription, Schema, SchemaBuilder};
use async_graphql_actix_web::{GraphQLRequest, GraphQLResponse};
use presentation::{
    graphql::{mutations::MutationRoot, queries::QueryRoot, AppSchema},
    handlers, pipeline,
};

pub mod auth;

pub fn schema_builder() -> SchemaBuilder<QueryRoot, MutationRoot, EmptySubscription> {
    Schema::build(
        QueryRoot::default(),
        MutationRoot::default(),
        EmptySubscription,
    )
}

pub fn configure_app(cfg: &mut web::ServiceConfig) {
    cfg.service(web::resource("/graphql").guard(guard::Post()).to(index))
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
        .route(
            "/contentful",
            web::post().to(handlers::contentful_webhook::contentful_webhook_handler),
        )
        .route(
            "/pipeline/dsps/daily",
            web::post().to(pipeline::dsp::dsp_daily_handler),
        )
        .route(
            "/pipeline/dsps/monthly",
            web::post().to(pipeline::dsp::dsp_monthly_handler),
        )
        .route(
            "/pipeline/credentials",
            web::post().to(pipeline::credential::credential_handler),
        )
        .route(
            "/pipeline/dsps/gendergen",
            web::post().to(pipeline::dsp::gender_gen_playback_handler),
        )
        .route(
            "/pipeline/dsps/sparse",
            web::post().to(pipeline::dsp::sparse_data_handler),
        );
}

async fn index(schema: web::Data<AppSchema>, req: GraphQLRequest) -> GraphQLResponse {
    schema.execute(req.into_inner()).await.into()
}

async fn index_graphiql() -> Result<HttpResponse> {
    Ok(HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(
            GraphiQLSource::build()
                .endpoint("/graphql")
                .title("GraphiQL IDE")
                .finish(),
        ))
}
