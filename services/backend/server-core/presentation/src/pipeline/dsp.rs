use actix_web::{web, HttpResponse, Responder};
use anyhow;
use futures::StreamExt;
use sha2::{Digest, Sha512};
use std::sync::Arc;
use tracing;

use registry::Usecases;

fn expected_hash_from_salt(salt: &str) -> String {
    let mut hasher = Sha512::new();
    hasher.update(salt.as_bytes());
    format!("{:x}", hasher.finalize())
}

fn expected_hash_from_env() -> anyhow::Result<String> {
    let salt = std::env::var("HASH_SALT")
        .map_err(|_| anyhow::anyhow!("HASH_SALT environment variable is not set"))?;
    Ok(expected_hash_from_salt(&salt))
}

fn split_sparse_request_body(body: String) -> (String, Option<String>) {
    if let Some((hash, date)) = body.split_once(':') {
        (hash.to_string(), Some(date.to_string()))
    } else {
        (body, None)
    }
}

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

    let expected_hash = match expected_hash_from_env() {
        Ok(hash) => hash,
        Err(error) => {
            tracing::error!("Failed to load pipeline hash: {:?}", error);
            return HttpResponse::InternalServerError().finish();
        }
    };

    if body == expected_hash {
        tracing::info!(
            "Hash verification successful. Starting Pipeline DAILY DSPs in background..."
        );
        let usecases_clone = Arc::clone(&usecases);
        tokio::spawn(async move {
            if let Err(e) = usecases_clone.dsps.add_daily_plays().await {
                tracing::error!("Background Pipeline DAILY DSPs failed: {:?}", e);
            } else {
                tracing::info!("Background Pipeline DAILY DSPs completed successfully.");
            }
        });
        HttpResponse::Accepted().body("Pipeline DAILY DSPs started")
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

    let expected_hash = match expected_hash_from_env() {
        Ok(hash) => hash,
        Err(error) => {
            tracing::error!("Failed to load pipeline hash: {:?}", error);
            return HttpResponse::InternalServerError().finish();
        }
    };

    if body == expected_hash {
        tracing::info!(
            "Hash verification successful. Starting Pipeline MONTHLY DSPs in background..."
        );
        let usecases_clone = Arc::clone(&usecases);
        tokio::spawn(async move {
            if let Err(e) = usecases_clone.dsps.add_monthly_plays().await {
                tracing::error!("Background Pipeline MONTHLY DSPs failed: {:?}", e);
            } else {
                tracing::info!("Background Pipeline MONTHLY DSPs completed successfully.");
            }
        });
        HttpResponse::Accepted().body("Pipeline MONTHLY DSPs started")
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

    let expected_hash = match expected_hash_from_env() {
        Ok(hash) => hash,
        Err(error) => {
            tracing::error!("Failed to load pipeline hash: {:?}", error);
            return HttpResponse::InternalServerError().finish();
        }
    };

    if body == expected_hash {
        tracing::info!(
            "Hash verification successful. Starting Pipeline GenderGen Playback in background..."
        );
        let usecases_clone = Arc::clone(&usecases);
        tokio::spawn(async move {
            if let Err(e) = usecases_clone.dsps.add_gender_gen_plays().await {
                tracing::error!("Background Pipeline GenderGen Playback failed: {:?}", e);
            } else {
                tracing::info!("Background Pipeline GenderGen Playback completed successfully.");
            }
        });
        HttpResponse::Accepted().body("Pipeline GenderGen Playback started")
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

    let (hash_part, date_part) = split_sparse_request_body(body);

    let expected_hash = match expected_hash_from_env() {
        Ok(hash) => hash,
        Err(error) => {
            tracing::error!("Failed to load pipeline hash: {:?}", error);
            return HttpResponse::InternalServerError().finish();
        }
    };

    if hash_part == expected_hash {
        tracing::info!(
            "Hash verification successful. Starting Pipeline Sparse Data in background..."
        );
        let usecases_clone = Arc::clone(&usecases);
        tokio::spawn(async move {
            if let Err(e) = usecases_clone.dsps.add_sparse_data(date_part).await {
                tracing::error!("Background Pipeline Sparse Data failed: {:?}", e);
            } else {
                tracing::info!("Background Pipeline Sparse Data completed successfully.");
            }
        });
        HttpResponse::Accepted().body("Pipeline Sparse Data started")
    } else {
        tracing::error!("Hash verification failed");
        HttpResponse::BadRequest().body("Invalid Key")
    }
}

#[cfg(test)]
mod tests {
    use super::{expected_hash_from_salt, split_sparse_request_body};

    #[test]
    fn expected_hash_from_salt_returns_sha512_hex_digest() {
        assert_eq!(
            expected_hash_from_salt("frienda-test-salt"),
            "8f26a52431eb6133a22da4f641c5041d769c42d6be64ac2f037954dbe2b5114e25ad9fc7249165219d9347df225d3f83470788c3660ab274d9582fa6925f8dd4",
        );
    }

    #[test]
    fn split_sparse_request_body_extracts_hash_and_date() {
        let (hash, date) = split_sparse_request_body("hash-value:2026-04-07".to_string());

        assert_eq!(hash, "hash-value");
        assert_eq!(date.as_deref(), Some("2026-04-07"));
    }

    #[test]
    fn split_sparse_request_body_without_date_keeps_body() {
        let (hash, date) = split_sparse_request_body("hash-only".to_string());

        assert_eq!(hash, "hash-only");
        assert_eq!(date, None);
    }
}
