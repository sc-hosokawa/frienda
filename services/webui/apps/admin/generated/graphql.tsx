export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = {
  [K in keyof T]: T[K];
};
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & {
  [SubKey in K]?: Maybe<T[SubKey]>;
};
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & {
  [SubKey in K]: Maybe<T[SubKey]>;
};
export type MakeEmpty<
  T extends { [key: string]: unknown },
  K extends keyof T,
> = { [_ in K]?: never };
export type Incremental<T> =
  | T
  | {
      [P in keyof T]?: P extends " $fragmentName" | "__typename" ? T[P] : never;
    };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string };
  String: { input: string; output: string };
  Boolean: { input: boolean; output: boolean };
  Int: { input: number; output: number };
  Float: { input: number; output: number };
  /** A scalar that can represent any JSON Object value. */
  JSONObject: { input: any; output: any };
};

export type AddNewConnectionByUserInput = {
  userId: Scalars["String"]["input"];
};

export type AddNewConnectionResponse = {
  __typename?: "AddNewConnectionResponse";
  mapId: Scalars["String"]["output"];
};

export type AllPendingMember = {
  __typename?: "AllPendingMember";
  artistId: Scalars["String"]["output"];
  artistName: Scalars["String"]["output"];
  member: PendingMember;
};

export type AllUsersData = {
  __typename?: "AllUsersData";
  users: Array<UserSimpleData>;
};

export type ArtistByUserData = {
  __typename?: "ArtistByUserData";
  artistId: Scalars["String"]["output"];
  fsp: Scalars["Int"]["output"];
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  isAdmin: Scalars["Boolean"]["output"];
  name: Scalars["String"]["output"];
  status: Scalars["String"]["output"];
};

export type ArtistByUserDataList = {
  __typename?: "ArtistByUserDataList";
  artistList: Array<ArtistByUserData>;
};

export type ArtistByUserDataWithMappingId = {
  __typename?: "ArtistByUserDataWithMappingId";
  artistId: Scalars["String"]["output"];
  fsp: Scalars["Int"]["output"];
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  isAdmin: Scalars["Boolean"]["output"];
  mappingId: Scalars["Int"]["output"];
  name: Scalars["String"]["output"];
  status: Scalars["String"]["output"];
};

export type ArtistData = {
  __typename?: "ArtistData";
  artistId: Scalars["String"]["output"];
  fsp: Scalars["Int"]["output"];
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
};

export type ArtistFullData = {
  __typename?: "ArtistFullData";
  amazonKey?: Maybe<Scalars["String"]["output"]>;
  appleKey?: Maybe<Scalars["String"]["output"]>;
  artistId: Scalars["String"]["output"];
  fsp: Scalars["Int"]["output"];
  id: Scalars["String"]["output"];
  imgUrl?: Maybe<Scalars["String"]["output"]>;
  lineKey?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  since?: Maybe<Scalars["String"]["output"]>;
  spotifyKey?: Maybe<Scalars["String"]["output"]>;
  status?: Maybe<Scalars["String"]["output"]>;
  universalId?: Maybe<Scalars["String"]["output"]>;
  youtubeKey?: Maybe<Scalars["String"]["output"]>;
};

export type ArtistsData = {
  __typename?: "ArtistsData";
  artistList: Array<ArtistData>;
};

export type ChartData = {
  __typename?: "ChartData";
  lineChartData: Array<LineChartData>;
};

export type ChartDataByIsrc = {
  __typename?: "ChartDataByISRC";
  date: Scalars["String"]["output"];
  trackCount: Scalars["JSONObject"]["output"];
};

export type ChartDataByUpc = {
  __typename?: "ChartDataByUPC";
  lineChartData: Array<ChartDataByIsrc>;
};

export type ConnectedUserByUserData = {
  __typename?: "ConnectedUserByUserData";
  connectedUser: UserBasicData;
  id: Scalars["String"]["output"];
};

export type ConnectedUsersData = {
  __typename?: "ConnectedUsersData";
  connectedUserList: Array<ConnectedUserByUserData>;
  countOfUsers?: Maybe<Scalars["Int"]["output"]>;
};

export type ContactToAdminInput = {
  category: Scalars["String"]["input"];
  content: Scalars["String"]["input"];
  email: Scalars["String"]["input"];
  username: Scalars["String"]["input"];
};

export type ContactToAdminResponse = {
  __typename?: "ContactToAdminResponse";
  id: Scalars["String"]["output"];
};

export type CreateNewArtistInput = {
  amazonKey?: InputMaybe<Scalars["String"]["input"]>;
  appleKey?: InputMaybe<Scalars["String"]["input"]>;
  fsp: Scalars["Int"]["input"];
  imgUrl?: InputMaybe<Scalars["String"]["input"]>;
  lineKey?: InputMaybe<Scalars["String"]["input"]>;
  name: Scalars["String"]["input"];
  since?: InputMaybe<Scalars["String"]["input"]>;
  spotifyKey?: InputMaybe<Scalars["String"]["input"]>;
  status?: InputMaybe<Scalars["String"]["input"]>;
  universalId?: InputMaybe<Scalars["String"]["input"]>;
  youtubeKey?: InputMaybe<Scalars["String"]["input"]>;
};

export type CreateNewArtistResponse = {
  __typename?: "CreateNewArtistResponse";
  artistId: Scalars["String"]["output"];
  name: Scalars["String"]["output"];
};

export type CreateNewMessageRoomInput = {
  category: Scalars["String"]["input"];
  createdBy: Scalars["String"]["input"];
  userList: Array<Scalars["String"]["input"]>;
};

export type CreateNewMessageRoomResponse = {
  __typename?: "CreateNewMessageRoomResponse";
  id: Scalars["String"]["output"];
};

export type CreateNewNotificationInput = {
  content: Scalars["String"]["input"];
  target?: InputMaybe<Scalars["String"]["input"]>;
  title: Scalars["String"]["input"];
  userId?: InputMaybe<Scalars["String"]["input"]>;
};

export type CreateNewNotificationResponse = {
  __typename?: "CreateNewNotificationResponse";
  id: Scalars["String"]["output"];
};

export type CreateNewOfferInput = {
  attachedFiles?: InputMaybe<Array<Scalars["String"]["input"]>>;
  attachedImgs?: InputMaybe<Array<Scalars["String"]["input"]>>;
  attention?: InputMaybe<Scalars["String"]["input"]>;
  category?: InputMaybe<Scalars["String"]["input"]>;
  deadline?: InputMaybe<Scalars["String"]["input"]>;
  description: Scalars["String"]["input"];
  fee: Scalars["Int"]["input"];
  imageUrl?: InputMaybe<Scalars["String"]["input"]>;
  owner: Scalars["String"]["input"];
  place: Scalars["String"]["input"];
  publicity?: InputMaybe<Scalars["Boolean"]["input"]>;
  raidId?: InputMaybe<Scalars["Int"]["input"]>;
  requiredSkill?: InputMaybe<Scalars["String"]["input"]>;
  targetRole?: InputMaybe<Scalars["String"]["input"]>;
  title: Scalars["String"]["input"];
};

export type CreateNewOfferResponse = {
  __typename?: "CreateNewOfferResponse";
  id: Scalars["Int"]["output"];
};

export type CreateNewPrizeInput = {
  condition?: InputMaybe<Scalars["String"]["input"]>;
  description: Scalars["String"]["input"];
  imgUrl?: InputMaybe<Scalars["String"]["input"]>;
  name: Scalars["String"]["input"];
  point: Scalars["Int"]["input"];
  publicity?: InputMaybe<Scalars["Boolean"]["input"]>;
  representation: Scalars["String"]["input"];
};

export type CreateNewPrizeResponse = {
  __typename?: "CreateNewPrizeResponse";
  id: Scalars["Int"]["output"];
};

export type CreateNewTransactionInput = {
  amount: Scalars["Int"]["input"];
  from?: InputMaybe<Scalars["String"]["input"]>;
  note?: InputMaybe<Scalars["String"]["input"]>;
  to: Scalars["String"]["input"];
};

export type CreateNewTransactionResponse = {
  __typename?: "CreateNewTransactionResponse";
  txId: Scalars["String"]["output"];
};

export type CreateNewUserDataInput = {
  category: Scalars["String"]["input"];
  email: Scalars["String"]["input"];
  id: Scalars["String"]["input"];
  imageUrl?: InputMaybe<Scalars["String"]["input"]>;
  invitedBy?: InputMaybe<Scalars["String"]["input"]>;
  name: Scalars["String"]["input"];
  primaryCategory: Scalars["String"]["input"];
  realname: Scalars["String"]["input"];
};

export type CreateNewUserDataResponse = {
  __typename?: "CreateNewUserDataResponse";
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  userId: Scalars["String"]["output"];
};

export type CreateQuestInput = {
  description: Scalars["String"]["input"];
  name: Scalars["String"]["input"];
};

export type CreateQuestResponse = {
  __typename?: "CreateQuestResponse";
  questId: Scalars["Int"]["output"];
};

export type DeleteNotificationInput = {
  id: Scalars["String"]["input"];
};

export type DeleteNotificationResponse = {
  __typename?: "DeleteNotificationResponse";
  id: Scalars["String"]["output"];
};

export type DeleteOfferInput = {
  id: Scalars["Int"]["input"];
};

export type DeleteOfferResponse = {
  __typename?: "DeleteOfferResponse";
  id: Scalars["Int"]["output"];
};

export type ExchangePrizeInput = {
  amount?: InputMaybe<Scalars["Int"]["input"]>;
  prizeId: Scalars["Int"]["input"];
  userId: Scalars["String"]["input"];
};

export type ExchangePrizeResponse = {
  __typename?: "ExchangePrizeResponse";
  id: Scalars["Int"]["output"];
  txId: Scalars["String"]["output"];
};

export type GenPlaybackRate = {
  __typename?: "GenPlaybackRate";
  gen50Over: Scalars["Int"]["output"];
  gen1519: Scalars["Int"]["output"];
  gen2024: Scalars["Int"]["output"];
  gen2529: Scalars["Int"]["output"];
  gen3034: Scalars["Int"]["output"];
  gen3539: Scalars["Int"]["output"];
  gen4044: Scalars["Int"]["output"];
  gen4549: Scalars["Int"]["output"];
  under14: Scalars["Int"]["output"];
};

export type GenderGenRateData = {
  __typename?: "GenderGenRateData";
  genRate: GenPlaybackRate;
  genderRate: GenderPlaybackRate;
};

export type GenderPlaybackRate = {
  __typename?: "GenderPlaybackRate";
  femaleCount: Scalars["Int"]["output"];
  maleCount: Scalars["Int"]["output"];
};

export type GetAllCreditsOutput = {
  __typename?: "GetAllCreditsOutput";
  credits: Array<TrackCreditsByAdmin>;
};

export type HealthCheck = {
  __typename?: "HealthCheck";
  status: Scalars["String"]["output"];
};

export type LineChartData = {
  __typename?: "LineChartData";
  amazon: Scalars["Int"]["output"];
  apple: Scalars["Int"]["output"];
  date: Scalars["String"]["output"];
  line: Scalars["Int"]["output"];
  spotify: Scalars["Int"]["output"];
  youtube: Scalars["Int"]["output"];
};

export type MarkAsAdminInput = {
  adminMember: Scalars["String"]["input"];
  artistId: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type MarkAsAdminResponse = {
  __typename?: "MarkAsAdminResponse";
  checkedUserId: Scalars["String"]["output"];
};

export type MarkAsDoneResponse = {
  __typename?: "MarkAsDoneResponse";
  questId: Scalars["Int"]["output"];
};

export type MarkAsMemberInput = {
  artistId: Scalars["String"]["input"];
  mapping: Array<StatusUser>;
  member: Scalars["String"]["input"];
};

export type MarkAsMemberResponse = {
  __typename?: "MarkAsMemberResponse";
  checkedUserId: Array<Scalars["String"]["output"]>;
};

export type MarkAsReadInput = {
  messageId: Scalars["String"]["input"];
  roomId: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type MarkAsReadResponse = {
  __typename?: "MarkAsReadResponse";
  isSuccess: Scalars["Boolean"]["output"];
};

export type MessageRoomData = {
  __typename?: "MessageRoomData";
  category?: Maybe<Scalars["String"]["output"]>;
  id: Scalars["String"]["output"];
  isRead: Scalars["Boolean"]["output"];
  latestMessage?: Maybe<Scalars["String"]["output"]>;
  latestMessageId?: Maybe<Scalars["String"]["output"]>;
  latestSentAt?: Maybe<Scalars["String"]["output"]>;
  users: Array<UserSimpleData>;
};

export type MessageRoomsByUserData = {
  __typename?: "MessageRoomsByUserData";
  countOfMessageRooms: Scalars["Int"]["output"];
  messageRoomList: Array<MessageRoomData>;
};

export type MessageTempData = {
  __typename?: "MessageTempData";
  attachedFile?: Maybe<Scalars["String"]["output"]>;
  attachedImg?: Maybe<Scalars["String"]["output"]>;
  content: Scalars["String"]["output"];
  id: Scalars["String"]["output"];
  sentAt: Scalars["String"]["output"];
  sentBy: Scalars["String"]["output"];
};

export type MessagesByRoomIdByUserData = {
  __typename?: "MessagesByRoomIdByUserData";
  id: Scalars["String"]["output"];
  messageList: Array<MessageTempData>;
  to: UserSimpleData;
};

export type MutationRoot = {
  __typename?: "MutationRoot";
  addNewConnection: AddNewConnectionResponse;
  contactToAdmin: ContactToAdminResponse;
  createBulkFspTx: CreateNewTransactionResponse;
  createFspTx: CreateNewTransactionResponse;
  createFspTxBetweenUserids: CreateNewTransactionResponse;
  createNewArtist: CreateNewArtistResponse;
  createNewMessageRoom: CreateNewMessageRoomResponse;
  createNewNotification: CreateNewNotificationResponse;
  createNewOffer: CreateNewOfferResponse;
  createNewUserData: CreateNewUserDataResponse;
  createPrize: CreateNewPrizeResponse;
  createQuest: CreateQuestResponse;
  deleteNotification: DeleteNotificationResponse;
  deleteOffer: DeleteOfferResponse;
  exchangePrize: ExchangePrizeResponse;
  markAsAdmin: MarkAsAdminResponse;
  markAsMember: MarkAsMemberResponse;
  markAsRead: MarkAsReadResponse;
  questMarkAsDone: MarkAsDoneResponse;
  registerCredit: RegisterCreditResponse;
  requestToAccessArtist: RequestToAccessArtistResponse;
  sendMessage: SendMessageResponse;
  updateBelongsToArtistStatus: UpdateBelongsToArtistStatusResponse;
  updateNotification: UpdateNotificationResponse;
  updateOfferInfo: UpdateOfferResponse;
  updateOfferStatus: UpdateOfferStatusResponse;
  updateUserData: UpdateUserDataResponse;
  updateUserDetailProfile: UpdateUserDetailProfileResponse;
};

export type MutationRootAddNewConnectionArgs = {
  input: AddNewConnectionByUserInput;
};

export type MutationRootContactToAdminArgs = {
  input: ContactToAdminInput;
};

export type MutationRootCreateBulkFspTxArgs = {
  input: Array<CreateNewTransactionInput>;
};

export type MutationRootCreateFspTxArgs = {
  input: CreateNewTransactionInput;
};

export type MutationRootCreateFspTxBetweenUseridsArgs = {
  input: CreateNewTransactionInput;
};

export type MutationRootCreateNewArtistArgs = {
  input: CreateNewArtistInput;
};

export type MutationRootCreateNewMessageRoomArgs = {
  input: CreateNewMessageRoomInput;
};

export type MutationRootCreateNewNotificationArgs = {
  input: CreateNewNotificationInput;
};

export type MutationRootCreateNewOfferArgs = {
  input: CreateNewOfferInput;
};

export type MutationRootCreateNewUserDataArgs = {
  input: CreateNewUserDataInput;
};

export type MutationRootCreatePrizeArgs = {
  input: CreateNewPrizeInput;
};

export type MutationRootCreateQuestArgs = {
  input: CreateQuestInput;
};

export type MutationRootDeleteNotificationArgs = {
  input: DeleteNotificationInput;
};

export type MutationRootDeleteOfferArgs = {
  input: DeleteOfferInput;
};

export type MutationRootExchangePrizeArgs = {
  input: ExchangePrizeInput;
};

export type MutationRootMarkAsAdminArgs = {
  input: MarkAsAdminInput;
};

export type MutationRootMarkAsMemberArgs = {
  input: MarkAsMemberInput;
};

export type MutationRootMarkAsReadArgs = {
  input: MarkAsReadInput;
};

export type MutationRootQuestMarkAsDoneArgs = {
  questId: Scalars["Int"]["input"];
  userId: Scalars["String"]["input"];
};

export type MutationRootRegisterCreditArgs = {
  input: RegisterCreditInput;
};

export type MutationRootRequestToAccessArtistArgs = {
  input: RequestToAccessArtistInput;
};

export type MutationRootSendMessageArgs = {
  input: SendMessageInput;
};

export type MutationRootUpdateBelongsToArtistStatusArgs = {
  input: UpdateBelongsToArtistStatusInput;
};

export type MutationRootUpdateNotificationArgs = {
  input: UpdateNotificationInput;
};

export type MutationRootUpdateOfferInfoArgs = {
  input: UpdateOfferInput;
};

export type MutationRootUpdateOfferStatusArgs = {
  input: UpdateOfferStatusInput;
};

export type MutationRootUpdateUserDataArgs = {
  input: UpdateUserDataInput;
};

export type MutationRootUpdateUserDetailProfileArgs = {
  input: UpdateUserDetailProfileInput;
};

export type NotificationData = {
  __typename?: "NotificationData";
  content: Scalars["String"]["output"];
  createdAt: Scalars["String"]["output"];
  id: Scalars["String"]["output"];
  title: Scalars["String"]["output"];
  updatedAt: Scalars["String"]["output"];
};

export type NotificationsData = {
  __typename?: "NotificationsData";
  notifications: Array<NotificationData>;
};

export type OfferByStatusData = {
  __typename?: "OfferByStatusData";
  appliedOffers: Array<OfferData>;
  inprogressOffers: Array<OfferData>;
};

export type OfferData = {
  __typename?: "OfferData";
  category?: Maybe<Scalars["String"]["output"]>;
  description: Scalars["String"]["output"];
  fee: Scalars["Int"]["output"];
  id: Scalars["Int"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  title: Scalars["String"]["output"];
};

export type OfferDetailData = {
  __typename?: "OfferDetailData";
  attachedFiles?: Maybe<Array<Scalars["String"]["output"]>>;
  attachedImgs?: Maybe<Array<Scalars["String"]["output"]>>;
  attention?: Maybe<Scalars["String"]["output"]>;
  category?: Maybe<Scalars["String"]["output"]>;
  createdAt: Scalars["String"]["output"];
  description: Scalars["String"]["output"];
  fee: Scalars["Int"]["output"];
  id: Scalars["Int"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  owner: UserSimpleData;
  place: Scalars["String"]["output"];
  publicity?: Maybe<Scalars["Boolean"]["output"]>;
  raidId?: Maybe<Scalars["Int"]["output"]>;
  requiredSkill?: Maybe<Scalars["String"]["output"]>;
  status?: Maybe<Scalars["String"]["output"]>;
  targetRole?: Maybe<Scalars["String"]["output"]>;
  title: Scalars["String"]["output"];
  updatedAt: Scalars["String"]["output"];
};

export type OfferStatsByUserData = {
  __typename?: "OfferStatsByUserData";
  appliedOffers: Scalars["Int"]["output"];
  completedOffers: Scalars["Int"]["output"];
  ongoingOffers: Scalars["Int"]["output"];
  totalEarnings: Scalars["Int"]["output"];
  totalOffers: Scalars["Int"]["output"];
};

export type OffersData = {
  __typename?: "OffersData";
  offerList: Array<OfferData>;
};

export type PendingMember = {
  __typename?: "PendingMember";
  email: Scalars["String"]["output"];
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  realname: Scalars["String"]["output"];
};

export type PrizeData = {
  __typename?: "PrizeData";
  id: Scalars["Int"]["output"];
  imgUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  point: Scalars["Int"]["output"];
};

export type PrizeDetailData = {
  __typename?: "PrizeDetailData";
  condition?: Maybe<Scalars["String"]["output"]>;
  description: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  imgUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  point: Scalars["Int"]["output"];
  representation: Scalars["String"]["output"];
};

export type Product = {
  __typename?: "Product";
  artistId?: Maybe<Scalars["String"]["output"]>;
  imgUrl?: Maybe<Scalars["String"]["output"]>;
  title: Scalars["String"]["output"];
  type?: Maybe<Scalars["String"]["output"]>;
  upc: Scalars["String"]["output"];
};

export type ProductWithTracks = {
  __typename?: "ProductWithTracks";
  product: Product;
  tracks: Array<Track>;
};

export type ProductsData = {
  __typename?: "ProductsData";
  album: Array<ProductWithTracks>;
  ep: Array<ProductWithTracks>;
  single: Array<ProductWithTracks>;
};

export type QueryRoot = {
  __typename?: "QueryRoot";
  getAllArtists: ArtistsData;
  getAllCredits: GetAllCreditsOutput;
  getAllNotifications: NotificationsData;
  getAllPendingMembers: Array<AllPendingMember>;
  getAllPrizes: Array<PrizeData>;
  getAllUsers: AllUsersData;
  getAllUsersExceptMe: AllUsersData;
  getArtistById: ArtistFullData;
  getArtistsByIds: ArtistsData;
  getArtistsByName: ArtistsData;
  getBelongedArtists: ArtistByUserDataList;
  getCommunities: ConnectedUsersData;
  getCredits: Array<TrackCredit>;
  getFspHistory: TransactionsData;
  getFspHistoryByUser: TransactionsByUserData;
  getGenderGenRateByArtist: GenderGenRateData;
  getGenderGenRateByUpc: GenderGenRateData;
  getMembersBelongedToArtist: Array<UserSimpleData>;
  getMembersJoinedToArtist: Array<UserSimpleData>;
  getMessageRooms: MessageRoomsByUserData;
  getMessagesByMessageRoomId: MessagesByRoomIdByUserData;
  getMessagesInProgress: MessageRoomsByUserData;
  getNotifications: NotificationsData;
  getOfferStatsByUser: OfferStatsByUserData;
  getOffers: OffersData;
  getOffersById: OfferDetailData;
  getOffersByOwner: OffersData;
  getOffersByStatus: OfferByStatusData;
  getOverview: TotalOverviewData;
  getOverviewByUpc: TotalOverviewData;
  getPlayCountHistory: ChartData;
  getPlaycountHistoryByUpc: ChartDataByUpc;
  getPopularPrizes: Array<PrizeData>;
  getPrizeDetail: PrizeDetailData;
  getProducts: ProductsData;
  getQuestByUserId: Array<QuestData>;
  getQuests: Array<QuestData>;
  getTrending: TrendingData;
  getTrendingByUpc: TrendingByUpcData;
  getUserData: UserDetailData;
  getUserDetailProfile: UserDetailData;
  getUserPointBalance: UserPointBalanceData;
  healthCheck: HealthCheck;
};

export type QueryRootGetAllCreditsArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetAllPendingMembersArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetAllUsersExceptMeArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetArtistByIdArgs = {
  artistId: Scalars["String"]["input"];
};

export type QueryRootGetArtistsByIdsArgs = {
  artistIds: Array<Scalars["String"]["input"]>;
};

export type QueryRootGetArtistsByNameArgs = {
  name: Scalars["String"]["input"];
};

export type QueryRootGetBelongedArtistsArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetCreditsArgs = {
  artistId: Scalars["String"]["input"];
  isrc: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetFspHistoryArgs = {
  count: Scalars["Int"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetFspHistoryByUserArgs = {
  count: Scalars["Int"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetGenderGenRateByArtistArgs = {
  artistId: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetGenderGenRateByUpcArgs = {
  artistId: Scalars["String"]["input"];
  upc: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetMembersBelongedToArtistArgs = {
  artistId: Scalars["String"]["input"];
  userId?: InputMaybe<Scalars["String"]["input"]>;
};

export type QueryRootGetMembersJoinedToArtistArgs = {
  artistId: Scalars["String"]["input"];
  userId?: InputMaybe<Scalars["String"]["input"]>;
};

export type QueryRootGetMessageRoomsArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetMessagesByMessageRoomIdArgs = {
  messageRoomId: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetMessagesInProgressArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetNotificationsArgs = {
  count: Scalars["Int"]["input"];
  offset: Scalars["Int"]["input"];
};

export type QueryRootGetOfferStatsByUserArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetOffersByIdArgs = {
  offerId: Scalars["Int"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetOffersByOwnerArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetOffersByStatusArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetOverviewArgs = {
  artistId: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetOverviewByUpcArgs = {
  artistId: Scalars["String"]["input"];
  upc: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetPlayCountHistoryArgs = {
  artistId: Scalars["String"]["input"];
  period: Scalars["Int"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetPlaycountHistoryByUpcArgs = {
  period: Scalars["Int"]["input"];
  upc: Scalars["String"]["input"];
};

export type QueryRootGetPrizeDetailArgs = {
  prizeId: Scalars["Int"]["input"];
};

export type QueryRootGetProductsArgs = {
  artistId: Scalars["String"]["input"];
};

export type QueryRootGetQuestByUserIdArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetTrendingArgs = {
  artistId: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetTrendingByUpcArgs = {
  upc: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type QueryRootGetUserDataArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetUserDetailProfileArgs = {
  userId: Scalars["String"]["input"];
};

export type QueryRootGetUserPointBalanceArgs = {
  userId: Scalars["String"]["input"];
};

export type QuestData = {
  __typename?: "QuestData";
  category: Scalars["String"]["output"];
  description: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  name: Scalars["String"]["output"];
};

export type RegisterCreditInput = {
  registerInfo: Array<RegisterInfo>;
};

export type RegisterCreditResponse = {
  __typename?: "RegisterCreditResponse";
  isSuccess: Scalars["Boolean"]["output"];
};

export type RegisterInfo = {
  commitUser: Scalars["String"]["input"];
  creditName: Scalars["String"]["input"];
  creditRole: Scalars["String"]["input"];
  email: Scalars["String"]["input"];
  isInvite: Scalars["Boolean"]["input"];
  isrc: Scalars["String"]["input"];
  memo?: InputMaybe<Scalars["String"]["input"]>;
};

export type RequestToAccessArtistInput = {
  artistIds: Array<Scalars["String"]["input"]>;
  userId: Scalars["String"]["input"];
};

export type RequestToAccessArtistResponse = {
  __typename?: "RequestToAccessArtistResponse";
  createdMappings: Array<ArtistByUserDataWithMappingId>;
};

export type SendMessageInput = {
  attachedFile?: InputMaybe<Array<Scalars["String"]["input"]>>;
  attachedImg?: InputMaybe<Array<Scalars["String"]["input"]>>;
  message: Scalars["String"]["input"];
  roomId: Scalars["String"]["input"];
  sentBy: Scalars["String"]["input"];
};

export type SendMessageResponse = {
  __typename?: "SendMessageResponse";
  attachedFile?: Maybe<Array<Scalars["String"]["output"]>>;
  attachedImg?: Maybe<Array<Scalars["String"]["output"]>>;
  id: Scalars["String"]["output"];
  message: Scalars["String"]["output"];
  sentAt: Scalars["String"]["output"];
};

export type StatusUser = {
  status: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type TotalOverviewData = {
  __typename?: "TotalOverviewData";
  totalPlaybacks: Scalars["Int"]["output"];
  weeklyPlaybacks: Scalars["Int"]["output"];
};

export type Track = {
  __typename?: "Track";
  imgUrl?: Maybe<Scalars["String"]["output"]>;
  isrc: Scalars["String"]["output"];
  title?: Maybe<Scalars["String"]["output"]>;
};

export type TrackCredit = {
  __typename?: "TrackCredit";
  commitUser: Scalars["String"]["output"];
  createdAt: Scalars["String"]["output"];
  creditName: Scalars["String"]["output"];
  creditRole: Scalars["String"]["output"];
  email: Scalars["String"]["output"];
  isInvite?: Maybe<Scalars["Boolean"]["output"]>;
  isrc: Scalars["String"]["output"];
  memo?: Maybe<Scalars["String"]["output"]>;
};

export type TrackCreditsByAdmin = {
  __typename?: "TrackCreditsByAdmin";
  commitUser: Scalars["String"]["output"];
  createdAt: Scalars["String"]["output"];
  creditName: Scalars["String"]["output"];
  creditRole: Scalars["String"]["output"];
  creditUser?: Maybe<Scalars["String"]["output"]>;
  email: Scalars["String"]["output"];
  id: Scalars["Int"]["output"];
  isInvite?: Maybe<Scalars["Boolean"]["output"]>;
  isrc: Scalars["String"]["output"];
  memo?: Maybe<Scalars["String"]["output"]>;
};

export type TransactionByUserData = {
  __typename?: "TransactionByUserData";
  amount: Scalars["Int"]["output"];
  counterParty: UserSimpleData;
  direction: TransactionDirection;
  id: Scalars["String"]["output"];
  txAt: Scalars["String"]["output"];
};

export type TransactionData = {
  __typename?: "TransactionData";
  amount: Scalars["Int"]["output"];
  from?: Maybe<UserSimpleData>;
  id: Scalars["String"]["output"];
  to?: Maybe<UserSimpleData>;
  txAt: Scalars["String"]["output"];
};

export enum TransactionDirection {
  In = "IN",
  Out = "OUT",
}

export type TransactionsByUserData = {
  __typename?: "TransactionsByUserData";
  transactionList: Array<TransactionByUserData>;
};

export type TransactionsData = {
  __typename?: "TransactionsData";
  transactionList: Array<TransactionData>;
};

export type TrendTrack = {
  __typename?: "TrendTrack";
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  isrc: Scalars["String"]["output"];
  totalPlayCount: Scalars["Int"]["output"];
  trackTitle?: Maybe<Scalars["String"]["output"]>;
  upcTitle?: Maybe<Scalars["String"]["output"]>;
  weeklyPlayCount: Scalars["Int"]["output"];
};

export type TrendingByUpcData = {
  __typename?: "TrendingByUPCData";
  artistName: Scalars["String"]["output"];
  productImgUrl?: Maybe<Scalars["String"]["output"]>;
  productTitle: Scalars["String"]["output"];
  trendingTracks: Array<TrendTrack>;
};

export type TrendingData = {
  __typename?: "TrendingData";
  trendingTracks: Array<TrendTrack>;
};

export type UpdateBelongsToArtistStatusInput = {
  artistId: Scalars["String"]["input"];
  nextStatus?: InputMaybe<Scalars["String"]["input"]>;
  nextStatusIsAdmin?: InputMaybe<Scalars["Boolean"]["input"]>;
  userId: Scalars["String"]["input"];
};

export type UpdateBelongsToArtistStatusResponse = {
  __typename?: "UpdateBelongsToArtistStatusResponse";
  updatedUserArtist: ArtistByUserData;
};

export type UpdateNotificationInput = {
  content?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["String"]["input"];
  title?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateNotificationResponse = {
  __typename?: "UpdateNotificationResponse";
  id: Scalars["String"]["output"];
};

export type UpdateOfferInput = {
  attachedMedia?: InputMaybe<Array<Scalars["String"]["input"]>>;
  attention?: InputMaybe<Scalars["String"]["input"]>;
  category?: InputMaybe<Scalars["String"]["input"]>;
  description?: InputMaybe<Scalars["String"]["input"]>;
  fee?: InputMaybe<Scalars["Int"]["input"]>;
  id: Scalars["Int"]["input"];
  imageUrl?: InputMaybe<Scalars["String"]["input"]>;
  place?: InputMaybe<Scalars["String"]["input"]>;
  publicity?: InputMaybe<Scalars["Boolean"]["input"]>;
  requiredSkill?: InputMaybe<Scalars["String"]["input"]>;
  targetRole?: InputMaybe<Scalars["String"]["input"]>;
  title?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateOfferResponse = {
  __typename?: "UpdateOfferResponse";
  id: Scalars["Int"]["output"];
};

export type UpdateOfferStatusInput = {
  id: Scalars["Int"]["input"];
  status: Scalars["String"]["input"];
  userId: Scalars["String"]["input"];
};

export type UpdateOfferStatusResponse = {
  __typename?: "UpdateOfferStatusResponse";
  id: Scalars["Int"]["output"];
  offerId: Scalars["Int"]["output"];
};

export type UpdateUserDataInput = {
  email?: InputMaybe<Scalars["String"]["input"]>;
  evmAddr?: InputMaybe<Scalars["String"]["input"]>;
  fbHandle?: InputMaybe<Scalars["String"]["input"]>;
  greeting?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["String"]["input"];
  imageUrl?: InputMaybe<Scalars["String"]["input"]>;
  instagramHandle?: InputMaybe<Scalars["String"]["input"]>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  primaryCategory?: InputMaybe<Scalars["String"]["input"]>;
  skill?: InputMaybe<Scalars["String"]["input"]>;
  xHandle?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateUserDataResponse = {
  __typename?: "UpdateUserDataResponse";
  userInfo: UserDetailData;
};

export type UpdateUserDetailProfileInput = {
  fbHandle?: InputMaybe<Scalars["String"]["input"]>;
  greeting?: InputMaybe<Scalars["String"]["input"]>;
  id: Scalars["String"]["input"];
  imageUrl?: InputMaybe<Scalars["String"]["input"]>;
  instagramHandle?: InputMaybe<Scalars["String"]["input"]>;
  interestOffer?: InputMaybe<Array<Scalars["String"]["input"]>>;
  name?: InputMaybe<Scalars["String"]["input"]>;
  primaryRole?: InputMaybe<Scalars["String"]["input"]>;
  role?: InputMaybe<Scalars["String"]["input"]>;
  skill?: InputMaybe<Scalars["String"]["input"]>;
  xHandle?: InputMaybe<Scalars["String"]["input"]>;
};

export type UpdateUserDetailProfileResponse = {
  __typename?: "UpdateUserDetailProfileResponse";
  userInfo: UserDetailData;
};

export type UserBasicData = {
  __typename?: "UserBasicData";
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  primaryArtist?: Maybe<ArtistByUserData>;
  primaryRole: Scalars["String"]["output"];
  role: Scalars["String"]["output"];
};

export type UserDetailData = {
  __typename?: "UserDetailData";
  belongsToArtists: Array<ArtistByUserData>;
  createdAt: Scalars["String"]["output"];
  credentialBalance: Scalars["Int"]["output"];
  fbHandle?: Maybe<Scalars["String"]["output"]>;
  fspBalance: Scalars["Int"]["output"];
  greeting?: Maybe<Scalars["String"]["output"]>;
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  instagramHandle?: Maybe<Scalars["String"]["output"]>;
  interestOffer?: Maybe<Scalars["String"]["output"]>;
  isSuperAdmin: Scalars["Boolean"]["output"];
  name: Scalars["String"]["output"];
  primaryArtist?: Maybe<ArtistByUserData>;
  primaryRole: Scalars["String"]["output"];
  realname: Scalars["String"]["output"];
  role: Scalars["String"]["output"];
  skill?: Maybe<Scalars["String"]["output"]>;
  xHandle?: Maybe<Scalars["String"]["output"]>;
};

export type UserPointBalanceData = {
  __typename?: "UserPointBalanceData";
  credentialBalance: Scalars["Int"]["output"];
  fspBalance: Scalars["Int"]["output"];
  fspBalanceTemp: Scalars["Int"]["output"];
};

export type UserSimpleData = {
  __typename?: "UserSimpleData";
  id: Scalars["String"]["output"];
  imageUrl?: Maybe<Scalars["String"]["output"]>;
  name: Scalars["String"]["output"];
  realname: Scalars["String"]["output"];
};
