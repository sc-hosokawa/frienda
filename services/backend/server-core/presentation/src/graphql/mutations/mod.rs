mod admin;
mod artist;
mod community;
mod credit;
mod general;
mod message;
mod notification;
mod offer;
mod points_tx;
mod prize;
mod quest;

use async_graphql::MergedObject;

#[derive(MergedObject, Default)]
pub struct MutationRoot(
    community::CommunityMutation,
    general::GeneralMutation,
    message::MessageMutation,
    notification::NotificationMutation,
    offer::OfferMutation,
    points_tx::PointsTxMutation,
    prize::PrizeMutation,
    quest::QuestMutation,
    artist::ArtistMutation,
    credit::CreditMutation,
    admin::AdminMutation,
);
