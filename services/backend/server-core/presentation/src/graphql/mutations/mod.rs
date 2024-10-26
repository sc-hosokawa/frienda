mod artist;
mod community;
mod general;
mod message;
mod notification;
mod offer;
mod points_tx;

use async_graphql::MergedObject;

#[derive(MergedObject, Default)]
pub struct MutationRoot(
    community::CommunityMutation,
    general::GeneralMutation,
    message::MessageMutation,
    notification::NotificationMutation,
    offer::OfferMutation,
    points_tx::PointsTxMutation,
    artist::ArtistMutation,
);
