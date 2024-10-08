use actix_web::{web, HttpRequest, HttpResponse, Responder};
use http::HeaderMap as HttpHeaderMap;
use serde::{Deserialize, Serialize};
use serde_json::{from_str, Value};
use std::collections::HashMap;
use std::env;
use svix::webhooks::Webhook;
use tracing::{error, info, instrument};

#[derive(Debug, Serialize, Deserialize)]
pub enum EventType {
    #[serde(rename = "user.created")]
    UserCreated,
    #[serde(rename = "user.deleted")]
    UserDeleted,
    #[serde(rename = "user.updated")]
    UserUpdated,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Event {
    pub data: HashMap<String, serde_json::Value>,
    pub object: String,
    #[serde(rename = "type")]
    pub event_type: EventType,
}

#[instrument(name = "clerk_webhook", skip_all, fields(event_type))]
pub async fn webhook_handler(req: HttpRequest, payload: web::Json<Value>) -> impl Responder {
    let webhook_secret = env::var("CLERK_SECRET_KEY").unwrap_or_default();

    let svix_id = req.headers().get("svix-id");
    let svix_timestamp = req.headers().get("svix-timestamp");
    let svix_signature = req.headers().get("svix-signature");

    if svix_id.is_none() || svix_timestamp.is_none() || svix_signature.is_none() {
        println!(
            "svixId: {:?}, svixIdTimeStamp: {:?}, svixSignature: {:?}",
            svix_id, svix_timestamp, svix_signature
        );
        return HttpResponse::BadRequest().body("Error occurred");
    }

    let svix_headers = [
        ("svix-id", svix_id.unwrap().to_str().unwrap()),
        ("svix-timestamp", svix_timestamp.unwrap().to_str().unwrap()),
        ("svix-signature", svix_signature.unwrap().to_str().unwrap()),
    ];

    let payload_string = serde_json::to_string(&payload).unwrap();

    let mut header_map = HttpHeaderMap::new();
    for (key, value) in svix_headers {
        header_map.insert(key, value.parse().unwrap());
    }

    let wh = Webhook::new(&webhook_secret).unwrap();

    match wh.verify(payload_string.as_bytes(), &header_map) {
        Ok(()) => {
            match from_str::<Event>(&payload_string) {
                Ok(event) => {
                    match event.event_type {
                        EventType::UserCreated => {
                            let id = event.data["id"].as_str().unwrap_or_default();
                            info!("User created: {}", id);
                            // TODO: ユーザー作成の処理
                            HttpResponse::Created().finish()
                        }
                        EventType::UserDeleted => {
                            let id = event.data["id"].as_str().unwrap_or_default();
                            info!("User deleted: {}", id);
                            // TODO: ユーザー削除の処理
                            HttpResponse::Ok().finish()
                        }
                        EventType::UserUpdated => {
                            let id = event.data["id"].as_str().unwrap_or_default();
                            info!("User updated: {}", id);
                            // TODO: ユーザー更新の処理
                            HttpResponse::Ok().finish()
                        }
                    }
                }
                Err(e) => {
                    error!("Webhook verification failed: {:?}", e);
                    HttpResponse::BadRequest().body("Webhook verification failed")
                }
            }
        }
        Err(e) => {
            error!("Webhook verification failed: {:?}", e);
            HttpResponse::BadRequest().body("Webhook verification failed")
        }
    }
}
