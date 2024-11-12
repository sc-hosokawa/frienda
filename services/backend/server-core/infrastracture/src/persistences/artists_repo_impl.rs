use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::artists::{
    ActiveModel as ArtistActiveModel, Column, Entity as ArtistEntity, Model as Artist,
};
use domain::repositories::artists_repo::ArtistsRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct ArtistsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl ArtistsRepository for ArtistsRepoImpl {
    async fn create(&self, model: ArtistActiveModel) -> Result<Artist, DomainError> {
        let res: InsertResult<ArtistActiveModel> =
            ArtistEntity::insert(model).exec(&self.db).await?;

        let created_artist: Option<Artist> = ArtistEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(created_artist.unwrap())
    }

    async fn update(&self, artist: ArtistActiveModel) -> Result<Artist, DomainError> {
        let updated_artist: Artist = artist.update(&self.db).await?;
        Ok(updated_artist)
    }

    async fn find_by_id(&self, id: &str) -> Result<Option<Artist>, DomainError> {
        let artist = ArtistEntity::find()
            .filter(Column::ArtistId.eq(id))
            .one(&self.db)
            .await?;
        Ok(artist)
    }

    async fn find_by_ids(&self, ids: Vec<&str>) -> Result<Vec<Artist>, DomainError> {
        let artists = ArtistEntity::find()
            .filter(Column::ArtistId.is_in(ids))
            .order_by_asc(Column::ArtistId)
            .all(&self.db)
            .await?;
        Ok(artists)
    }

    async fn find_by_name(&self, name: &str) -> Result<Vec<Artist>, DomainError> {
        let search_pattern = format!("%{}%", name);
        let artists = ArtistEntity::find()
            .filter(
                Condition::any()
                    .add(Column::DisplayNameJp.like(&search_pattern))
                    .add(Column::DisplayNameEn.like(&search_pattern)),
            )
            .order_by_asc(Column::ArtistId)
            .all(&self.db)
            .await?;
        Ok(artists)
    }

    async fn find_all(&self) -> Result<Vec<Artist>, DomainError> {
        let artists = ArtistEntity::find()
            .order_by_asc(Column::ArtistId)
            .all(&self.db)
            .await?;
        Ok(artists)
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        let _res = ArtistEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn update_fsp(&self, id: &str, fsp: i32) -> Result<Artist, DomainError> {
        let update_artist: Artist = ArtistEntity::find()
            .filter(Column::ArtistId.eq(id))
            .one(&self.db)
            .await?
            .unwrap();

        let new_fsp: i32 = update_artist.fsp + fsp;

        let updated_artist: ArtistActiveModel = ArtistActiveModel {
            id: ActiveValue::Set(update_artist.id),
            fsp: ActiveValue::Set(new_fsp),
            ..Default::default()
        };

        let res: Artist = ArtistEntity::update(updated_artist).exec(&self.db).await?;
        Ok(res)
    }
}
