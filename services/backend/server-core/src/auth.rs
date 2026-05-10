use alcoholic_jwt::{token_kid, validate, Validation, JWK, JWKS};
use presentation::graphql::context::AuthenticatedUser;
use std::sync::RwLock;

#[derive(Debug, derive_more::Display)]
pub enum AuthError {
    #[display("Invalid token")]
    InvalidToken,

    #[display("Token is missing kid")]
    MissingKeyId,

    #[display("Token is missing subject")]
    MissingSubject,

    #[display("JWKS key not found")]
    KeyNotFound,

    #[display("Could not fetch JWKS: {_0}")]
    JwksFetchError(String),

    #[display("Invalid JWT configuration: {_0}")]
    InvalidConfiguration(String),
}

#[async_trait::async_trait]
pub trait TokenValidator: Send + Sync {
    async fn validate(&self, token: &str) -> Result<AuthenticatedUser, AuthError>;
}

pub struct JwksTokenValidator {
    jwk_url: String,
    jwk_issuer: String,
    jwk_audience: String,
    http_client: reqwest::Client,
    jwks: RwLock<Option<JWKS>>,
}

impl JwksTokenValidator {
    pub fn from_env() -> Result<Self, AuthError> {
        let jwk_url = std::env::var("JWK_URL")
            .map_err(|_| AuthError::InvalidConfiguration("JWK_URL must be set".to_string()))?;
        let jwk_issuer = std::env::var("JWK_ISSUER")
            .map_err(|_| AuthError::InvalidConfiguration("JWK_ISSUER must be set".to_string()))?;
        let jwk_audience = std::env::var("JWK_AUDIENCE").unwrap_or_else(|_| {
            jwk_issuer
                .rsplit('/')
                .next()
                .unwrap_or_default()
                .to_string()
        });

        if jwk_audience.is_empty() {
            return Err(AuthError::InvalidConfiguration(
                "JWK_AUDIENCE must be set or derivable from JWK_ISSUER".to_string(),
            ));
        }

        Ok(Self::new(jwk_url, jwk_issuer, jwk_audience))
    }

    pub fn new(jwk_url: String, jwk_issuer: String, jwk_audience: String) -> Self {
        Self {
            jwk_url,
            jwk_issuer,
            jwk_audience,
            http_client: reqwest::Client::new(),
            jwks: RwLock::new(None),
        }
    }

    fn cached_jwk(&self, kid: &str) -> Option<JWK> {
        self.jwks
            .read()
            .ok()
            .and_then(|jwks| jwks.as_ref().and_then(|jwks| jwks.find(kid).cloned()))
    }

    async fn fetch_jwks(&self) -> Result<JWKS, AuthError> {
        let response = self
            .http_client
            .get(&self.jwk_url)
            .send()
            .await
            .map_err(|error| AuthError::JwksFetchError(error.to_string()))?
            .error_for_status()
            .map_err(|error| AuthError::JwksFetchError(error.to_string()))?;

        response
            .json::<JWKS>()
            .await
            .map_err(|error| AuthError::JwksFetchError(error.to_string()))
    }

    async fn find_jwk(&self, kid: &str) -> Result<JWK, AuthError> {
        if let Some(jwk) = self.cached_jwk(kid) {
            return Ok(jwk);
        }

        let jwks = self.fetch_jwks().await?;
        let jwk = jwks.find(kid).cloned().ok_or(AuthError::KeyNotFound)?;

        if let Ok(mut cache) = self.jwks.write() {
            *cache = Some(jwks);
        }

        Ok(jwk)
    }
}

#[async_trait::async_trait]
impl TokenValidator for JwksTokenValidator {
    async fn validate(&self, token: &str) -> Result<AuthenticatedUser, AuthError> {
        let kid = token_kid(token)
            .map_err(|_| AuthError::InvalidToken)?
            .ok_or(AuthError::MissingKeyId)?;
        let jwk = self.find_jwk(&kid).await?;

        let validations = vec![
            Validation::Issuer(self.jwk_issuer.clone()),
            Validation::Audience(self.jwk_audience.clone()),
            Validation::SubjectPresent,
            Validation::NotExpired,
        ];

        let valid_jwt = validate(token, &jwk, validations).map_err(|_| AuthError::InvalidToken)?;
        let user_id = valid_jwt
            .claims
            .get("sub")
            .and_then(|value| value.as_str())
            .ok_or(AuthError::MissingSubject)?
            .to_string();

        Ok(AuthenticatedUser { user_id })
    }
}
