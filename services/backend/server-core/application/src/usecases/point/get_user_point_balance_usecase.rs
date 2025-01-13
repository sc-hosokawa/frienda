use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::users::Model as User;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct GetUserPointBalanceInput {
    pub user_id: String,
}

pub struct GetUserPointBalanceOutput {
    pub fsp_balance: i32,
    pub fsp_balance_temp: i32,
    pub credential_balance: i32,
    pub is_credential_available: bool,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetUserPointBalanceUsecaseTrait: Send + Sync {
    async fn get_user_point_balance(
        &self,
        input: GetUserPointBalanceInput,
    ) -> Result<GetUserPointBalanceOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetUserPointBalanceUsecase {
    users_repo: Arc<dyn UsersRepository>,
}

impl GetUserPointBalanceUsecase {
    pub fn new(users_repo: Arc<dyn UsersRepository>) -> Self {
        Self { users_repo }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetUserPointBalanceUsecaseTrait for GetUserPointBalanceUsecase {
    async fn get_user_point_balance(
        &self,
        input: GetUserPointBalanceInput,
    ) -> Result<GetUserPointBalanceOutput, anyhow::Error> {
        let user: User = self
            .users_repo
            .find_by_id(&input.user_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found"))?;
        let is_credential_available: bool = user.evm_addr.is_some();

        Ok(GetUserPointBalanceOutput {
            fsp_balance: user.fsp,
            fsp_balance_temp: user.fsp_temp,
            credential_balance: user.credential,
            is_credential_available,
        })
    }
}
