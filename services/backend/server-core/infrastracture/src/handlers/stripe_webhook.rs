use actix_web::{web, HttpResponse, Responder};
use futures::StreamExt;
use serde::Deserialize;
use serde_json::json;
use tracing::{debug, error, info, instrument};

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

#[instrument(name = "stripe_webhook", skip(payload))]
pub async fn webhook_handler(mut payload: web::Payload) -> impl Responder {
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

    let event: StripeEvent = match serde_json::from_str(&body) {
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
            info!(
                "RESULT: checkout.session.completed: {:?}",
                session.get("object").unwrap().get("metadata")
            );
        }
        _ => {
            debug!("Unhandled event type: {}", event.type_);
        }
    }

    HttpResponse::Ok().json(json!({"status": "success"}))
}
