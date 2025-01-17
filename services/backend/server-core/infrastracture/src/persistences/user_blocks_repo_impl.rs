use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::user_blocks::{
    ActiveModel as UserBlocksActiveModel, Column, Entity as UserBlocksEntity, Model as UserBlocks,
};
use domain::repositories::user_blocks_repo::UserBlocksRepo;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct UserBlocksRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl UserBlocksRepo for UserBlocksRepoImpl {
    async fn create(&self, model: UserBlocksActiveModel) -> Result<UserBlocks, DomainError> {
        let res = UserBlocksEntity::insert(model).exec(&self.db).await?;
        let inserted_user_blocks = UserBlocksEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_user_blocks.unwrap())
    }

    async fn update(&self, model: UserBlocksActiveModel) -> Result<UserBlocks, DomainError> {
        let res = model.update(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res = UserBlocksEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn find_all(&self) -> Result<Vec<UserBlocks>, DomainError> {
        let res = UserBlocksEntity::find().all(&self.db).await?;
        Ok(res)
    }

    async fn find_by_id(&self, id: i32) -> Result<Option<UserBlocks>, DomainError> {
        let res = UserBlocksEntity::find_by_id(id).one(&self.db).await?;
        Ok(res)
    }

    async fn find_by_blocked_user_id(
        &self,
        blocked_user_id: &str,
    ) -> Result<Vec<UserBlocks>, DomainError> {
        let res = UserBlocksEntity::find()
            .filter(Column::BlockedUserId.eq(blocked_user_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_blocker_user_id(
        &self,
        blocker_user_id: &str,
    ) -> Result<Vec<UserBlocks>, DomainError> {
        let res = UserBlocksEntity::find()
            .filter(Column::BlockerUserId.eq(blocker_user_id))
            .all(&self.db)
            .await?;
        Ok(res)
    }

    async fn find_by_blocked_user_id_and_blocker_user_id(
        &self,
        blocked_user_id: &str,
        blocker_user_id: &str,
    ) -> Result<Option<UserBlocks>, DomainError> {
        let res = UserBlocksEntity::find()
            .filter(Column::BlockedUserId.eq(blocked_user_id))
            .filter(Column::BlockerUserId.eq(blocker_user_id))
            .one(&self.db)
            .await?;
        Ok(res)
    }
}
