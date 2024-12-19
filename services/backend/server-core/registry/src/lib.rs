use sea_orm::DatabaseConnection;
use std::sync::Arc;
use tracing;

use application::health_check::*;
use application::usecases::artist::{
    get_artist_usecase::{GetArtistUsecase, GetArtistUsecaseTrait},
    get_members_usecase::{GetMembersUsecase, GetMembersUsecaseTrait},
    manage_artists_usecase::{ManageArtistsUsecase, ManageArtistsUsecaseTrait},
    mark_as_member_usecase::{MarkAsMemberUsecase, MarkAsMemberUsecaseTrait},
    request_to_access_usecase::{RequestToAccessUsecase, RequestToAccessUsecaseTrait},
};
use application::usecases::basic::{
    create_user_usecase::{CreateUserUsecase, CreateUserUsecaseTrait},
    get_all_users_usecase::{GetAllUsersUsecase, GetAllUsersUsecaseTrait},
    get_user_basic_info_usecase::{GetUserBasicInfoUsecase, GetUserBasicInfoUsecaseTrait},
    search_users_usecase::{SearchUsersUsecase, SearchUsersUsecaseTrait},
    update_user_profile_usecase::{UpdateUserProfileUsecase, UpdateUserProfileUsecaseTrait},
};
use application::usecases::community::{
    add_shortnote_usecase::{AddShortnoteUsecase, AddShortnoteUsecaseTrait},
    mark_favorite_usecase::{MarkFavoriteUsecase, MarkFavoriteUsecaseTrait},
};
use application::usecases::credit::{
    get_credits_usecase::{GetCreditsUsecase, GetCreditsUsecaseTrait},
    register_usecase::{RegisterUsecase, RegisterUsecaseTrait},
};
use application::usecases::dashboard::{
    get_play_count_history_usecase::{GetPlayCountHistoryUsecase, GetPlayCountHistoryUsecaseTrait},
    get_playback_gender_gen_usecase::{
        GetPlaybackGenderGenUsecase, GetPlaybackGenderGenUsecaseTrait,
    },
    get_products_usecase::{GetProductsUsecase, GetProductsUsecaseTrait},
    get_trending_usecase::{GetTrendingUsecase, GetTrendingUsecaseTrait},
    playback_overview_usecase::{PlaybackOverviewUsecase, PlaybackOverviewUsecaseTrait},
};
use application::usecases::messaging::{
    create_message_room_usecase::{CreateMessageRoomUsecase, CreateMessageRoomUsecaseTrait},
    get_messages_usecase::{GetMessagesUsecase, GetMessagesUsecaseTrait},
    get_room_list_usecase::{GetRoomListUsecase, GetRoomListUsecaseTrait},
    mark_as_read_usecase::{MarkAsReadUsecase, MarkAsReadUsecaseTrait},
    request_llm_usecase::{RequestLlmUsecase, RequestLlmUsecaseTrait},
    send_message_usecase::{SendMessageUsecase, SendMessageUsecaseTrait},
};
use application::usecases::notification::{
    get_notifications_usecase::{GetNotificationsUsecase, GetNotificationsUsecaseTrait},
    mark_notification_as_read_usecase::{
        MarkNotificationAsReadUsecase, MarkNotificationAsReadUsecaseTrait,
    },
};
use application::usecases::offer::{
    change_status_usecase::{ChangeStatusUsecase, ChangeStatusUsecaseTrait},
    delete_offer_usecase::{DeleteOfferUsecase, DeleteOfferUsecaseTrait},
    get_available_offer_usecase::{GetAvailableOfferUsecase, GetAvailableOfferUsecaseTrait},
    get_offer_by_owner_usecase::{GetOfferByOwnerUsecase, GetOfferByOwnerUsecaseTrait},
    get_offer_by_status_usecase::{GetOfferByStatusUsecase, GetOfferByStatusUsecaseTrait},
    get_offer_details_usecase::{GetOfferDetailsUsecase, GetOfferDetailsUsecaseTrait},
    get_offer_stats_usecase::{GetOfferStatsUsecase, GetOfferStatsUsecaseTrait},
    manage_users_in_offer_usecase::{ManageUsersInOfferUsecase, ManageUsersInOfferUsecaseTrait},
    register_task_usecase::{RegisterTaskUsecase, RegisterTaskUsecaseTrait},
    update_task_usecase::{UpdateTaskUsecase, UpdateTaskUsecaseTrait},
};
use application::usecases::point::{
    get_point_transaction_history_usecase::{
        GetPointTransactionHistoryUsecase, GetPointTransactionHistoryUsecaseTrait,
    },
    get_user_point_balance_usecase::{GetUserPointBalanceUsecase, GetUserPointBalanceUsecaseTrait},
    transfer_point_between_accounts_usecase::{
        TransferPointBetweenAccountsUsecase, TransferPointBetweenAccountsUsecaseTrait,
    },
};
use application::usecases::prize::{
    create_prize_usecase::{CreatePrizeUsecase, CreatePrizeUsecaseTrait},
    delete_prize_usecase::{DeletePrizeUsecase, DeletePrizeUsecaseTrait},
    exchange_prize_usecase::{ExchangePrizeUsecase, ExchangePrizeUsecaseTrait},
    get_prize_list_usecase::{GetPrizeListUsecase, GetPrizeListUsecaseTrait},
    get_prize_usecase::{GetPrizeUsecase, GetPrizeUsecaseTrait},
    update_prize_usecase::{UpdatePrizeUsecase, UpdatePrizeUsecaseTrait},
};
use application::usecases::quest::{
    create_quest_usecase::{CreateQuestUsecase, CreateQuestUsecaseTrait},
    get_quests_usecase::{GetQuestsUsecase, GetQuestsUsecaseTrait},
    login_reward_usecase::{LoginRewardUsecase, LoginRewardUsecaseTrait},
    mark_as_done_usecase::{MarkAsDoneUsecase, MarkAsDoneUsecaseTrait},
};
use infrastracture::persistences::health_check_repo_impl::HealthCheckRepoImpl;
use infrastracture::persistences::{
    artists_repo_impl::ArtistsRepoImpl,
    exchange_prize_history_repo_impl::ExchangePrizeHistoryRepoImpl,
    favorites_repo_impl::FavoritesRepoImpl,
    gender_gen_playback_repo_impl::GenderGenPlaybackRepoImpl,
    message_attach_repo_impl::MessageAttachRepoImpl, messages_repo_impl::MessagesRepoImpl,
    notification_user_repo_impl::NotificationUserRepoImpl,
    notifications_repo_impl::NotificationsRepoImpl, offer_attach_repo_impl::OfferAttachRepoImpl,
    offer_user_repo_impl::OfferUserRepoImpl, offers_repo_impl::OffersRepoImpl,
    plays_daily_repo_impl::PlaysDailyRepoImpl, plays_monthly_repo_impl::PlaysMonthlyRepoImpl,
    prizes_repo_impl::PrizesRepoImpl, product_track_repo_impl::ProductTrackRepoImpl,
    products_repo_impl::ProductsRepoImpl, quest_user_repo_impl::QuestUserRepoImpl,
    quests_repo_impl::QuestsRepoImpl, room_user_repo_impl::RoomUserRepoImpl,
    rooms_repo_impl::RoomsRepoImpl, short_notes_repo_impl::ShortNotesRepoImpl,
    track_credits_repo_impl::TrackCreditsRepoImpl, tracks_repo_impl::TracksRepoImpl,
    txs_fsp_repo_impl::TxsFspRepoImpl, user_artist_repo_impl::UserArtistRepoImpl,
    users_repo_impl::UsersRepoImpl,
};

use application::services::{
    push_notification::{PushNotificationService, PushNotificationServiceTrait},
    request_llm::{LlmService, LlmServiceTrait},
    send_email::{EmailService, EmailServiceTrait},
};
use infrastracture::services::{
    fcm::FcmNotificationService, gemini::GeminiService, sendgrid::SendGridService,
};

pub struct RepositoriesImpl {
    pub health_check: Arc<HealthCheckRepoImpl>,
    pub users: Arc<UsersRepoImpl>,
    pub artists: Arc<ArtistsRepoImpl>,
    pub user_artist: Arc<UserArtistRepoImpl>,
    pub offers: Arc<OffersRepoImpl>,
    pub txs_fsp: Arc<TxsFspRepoImpl>,
    pub rooms: Arc<RoomsRepoImpl>,
    pub exchange_prize_history: Arc<ExchangePrizeHistoryRepoImpl>,
    pub prizes: Arc<PrizesRepoImpl>,
    pub room_user: Arc<RoomUserRepoImpl>,
    pub messages: Arc<MessagesRepoImpl>,
    pub offer_attach: Arc<OfferAttachRepoImpl>,
    pub offer_user: Arc<OfferUserRepoImpl>,
    pub message_attach: Arc<MessageAttachRepoImpl>,
    pub quests: Arc<QuestsRepoImpl>,
    pub quest_user: Arc<QuestUserRepoImpl>,
    pub tracks: Arc<TracksRepoImpl>,
    pub product_track: Arc<ProductTrackRepoImpl>,
    pub products: Arc<ProductsRepoImpl>,
    pub plays_monthly: Arc<PlaysMonthlyRepoImpl>,
    pub plays_daily: Arc<PlaysDailyRepoImpl>,
    pub gender_gen_playback: Arc<GenderGenPlaybackRepoImpl>,
    pub track_credits: Arc<TrackCreditsRepoImpl>,
    pub favorites: Arc<FavoritesRepoImpl>,
    pub short_notes: Arc<ShortNotesRepoImpl>,
    pub notifications: Arc<NotificationsRepoImpl>,
    pub notification_user: Arc<NotificationUserRepoImpl>,
}

pub struct ServicesImpl {
    pub llm_service: Arc<dyn LlmServiceTrait>,
    pub push_notification_service: Arc<dyn PushNotificationServiceTrait>,
    pub email_service: Arc<dyn EmailServiceTrait>,
}

pub struct Usecases {
    pub health_check: Arc<dyn HealthCheckUseCase>,
    pub create_user: Arc<dyn CreateUserUsecaseTrait>,
    pub get_user_basic_info: Arc<dyn GetUserBasicInfoUsecaseTrait>,
    pub update_user_profile: Arc<dyn UpdateUserProfileUsecaseTrait>,
    pub create_message_room: Arc<dyn CreateMessageRoomUsecaseTrait>,
    pub send_message: Arc<dyn SendMessageUsecaseTrait>,
    pub get_room_list: Arc<dyn GetRoomListUsecaseTrait>,
    pub get_messages: Arc<dyn GetMessagesUsecaseTrait>,
    pub get_available_offer: Arc<dyn GetAvailableOfferUsecaseTrait>,
    pub get_offer_by_owner: Arc<dyn GetOfferByOwnerUsecaseTrait>,
    pub get_offer_by_status: Arc<dyn GetOfferByStatusUsecaseTrait>,
    pub get_offer_stats: Arc<dyn GetOfferStatsUsecaseTrait>,
    pub register_task: Arc<dyn RegisterTaskUsecaseTrait>,
    pub update_task: Arc<dyn UpdateTaskUsecaseTrait>,
    pub change_status: Arc<dyn ChangeStatusUsecaseTrait>,
    pub delete_offer: Arc<dyn DeleteOfferUsecaseTrait>,
    pub create_prize: Arc<dyn CreatePrizeUsecaseTrait>,
    pub delete_prize: Arc<dyn DeletePrizeUsecaseTrait>,
    pub exchange_prize: Arc<dyn ExchangePrizeUsecaseTrait>,
    pub get_prize_list: Arc<dyn GetPrizeListUsecaseTrait>,
    pub get_prize: Arc<dyn GetPrizeUsecaseTrait>,
    pub update_prize: Arc<dyn UpdatePrizeUsecaseTrait>,
    pub get_point_transaction_history: Arc<dyn GetPointTransactionHistoryUsecaseTrait>,
    pub get_user_point_balance: Arc<dyn GetUserPointBalanceUsecaseTrait>,
    pub transfer_point_between_accounts: Arc<dyn TransferPointBetweenAccountsUsecaseTrait>,
    pub get_artist: Arc<dyn GetArtistUsecaseTrait>,
    pub get_all_users: Arc<dyn GetAllUsersUsecaseTrait>,
    pub mark_as_read: Arc<dyn MarkAsReadUsecaseTrait>,
    pub get_offer_details: Arc<dyn GetOfferDetailsUsecaseTrait>,
    pub request_to_access: Arc<dyn RequestToAccessUsecaseTrait>,
    pub get_members: Arc<dyn GetMembersUsecaseTrait>,
    pub get_quests: Arc<dyn GetQuestsUsecaseTrait>,
    pub create_quest: Arc<dyn CreateQuestUsecaseTrait>,
    pub quest_mark_as_done: Arc<dyn MarkAsDoneUsecaseTrait>,
    pub mark_as_member: Arc<dyn MarkAsMemberUsecaseTrait>,
    pub get_trending: Arc<dyn GetTrendingUsecaseTrait>,
    pub get_play_count_history: Arc<dyn GetPlayCountHistoryUsecaseTrait>,
    pub get_playback_gender_gen: Arc<dyn GetPlaybackGenderGenUsecaseTrait>,
    pub get_playback_overview: Arc<dyn PlaybackOverviewUsecaseTrait>,
    pub register_credit: Arc<dyn RegisterUsecaseTrait>,
    pub get_credits: Arc<dyn GetCreditsUsecaseTrait>,
    pub get_products: Arc<dyn GetProductsUsecaseTrait>,
    pub search_users: Arc<dyn SearchUsersUsecaseTrait>,
    pub login_reward: Arc<dyn LoginRewardUsecaseTrait>,
    pub request_llm: Arc<dyn RequestLlmUsecaseTrait>,
    pub mark_favorite: Arc<dyn MarkFavoriteUsecaseTrait>,
    pub add_shortnote: Arc<dyn AddShortnoteUsecaseTrait>,
    pub manage_artists: Arc<dyn ManageArtistsUsecaseTrait>,
    pub get_notifications: Arc<dyn GetNotificationsUsecaseTrait>,
    pub mark_notification_as_read: Arc<dyn MarkNotificationAsReadUsecaseTrait>,
    pub manage_users_in_offer: Arc<dyn ManageUsersInOfferUsecaseTrait>,
}

pub fn create_repositories(db: DatabaseConnection) -> RepositoriesImpl {
    tracing::info!("Creating Repositories...");
    RepositoriesImpl {
        health_check: Arc::new(HealthCheckRepoImpl::new(db.clone())),
        tracks: Arc::new(TracksRepoImpl::new(db.clone())),
        users: Arc::new(UsersRepoImpl::new(db.clone())),
        artists: Arc::new(ArtistsRepoImpl::new(db.clone())),
        user_artist: Arc::new(UserArtistRepoImpl::new(db.clone())),
        offers: Arc::new(OffersRepoImpl::new(db.clone())),
        txs_fsp: Arc::new(TxsFspRepoImpl::new(db.clone())),
        rooms: Arc::new(RoomsRepoImpl::new(db.clone())),
        exchange_prize_history: Arc::new(ExchangePrizeHistoryRepoImpl::new(db.clone())),
        prizes: Arc::new(PrizesRepoImpl::new(db.clone())),
        room_user: Arc::new(RoomUserRepoImpl::new(db.clone())),
        messages: Arc::new(MessagesRepoImpl::new(db.clone())),
        offer_attach: Arc::new(OfferAttachRepoImpl::new(db.clone())),
        offer_user: Arc::new(OfferUserRepoImpl::new(db.clone())),
        message_attach: Arc::new(MessageAttachRepoImpl::new(db.clone())),
        quests: Arc::new(QuestsRepoImpl::new(db.clone())),
        quest_user: Arc::new(QuestUserRepoImpl::new(db.clone())),
        product_track: Arc::new(ProductTrackRepoImpl::new(db.clone())),
        products: Arc::new(ProductsRepoImpl::new(db.clone())),
        plays_monthly: Arc::new(PlaysMonthlyRepoImpl::new(db.clone())),
        plays_daily: Arc::new(PlaysDailyRepoImpl::new(db.clone())),
        gender_gen_playback: Arc::new(GenderGenPlaybackRepoImpl::new(db.clone())),
        track_credits: Arc::new(TrackCreditsRepoImpl::new(db.clone())),
        favorites: Arc::new(FavoritesRepoImpl::new(db.clone())),
        short_notes: Arc::new(ShortNotesRepoImpl::new(db.clone())),
        notifications: Arc::new(NotificationsRepoImpl::new(db.clone())),
        notification_user: Arc::new(NotificationUserRepoImpl::new(db.clone())),
    }
}

pub async fn create_services() -> ServicesImpl {
    tracing::info!("Setup Services...");
    let gemini_service = GeminiService::new().expect("Failed to create GeminiService");
    let llm_service = LlmService::new(Arc::new(gemini_service));
    let push_notification_service = FcmNotificationService::new()
        .await
        .expect("Failed to create FcmNotificationService");
    let sendgrid_service = SendGridService::new().expect("Failed to create SendGridService");

    ServicesImpl {
        llm_service: Arc::new(llm_service),
        push_notification_service: Arc::new(push_notification_service),
        email_service: Arc::new(sendgrid_service),
    }
}

pub fn create_usecases(repos: RepositoriesImpl, services: ServicesImpl) -> Usecases {
    tracing::info!("Creating Usecases...");
    Usecases {
        health_check: Arc::new(HealthCheckUsecase::new(repos.health_check.clone())),
        mark_favorite: Arc::new(MarkFavoriteUsecase::new(repos.favorites.clone())),
        add_shortnote: Arc::new(AddShortnoteUsecase::new(repos.short_notes.clone())),
        search_users: Arc::new(SearchUsersUsecase::new(repos.users.clone())),
        login_reward: Arc::new(LoginRewardUsecase::new(repos.users.clone())),
        manage_users_in_offer: Arc::new(ManageUsersInOfferUsecase::new(
            repos.offers.clone(),
            repos.users.clone(),
            repos.offer_user.clone(),
        )),
        manage_artists: Arc::new(ManageArtistsUsecase::new(repos.artists.clone())),
        get_products: Arc::new(GetProductsUsecase::new(
            repos.products.clone(),
            repos.tracks.clone(),
            repos.product_track.clone(),
        )),
        get_credits: Arc::new(GetCreditsUsecase::new(
            repos.track_credits.clone(),
            repos.users.clone(),
        )),
        create_quest: Arc::new(CreateQuestUsecase::new(repos.quests.clone())),
        mark_as_member: Arc::new(MarkAsMemberUsecase::new(
            repos.user_artist.clone(),
            repos.users.clone(),
        )),
        quest_mark_as_done: Arc::new(MarkAsDoneUsecase::new(repos.quest_user.clone())),
        register_credit: Arc::new(RegisterUsecase::new(repos.track_credits.clone())),
        request_to_access: Arc::new(RequestToAccessUsecase::new(
            repos.user_artist.clone(),
            repos.artists.clone(),
        )),
        get_quests: Arc::new(GetQuestsUsecase::new(
            repos.quests.clone(),
            repos.quest_user.clone(),
        )),
        get_members: Arc::new(GetMembersUsecase::new(
            repos.user_artist.clone(),
            repos.users.clone(),
            repos.artists.clone(),
        )),
        create_user: Arc::new(CreateUserUsecase::new(repos.users.clone())),
        get_artist: Arc::new(GetArtistUsecase::new(repos.artists.clone())),
        get_trending: Arc::new(GetTrendingUsecase::new(
            repos.plays_monthly.clone(),
            repos.plays_daily.clone(),
            repos.products.clone(),
            repos.tracks.clone(),
            repos.product_track.clone(),
            repos.artists.clone(),
        )),
        get_play_count_history: Arc::new(GetPlayCountHistoryUsecase::new(
            repos.plays_monthly.clone(),
            repos.plays_daily.clone(),
            repos.gender_gen_playback.clone(),
            repos.products.clone(),
            repos.product_track.clone(),
            repos.tracks.clone(),
        )),
        get_playback_gender_gen: Arc::new(GetPlaybackGenderGenUsecase::new(
            repos.gender_gen_playback.clone(),
            repos.product_track.clone(),
            repos.products.clone(),
        )),
        get_playback_overview: Arc::new(PlaybackOverviewUsecase::new(
            repos.plays_monthly.clone(),
            repos.plays_daily.clone(),
            repos.products.clone(),
            repos.product_track.clone(),
        )),
        get_all_users: Arc::new(GetAllUsersUsecase::new(repos.users.clone())),
        get_offer_details: Arc::new(GetOfferDetailsUsecase::new(
            repos.offers.clone(),
            repos.users.clone(),
            repos.offer_attach.clone(),
            repos.offer_user.clone(),
        )),
        get_user_basic_info: Arc::new(GetUserBasicInfoUsecase::new(
            repos.users.clone(),
            repos.user_artist.clone(),
            repos.artists.clone(),
        )),
        update_user_profile: Arc::new(UpdateUserProfileUsecase::new(
            repos.users.clone(),
            repos.user_artist.clone(),
            repos.artists.clone(),
        )),
        create_message_room: Arc::new(CreateMessageRoomUsecase::new(
            repos.rooms.clone(),
            repos.room_user.clone(),
        )),
        send_message: Arc::new(SendMessageUsecase::new(
            repos.messages.clone(),
            repos.message_attach.clone(),
            repos.rooms.clone(),
            services.push_notification_service.clone(),
            repos.users.clone(),
            repos.room_user.clone(),
            services.email_service.clone(),
        )),
        get_room_list: Arc::new(GetRoomListUsecase::new(
            repos.room_user.clone(),
            repos.rooms.clone(),
            repos.users.clone(),
        )),
        get_messages: Arc::new(GetMessagesUsecase::new(
            repos.messages.clone(),
            repos.users.clone(),
            repos.room_user.clone(),
            repos.message_attach.clone(),
        )),
        request_llm: Arc::new(RequestLlmUsecase::new(
            services.llm_service.clone(),
            repos.users.clone(),
        )),
        get_available_offer: Arc::new(GetAvailableOfferUsecase::new(repos.offers.clone())),
        get_offer_by_owner: Arc::new(GetOfferByOwnerUsecase::new(repos.offers.clone())),
        get_offer_by_status: Arc::new(GetOfferByStatusUsecase::new(
            repos.offers.clone(),
            repos.offer_user.clone(),
        )),
        get_offer_stats: Arc::new(GetOfferStatsUsecase::new(
            repos.offers.clone(),
            repos.offer_user.clone(),
        )),
        register_task: Arc::new(RegisterTaskUsecase::new(
            repos.offers.clone(),
            repos.offer_attach.clone(),
        )),
        update_task: Arc::new(UpdateTaskUsecase::new(
            repos.offers.clone(),
            repos.offer_attach.clone(),
        )),
        change_status: Arc::new(ChangeStatusUsecase::new(
            repos.offers.clone(),
            repos.offer_user.clone(),
            repos.txs_fsp.clone(),
            repos.users.clone(),
        )),
        delete_offer: Arc::new(DeleteOfferUsecase::new(
            repos.offers.clone(),
            repos.offer_attach.clone(),
            repos.offer_user.clone(),
        )),
        create_prize: Arc::new(CreatePrizeUsecase::new(repos.prizes.clone())),
        delete_prize: Arc::new(DeletePrizeUsecase::new(repos.prizes.clone())),
        exchange_prize: Arc::new(ExchangePrizeUsecase::new(
            repos.prizes.clone(),
            repos.exchange_prize_history.clone(),
            repos.users.clone(),
            repos.txs_fsp.clone(),
        )),
        get_prize_list: Arc::new(GetPrizeListUsecase::new(repos.prizes.clone())),
        get_prize: Arc::new(GetPrizeUsecase::new(repos.prizes.clone())),
        update_prize: Arc::new(UpdatePrizeUsecase::new(repos.prizes.clone())),
        get_point_transaction_history: Arc::new(GetPointTransactionHistoryUsecase::new(
            repos.txs_fsp.clone(),
            repos.users.clone(),
            repos.artists.clone(),
        )),
        get_user_point_balance: Arc::new(GetUserPointBalanceUsecase::new(repos.users.clone())),
        transfer_point_between_accounts: Arc::new(TransferPointBetweenAccountsUsecase::new(
            repos.txs_fsp.clone(),
            repos.users.clone(),
            repos.artists.clone(),
        )),
        mark_as_read: Arc::new(MarkAsReadUsecase::new(repos.room_user.clone())),
        get_notifications: Arc::new(GetNotificationsUsecase::new(
            repos.notification_user.clone(),
            repos.notifications.clone(),
        )),
        mark_notification_as_read: Arc::new(MarkNotificationAsReadUsecase::new(
            repos.notification_user.clone(),
        )),
    }
}
