use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::gender_gen_playback::{
    ActiveModel as GenderGenPlaybackActiveModel, Column, Entity as GenderGenPlaybackEntity,
    Model as GenderGenPlayback,
};
use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct GenderGenPlaybackRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl GenderGenPlaybackRepository for GenderGenPlaybackRepoImpl {
    async fn create(
        &self,
        model: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError> {
        let res: InsertResult<GenderGenPlaybackActiveModel> =
            GenderGenPlaybackEntity::insert(model)
                .exec(&self.db)
                .await?;

        let inserted_model = GenderGenPlaybackEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_model.unwrap())
    }

    async fn update(
        &self,
        model: GenderGenPlaybackActiveModel,
    ) -> Result<GenderGenPlayback, DomainError> {
        let res: GenderGenPlayback = model.update(&self.db).await?;
        Ok(res)
    }

    async fn insert_many(
        &self,
        models: Vec<GenderGenPlaybackActiveModel>,
    ) -> Result<(), DomainError> {
        GenderGenPlaybackEntity::insert_many(models)
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        GenderGenPlaybackEntity::delete_by_id(id)
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<GenderGenPlayback>, DomainError> {
        let res: Option<GenderGenPlayback> = GenderGenPlaybackEntity::find_by_id(id)
            .one(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrc(&self, isrc: &str) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrc_and_year(
        &self,
        isrc: &str,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Isrc.eq(isrc))
            .filter(Column::Date.like(&format!("{}%", year)))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs(
        &self,
        isrcs: Vec<String>,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_isrcs_and_year(
        &self,
        isrcs: Vec<String>,
        year: &str,
    ) -> Result<Vec<GenderGenPlayback>, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .filter(Column::Date.like(&format!("{}%", year)))
            .filter(Column::Isrc.is_in(isrcs))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_lastest_id(&self) -> Result<i32, DomainError> {
        let res: Vec<GenderGenPlayback> = GenderGenPlaybackEntity::find()
            .order_by(Column::Id, Order::Desc)
            .limit(1)
            .all(&self.db)
            .await?;

        Ok(res.first().map_or(0, |record| record.id))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use domain::repositories::gender_gen_playback_repo::GenderGenPlaybackRepository;
    use sea_orm::{DbBackend, MockDatabase};

    #[tokio::test]
    async fn find_by_isrcs_filters_requested_isrcs() {
        // dashboard の属性集計対象が別 track に広がらないよう、ISRC list filter を固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<GenderGenPlayback>::new()])
            .into_connection();
        let repo = GenderGenPlaybackRepoImpl::new(db);

        repo.find_by_isrcs(vec!["ISRC1".to_string(), "ISRC2".to_string()])
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("WHERE"), "{log}");
        assert!(log.contains("gender_gen_playback"), "{log}");
        assert!(log.contains("isrc"), "{log}");
        assert!(log.contains(" IN "), "{log}");
        assert!(log.contains("ISRC1"), "{log}");
        assert!(log.contains("ISRC2"), "{log}");
    }

    #[tokio::test]
    async fn find_by_isrc_and_year_filters_isrc_and_year_prefix() {
        // 年指定集計では指定 ISRC かつ指定年だけに閉じることを SQL 条件として固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<GenderGenPlayback>::new()])
            .into_connection();
        let repo = GenderGenPlaybackRepoImpl::new(db);

        repo.find_by_isrc_and_year("ISRC1", "2025").await.unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("gender_gen_playback"), "{log}");
        assert!(log.contains("isrc"), "{log}");
        assert!(log.contains(" = "), "{log}");
        assert!(log.contains("date"), "{log}");
        assert!(log.contains(" LIKE "), "{log}");
        assert!(log.contains("2025%"), "{log}");
    }

    #[tokio::test]
    async fn find_by_isrcs_and_year_filters_isrc_list_and_year_prefix() {
        // artist/UPC 由来の複数 ISRC 集計でも、年条件が抜けて全期間集計にならないことを固定する。
        let db = MockDatabase::new(DbBackend::Postgres)
            .append_query_results([Vec::<GenderGenPlayback>::new()])
            .into_connection();
        let repo = GenderGenPlaybackRepoImpl::new(db);

        repo.find_by_isrcs_and_year(vec!["ISRC1".to_string()], "2025")
            .await
            .unwrap();

        let log = format!("{:?}", repo.db.into_transaction_log());
        assert!(log.contains("gender_gen_playback"), "{log}");
        assert!(log.contains("date"), "{log}");
        assert!(log.contains(" LIKE "), "{log}");
        assert!(log.contains("isrc"), "{log}");
        assert!(log.contains(" IN "), "{log}");
        assert!(log.contains("2025%"), "{log}");
        assert!(log.contains("ISRC1"), "{log}");
    }
}
