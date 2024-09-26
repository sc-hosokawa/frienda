use sea_orm::DbErr;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum DomainError {
    #[error("Entity not found")]
    NotFound,

    #[error("Database error: {0}")]
    DatabaseError(String),

    #[error("Validation error: {0}")]
    ValidationError(String),

    #[error("Authentication error: {0}")]
    AuthenticationError(String),

    #[error("Authorization error: {0}")]
    AuthorizationError(String),

    #[error("Unexpected error occurred: {0}")]
    UnexpectedError(String),
}

impl From<DbErr> for DomainError {
    fn from(err: DbErr) -> Self {
        DomainError::DatabaseError(err.to_string())
    }
}
