use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;

use domain::entities::sea_orm_active_enums::{UserCategory, UserStatus};
use domain::entities::users::{
    ActiveModel as ActiveUser, Column, Entity as UserEntity, Model as User,
};
use domain::repositories::users_repo::UsersRepository;
use shared::error::domain_err::DomainError;

#[derive(new)]
pub struct UsersRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl UsersRepository for UsersRepoImpl {
    async fn create(&self, user: ActiveUser) -> Result<User, DomainError> {
        let res: InsertResult<ActiveUser> = UserEntity::insert(user).exec(&self.db).await?;

        let inserted_user = UserEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(inserted_user.unwrap())
    }

    async fn update(&self, user: ActiveUser) -> Result<User, DomainError> {
        let res = UserEntity::update(user).exec(&self.db).await?;
        Ok(res)
    }

    async fn update_fsp(&self, id: &str, fsp: i32) -> Result<User, DomainError> {
        let user = UserEntity::find_by_id(id).one(&self.db).await?.unwrap();

        let new_fsp: i32 = user.fsp + fsp;

        let update_user: ActiveUser = ActiveUser {
            id: ActiveValue::Set(user.id),
            fsp: ActiveValue::Set(new_fsp),
            ..Default::default()
        };

        let res = UserEntity::update(update_user).exec(&self.db).await?;

        Ok(res)
    }

    async fn find_by_id(&self, id: &str) -> Result<Option<User>, DomainError> {
        let user = UserEntity::find_by_id(id).one(&self.db).await?;
        Ok(user)
    }

    async fn find_by_ids(&self, ids: Vec<&str>) -> Result<Vec<User>, DomainError> {
        let users = UserEntity::find()
            .filter(Column::Id.is_in(ids))
            .all(&self.db)
            .await?;
        Ok(users)
    }

    // [TODO] ユーザーが存在しない場合の処理
    async fn find_by_id_and_update_fsp(
        &self,
        id: &str,
        fsp: i32,
    ) -> Result<Option<User>, DomainError> {
        let user = UserEntity::find_by_id(id).one(&self.db).await?.unwrap();

        let new_fsp: i32 = user.fsp + fsp;

        let update_user: ActiveUser = ActiveUser {
            id: ActiveValue::Set(user.id),
            fsp: ActiveValue::Set(new_fsp),
            ..Default::default()
        };

        let res = UserEntity::update(update_user).exec(&self.db).await?;

        Ok(Some(res))
    }

    async fn find_by_email(&self, email: &str) -> Result<Option<User>, DomainError> {
        let user = UserEntity::find()
            .filter(Column::Email.eq(email))
            .one(&self.db)
            .await?;
        Ok(user)
    }

    async fn delete(&self, id: &str) -> Result<(), DomainError> {
        let _res: DeleteResult = UserEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn list(&self, limit: usize, offset: usize) -> Result<Vec<User>, DomainError> {
        let users = UserEntity::find()
            .limit(limit as u64)
            .offset(offset as u64)
            .all(&self.db)
            .await?;
        Ok(users)
    }

    async fn get_all_users(&self) -> Result<Vec<User>, DomainError> {
        let users = UserEntity::find().all(&self.db).await?;
        Ok(users)
    }

    async fn find_by_username(&self, username: &str) -> Result<Option<User>, DomainError> {
        let user = UserEntity::find()
            .filter(Column::Username.eq(username))
            .one(&self.db)
            .await?;
        Ok(user)
    }

    async fn find_by_evm_addr(&self, evm_addr: &str) -> Result<Option<User>, DomainError> {
        let user = UserEntity::find()
            .filter(Column::EvmAddr.eq(evm_addr))
            .one(&self.db)
            .await?;
        Ok(user)
    }

    async fn find_by_invited_by(&self, invited_by: &str) -> Result<Vec<User>, DomainError> {
        let users = UserEntity::find()
            .filter(Column::InvitedBy.eq(invited_by))
            .order_by_desc(Column::UpdatedAt)
            .all(&self.db)
            .await?;
        Ok(users)
    }

    async fn update_status(&self, id: &str, status: UserStatus) -> Result<User, DomainError> {
        let user = UserEntity::find_by_id(id).one(&self.db).await?.unwrap();

        let update_user: ActiveUser = ActiveUser {
            id: ActiveValue::Set(user.id),
            status: ActiveValue::Set(status),
            ..Default::default()
        };

        let res = UserEntity::update(update_user).exec(&self.db).await?;
        Ok(res)
    }

    async fn find_by_category(&self, category: UserCategory) -> Result<Vec<User>, DomainError> {
        let users = UserEntity::find()
            .filter(Column::Category.eq(category))
            .order_by_desc(Column::UpdatedAt)
            .all(&self.db)
            .await?;
        Ok(users)
    }

    async fn count(&self) -> Result<i64, DomainError> {
        let count = UserEntity::find().count(&self.db).await?;
        Ok(count as i64)
    }

    async fn find_by_username_or_email(
        &self,
        username_or_email: &str,
    ) -> Result<Option<User>, DomainError> {
        let user = UserEntity::find()
            .filter(
                Condition::any()
                    .add(Column::Username.eq(username_or_email))
                    .add(Column::Email.eq(username_or_email)),
            )
            .one(&self.db)
            .await?;
        Ok(user)
    }
}
