use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::quests::{
    ActiveModel as QuestActiveModel, Column, Entity as QuestEntity, Model as Quest,
};
use domain::repositories::quests_repo::QuestsRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct QuestsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl QuestsRepository for QuestsRepoImpl {
    async fn create(&self, quest: QuestActiveModel) -> Result<Quest, DomainError> {
        let res: InsertResult<QuestActiveModel> = QuestEntity::insert(quest).exec(&self.db).await?;
        let inserted_quest = QuestEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_quest.unwrap())
    }

    async fn update(&self, quest: QuestActiveModel) -> Result<Quest, DomainError> {
        let updated_quest: Quest = quest.update(&self.db).await?;
        Ok(updated_quest)
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<Quest>, DomainError> {
        let quest = QuestEntity::find_by_id(id).one(&self.db).await?;
        Ok(quest)
    }
    async fn find_all(&self) -> Result<Vec<Quest>, DomainError> {
        let quests = QuestEntity::find().all(&self.db).await?;
        Ok(quests)
    }
    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res: DeleteResult = QuestEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }
    async fn find_by_name(&self, name: &str) -> Result<Vec<Quest>, DomainError> {
        let quests = QuestEntity::find()
            .filter(Column::Name.eq(name))
            .all(&self.db)
            .await?;
        Ok(quests)
    }
    async fn find_recent(&self, limit: u64) -> Result<Vec<Quest>, DomainError> {
        let quests = QuestEntity::find()
            .order_by_desc(Column::Id)
            .limit(limit)
            .all(&self.db)
            .await?;
        Ok(quests)
    }
}
