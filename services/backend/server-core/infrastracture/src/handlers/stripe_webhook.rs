use actix_web::{web, HttpResponse, Responder};
use futures::StreamExt;
use serde::Deserialize;
use serde_json::json;
use tracing::{error, info, instrument};

#[derive(Deserialize, Debug)]
struct StripeEvent {
    #[serde(rename = "type")]
    event_type: String,
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

    info!("body: {:?}", body);

    let event: StripeEvent = match serde_json::from_str(&body) {
        Ok(event) => event,
        Err(e) => {
            error!("Failed to parse webhook body json: {}", e);
            return HttpResponse::BadRequest().finish();
        }
    };

    info!("event: {:?}", event);

    match event.event_type.as_str() {
        "payment_intent.succeeded" => {
            let payment_intent: serde_json::Value = match serde_json::from_value(event.data.object)
            {
                Ok(payment_intent) => payment_intent,
                Err(e) => {
                    error!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };
            // handle_payment_intent_succeeded(payment_intent)
            info!("payment_intent.succeeded: {:?}", payment_intent);
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
        _ => {
            error!("Unhandled event type: {}", event.event_type);
        }
    }

    HttpResponse::Ok().json(json!({"status": "success"}))
}
