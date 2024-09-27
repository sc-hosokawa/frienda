use actix_web::{web, HttpResponse, Responder};
use futures::StreamExt;
use serde::Deserialize;
use serde_json::json;

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

pub async fn webhook_handler(mut payload: web::Payload) -> impl Responder {
    const MAX_BODY_BYTES: usize = 65536;

    let body = match payload.next().await {
        Some(Ok(bytes)) => match String::from_utf8(bytes.to_vec()) {
            Ok(string) => string,
            Err(e) => {
                eprintln!("Error converting body to UTF-8: {:?}", e);
                return HttpResponse::BadRequest().finish();
            }
        },
        Some(Err(e)) => {
            eprintln!("Error reading request body: {:?}", e);
            return HttpResponse::InternalServerError().finish();
        }
        None => {
            eprintln!("Empty request body");
            return HttpResponse::BadRequest().finish();
        }
    };

    let event: StripeEvent = match serde_json::from_str(&body) {
        Ok(event) => event,
        Err(e) => {
            eprintln!("Failed to parse webhook body json: {}", e);
            return HttpResponse::BadRequest().finish();
        }
    };

    match event.event_type.as_str() {
        "payment_intent.succeeded" => {
            // payment_intent.succeededイベントの処理
            let payment_intent: serde_json::Value = match serde_json::from_value(event.data.object)
            {
                Ok(payment_intent) => payment_intent,
                Err(e) => {
                    eprintln!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };
            // handle_payment_intent_succeeded(payment_intent)
            println!("payment_intent.succeeded: {:?}", payment_intent);
        }
        "payment_method.attached" => {
            // payment_method.attachedイベントの処理
            let payment_method: serde_json::Value = match serde_json::from_value(event.data.object)
            {
                Ok(payment_method) => payment_method,
                Err(e) => {
                    eprintln!("Error parsing webhook JSON: {}", e);
                    return HttpResponse::BadRequest().finish();
                }
            };
            // handle_payment_method_attached(payment_method)
            println!("payment_method.attached: {:?}", payment_method);
        }
        _ => {
            eprintln!("Unhandled event type: {}", event.event_type);
        }
    }

    HttpResponse::Ok().json(json!({"status": "success"}))
}
