use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::sea_orm_active_enums::UserCategory;
use domain::entities::users::{ActiveModel as UserActiveModel, Model as User};
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct CreateUserInput {
    pub id: String,
    pub email: String,
    pub name: String,
    pub image_url: Option<String>,
    pub invited_by: Option<String>,
    pub category: UserCategory,
    pub primary_category: UserCategory,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait CreateUserUsecaseTrait: Send + Sync {
    async fn create(&self, input: CreateUserInput) -> Result<User, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct CreateUserUsecase {
    users_repo: Arc<dyn UsersRepository>,
}

impl CreateUserUsecase {
    pub fn new(users_repo: Arc<dyn UsersRepository>) -> Self {
        Self { users_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl CreateUserUsecaseTrait for CreateUserUsecase {
    async fn create(&self, input: CreateUserInput) -> Result<User, anyhow::Error> {
        let user: UserActiveModel = UserActiveModel {
            id: ActiveValue::Set(input.id),
            email: ActiveValue::Set(input.email),
            username: ActiveValue::Set(input.name),
            img_url: ActiveValue::Set(input.image_url),
            invited_by: ActiveValue::Set(input.invited_by),
            category: ActiveValue::Set(input.category),
            primary_category: ActiveValue::Set(input.primary_category),
            ..Default::default()
        };

        let res = self.users_repo.create(user).await?;

        Ok(res)
    }
}
