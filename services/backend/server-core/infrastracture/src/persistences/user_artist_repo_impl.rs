use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::user_artist::{
    ActiveModel as UserArtistActiveModel, Column, Entity as UserArtistEntity, Model as UserArtist,
};
use domain::repositories::user_artist_repo::UserArtistRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct UserArtistRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl UserArtistRepository for UserArtistRepoImpl {
    async fn create(&self, user_artist: UserArtistActiveModel) -> Result<UserArtist, DomainError> {
        let res: InsertResult<UserArtistActiveModel> =
            UserArtistEntity::insert(user_artist).exec(&self.db).await?;

        let inserted_user_artist = UserArtistEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_user_artist.unwrap())
    }

    async fn update(&self, user_artist: UserArtistActiveModel) -> Result<UserArtist, DomainError> {
        let res = UserArtistEntity::update(user_artist).exec(&self.db).await?;
        Ok(res)
    }

    async fn update_status(
        &self,
        user_artist: UserArtistActiveModel,
    ) -> Result<UserArtist, DomainError> {
        let res = UserArtistEntity::update(user_artist).exec(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res: DeleteResult = UserArtistEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn find_all(&self) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find().all(&self.db).await?;
        Ok(user_artists)
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;
        Ok(user_artists)
    }

    async fn find_by_user_id(&self, user_id: &str) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find()
            .filter(Column::UserId.eq(user_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;
        Ok(user_artists)
    }

    async fn find_by_artist_id_and_user_id(
        &self,
        artist_id: &str,
        user_id: &str,
    ) -> Result<Option<UserArtist>, DomainError> {
        let user_artist = UserArtistEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .filter(Column::UserId.eq(user_id))
            .one(&self.db)
            .await?;
        Ok(user_artist)
    }

    async fn exists(&self, user_id: &str, artist_id: &str) -> Result<bool, DomainError> {
        let user_artist = UserArtistEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .filter(Column::UserId.eq(user_id))
            .one(&self.db)
            .await?;
        Ok(user_artist.is_some())
    }
}
