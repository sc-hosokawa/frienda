use async_trait::async_trait;
use derive_new::new;
use sea_orm::sea_query::{Expr, LockType};
use sea_orm::*;

use domain::entities::sea_orm_active_enums::UserArtistStatus;
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

    async fn set_default_for_user(
        &self,
        user_id: &str,
        artist_id: &str,
    ) -> Result<UserArtist, DomainError> {
        let txn = self.db.begin().await?;

        UserArtistEntity::find()
            .filter(Column::UserId.eq(user_id))
            .lock(LockType::Update)
            .all(&txn)
            .await?;

        UserArtistEntity::update_many()
            .col_expr(Column::IsDefault, Expr::value(false))
            .filter(Column::UserId.eq(user_id))
            .exec(&txn)
            .await?;

        UserArtistEntity::update_many()
            .col_expr(Column::IsDefault, Expr::value(true))
            .filter(Column::UserId.eq(user_id))
            .filter(Column::ArtistId.eq(artist_id))
            .exec(&txn)
            .await?;

        let updated_user_artist = UserArtistEntity::find()
            .filter(Column::UserId.eq(user_id))
            .filter(Column::ArtistId.eq(artist_id))
            .one(&txn)
            .await?
            .ok_or(DomainError::NotFound)?;

        txn.commit().await?;

        Ok(updated_user_artist)
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

    async fn find_by_artist_ids(
        &self,
        artist_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find()
            .filter(Column::ArtistId.is_in(artist_ids))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;
        Ok(user_artists)
    }

    async fn find_by_user_id_and_artist_ids(
        &self,
        user_id: &str,
        artist_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find()
            .filter(Column::UserId.eq(user_id))
            .filter(Column::ArtistId.is_in(artist_ids))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;
        Ok(user_artists)
    }

    async fn find_by_artist_id_and_user_ids(
        &self,
        artist_id: &str,
        user_ids: Vec<&str>,
    ) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .filter(Column::UserId.is_in(user_ids))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;
        Ok(user_artists)
    }

    async fn find_by_status(
        &self,
        status: UserArtistStatus,
    ) -> Result<Vec<UserArtist>, DomainError> {
        let user_artists = UserArtistEntity::find()
            .filter(Column::Status.eq(status))
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

#[cfg(test)]
mod tests {
    use super::*;
    use sea_orm::{DbBackend, MockDatabase, MockExecResult};

    fn user_artist(id: i32, user_id: &str, artist_id: &str, is_default: bool) -> UserArtist {
        UserArtist {
            id,
            user_id: user_id.to_string(),
            artist_id: artist_id.to_string(),
            is_admin: false,
            status: UserArtistStatus::Accept,
            request_message: None,
            is_default,
            requested_at: None,
        }
    }

    #[tokio::test]
    async fn set_default_for_user_locks_user_artist_rows_before_switching_default() {
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results(vec![
                vec![
                    user_artist(2, "user-1", "artist-2", true),
                    user_artist(1, "user-1", "artist-1", true),
                ],
                vec![user_artist(2, "user-1", "artist-2", true)],
            ])
            .append_exec_results([
                MockExecResult {
                    last_insert_id: 0,
                    rows_affected: 2,
                },
                MockExecResult {
                    last_insert_id: 0,
                    rows_affected: 1,
                },
            ])
            .into_connection();
        let repo = UserArtistRepoImpl::new(db);

        let updated = repo
            .set_default_for_user("user-1", "artist-2")
            .await
            .expect("default artist should update");

        assert_eq!(updated.artist_id, "artist-2");
        assert!(updated.is_default);

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("BEGIN"), "{log}");
        assert!(log.contains("SELECT"), "{log}");
        assert!(log.contains("FOR UPDATE"), "{log}");
        assert_eq!(log.matches("SET").count(), 2, "{log}");
        assert!(log.contains("COMMIT"), "{log}");
        assert!(!log.contains("ROLLBACK"), "{log}");
    }
}
