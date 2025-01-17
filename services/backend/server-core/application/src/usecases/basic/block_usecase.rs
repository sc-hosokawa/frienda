use async_trait::async_trait;
use sea_orm::*;
use std::sync::Arc;

use domain::entities::user_blocks::{ActiveModel as UserBlocksActiveModel, Model as UserBlocks};
use domain::repositories::user_blocks_repo::UserBlocksRepo;

pub struct UserBlocksInput {
    pub blocked_user_id: String,
    pub blocker_user_id: String,
}

pub struct UserBlocksOutput {
    pub id: i32,
}

pub struct UserBlocksDataOutput {
    pub id: i32,
    pub blocked_user_id: String,
    pub blocker_user_id: String,
    pub is_solved: bool,
}

#[async_trait]
pub trait UserBlocksUsecaseTrait: Send + Sync {
    async fn block_user(&self, input: UserBlocksInput) -> Result<UserBlocksOutput, anyhow::Error>;
    async fn mark_as_solved(&self, id: i32) -> Result<UserBlocksOutput, anyhow::Error>;
    async fn delete_block(&self, id: i32) -> Result<(), anyhow::Error>;
    async fn get_all_block_data(&self) -> Result<Vec<UserBlocksDataOutput>, anyhow::Error>;
    async fn get_block_data(&self, id: i32) -> Result<UserBlocksDataOutput, anyhow::Error>;
}

pub struct UserBlocksUsecase {
    user_blocks_repo: Arc<dyn UserBlocksRepo>,
}

impl UserBlocksUsecase {
    pub fn new(user_blocks_repo: Arc<dyn UserBlocksRepo>) -> Self {
        Self { user_blocks_repo }
    }
}

#[async_trait]
impl UserBlocksUsecaseTrait for UserBlocksUsecase {
    async fn block_user(&self, input: UserBlocksInput) -> Result<UserBlocksOutput, anyhow::Error> {
        let active_model: UserBlocksActiveModel = UserBlocksActiveModel {
            blocked_user_id: Set(input.blocked_user_id),
            blocker_user_id: Set(input.blocker_user_id),
            ..Default::default()
        };
        let res: UserBlocks = self.user_blocks_repo.create(active_model).await?;
        Ok(UserBlocksOutput { id: res.id })
    }

    async fn mark_as_solved(&self, id: i32) -> Result<UserBlocksOutput, anyhow::Error> {
        let active_model: UserBlocksActiveModel = UserBlocksActiveModel {
            id: Set(id),
            is_solved: Set(true),
            ..Default::default()
        };
        let res: UserBlocks = self.user_blocks_repo.update(active_model).await?;
        Ok(UserBlocksOutput { id: res.id })
    }

    async fn delete_block(&self, id: i32) -> Result<(), anyhow::Error> {
        self.user_blocks_repo.delete(id).await?;
        Ok(())
    }

    async fn get_all_block_data(&self) -> Result<Vec<UserBlocksDataOutput>, anyhow::Error> {
        let res: Vec<UserBlocks> = self.user_blocks_repo.find_all().await?;
        Ok(res
            .into_iter()
            .map(|block| UserBlocksDataOutput {
                id: block.id,
                blocked_user_id: block.blocked_user_id,
                blocker_user_id: block.blocker_user_id,
                is_solved: block.is_solved,
            })
            .collect())
    }

    async fn get_block_data(&self, id: i32) -> Result<UserBlocksDataOutput, anyhow::Error> {
        let res: UserBlocks = self.user_blocks_repo.find_by_id(id).await?.unwrap();
        Ok(UserBlocksDataOutput {
            id: res.id,
            blocked_user_id: res.blocked_user_id,
            blocker_user_id: res.blocker_user_id,
            is_solved: res.is_solved,
        })
    }
}
