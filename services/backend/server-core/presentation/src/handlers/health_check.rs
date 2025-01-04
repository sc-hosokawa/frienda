use actix_web::{web, HttpResponse, Responder};
use futures::StreamExt;
use tracing;

#[tracing::instrument(name = "health_check", skip(payload))]
pub async fn health_check(mut payload: web::Payload) -> impl Responder {
    let body: String = match payload.next().await {
        Some(Ok(bytes)) => match String::from_utf8(bytes.to_vec()) {
            Ok(string) => string,
            Err(e) => {
                tracing::error!("Error converting body to UTF-8: {:?}", e);
                return HttpResponse::BadRequest().finish();
            }
        },
        Some(Err(e)) => {
            tracing::error!("Error reading request body: {:?}", e);
            return HttpResponse::InternalServerError().finish();
        }
        None => {
            tracing::error!("Empty request body");
            return HttpResponse::BadRequest().finish();
        }
    };
    HttpResponse::Ok().body(body)
}
