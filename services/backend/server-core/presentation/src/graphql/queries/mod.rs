mod health_check;

mod community;
mod dashboard;
mod general;
mod message;
mod news;
mod notification;
mod offer;

use async_graphql::MergedObject;
use health_check::HealthCheckQuery;

#[derive(MergedObject, Default)]
pub struct QueryRoot(
    HealthCheckQuery,
    dashboard::DashboardQuery,
    community::CommunityQuery,
    offer::OfferQuery,
    message::MessageQuery,
    notification::NotificationQuery,
    general::GeneralQuery,
);
