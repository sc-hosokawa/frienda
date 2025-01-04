mod health_check;

mod admin;
mod artist;
mod community;
mod credit;
mod dashboard;
mod general;
mod message;
mod news;
mod notification;
mod offer;
mod points_tx;
mod prize;
mod quest;

use async_graphql::MergedObject;
use health_check::HealthCheckQuery;

#[derive(MergedObject, Default)]
pub struct QueryRoot(
    HealthCheckQuery,
    dashboard::DashboardQuery,
    admin::AdminQuery,
    community::CommunityQuery,
    offer::OfferQuery,
    message::MessageQuery,
    notification::NotificationQuery,
    general::GeneralQuery,
    artist::ArtistQuery,
    prize::PrizeQuery,
    points_tx::PointsTxQuery,
    quest::QuestQuery,
    credit::CreditQuery,
);
