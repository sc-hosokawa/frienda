use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;
use tokio::try_join;

use domain::entities::offer_user::ActiveModel as OfferUserActiveModel;
use domain::entities::offers::ActiveModel as OfferActiveModel;
use domain::entities::sea_orm_active_enums::OfferStatus;
use domain::entities::txs_fsp::ActiveModel as TxsFspActiveModel;
use domain::repositories::offer_user_repo::OfferUserRepository;
use domain::repositories::offers_repo::OffersRepository;
use domain::repositories::txs_fsp_repo::TxsFspRepository;
use domain::repositories::users_repo::UsersRepository;

//
// Define the input for the usecase
//
pub struct ChangeStatusInput {
    pub id: i32,
    pub user_id: String,
    pub status: OfferStatus,
}

//
// Define the interface for the usecase
//
#[async_trait]
pub trait ChangeStatusUsecaseTrait: Send + Sync {
    async fn apply(&self, input: ChangeStatusInput) -> Result<(), anyhow::Error>;
    async fn change_status(&self, input: ChangeStatusInput) -> Result<(), anyhow::Error>;
    async fn complete(&self, input: ChangeStatusInput) -> Result<(), anyhow::Error>;
}

//
// Implement the usecase
//
pub struct ChangeStatusUsecase {
    offers_repo: Arc<dyn OffersRepository>,
    offer_user_repo: Arc<dyn OfferUserRepository>,
    txs_fsp_repo: Arc<dyn TxsFspRepository>,
    users_repo: Arc<dyn UsersRepository>,
}

impl ChangeStatusUsecase {
    pub fn new(
        offers_repo: Arc<dyn OffersRepository>,
        offer_user_repo: Arc<dyn OfferUserRepository>,
        txs_fsp_repo: Arc<dyn TxsFspRepository>,
        users_repo: Arc<dyn UsersRepository>,
    ) -> Self {
        Self {
            offers_repo,
            offer_user_repo,
            txs_fsp_repo,
            users_repo,
        }
    }
}

//
// Implement the trait
//
#[async_trait]
impl ChangeStatusUsecaseTrait for ChangeStatusUsecase {
    async fn apply(&self, input: ChangeStatusInput) -> Result<(), anyhow::Error> {
        let new_status: OfferUserActiveModel = OfferUserActiveModel {
            offer_id: ActiveValue::Set(input.id),
            user_id: ActiveValue::Set(input.user_id),
            status: ActiveValue::Set(OfferStatus::Applied),
            ..Default::default()
        };

        self.offer_user_repo.create(new_status).await?;

        Ok(())
    }

    async fn change_status(&self, input: ChangeStatusInput) -> Result<(), anyhow::Error> {
        // Validate the input status
        match input.status {
            OfferStatus::Rejected | OfferStatus::Ongoing => {}
            _ => {
                return Err(anyhow::anyhow!(
                    "Invalid status. Only Rejected or Ongoing are allowed."
                ))
            }
        }

        let offer_user = self
            .offer_user_repo
            .get_by_id(input.id)
            .await?
            .ok_or_else(|| anyhow::anyhow!("Offer user mapping not found"))?;

        let mut updated_offer_user: OfferUserActiveModel = offer_user.into();
        updated_offer_user.status = ActiveValue::Set(input.status);

        self.offer_user_repo.update(updated_offer_user).await?;

        Ok(())
    }

    async fn complete(&self, input: ChangeStatusInput) -> Result<(), anyhow::Error> {
        match input.status {
            OfferStatus::Finished => {}
            _ => {
                return Err(anyhow::anyhow!(
                    "Invalid status. Only Rejected or Ongoing are allowed."
                ))
            }
        }

        let (offer_user, offer) = try_join!(
            self.offer_user_repo.get_by_id(input.id),
            self.offers_repo.get_by_id(input.id)
        )?;

        let offer_user =
            offer_user.ok_or_else(|| anyhow::anyhow!("Offer user mapping not found"))?;
        let offer = offer.ok_or_else(|| anyhow::anyhow!("Offer not found"))?;

        let user_id = offer_user.user_id.clone();

        // Update user's FSP balance
        self.users_repo.update_fsp(&user_id, offer.fee).await?;
        // Update offer owner's FSP balance
        self.users_repo.update_fsp(&offer.owner, -offer.fee).await?;

        let (updated_offer_user, updated_offer, txs_fsp) = (
            OfferUserActiveModel {
                status: ActiveValue::Set(OfferStatus::Finished),
                ..offer_user.into()
            },
            OfferActiveModel {
                publicity: ActiveValue::Set(false),
                ..offer.clone().into()
            },
            TxsFspActiveModel {
                from: ActiveValue::Set(Some(offer.owner)),
                to: ActiveValue::Set(user_id),
                amount: ActiveValue::Set(offer.fee),
                notes: ActiveValue::Set(Some(format!("[Offer] {} completed", offer.title))),
                ..Default::default()
            },
        );

        try_join!(
            self.offer_user_repo.update(updated_offer_user),
            self.offers_repo.update(updated_offer),
            self.txs_fsp_repo.create(txs_fsp)
        )?;

        Ok(())
    }
}
