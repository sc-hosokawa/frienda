use async_trait::async_trait;
use derive_new::new;
use sea_orm::*;
use shared::error::domain_err::DomainError;

use domain::entities::portfolios::{
    ActiveModel as PortfolioActiveModel, Column, Entity as PortfolioEntity, Model as Portfolio,
};
use domain::repositories::portfolios_repo::PortfoliosRepository;

#[derive(new)]
pub struct PortfoliosRepoImpl {
    db: DatabaseConnection,
}

#[async_trait]
impl PortfoliosRepository for PortfoliosRepoImpl {
    async fn create(&self, portfolio: PortfolioActiveModel) -> Result<Portfolio, DomainError> {
        let res: InsertResult<PortfolioActiveModel> =
            PortfolioEntity::insert(portfolio).exec(&self.db).await?;
        let created_portfolio: Option<Portfolio> = PortfolioEntity::find_by_id(res.last_insert_id)
            .one(&self.db)
            .await?;
        Ok(created_portfolio.unwrap())
    }

    async fn update(&self, portfolio: PortfolioActiveModel) -> Result<Portfolio, DomainError> {
        let updated_portfolio: Portfolio = portfolio.update(&self.db).await?;
        Ok(updated_portfolio)
    }

    async fn delete(&self, id: i32) -> Result<(), DomainError> {
        let _deleted_portfolio: DeleteResult =
            PortfolioEntity::delete_by_id(id).exec(&self.db).await?;
        Ok(())
    }

    async fn get_all(&self) -> Result<Vec<Portfolio>, DomainError> {
        let portfolios = PortfolioEntity::find().all(&self.db).await?;
        Ok(portfolios)
    }

    async fn get_by_id(&self, id: i32) -> Result<Option<Portfolio>, DomainError> {
        let portfolio = PortfolioEntity::find_by_id(id).one(&self.db).await?;
        Ok(portfolio)
    }

    async fn get_by_user_id(&self, user_id: String) -> Result<Vec<Portfolio>, DomainError> {
        let portfolios = PortfolioEntity::find()
            .filter(Column::UserId.eq(user_id))
            .all(&self.db)
            .await?;
        Ok(portfolios)
    }
}
