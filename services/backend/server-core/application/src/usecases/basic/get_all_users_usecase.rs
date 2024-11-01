use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::users::Model as User;
use domain::repositories::users_repo::UsersRepository;

//
// Define the output for the usecase
//
pub struct AllUsersData {
    pub users: Vec<UserSimpleData>,
}
pub struct UserSimpleData {
    pub id: String,
    pub name: String,
    pub image_url: Option<String>,
}

#[async_trait]
pub trait GetAllUsersUsecaseTrait: Send + Sync {
    async fn get_all_users(&self) -> Result<AllUsersData, anyhow::Error>;
    async fn get_all_users_except_me(&self, user_id: String)
        -> Result<AllUsersData, anyhow::Error>;
}

pub struct GetAllUsersUsecase {
    users_repo: Arc<dyn UsersRepository>,
}
impl GetAllUsersUsecase {
    pub fn new(users_repo: Arc<dyn UsersRepository>) -> Self {
        Self { users_repo }
    }
}

#[async_trait]
impl GetAllUsersUsecaseTrait for GetAllUsersUsecase {
    async fn get_all_users(&self) -> Result<AllUsersData, anyhow::Error> {
        let users: Vec<User> = self.users_repo.get_all_users().await?;
        let users_simple_data: Vec<UserSimpleData> = users
            .iter()
            .map(|user| UserSimpleData {
                id: user.id.clone(),
                name: user.username.clone(),
                image_url: user.img_url.clone(),
            })
            .collect();
        Ok(AllUsersData {
            users: users_simple_data,
        })
    }

    async fn get_all_users_except_me(
        &self,
        user_id: String,
    ) -> Result<AllUsersData, anyhow::Error> {
        let users: Vec<User> = self.users_repo.get_all_users().await?;
        let users_simple_data: Vec<UserSimpleData> = users
            .iter()
            .filter(|user| user.id != user_id)
            .map(|user| UserSimpleData {
                id: user.id.clone(),
                name: user.username.clone(),
                image_url: user.img_url.clone(),
            })
            .collect();
        Ok(AllUsersData {
            users: users_simple_data,
        })
    }
}
