mod artist;
mod community;
mod general;
mod message;
mod notification;
mod offer;
mod points_tx;
mod prize;

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
    artist::ArtistMutation,
);
