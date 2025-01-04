use async_trait::async_trait;
use std::sync::Arc;

use domain::entities::txs_fsp::Model as TxsFsp;
use domain::repositories::artists_repo::ArtistsRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct GetPointTransactionHistoryInput {
    pub user_id: String,
    pub count: i32,
}

pub struct GetPointTransactionHistoryOutput {
    pub transactions: Vec<TransactionData>,
}
pub struct TransactionData {
    pub id: uuid::Uuid,
    pub amount: i32,
    pub direction: String,
    pub counter_party: UserSimpleData,
    pub tx_at: String,
    pub note: Option<String>,
}
pub struct UserSimpleData {
    pub id: String,
    pub name: String,
    pub img_url: Option<String>,
}

//
// Define the trait for the usecase
//
#[async_trait]
pub trait GetPointTransactionHistoryUsecaseTrait: Send + Sync {
    async fn get_point_transaction_history(
        &self,
        input: GetPointTransactionHistoryInput,
    ) -> Result<GetPointTransactionHistoryOutput, anyhow::Error>;
}

//
// Implement the usecase
//
pub struct GetPointTransactionHistoryUsecase {
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    users_repo: Arc<dyn UsersRepository>,
    artists_repo: Arc<dyn ArtistsRepository>,
}

impl GetPointTransactionHistoryUsecase {
    pub fn new(
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        users_repo: Arc<dyn UsersRepository>,
        artists_repo: Arc<dyn ArtistsRepository>,
    ) -> Self {
        Self {
            txs_fsp_repo,
            users_repo,
            artists_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl GetPointTransactionHistoryUsecaseTrait for GetPointTransactionHistoryUsecase {
    async fn get_point_transaction_history(
        &self,
        input: GetPointTransactionHistoryInput,
    ) -> Result<GetPointTransactionHistoryOutput, anyhow::Error> {
        let txs_fsps: Vec<TxsFsp> = self
            .txs_fsp_repo
            .get_by_user_id(&input.user_id, input.count)
            .await?;

        let mut transactions = Vec::new();
        for tx in txs_fsps {
            let (direction, counter_party) = match (&tx.from, &tx.to) {
                (Some(from_id), to_id) if from_id == &input.user_id => {
                    if to_id.starts_with("artist_") {
                        match self.artists_repo.find_by_id(to_id).await? {
                            Some(artist) => (
                                "Out".to_string(),
                                UserSimpleData {
                                    id: artist.artist_id,
                                    name: artist.display_name_jp,
                                    img_url: artist.img_url,
                                },
                            ),
                            None => (
                                "Out".to_string(),
                                UserSimpleData {
                                    id: to_id.to_string(),
                                    name: "Unknown".to_string(),
                                    img_url: None,
                                },
                            ),
                        }
                    } else {
                        match self.users_repo.find_by_id(to_id).await? {
                            Some(user) => (
                                "Out".to_string(),
                                UserSimpleData {
                                    id: user.id,
                                    name: user.username,
                                    img_url: user.img_url,
                                },
                            ),
                            None => (
                                "Out".to_string(),
                                UserSimpleData {
                                    id: to_id.to_string(),
                                    name: "Unknown".to_string(),
                                    img_url: None,
                                },
                            ),
                        }
                    }
                }
                (from_opt, to_id) if to_id == &input.user_id => {
                    let from_id = match from_opt {
                        Some(id) => id,
                        None => "system",
                    };

                    if from_id.starts_with("artist_") {
                        match self.artists_repo.find_by_id(&from_id).await? {
                            Some(artist) => (
                                "In".to_string(),
                                UserSimpleData {
                                    id: artist.artist_id,
                                    name: artist.display_name_jp,
                                    img_url: artist.img_url,
                                },
                            ),
                            None => (
                                "In".to_string(),
                                UserSimpleData {
                                    id: from_id.to_string(),
                                    name: "Unknown".to_string(),
                                    img_url: None,
                                },
                            ),
                        }
                    } else {
                        match self.users_repo.find_by_id(&from_id).await? {
                            Some(user) => (
                                "In".to_string(),
                                UserSimpleData {
                                    id: user.id,
                                    name: user.username,
                                    img_url: user.img_url,
                                },
                            ),
                            None => (
                                "In".to_string(),
                                UserSimpleData {
                                    id: from_id.to_string(),
                                    name: if from_id == "system" {
                                        "System".to_string()
                                    } else {
                                        "Unknown".to_string()
                                    },
                                    img_url: None,
                                },
                            ),
                        }
                    }
                }
                _ => (
                    "Unknown".to_string(),
                    UserSimpleData {
                        id: "unknown".to_string(),
                        name: "Unknown".to_string(),
                        img_url: None,
                    },
                ),
            };

            transactions.push(TransactionData {
                id: tx.id,
                amount: tx.amount,
                direction,
                counter_party,
                tx_at: tx.tx_at.to_string(),
                note: tx.notes,
            });
        }

        Ok(GetPointTransactionHistoryOutput { transactions })
    }
}
