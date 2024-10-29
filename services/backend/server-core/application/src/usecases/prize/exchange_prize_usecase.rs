use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::exchange_prize_history::ActiveModel as ExchangePrizeHistoryActiveModel;
use domain::entities::txs_fsp::ActiveModel as FspTxActiveModel;
use domain::entities::users::Model as User;

use domain::repositories::exchange_prize_history_repo::ExchangePrizeHistoryRepository;
use domain::repositories::prizes_repo::PrizesRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct ExchangePrizeInput {
    pub user_id: String,
    pub prize_id: i32,
    pub amount: Option<i32>,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait ExchangePrizeUsecaseTrait: Send + Sync {
    async fn exchange(&self, input: ExchangePrizeInput) -> Result<(), anyhow::Error>;
}

//
// Implement the usecase
//
pub struct ExchangePrizeUsecase {
    prizes_repo: Arc<dyn PrizesRepository>,
    exchange_prize_history_repo: Arc<dyn ExchangePrizeHistoryRepository>,
    users_repo: Arc<dyn UsersRepository>,
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
}

impl ExchangePrizeUsecase {
    pub fn new(
        prizes_repo: Arc<dyn PrizesRepository>,
        exchange_prize_history_repo: Arc<dyn ExchangePrizeHistoryRepository>,
        users_repo: Arc<dyn UsersRepository>,
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
    ) -> Self {
        Self {
            prizes_repo,
            exchange_prize_history_repo,
            users_repo,
            txs_fsp_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl ExchangePrizeUsecaseTrait for ExchangePrizeUsecase {
    async fn exchange(&self, input: ExchangePrizeInput) -> Result<(), anyhow::Error> {
        // prizeの確認
        let prize = self
            .prizes_repo
            .get_by_id(input.prize_id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Prize not found"))?;

        let amount = input.amount.unwrap_or(1);
        let total_points = prize.point * amount;

        // userのfsp残高の更新と取得を同時に行う
        let user: User = self
            .users_repo
            .find_by_id_and_update_fsp(&input.user_id, -total_points)
            .await?
            .ok_or_else(|| anyhow::anyhow!("User not found or insufficient balance"))?;

        // representation_userのfsp残高の更新
        self.users_repo
            .update_fsp(&prize.representation, total_points)
            .await?;

        // exchange_prize_historyの作成
        let exchange_prize_history: ExchangePrizeHistoryActiveModel =
            ExchangePrizeHistoryActiveModel {
                user: ActiveValue::Set(input.user_id.clone()),
                prize_id: ActiveValue::Set(input.prize_id),
                point_used: ActiveValue::Set(total_points),
                amount: ActiveValue::Set(amount),
                ..Default::default()
            };

        // fsp_txの作成
        let fsp_tx: FspTxActiveModel = FspTxActiveModel {
            from: ActiveValue::Set(Some(user.id.clone())),
            to: ActiveValue::Set(prize.representation),
            amount: ActiveValue::Set(-total_points),
            notes: ActiveValue::Set(Some(format!("Exchange prize: {}", prize.name))),
            ..Default::default()
        };

        // 並行して実行
        tokio::try_join!(
            self.exchange_prize_history_repo
                .create(exchange_prize_history),
            self.txs_fsp_repo.create(fsp_tx)
        )?;

        Ok(())
    }
}
