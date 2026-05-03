use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::tracks::{
    ActiveModel as TracksActiveModel, Column, Entity as TracksEntity, Model as Tracks,
};
use domain::repositories::tracks_repo::{SearchTracksOptions, TracksRepository};
use shared::error::domain_err::DomainError;
use tracing::info;

#[derive(new)]
pub struct TracksRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl TracksRepository for TracksRepoImpl {
    async fn create(&self, model: TracksActiveModel) -> Result<Tracks, DomainError> {
        let res = TracksEntity::insert(model).exec(&self.db).await?;
        let inserted_model: Option<Tracks> = TracksEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn create_many(&self, models: Vec<TracksActiveModel>) -> Result<bool, DomainError> {
        info!("========== Before insert: models count = {}", models.len());

        let try_res = TracksEntity::insert_many(models)
            .on_conflict(
                sea_orm::sea_query::OnConflict::column(Column::Isrc)
                    .do_nothing()
                    .to_owned(),
            )
            .do_nothing()
            .exec(&self.db)
            .await?;

        let success = matches!(try_res, TryInsertResult::Inserted(_));
        info!(
            "========== Insert completed: {}",
            if success { "inserted" } else { "skipped" }
        );

        Ok(success)
    }

    async fn update(&self, model: TracksActiveModel) -> Result<Tracks, DomainError> {
        let res: Tracks = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: &str) -> Result<(), DomainError> {
        TracksEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_isrc(&self, isrc: &str) -> Result<Option<Tracks>, DomainError> {
        let res: Option<Tracks> = TracksEntity::find_by_id(isrc).one(&self.db).await?;
        Ok(res)
    }

    async fn get_by_isrcs(&self, isrcs: Vec<String>) -> Result<Vec<Tracks>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_artist_id(&self, artist_id: &str) -> Result<Vec<Tracks>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find()
            .filter(Column::ArtistId.eq(artist_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn count(&self) -> Result<i64, DomainError> {
        let res: u64 = TracksEntity::find().count(&self.db).await?;
        Ok(res as i64)
    }

    async fn find_all(&self) -> Result<Vec<Tracks>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn find_all_isrcs(&self) -> Result<Vec<String>, DomainError> {
        let res: Vec<Tracks> = TracksEntity::find().all(&self.db).await?;
        Ok(res.iter().map(|t| t.isrc.clone()).collect())
    }

    async fn search(&self, options: SearchTracksOptions) -> Result<Vec<Tracks>, DomainError> {
        let mut query: Select<TracksEntity> = TracksEntity::find();

        if let Some(isrc) = options.isrc {
            query = query.filter(Column::Isrc.eq(isrc));
        }

        if let Some(track_title) = options.track_title {
            query = query.filter(Column::Title.contains(&track_title));
        }

        let res: Vec<Tracks> = query.all(&self.db).await?;
        Ok(res)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::tracks_repo::TracksRepository;
    use sea_orm::{DbBackend, MockDatabase};

    #[tokio::test]
    async fn get_by_isrcs_filters_requested_tracks_for_dashboard_titles() {
        // dashboard の track title 解決で別 ISRC の title を混ぜないよう、ISRC list filter を固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<Tracks>::new()])
            .into_connection();
        let repo = TracksRepoImpl::new(db);

        repo.get_by_isrcs(vec!["ISRC1".to_string(), "ISRC2".to_string()])
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("tracks"), "{log}");
        assert!(log.contains("isrc"), "{log}");
        assert!(log.contains(" IN "), "{log}");
        assert!(log.contains("ISRC1"), "{log}");
        assert!(log.contains("ISRC2"), "{log}");
    }

    #[tokio::test]
    async fn find_by_artist_id_filters_artist_tracks() {
        // artist 単位で track を扱う dashboard 系処理が、他 artist の track を含めないことを固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<Tracks>::new()])
            .into_connection();
        let repo = TracksRepoImpl::new(db);

        repo.find_by_artist_id("artist-1").await.unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("tracks"), "{log}");
        assert!(log.contains("artist_id"), "{log}");
        assert!(log.contains(" = "), "{log}");
        assert!(log.contains("artist-1"), "{log}");
    }
}
