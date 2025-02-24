use actix_web::{web, HttpResponse, Responder};
use anyhow;
use futures::StreamExt;
use sha2::{Digest, Sha512};
use std::sync::Arc;
use tracing;

use registry::Usecases;

pub async fn dsp_daily_handler(
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
        let salt = std::env::var("HASH_SALT")
            .map_err(|_| anyhow::anyhow!("HASH_SALT environment variable is not set"))
            .unwrap();
        hasher.update(salt.as_bytes());
        format!("{:x}", hasher.finalize())
    };

    if body == expected_hash {
        tracing::info!("Hash verification successful");
        usecases.dsps.add_daily_plays().await.unwrap();
        HttpResponse::Ok().body("Pipeline DAILY DSPs successful!")
    } else {
        tracing::error!("Hash verification failed");
        HttpResponse::BadRequest().body("Invalid Key")
    }
}

pub async fn dsp_monthly_handler(
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
        let salt = std::env::var("HASH_SALT")
            .map_err(|_| anyhow::anyhow!("HASH_SALT environment variable is not set"))
            .unwrap();
        hasher.update(salt.as_bytes());
        format!("{:x}", hasher.finalize())
    };

    if body == expected_hash {
        tracing::info!("Hash verification successful");
        usecases.dsps.add_monthly_plays().await.unwrap();
        HttpResponse::Ok().body("Pipeline MONTHLY DSPs successful!")
    } else {
        tracing::error!("Hash verification failed");
        HttpResponse::BadRequest().body("Invalid Key")
    }
}

pub async fn gender_gen_playback_handler(
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
        let salt = std::env::var("HASH_SALT")
            .map_err(|_| anyhow::anyhow!("HASH_SALT environment variable is not set"))
            .unwrap();
        hasher.update(salt.as_bytes());
        format!("{:x}", hasher.finalize())
    };

    if body == expected_hash {
        tracing::info!("Hash verification successful");
        usecases.dsps.add_gender_gen_plays().await.unwrap();
        HttpResponse::Ok().body("Pipeline GenderGen Playback successful!")
    } else {
        tracing::error!("Hash verification failed");
        HttpResponse::BadRequest().body("Invalid Key")
    }
}

pub async fn sparse_data_handler(
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

    let (hash_part, date_part) = if body.contains(':') {
        let parts: Vec<&str> = body.split(':').collect();
        (parts[0].to_string(), Some(parts[1].to_string()))
    } else {
        (body, None)
    };

    let expected_hash = {
        let mut hasher = Sha512::new();
        let salt = std::env::var("HASH_SALT")
            .map_err(|_| anyhow::anyhow!("HASH_SALT environment variable is not set"))
            .unwrap();
        hasher.update(salt.as_bytes());
        format!("{:x}", hasher.finalize())
    };

    if hash_part == expected_hash {
        tracing::info!("Hash verification successful");
        usecases.dsps.add_sparse_data(date_part).await.unwrap();
        HttpResponse::Ok().body("Pipeline Sparse Data successful!")
    } else {
        tracing::error!("Hash verification failed");
        HttpResponse::BadRequest().body("Invalid Key")
    }
}
