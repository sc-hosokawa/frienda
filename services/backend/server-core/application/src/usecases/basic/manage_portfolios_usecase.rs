use async_trait::async_trait;
use chrono::NaiveDate;
use sea_orm::prelude::*;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::portfolios::{ActiveModel as PortfolioActiveModel, Model as Portfolio};
use domain::repositories::portfolios_repo::PortfoliosRepository;

use shared::error::domain_err::DomainError;

pub struct RegisterPortfolioInput {
    pub user_id: String,
    pub title: String,
    pub description: String,
    pub img_url: Option<String>,
    pub category: String,
    pub release_date: Option<Date>,
    pub external_url: Option<String>,
}

pub struct RegisterPortfolioResponse {
    pub id: i32,
}

pub struct UpdatePortfolioInput {
    pub id: i32,
    pub title: Option<String>,
    pub description: Option<String>,
    pub img_url: Option<String>,
    pub category: Option<String>,
    pub release_date: Option<Date>,
    pub external_url: Option<String>,
}

pub struct UpdatePortfolioResponse {
    pub id: i32,
}

impl UpdatePortfolioInput {
    pub fn parse_date(date_str: Option<&str>) -> Result<Option<Date>, DomainError> {
        match date_str {
            Some(date_str) => NaiveDate::parse_from_str(date_str, "%Y-%m-%d")
                .map(|naive_date| Some(Date::from(naive_date)))
                .map_err(|_| DomainError::UnexpectedError("Invalid date format".to_string())),
            None => Ok(None),
        }
    }
}

#[async_trait]
pub trait ManagePortfoliosUsecaseTrait: Send + Sync {
    async fn register_portfolio(
        &self,
        input: RegisterPortfolioInput,
    ) -> Result<RegisterPortfolioResponse, DomainError>;
    async fn update_portfolio(
        &self,
        input: UpdatePortfolioInput,
    ) -> Result<UpdatePortfolioResponse, DomainError>;
    async fn delete_portfolio(&self, id: i32) -> Result<(), DomainError>;
    async fn get_portfolios_by_user_id(
        &self,
        user_id: String,
    ) -> Result<Vec<Portfolio>, DomainError>;
    async fn get_all_portfolios(&self) -> Result<Vec<Portfolio>, DomainError>;
}

pub struct ManagePortfoliosUsecase {
    portfolios: Arc<dyn PortfoliosRepository>,
}

impl ManagePortfoliosUsecase {
    pub fn new(portfolios: Arc<dyn PortfoliosRepository>) -> Self {
        Self { portfolios }
    }
}

#[async_trait]
impl ManagePortfoliosUsecaseTrait for ManagePortfoliosUsecase {
    async fn register_portfolio(
        &self,
        input: RegisterPortfolioInput,
    ) -> Result<RegisterPortfolioResponse, DomainError> {
        let portfolio = PortfolioActiveModel {
            user_id: ActiveValue::Set(input.user_id),
            title: ActiveValue::Set(input.title),
            description: ActiveValue::Set(input.description),
            img_url: ActiveValue::Set(input.img_url),
            category: ActiveValue::Set(input.category),
            release_date: ActiveValue::Set(input.release_date),
            external_url: ActiveValue::Set(input.external_url),
            ..Default::default()
        };
        let res: Portfolio = self.portfolios.create(portfolio).await?;
        Ok(RegisterPortfolioResponse { id: res.id })
    }

    async fn update_portfolio(
        &self,
        input: UpdatePortfolioInput,
    ) -> Result<UpdatePortfolioResponse, DomainError> {
        let mut portfolio = PortfolioActiveModel {
            id: ActiveValue::Set(input.id),
            ..Default::default()
        };

        if let Some(title) = input.title {
            portfolio.title = ActiveValue::Set(title);
        }
        if let Some(description) = input.description {
            portfolio.description = ActiveValue::Set(description);
        }
        if let Some(category) = input.category {
            portfolio.category = ActiveValue::Set(category);
        }

        portfolio.img_url = ActiveValue::Set(input.img_url);
        portfolio.release_date = match input.release_date {
            Some(date) => ActiveValue::Set(Some(date)),
            None => ActiveValue::NotSet,
        };
        portfolio.external_url = ActiveValue::Set(input.external_url);

        let res: Portfolio = self.portfolios.update(portfolio).await?;
        Ok(UpdatePortfolioResponse { id: res.id })
    }

    async fn delete_portfolio(&self, id: i32) -> Result<(), DomainError> {
        self.portfolios.delete(id).await?;
        Ok(())
    }

    async fn get_portfolios_by_user_id(
        &self,
        user_id: String,
    ) -> Result<Vec<Portfolio>, DomainError> {
        let portfolios: Vec<Portfolio> = self.portfolios.get_by_user_id(user_id).await?;
        Ok(portfolios)
    }

    async fn get_all_portfolios(&self) -> Result<Vec<Portfolio>, DomainError> {
        let portfolios: Vec<Portfolio> = self.portfolios.get_all().await?;
        Ok(portfolios)
    }
}
