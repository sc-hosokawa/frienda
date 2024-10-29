use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::room_user::{
    ActiveModel as RoomUserActiveModel, Column, Entity as RoomUserEntity, Model as RoomUser,
};
use domain::repositories::room_user_repo::RoomUserRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct RoomUserRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl RoomUserRepository for RoomUserRepoImpl {
    async fn create(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError> {
        let res: InsertResult<RoomUserActiveModel> =
            RoomUserEntity::insert(room_user).exec(&self.db).await?;

        let inserted_room_user = RoomUserEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_room_user.unwrap())
    }

    async fn create_many(&self, room_users: Vec<RoomUserActiveModel>) -> Result<(), DomainError> {
        let _res = RoomUserEntity::insert_many(room_users)
            .exec(&self.db)
            .await?;
        Ok(())
    }

    async fn update(&self, room_user: RoomUserActiveModel) -> Result<RoomUser, DomainError> {
        let updated_room_user: RoomUser = room_user.update(&self.db).await?;
        Ok(updated_room_user)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _res: DeleteResult = RoomUserEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_room_id(&self, room_id: Uuid) -> Result<Vec<RoomUser>, DomainError> {
        let room_users = RoomUserEntity::find()
            .filter(Column::RoomId.eq(room_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(room_users)
    }

    async fn get_by_user_id(&self, user_id: &str) -> Result<Vec<RoomUser>, DomainError> {
        let room_users = RoomUserEntity::find()
            .filter(Column::UserId.eq(user_id))
            .order_by_desc(Column::Id)
            .all(&self.db)
            .await?;

        Ok(room_users)
    }
}
