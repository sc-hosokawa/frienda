use sea_orm::DatabaseConnection;
use std::sync::Arc;
use tracing;

use application::health_check::*;
use application::usecases::artist::get_artist_usecase::{GetArtistUsecase, GetArtistUsecaseTrait};
use application::usecases::basic::{
    create_user_usecase::{CreateUserUsecase, CreateUserUsecaseTrait},
    get_all_users_usecase::{GetAllUsersUsecase, GetAllUsersUsecaseTrait},
    get_user_basic_info_usecase::{GetUserBasicInfoUsecase, GetUserBasicInfoUsecaseTrait},
    update_user_profile_usecase::{UpdateUserProfileUsecase, UpdateUserProfileUsecaseTrait},
};
use application::usecases::messaging::{
    create_message_room_usecase::{CreateMessageRoomUsecase, CreateMessageRoomUsecaseTrait},
    get_messages_usecase::{GetMessagesUsecase, GetMessagesUsecaseTrait},
    get_room_list_usecase::{GetRoomListUsecase, GetRoomListUsecaseTrait},
    mark_as_read_usecase::{MarkAsReadUsecase, MarkAsReadUsecaseTrait},
    send_message_usecase::{SendMessageUsecase, SendMessageUsecaseTrait},
};
use application::usecases::offer::{
    change_status_usecase::{ChangeStatusUsecase, ChangeStatusUsecaseTrait},
    delete_offer_usecase::{DeleteOfferUsecase, DeleteOfferUsecaseTrait},
    get_available_offer_usecase::{GetAvailableOfferUsecase, GetAvailableOfferUsecaseTrait},
    get_offer_by_owner_usecase::{GetOfferByOwnerUsecase, GetOfferByOwnerUsecaseTrait},
    get_offer_by_status_usecase::{GetOfferByStatusUsecase, GetOfferByStatusUsecaseTrait},
    get_offer_details_usecase::{GetOfferDetailsUsecase, GetOfferDetailsUsecaseTrait},
    get_offer_stats_usecase::{GetOfferStatsUsecase, GetOfferStatsUsecaseTrait},
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
use infrastracture::persistences::health_check_repo_impl::HealthCheckRepoImpl;
use infrastracture::persistences::{
    artists_repo_impl::ArtistsRepoImpl,
    exchange_prize_history_repo_impl::ExchangePrizeHistoryRepoImpl,
    message_attach_repo_impl::MessageAttachRepoImpl, messages_repo_impl::MessagesRepoImpl,
    offer_attach_repo_impl::OfferAttachRepoImpl, offer_user_repo_impl::OfferUserRepoImpl,
    offers_repo_impl::OffersRepoImpl, prizes_repo_impl::PrizesRepoImpl,
    room_user_repo_impl::RoomUserRepoImpl, rooms_repo_impl::RoomsRepoImpl,
    txs_fsp_repo_impl::TxsFspRepoImpl, user_artist_repo_impl::UserArtistRepoImpl,
    users_repo_impl::UsersRepoImpl,
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
}

pub fn create_repositories(db: DatabaseConnection) -> RepositoriesImpl {
    tracing::info!("Creating Repositories...");
    RepositoriesImpl {
        health_check: Arc::new(HealthCheckRepoImpl::new(db.clone())),
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
    }
}

pub fn create_usecases(repos: RepositoriesImpl) -> Usecases {
    tracing::info!("Creating Usecases...");
    Usecases {
        health_check: Arc::new(HealthCheckUsecase::new(repos.health_check.clone())),
        create_user: Arc::new(CreateUserUsecase::new(repos.users.clone())),
        get_artist: Arc::new(GetArtistUsecase::new(repos.artists.clone())),
        get_all_users: Arc::new(GetAllUsersUsecase::new(repos.users.clone())),
        get_offer_details: Arc::new(GetOfferDetailsUsecase::new(
            repos.offers.clone(),
            repos.users.clone(),
            repos.offer_attach.clone(),
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
        delete_offer: Arc::new(DeleteOfferUsecase::new(repos.offers.clone())),
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
        )),
        get_user_point_balance: Arc::new(GetUserPointBalanceUsecase::new(repos.users.clone())),
        transfer_point_between_accounts: Arc::new(TransferPointBetweenAccountsUsecase::new(
            repos.txs_fsp.clone(),
            repos.users.clone(),
        )),
        mark_as_read: Arc::new(MarkAsReadUsecase::new(repos.room_user.clone())),
    }
}
