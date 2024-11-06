use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::quest_user::{
    ActiveModel as QuestUserActiveModel, Column, Entity as QuestUserEntity, Model as QuestUser,
};
use domain::repositories::quest_user_repo::QuestUserRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct QuestUserRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl QuestUserRepository for QuestUserRepoImpl {
    async fn create(&self, quest_user: QuestUserActiveModel) -> Result<QuestUser, DomainError> {
        let res: InsertResult<QuestUserActiveModel> =
            QuestUserEntity::insert(quest_user).exec(&self.db).await?;
        let inserted_quest_user = QuestUserEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_quest_user.unwrap())
    }
    async fn update(&self, quest_user: QuestUserActiveModel) -> Result<QuestUser, DomainError> {
        let updated_quest_user: QuestUser = quest_user.update(&self.db).await?;
        Ok(updated_quest_user)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res: DeleteResult = QuestUserEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<QuestUser>, DomainError> {
        let quest_user = QuestUserEntity::find_by_id(id).one(&self.db).await?;
        Ok(quest_user)
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<QuestUser>, DomainError> {
        let quest_users = QuestUserEntity::find()
            .filter(Column::User.eq(user_id))
            .all(&self.db)
            .await?;
        Ok(quest_users)
    }

    async fn get_by_user_and_status(
        &self,
        user_id: &str,
        is_done: bool,
    ) -> Result<Vec<QuestUser>, DomainError> {
        let quest_users = QuestUserEntity::find()
            .filter(Column::User.eq(user_id))
            .filter(Column::IsDone.eq(is_done))
            .all(&self.db)
            .await?;
        Ok(quest_users)
    }
}
