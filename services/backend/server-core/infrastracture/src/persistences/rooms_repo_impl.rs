use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use uuid::Uuid;

use domain::entities::rooms::{
    ActiveModel as RoomActiveModel, Entity as RoomEntity, Model as Room,
};
use domain::repositories::rooms_repo::RoomsRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct RoomsRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl RoomsRepository for RoomsRepoImpl {
    async fn create(&self, room: RoomActiveModel) -> Result<Room, DomainError> {
        let res: InsertResult<RoomActiveModel> = RoomEntity::insert(room).exec(&self.db).await?;

        let inserted_room = RoomEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;

        Ok(inserted_room.unwrap())
    }

    async fn update(&self, room: RoomActiveModel) -> Result<Room, DomainError> {
        let res = RoomEntity::update(room).exec(&self.db).await?;
        Ok(res)
    }

    async fn delete(&self, id: Uuid) -> Result<(), DomainError> {
        let _res: DeleteResult = RoomEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_by_id(&self, id: Uuid) -> Result<Option<Room>, DomainError> {
        let room = RoomEntity::find_by_id(id).one(&self.db).await?;
        Ok(room)
    }
}
