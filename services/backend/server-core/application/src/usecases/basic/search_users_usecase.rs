use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::users::Model as User;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct SearchUsersInput {
    pub username: String,
}

pub struct SearchUsersOutput {
    pub users: Vec<User>,
}

#[async_trait]
pub trait SearchUsersUsecaseTrait: Send + Sync {
    async fn search_users(
        &self,
        input: SearchUsersInput,
    ) -> Result<SearchUsersOutput, anyhow::Error>;
}

pub struct SearchUsersUsecase {
    users_repo: Arc<dyn UsersRepository>,
}

impl SearchUsersUsecase {
    pub fn new(users_repo: Arc<dyn UsersRepository>) -> Self {
        Self { users_repo }
    }
}

#[async_trait]
impl SearchUsersUsecaseTrait for SearchUsersUsecase {
    async fn search_users(
        &self,
        input: SearchUsersInput,
    ) -> Result<SearchUsersOutput, anyhow::Error> {
        let users = self.users_repo.search_users(&input.username).await?;
        Ok(SearchUsersOutput { users })
    }
}

#[cfg(test)]
#[path = "search_users_usecase_tests.rs"]
mod tests;
