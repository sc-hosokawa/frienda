use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::collections::HashMap;
use std::sync::Arc;

use crate::services::onchain_fetcher::{CredentialBalance, OnchainFetcherServiceTrait};
use domain::entities::users::{ActiveModel as UsersActiveModel, Model as Users};
use domain::repositories::users_repo::UsersRepository;
use shared::numeric::checked_i64_to_i32;

#[async_trait]
pub trait CredentialsUsecaseTrait: Send + Sync {
    async fn fetch_credential_balances(&self) -> Result<(), anyhow::Error>;
}

pub struct CredentialsUsecase {
    users_repo: Arc<dyn UsersRepository>,
    onchain_fetcher_service: Arc<dyn OnchainFetcherServiceTrait>,
}

impl CredentialsUsecase {
    pub fn new(
        users_repo: Arc<dyn UsersRepository>,
        onchain_fetcher_service: Arc<dyn OnchainFetcherServiceTrait>,
    ) -> Self {
        Self {
            users_repo,
            onchain_fetcher_service,
        }
    }
}

#[async_trait]
impl CredentialsUsecaseTrait for CredentialsUsecase {
    async fn fetch_credential_balances(&self) -> Result<(), anyhow::Error> {
        let users: Vec<Users> = self.users_repo.find_users_have_evm_addr().await?;
        let evm_addrs: Vec<String> = users
            .iter()
            .map(|user| user.evm_addr.clone().unwrap())
            .collect();

        let res: Vec<CredentialBalance> = self
            .onchain_fetcher_service
            .fetch_credential_balances(evm_addrs)
            .await?;
        let mut user_balances: HashMap<String, i64> = HashMap::new();
        for balance in res {
            user_balances.insert(balance.evm_addr, balance.balance);
        }

        tracing::info!("user_balances: {:?}", user_balances);

        let mut users_active_models: Vec<UsersActiveModel> = Vec::new();
        for user in users {
            let balance: &i64 = user_balances.get(&user.evm_addr.unwrap()).unwrap_or(&0);
            let user: UsersActiveModel = UsersActiveModel {
                id: ActiveValue::Set(user.id),
                credential: ActiveValue::Set(
                    checked_i64_to_i32(*balance, "credential_balance")
                        .map_err(anyhow::Error::msg)?,
                ),
                ..Default::default()
            };
            users_active_models.push(user);
        }
        tracing::info!("users_active_models: {:?}", users_active_models);
        self.users_repo.update_many(users_active_models).await?;

        Ok(())
    }
}
