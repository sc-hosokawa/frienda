mod community;
mod general;
mod message;
mod notification;
mod offer;

use async_graphql::MergedObject;

#[derive(MergedObject, Default)]
pub struct MutationRoot(
    community::CommunityMutation,
    general::GeneralMutation,
    message::MessageMutation,
    notification::NotificationMutation,
    offer::OfferMutation,
);
