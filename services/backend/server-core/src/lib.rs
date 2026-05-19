use actix_web::{
    error::{ErrorInternalServerError, ErrorUnauthorized},
    guard,
    http::header,
    web, Error, HttpRequest, HttpResponse, Responder, Result,
};
use async_graphql::parser::types::{DocumentOperations, OperationType, Selection};
use async_graphql::{http::GraphiQLSource, EmptySubscription, Schema, SchemaBuilder};
use async_graphql_actix_web::{GraphQLRequest, GraphQLResponse};
use presentation::{
    graphql::{mutations::MutationRoot, queries::QueryRoot, AppSchema},
    handlers, pipeline,
};
use std::sync::Arc;

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

fn is_unauthenticated_admin_field(field_name: &str) -> bool {
    matches!(
        field_name,
        "getPlayCountHistory"
            | "getAllArtists"
            | "getArtistById"
            | "getGenderGenRateByArtist"
            | "getTrending"
            | "getSystemOverview"
            | "getFspHistoryForAdmin"
            | "getTrackCreditsHistoryForAdmin"
            | "getAllUsersForAdmin"
            | "searchProducts"
            | "searchTracks"
            | "createNewArtist"
            | "updateProduct"
            | "deleteProduct"
            | "updateTrack"
            | "deleteTrack"
            | "registerReleases"
    )
}

fn allows_unauthenticated_admin_access(request: &mut async_graphql::Request) -> bool {
    let operation_name = request.operation_name.clone();
    let document = match request.parsed_query() {
        Ok(document) => document,
        Err(_) => return false,
    };

    let operation = match &document.operations {
        DocumentOperations::Single(operation) => {
            if operation_name.is_some() {
                return false;
            }
            operation
        }
        DocumentOperations::Multiple(operations) => {
            if let Some(operation_name) = operation_name.as_deref() {
                let Some(operation) = operations.get(operation_name) else {
                    return false;
                };
                operation
            } else {
                let mut operations = operations.values();
                let Some(operation) = operations.next() else {
                    return false;
                };
                if operations.next().is_some() {
                    return false;
                }
                operation
            }
        }
    };

    if !matches!(
        operation.node.ty,
        OperationType::Query | OperationType::Mutation
    ) {
        return false;
    }

    let selections = &operation.node.selection_set.node.items;
    !selections.is_empty()
        && selections.iter().all(|selection| match &selection.node {
            Selection::Field(field) => {
                is_unauthenticated_admin_field(field.node.name.node.as_str())
            }
            Selection::FragmentSpread(_) | Selection::InlineFragment(_) => false,
        })
}

fn extract_bearer_token(http_req: &HttpRequest) -> Result<&str, Error> {
    let authorization = http_req
        .headers()
        .get(header::AUTHORIZATION)
        .and_then(|value| value.to_str().ok())
        .ok_or_else(|| ErrorUnauthorized("Unauthorized"))?;

    authorization
        .strip_prefix("Bearer ")
        .filter(|token| !token.is_empty())
        .ok_or_else(|| ErrorUnauthorized("Unauthorized"))
}

async fn authorize_graphql_request(
    http_req: &HttpRequest,
    mut request: async_graphql::Request,
) -> Result<async_graphql::Request, Error> {
    if allows_unauthenticated_admin_access(&mut request) {
        return Ok(request);
    }

    let token = extract_bearer_token(http_req)?;
    let validator = http_req
        .app_data::<web::Data<Arc<dyn auth::TokenValidator>>>()
        .ok_or_else(|| ErrorInternalServerError("Token validator is not configured"))?;
    let authenticated_user = validator.validate(token).await.map_err(|error| {
        tracing::warn!("GraphQL JWT authentication failed: {}", error);
        ErrorUnauthorized("Unauthorized")
    })?;

    Ok(request.data(authenticated_user))
}

async fn index(
    http_req: HttpRequest,
    schema: web::Data<AppSchema>,
    req: GraphQLRequest,
) -> Result<HttpResponse, Error> {
    let request = authorize_graphql_request(&http_req, req.into_inner()).await?;
    let response: GraphQLResponse = schema.execute(request).await.into();
    Ok(response.respond_to(&http_req))
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
