use actix_web::{web, HttpResponse, Responder};
use futures::StreamExt;
use sha2::{Digest, Sha512};
use std::sync::Arc;
use tracing;

use registry::Usecases;

pub async fn credential_handler(
    mut payload: web::Payload,
    usecases: web::Data<Arc<Usecases>>,
) -> impl Responder {
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

    let expected_hash = {
        let mut hasher = Sha512::new();
        hasher.update(b"aaaaa");
        format!("{:x}", hasher.finalize())
    };

    if body == expected_hash {
        tracing::info!("Hash verification successful");
        usecases
            .credentials
            .fetch_credential_balances()
            .await
            .unwrap();
        HttpResponse::Ok().body("Pipeline Credentials successful")
    } else {
        tracing::error!("Hash verification failed");
        HttpResponse::BadRequest().body("Invalid Key")
    }
}
