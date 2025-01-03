use actix_web::{web, HttpResponse, Responder};
use std::sync::Arc;

use registry::Usecases;

pub async fn contentful_webhook_handler(usecases: web::Data<Arc<Usecases>>) -> impl Responder {
    let _result: bool = usecases.update_news.update_news().await.unwrap();
    HttpResponse::Ok().finish()
}
