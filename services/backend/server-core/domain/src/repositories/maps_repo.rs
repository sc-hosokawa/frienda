use crate::entities::maps::{ActiveModel as MapActiveModel, Model as Map};
use async_trait::async_trait;
use shared::error::domain_err::DomainError;
use uuid::Uuid;

#[async_trait]
pub trait MapsRepository {
    async fn create(&self, map: &MapActiveModel) -> Result<Map, DomainError>;
    async fn update(&self, map: &MapActiveModel) -> Result<Map, DomainError>;

    async fn delete(&self, id: &Uuid) -> Result<(), DomainError>;
    async fn get_by_id(&self, id: &Uuid) -> Result<Option<Map>, DomainError>;
    async fn get_by_following_user_id(&self, user_id: &str) -> Result<Vec<Map>, DomainError>;
    async fn get_by_followed_user_id(&self, user_id: &str) -> Result<Vec<Map>, DomainError>;
    async fn get_all(&self) -> Result<Vec<Map>, DomainError>;
    async fn count(&self) -> Result<i64, DomainError>;
    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<Map>, DomainError>;
    async fn get_paginated(&self, page: u32, per_page: u32) -> Result<Vec<Map>, DomainError>;
    async fn search(&self, query: &str) -> Result<Vec<Map>, DomainError>;
}
