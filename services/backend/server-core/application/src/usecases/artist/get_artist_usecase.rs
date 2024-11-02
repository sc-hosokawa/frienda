use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::artists::Model as Artist;
use domain::repositories::artists_repo::ArtistsRepository;

//
// Define the input for the usecase
//
pub struct GetArtistUsecaseInput {
    pub artist_id: String, // varchar(28)
}

pub struct GetArtistUsecaseOutput {
    pub artists: Vec<Artist>,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait GetArtistUsecaseTrait: Send + Sync {
    async fn get_artist_by_id(&self, input: GetArtistUsecaseInput)
        -> Result<Artist, anyhow::Error>;
    async fn get_artists_by_ids(
        &self,
        ids: Vec<&str>,
    ) -> Result<GetArtistUsecaseOutput, anyhow::Error>;
    async fn get_all_artists(&self) -> Result<GetArtistUsecaseOutput, anyhow::Error>;
    async fn get_artists_by_name(
        &self,
        name: &str,
    ) -> Result<GetArtistUsecaseOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetArtistUsecase {
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetArtistUsecase {
    pub fn new(artists_repo: Arc<dyn ArtistsRepository>) -> Self {
        Self { artists_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetArtistUsecaseTrait for GetArtistUsecase {
    async fn get_artist_by_id(
        &self,
        input: GetArtistUsecaseInput,
    ) -> Result<Artist, anyhow::Error> {
        let artist = self
            .artists_repo
            .find_by_id(&input.artist_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Artist not found"))?;
        Ok(artist)
    }

    async fn get_artists_by_ids(
        &self,
        ids: Vec<&str>,
    ) -> Result<GetArtistUsecaseOutput, anyhow::Error> {
        let artists: Vec<Artist> = self.artists_repo.find_by_ids(ids).await?;
        Ok(GetArtistUsecaseOutput { artists })
    }

    async fn get_all_artists(&self) -> Result<GetArtistUsecaseOutput, anyhow::Error> {
        let artists: Vec<Artist> = self.artists_repo.find_all().await?;
        Ok(GetArtistUsecaseOutput { artists })
    }

    async fn get_artists_by_name(
        &self,
        name: &str,
    ) -> Result<GetArtistUsecaseOutput, anyhow::Error> {
        let artists: Vec<Artist> = self.artists_repo.find_by_name(name).await?;
        Ok(GetArtistUsecaseOutput { artists })
    }
}
