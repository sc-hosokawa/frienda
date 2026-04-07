use async_trait::async_trait;
use domain::entities::tracks::{ActiveModel as TrackActiveModel, Model as Track};
use domain::repositories::tracks_repo::{SearchTracksOptions, TracksRepository};
use mockall::automock;
use shared::error::domain_err::DomainError;

#[automock]
#[async_trait]
pub trait MockTracksRepo {
    async fn mock_create(&self, track: TrackActiveModel) -> Result<Track, DomainError>;
    async fn mock_create_many(&self, tracks: Vec<TrackActiveModel>) -> Result<bool, DomainError>;
    async fn mock_update(&self, track: TrackActiveModel) -> Result<Track, DomainError>;
    async fn mock_delete(&self, isrc: String) -> Result<(), DomainError>;
    async fn mock_get_by_isrc(&self, isrc: String) -> Result<Option<Track>, DomainError>;
    async fn mock_get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<Track>, DomainError>;
    async fn mock_find_by_artist_id(&self, artist_id: String) -> Result<Vec<Track>, DomainError>;
    async fn mock_count(&self) -> Result<i64, DomainError>;
    async fn mock_find_all(&self) -> Result<Vec<Track>, DomainError>;
    async fn mock_find_all_isrcs(&self) -> Result<Vec<String>, DomainError>;
    async fn mock_search(&self, options: SearchTracksOptions) -> Result<Vec<Track>, DomainError>;
}

#[async_trait]
impl TracksRepository for MockMockTracksRepo {
    async fn create(&self, track: TrackActiveModel) -> Result<Track, DomainError> {
        self.mock_create(track).await
    }

    async fn create_many(&self, tracks: Vec<TrackActiveModel>) -> Result<bool, DomainError> {
        self.mock_create_many(tracks).await
    }

    async fn update(&self, track: TrackActiveModel) -> Result<Track, DomainError> {
        self.mock_update(track).await
    }

    async fn delete(&self, isrc: &str) -> Result<(), DomainError> {
        self.mock_delete(isrc.to_string()).await
    }

    async fn get_by_isrc(&self, isrc: &str) -> Result<Option<Track>, DomainError> {
        self.mock_get_by_isrc(isrc.to_string()).await
    }

    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<Track>, DomainError> {
        self.mock_get_by_isrcs(isrcs).await
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Track>, DomainError> {
        self.mock_find_by_artist_id(artist_id.to_string()).await
    }

    async fn count(&self) -> Result<i64, DomainError> {
        self.mock_count().await
    }

    async fn find_all(&self) -> Result<Vec<Track>, DomainError> {
        self.mock_find_all().await
    }

    async fn find_all_isrcs(&self) -> Result<Vec<String>, DomainError> {
        self.mock_find_all_isrcs().await
    }

    async fn search(&self, options: SearchTracksOptions) -> Result<Vec<Track>, DomainError> {
        self.mock_search(options).await
    }
}
