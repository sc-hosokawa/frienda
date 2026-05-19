use actix_web::{
    dev::{ServiceFactory, ServiceRequest},
    web, App, Error,
};
use presentation::graphql::AppSchema;
use registry::Usecases;
use sea_orm::DatabaseConnection;
use server_core::auth::TokenValidator;
use std::sync::Arc;

#[allow(dead_code)]
pub struct TestAppDataBuilder {
    schema: Option<web::Data<AppSchema>>,
    usecases: Option<web::Data<Arc<Usecases>>>,
    db: Option<web::Data<DatabaseConnection>>,
    token_validator: Option<web::Data<Arc<dyn TokenValidator>>>,
}

#[allow(dead_code)]
impl TestAppDataBuilder {
    pub fn new() -> Self {
        Self {
            schema: None,
            usecases: None,
            db: None,
            token_validator: None,
        }
    }

    pub fn with_schema(mut self, schema: AppSchema) -> Self {
        self.schema = Some(web::Data::new(schema));
        self
    }

    pub fn with_default_schema(self) -> Self {
        self.with_schema(server_core::schema_builder().finish())
    }

    pub fn with_usecases(mut self, usecases: Arc<Usecases>) -> Self {
        self.usecases = Some(web::Data::new(usecases));
        self
    }

    pub fn with_db(mut self, db: DatabaseConnection) -> Self {
        self.db = Some(web::Data::new(db));
        self
    }

    pub fn with_token_validator(mut self, token_validator: Arc<dyn TokenValidator>) -> Self {
        self.token_validator = Some(web::Data::new(token_validator));
        self
    }

    pub fn configure<T>(self, app: App<T>) -> App<T>
    where
        T: ServiceFactory<ServiceRequest, Config = (), Error = Error, InitError = ()>,
    {
        let app = if let Some(schema) = self.schema {
            app.app_data(schema)
        } else {
            app
        };
        let app = if let Some(usecases) = self.usecases {
            app.app_data(usecases)
        } else {
            app
        };
        let app = if let Some(db) = self.db {
            app.app_data(db)
        } else {
            app
        };
        let app = if let Some(token_validator) = self.token_validator {
            app.app_data(token_validator)
        } else {
            app
        };

        app.configure(server_core::configure_app)
    }
}

pub fn test_app() -> TestAppDataBuilder {
    TestAppDataBuilder::new()
}
