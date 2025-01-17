use async_trait::async_trait;
use sea_orm::ActiveValue;
use std::sync::Arc;

use domain::entities::offer_report::{ActiveModel as OfferReportActiveModel, Model as OfferReport};
use domain::entities::release_report::{
    ActiveModel as ReleaseReportActiveModel, Model as ReleaseReport,
};
use domain::entities::user_report::{ActiveModel as UserReportActiveModel, Model as UserReport};
use domain::repositories::offer_report_repo::OfferReportRepository;
use domain::repositories::release_report_repo::ReleaseReportRepository;
use domain::repositories::user_report_repo::UserReportRepository;

pub struct UserReportInput {
    pub reported_user_id: String,
    pub reporter_user_id: String,
    pub report_content: String,
}

pub struct OfferReportInput {
    pub offer_id: i32,
    pub reporter_user_id: String,
    pub report_content: String,
}

pub struct ReleaseReportInput {
    pub release: String,
    pub reporter_user_id: String,
    pub report_content: String,
}

#[async_trait]
pub trait ReportUsecaseTrait: Send + Sync {
    async fn report_user(&self, input: UserReportInput) -> Result<UserReport, anyhow::Error>;
    async fn report_offer(&self, input: OfferReportInput) -> Result<OfferReport, anyhow::Error>;
    async fn report_release(
        &self,
        input: ReleaseReportInput,
    ) -> Result<ReleaseReport, anyhow::Error>;
    async fn get_all_user_reports(&self) -> Result<Vec<UserReport>, anyhow::Error>;
    async fn get_all_offer_reports(&self) -> Result<Vec<OfferReport>, anyhow::Error>;
    async fn get_all_release_reports(&self) -> Result<Vec<ReleaseReport>, anyhow::Error>;
    async fn delete_user_report(&self, id: i32) -> Result<(), anyhow::Error>;
    async fn delete_offer_report(&self, id: i32) -> Result<(), anyhow::Error>;
    async fn delete_release_report(&self, id: i32) -> Result<(), anyhow::Error>;
}

pub struct ReportUsecase {
    user_report_repo: Arc<dyn UserReportRepository>,
    offer_report_repo: Arc<dyn OfferReportRepository>,
    release_report_repo: Arc<dyn ReleaseReportRepository>,
}

impl ReportUsecase {
    pub fn new(
        user_report_repo: Arc<dyn UserReportRepository>,
        offer_report_repo: Arc<dyn OfferReportRepository>,
        release_report_repo: Arc<dyn ReleaseReportRepository>,
    ) -> Self {
        Self {
            user_report_repo,
            offer_report_repo,
            release_report_repo,
        }
    }
}

#[async_trait]
impl ReportUsecaseTrait for ReportUsecase {
    async fn report_user(&self, input: UserReportInput) -> Result<UserReport, anyhow::Error> {
        let user_report: UserReportActiveModel = UserReportActiveModel {
            reported_user_id: ActiveValue::Set(input.reported_user_id),
            reporter_user_id: ActiveValue::Set(input.reporter_user_id),
            report_content: ActiveValue::Set(input.report_content),
            ..Default::default()
        };

        let user_report: UserReport = self.user_report_repo.create(user_report).await?;
        Ok(user_report)
    }

    async fn report_offer(&self, input: OfferReportInput) -> Result<OfferReport, anyhow::Error> {
        let offer_report: OfferReportActiveModel = OfferReportActiveModel {
            offer_id: ActiveValue::Set(input.offer_id),
            reporter_user_id: ActiveValue::Set(input.reporter_user_id),
            report_content: ActiveValue::Set(input.report_content),
            ..Default::default()
        };

        let offer_report: OfferReport = self.offer_report_repo.create(offer_report).await?;
        Ok(offer_report)
    }

    async fn report_release(
        &self,
        input: ReleaseReportInput,
    ) -> Result<ReleaseReport, anyhow::Error> {
        let release_report: ReleaseReportActiveModel = ReleaseReportActiveModel {
            release: ActiveValue::Set(input.release),
            reporter_user_id: ActiveValue::Set(input.reporter_user_id),
            report_content: ActiveValue::Set(input.report_content),
            ..Default::default()
        };

        let release_report: ReleaseReport = self.release_report_repo.create(release_report).await?;
        Ok(release_report)
    }

    async fn get_all_user_reports(&self) -> Result<Vec<UserReport>, anyhow::Error> {
        let user_reports = self.user_report_repo.get_all().await?;
        Ok(user_reports)
    }

    async fn get_all_offer_reports(&self) -> Result<Vec<OfferReport>, anyhow::Error> {
        let offer_reports = self.offer_report_repo.get_all().await?;
        Ok(offer_reports)
    }

    async fn get_all_release_reports(&self) -> Result<Vec<ReleaseReport>, anyhow::Error> {
        let release_reports = self.release_report_repo.get_all().await?;
        Ok(release_reports)
    }

    async fn delete_user_report(&self, id: i32) -> Result<(), anyhow::Error> {
        self.user_report_repo.delete(id).await?;
        Ok(())
    }

    async fn delete_offer_report(&self, id: i32) -> Result<(), anyhow::Error> {
        self.offer_report_repo.delete(id).await?;
        Ok(())
    }

    async fn delete_release_report(&self, id: i32) -> Result<(), anyhow::Error> {
        self.release_report_repo.delete(id).await?;
        Ok(())
    }
}
