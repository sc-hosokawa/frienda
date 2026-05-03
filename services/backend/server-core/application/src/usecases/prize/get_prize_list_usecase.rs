use async_trait::async_trait;
use std::{collections::HashMap, sync::Arc};

use domain::entities::exchange_prize_history::Model as ExchangePrizeHistory;
use domain::entities::prizes::Model as Prize;
use domain::entities::users::Model as User;
use domain::repositories::exchange_prize_history_repo::ExchangePrizeHistoryRepository;
use domain::repositories::prizes_repo::PrizesRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct GetPrizeListInput {
    pub limit: u32,
    pub offset: u32,
}

pub struct GetPrizeListOutput {
    pub prizes: Vec<Prize>,
}

pub struct GetPrizeListByUserIdOutput {
    pub un_used_prizes: Vec<Prize>,
    pub used_prizes: Vec<Prize>,
    pub requested_prizes: Vec<Prize>,
}

pub struct GetPrizeHistoryByUserIdOutput {
    pub used_history: Vec<ExchangeHistory>,
    pub requested_history: Vec<ExchangeHistory>,
    pub un_used_history: Vec<ExchangeHistory>,
}

#[derive(Debug)]
pub struct ExchangeHistory {
    pub history: ExchangePrizeHistory,
    pub user: User,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetPrizeListUsecaseTrait: Send + Sync {
    async fn get_prize_list(
        &self,
        input: GetPrizeListInput,
    ) -> Result<GetPrizeListOutput, anyhow::Error>;
    async fn get_prize_list_by_user_id(
        &self,
        user_id: String,
    ) -> Result<GetPrizeListByUserIdOutput, anyhow::Error>;
    async fn get_prize_history_by_user_id(
        &self,
        user_id: String,
        prize_id: i32,
    ) -> Result<GetPrizeHistoryByUserIdOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetPrizeListUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
    exchange_prize_history_repo: Arc<dyn ExchangePrizeHistoryRepository>,
    users_repo: Arc<dyn UsersRepository>,
}

impl GetPrizeListUsecase {
    pub fn new(
        prizes_repo: Arc<dyn PrizesRepository>,
        exchange_prize_history_repo: Arc<dyn ExchangePrizeHistoryRepository>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            prizes_repo,
            exchange_prize_history_repo,
            users_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetPrizeListUsecaseTrait for GetPrizeListUsecase {
    async fn get_prize_list(
        &self,
        input: GetPrizeListInput,
    ) -> Result<GetPrizeListOutput, anyhow::Error> {
        let prizes = self.prizes_repo.list(input.limit, input.offset).await?;
        Ok(GetPrizeListOutput { prizes })
    }

    async fn get_prize_list_by_user_id(
        &self,
        user_id: String,
    ) -> Result<GetPrizeListByUserIdOutput, anyhow::Error> {
        // ユーザーの交換履歴を取得
        let exchange_prize_history: Vec<ExchangePrizeHistory> = self
            .exchange_prize_history_repo
            .get_by_user_id(&user_id)
            .await?;

        // 交換履歴から景品IDのリストを作成
        let prize_ids: Vec<i32> = exchange_prize_history
            .iter()
            .map(|history| history.prize_id)
            .collect();

        // 景品の詳細情報を一括取得
        let prizes: Vec<Prize> = if !prize_ids.is_empty() {
            self.prizes_repo.get_by_ids(prize_ids).await?
        } else {
            vec![]
        };

        // 使用済みと未使用の景品に分類
        let mut used_prizes: Vec<Prize> = Vec::new();
        let mut un_used_prizes: Vec<Prize> = Vec::new();
        let mut requested_prizes: Vec<Prize> = Vec::new();

        for history in exchange_prize_history {
            if let Some(prize) = prizes.iter().find(|p| p.id == history.prize_id) {
                // amount分だけ景品を複製
                for _ in 0..history.amount {
                    if history.is_used {
                        used_prizes.push(prize.clone());
                    } else if history.is_requested {
                        requested_prizes.push(prize.clone());
                    } else {
                        un_used_prizes.push(prize.clone());
                    }
                }
            }
        }

        Ok(GetPrizeListByUserIdOutput {
            un_used_prizes,
            requested_prizes,
            used_prizes,
        })
    }

    async fn get_prize_history_by_user_id(
        &self,
        user_id: String,
        prize_id: i32,
    ) -> Result<GetPrizeHistoryByUserIdOutput, anyhow::Error> {
        let exchange_prize_history: Vec<ExchangePrizeHistory> = self
            .exchange_prize_history_repo
            .get_by_prize_id(prize_id)
            .await?;

        println!("exchange_prize_history: {:?}", exchange_prize_history);

        let users_by_id: HashMap<String, User> = if exchange_prize_history.is_empty() {
            HashMap::new()
        } else {
            self.users_repo
                .find_by_ids(
                    exchange_prize_history
                        .iter()
                        .map(|history| history.user.as_str())
                        .collect(),
                )
                .await
                .map_err(|e| anyhow::anyhow!("Failed to fetch users: {}", e))?
                .into_iter()
                .map(|user| (user.id.clone(), user))
                .collect()
        };

        let mut used_history: Vec<ExchangeHistory> = Vec::new();
        let mut requested_history: Vec<ExchangeHistory> = Vec::new();
        let mut un_used_history: Vec<ExchangeHistory> = Vec::new();

        for history in exchange_prize_history {
            let user = match users_by_id.get(&history.user) {
                Some(user) => user.clone(),
                None => continue,
            };

            println!("user: {:?}", user);

            let exchange_history = ExchangeHistory {
                history: history.clone(),
                user,
            };

            if history.is_used {
                used_history.push(exchange_history);
            } else if history.is_requested {
                requested_history.push(exchange_history);
            } else {
                un_used_history.push(exchange_history);
            }
        }

        Ok(GetPrizeHistoryByUserIdOutput {
            used_history,
            requested_history,
            un_used_history,
        })
    }
}
