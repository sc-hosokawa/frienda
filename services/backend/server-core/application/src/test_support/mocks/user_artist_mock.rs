use async_trait::async_trait;
use domain::entities::sea_orm_active_enums::UserArtistStatus;
use domain::entities::user_artist::{ActiveModel as UserArtistActiveModel, Model as UserArtist};
use mockall::automock;
use shared::error::domain_err::DomainError;

use domain::repositories::user_artist_repo::UserArtistRepository;

#[automock]
#[async_trait]
pub trait MockUserArtistRepo {
    async fn mock_create(
        &self,
        user_artist: UserArtistActiveModel,
    ) -> Result<UserArtist, DomainError>;
    async fn mock_update(
        &self,
        user_artist: UserArtistActiveModel,
    ) -> Result<UserArtist, DomainError>;
    async fn mock_update_status(
        &self,
        user_artist: UserArtistActiveModel,
    ) -> Result<UserArtist, DomainError>;
    async fn mock_set_default_for_user(
        &self,
        user_id: String,
        artist_id: String,
    ) -> Result<UserArtist, DomainError>;
    async fn mock_delete(&self, id: i32) -> Result<(), DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<UserArtist>, DomainError>;
    async fn mock_find_by_user_id(&self, user_id: String) -> Result<Vec<UserArtist>, DomainError>;
    async fn mock_find_by_artist_id(
        &self,
        artist_id: String,
    ) -> Result<Vec<UserArtist>, DomainError>;
    async fn mock_find_by_artist_id_and_user_id(
        &self,
        artist_id: String,
        user_id: String,
    ) -> Result<Option<UserArtist>, DomainError>;
    async fn mock_exists(&self, user_id: String, artist_id: String) -> Result<bool, DomainError>;
    async fn mock_find_by_artist_ids(
        &self,
        artist_ids: Vec<String>,
    ) -> Result<Vec<UserArtist>, DomainError>;
    async fn mock_find_by_user_id_and_artist_ids(
        &self,
        user_id: String,
        artist_ids: Vec<String>,
    ) -> Result<Vec<UserArtist>, DomainError>;
    async fn mock_find_by_artist_id_and_user_ids(
        &self,
        artist_id: String,
        user_ids: Vec<String>,
    ) -> Result<Vec<UserArtist>, DomainError>;
    async fn mock_find_by_status(
        &self,
        status: UserArtistStatus,
    ) -> Result<Vec<UserArtist>, DomainError>;
}

#[async_trait]
impl UserArtistRepository for MockMockUserArtistRepo {
    async fn create(&self, user_artist: UserArtistActiveModel) -> Result<UserArtist, DomainError> {
        self.mock_create(user_artist).await
    }

    async fn update(&self, user_artist: UserArtistActiveModel) -> Result<UserArtist, DomainError> {
        self.mock_update(user_artist).await
    }

    async fn update_status(
        &self,
        user_artist: UserArtistActiveModel,
    ) -> Result<UserArtist, DomainError> {
        self.mock_update_status(user_artist).await
    }

    async fn set_default_for_user(
        &self,
        user_id: &str,
        artist_id: &str,
    ) -> Result<UserArtist, DomainError> {
        self.mock_set_default_for_user(user_id.to_string(), artist_id.to_string())
            .await
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        self.mock_delete(id).await
    }

    async fn find_all(&self) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_all().await
    }

    async fn find_by_user_id(&self, user_id: &str) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_by_user_id(user_id.to_string()).await
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_by_artist_id(artist_id.to_string()).await
    }

    async fn find_by_artist_id_and_user_id(
        &self,
        artist_id: &str,
        user_id: &str,
    ) -> Result<Option<UserArtist>, DomainError> {
        self.mock_find_by_artist_id_and_user_id(artist_id.to_string(), user_id.to_string())
            .await
    }

    async fn exists(&self, user_id: &str, artist_id: &str) -> Result<bool, DomainError> {
        self.mock_exists(user_id.to_string(), artist_id.to_string())
            .await
    }

    async fn find_by_artist_ids(
        &self,
        artist_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_by_artist_ids(artist_ids.iter().map(|s| s.to_string()).collect())
            .await
    }

    async fn find_by_user_id_and_artist_ids(
        &self,
        user_id: &str,
        artist_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_by_user_id_and_artist_ids(
            user_id.to_string(),
            artist_ids.iter().map(|s| s.to_string()).collect(),
        )
        .await
    }

    async fn find_by_artist_id_and_user_ids(
        &self,
        artist_id: &str,
        user_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_by_artist_id_and_user_ids(
            artist_id.to_string(),
            user_ids.iter().map(|s| s.to_string()).collect(),
        )
        .await
    }

    async fn find_by_status(
        &self,
        status: UserArtistStatus,
    ) -> Result<Vec<UserArtist>, DomainError> {
        self.mock_find_by_status(status).await
    }
}
