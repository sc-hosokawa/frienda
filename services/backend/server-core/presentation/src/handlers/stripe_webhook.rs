use actix_web::{web, HttpResponse, Responder};
use futures::StreamExt;
use serde::Deserialize;
use serde_json::json;
use std::sync::Arc;
use tracing::{debug, error, info};

use registry::Usecases;

#[derive(Deserialize, Debug)]
struct StripeEvent {
    #[serde(rename = "type")]
    type_: String,
    data: StripeEventData,
}

#[derive(Deserialize, Debug)]
struct StripeEventData {
    object: serde_json::Value,
}

fn parse_event(body: &str) -> Result<StripeEvent, serde_json::Error> {
    serde_json::from_str(body)
}

fn extract_checkout_metadata(session: &serde_json::Value) -> Option<(String, i32)> {
    let metadata = session.get("metadata")?;
    let user_id = metadata.get("user_id")?.as_str()?.to_string();
    let points = metadata.get("points")?.as_str()?.parse::<i32>().ok()?;

    Some((user_id, points))
}

pub async fn webhook_handler(
    mut payload: web::Payload,
    usecases: web::Data<Arc<Usecases>>,
) -> impl Responder {
    let body = match payload.next().await {
        Some(Ok(bytes)) => match String::from_utf8(bytes.to_vec()) {
            Ok(string) => string,
            Err(e) => {
                error!("Error converting body to UTF-8: {:?}", e);
                return HttpResponse::BadRequest().finish();
            }
        },
        Some(Err(e)) => {
            error!("Error reading request body: {:?}", e);
            return HttpResponse::InternalServerError().finish();
        }
        None => {
            error!("Empty request body");
            return HttpResponse::BadRequest().finish();
        }
    };

    let event: StripeEvent = match parse_event(&body) {
        Ok(event) => event,
        Err(e) => {
            error!("Failed to parse webhook body json: {}", e);
            return HttpResponse::BadRequest().finish();
        }
    };

    info!("event: {:?}", event.type_);

    match event.type_.as_str() {
        "payment_intent.succeeded" => {
            let payment_intent: serde_json::Value = match serde_json::from_value(event.data.object)
            {
                Ok(payment_intent) => payment_intent,
                Err(e) => {
                    error!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };
            info!("RESULT: payment_intent.succeeded: {:?}", payment_intent);
        }
        "charge.succeeded" => {
            let charge: serde_json::Value = match serde_json::from_value(event.data.object) {
                Ok(charge) => charge,
                Err(e) => {
                    error!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };
            info!("RESULT: charge.succeeded: {:?}", charge);
        }
        "payment_method.attached" => {
            let payment_method: serde_json::Value = match serde_json::from_value(event.data.object)
            {
                Ok(payment_method) => payment_method,
                Err(e) => {
                    error!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };
            // handle_payment_method_attached(payment_method)
            info!("payment_method.attached: {:?}", payment_method);
        }
        "checkout.session.completed" => {
            let session: serde_json::Value = match serde_json::from_value(event.data.object) {
                Ok(session) => session,
                Err(e) => {
                    error!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };

            if let Some((user_id, points)) = extract_checkout_metadata(&session) {
                if let Some(metadata) = session.get("metadata") {
                    info!("Session metadata: {:?}", metadata);
                }

                info!("user_id: {:?}, points: {:?}", user_id, points);
                let result = usecases.transfer_point_between_accounts.transfer(
                    application::usecases::point::transfer_point_between_accounts_usecase::TransferPointBetweenAccountsInput {
                        from: None,
                        to: user_id,
                        amount: points,
                        notes: Some("Stripeにより購入".to_string()),
                    }
                ).await.unwrap();

                info!("RESULT: transfer_point_between_accounts: {:?}", result);
            } else {
                error!("Required metadata fields are missing or invalid");
                return HttpResponse::BadRequest().finish();
            }
        }
        _ => {
            debug!("Unhandled event type: {}", event.type_);
        }
    }

    HttpResponse::Ok().json(json!({"status": "success"}))
}

#[cfg(test)]
mod tests {
    use super::{extract_checkout_metadata, parse_event};
    use serde_json::json;

    #[test]
    fn parse_event_reads_event_type() {
        let event = parse_event(r#"{"type":"charge.succeeded","data":{"object":{"id":"ch_123"}}}"#)
            .expect("valid stripe event");

        assert_eq!(event.type_, "charge.succeeded");
    }

    #[test]
    fn extract_checkout_metadata_returns_user_id_and_points() {
        let session = json!({
            "metadata": {
                "user_id": "user-123",
                "points": "42"
            }
        });

        let metadata = extract_checkout_metadata(&session);

        assert_eq!(metadata, Some(("user-123".to_string(), 42)));
    }

    #[test]
    fn extract_checkout_metadata_rejects_invalid_points() {
        let session = json!({
            "metadata": {
                "user_id": "user-123",
                "points": "forty-two"
            }
        });

        assert_eq!(extract_checkout_metadata(&session), None);
    }
}
