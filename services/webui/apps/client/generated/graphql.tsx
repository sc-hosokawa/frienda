import { gql } from '@apollo/client';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
  /** A scalar that can represent any JSON Object value. */
  JSONObject: { input: any; output: any; }
};

export type AddShortnoteResponse = {
  __typename?: 'AddShortnoteResponse';
  id: Scalars['String']['output'];
};

export type AdminNotificationDetail = {
  __typename?: 'AdminNotificationDetail';
  category?: Maybe<Scalars['String']['output']>;
  channels: Array<NotificationChannel>;
  content: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  recipients: Array<AdminNotificationRecipient>;
  title: Scalars['String']['output'];
};

export type AdminNotificationListData = {
  __typename?: 'AdminNotificationListData';
  hasNextPage: Scalars['Boolean']['output'];
  notifications: Array<AdminNotificationListItem>;
  totalCount: Scalars['Int']['output'];
};

export type AdminNotificationListItem = {
  __typename?: 'AdminNotificationListItem';
  category?: Maybe<Scalars['String']['output']>;
  channels: Array<NotificationChannel>;
  content: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  recipientCount: Scalars['Int']['output'];
  title: Scalars['String']['output'];
};

export type AdminNotificationRecipient = {
  __typename?: 'AdminNotificationRecipient';
  email: Scalars['String']['output'];
  mobilePushIsDeleted?: Maybe<Scalars['Boolean']['output']>;
  mobilePushIsRead?: Maybe<Scalars['Boolean']['output']>;
  userId: Scalars['String']['output'];
  username: Scalars['String']['output'];
};

export type AllPendingMember = {
  __typename?: 'AllPendingMember';
  artistId: Scalars['String']['output'];
  artistName: Scalars['String']['output'];
  member: PendingMember;
};

export type AllUsersData = {
  __typename?: 'AllUsersData';
  users: Array<UserSimpleData>;
};

export type ArtistByUserData = {
  __typename?: 'ArtistByUserData';
  artistId: Scalars['String']['output'];
  fsp: Scalars['Int']['output'];
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  isAdmin: Scalars['Boolean']['output'];
  isDefault: Scalars['Boolean']['output'];
  name: Scalars['String']['output'];
  requestMessage?: Maybe<Scalars['String']['output']>;
  status: Scalars['String']['output'];
};

export type ArtistByUserDataList = {
  __typename?: 'ArtistByUserDataList';
  artistList: Array<ArtistByUserData>;
};

export type ArtistByUserDataWithMappingId = {
  __typename?: 'ArtistByUserDataWithMappingId';
  artistId: Scalars['String']['output'];
  fsp: Scalars['Int']['output'];
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  isAdmin: Scalars['Boolean']['output'];
  mappingId: Scalars['Int']['output'];
  name: Scalars['String']['output'];
  requestMessage?: Maybe<Scalars['String']['output']>;
  status: Scalars['String']['output'];
};

export type ArtistData = {
  __typename?: 'ArtistData';
  amazonKey?: Maybe<Scalars['String']['output']>;
  appleKey?: Maybe<Scalars['String']['output']>;
  artistId: Scalars['String']['output'];
  displayNameEn: Scalars['String']['output'];
  displayNameKana?: Maybe<Scalars['String']['output']>;
  fsp: Scalars['Int']['output'];
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  lineKey?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  spotifyKey?: Maybe<Scalars['String']['output']>;
  status: Scalars['String']['output'];
  universalId?: Maybe<Scalars['String']['output']>;
  youtubeKey?: Maybe<Scalars['String']['output']>;
};

export type ArtistFullData = {
  __typename?: 'ArtistFullData';
  amazonKey?: Maybe<Scalars['String']['output']>;
  appleKey?: Maybe<Scalars['String']['output']>;
  artistId: Scalars['String']['output'];
  fsp: Scalars['Int']['output'];
  id: Scalars['String']['output'];
  imgUrl?: Maybe<Scalars['String']['output']>;
  lineKey?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  since?: Maybe<Scalars['String']['output']>;
  spotifyKey?: Maybe<Scalars['String']['output']>;
  status?: Maybe<Scalars['String']['output']>;
  universalId?: Maybe<Scalars['String']['output']>;
  youtubeKey?: Maybe<Scalars['String']['output']>;
};

export type ArtistsData = {
  __typename?: 'ArtistsData';
  artistList: Array<ArtistData>;
};

export type BlockUserDataResponse = {
  __typename?: 'BlockUserDataResponse';
  blockedUserId: Scalars['String']['output'];
  blockerUserId: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  isSolved: Scalars['Boolean']['output'];
};

export type BlockUserInput = {
  blockedUserId: Scalars['String']['input'];
  blockerUserId: Scalars['String']['input'];
};

export type BlockUserResponse = {
  __typename?: 'BlockUserResponse';
  id: Scalars['Int']['output'];
};

export type CancelRequestToAccessArtistInput = {
  artistId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type CancelRequestToAccessArtistResponse = {
  __typename?: 'CancelRequestToAccessArtistResponse';
  canceledMapping: ArtistByUserDataWithMappingId;
};

export type ChartData = {
  __typename?: 'ChartData';
  lineChartData: Array<LineChartData>;
};

export type ChartDataByIsrc = {
  __typename?: 'ChartDataByISRC';
  date: Scalars['String']['output'];
  trackCount: Scalars['JSONObject']['output'];
};

export type ChartDataByUpc = {
  __typename?: 'ChartDataByUPC';
  lineChartData: Array<ChartDataByIsrc>;
};

export type ChartDataForAdmin = {
  __typename?: 'ChartDataForAdmin';
  lineChartData: Array<LineChartDataForAdmin>;
};

export type ConnectedUsersData = {
  __typename?: 'ConnectedUsersData';
  community: Array<UserConnectionData>;
};

export type ContactToAdminInput = {
  category: Scalars['String']['input'];
  content: Scalars['String']['input'];
  email: Scalars['String']['input'];
  username: Scalars['String']['input'];
};

export type CreateNewArtistData = {
  __typename?: 'CreateNewArtistData';
  artistId: Scalars['String']['output'];
  displayNameJp: Scalars['String']['output'];
};

export type CreateNewArtistInput = {
  amazonKey?: InputMaybe<Scalars['String']['input']>;
  appleKey?: InputMaybe<Scalars['String']['input']>;
  displayNameEn: Scalars['String']['input'];
  displayNameJp: Scalars['String']['input'];
  displayNameKana?: InputMaybe<Scalars['String']['input']>;
  fsp?: InputMaybe<Scalars['Int']['input']>;
  imgUrl?: InputMaybe<Scalars['String']['input']>;
  lineKey?: InputMaybe<Scalars['String']['input']>;
  since?: InputMaybe<Scalars['String']['input']>;
  spotifyKey?: InputMaybe<Scalars['String']['input']>;
  status?: InputMaybe<Scalars['String']['input']>;
  universalId?: InputMaybe<Scalars['String']['input']>;
  youtubeKey?: InputMaybe<Scalars['String']['input']>;
};

export type CreateNewArtistsResponse = {
  __typename?: 'CreateNewArtistsResponse';
  addedArtists: Array<CreateNewArtistData>;
};

export type CreateNewMessageRoomInput = {
  category: Scalars['String']['input'];
  createdBy: Scalars['String']['input'];
  userList: Array<Scalars['String']['input']>;
};

export type CreateNewMessageRoomResponse = {
  __typename?: 'CreateNewMessageRoomResponse';
  id: Scalars['String']['output'];
};

export type CreateNewOfferInput = {
  attachedFiles?: InputMaybe<Array<Scalars['String']['input']>>;
  attachedImgs?: InputMaybe<Array<Scalars['String']['input']>>;
  attention?: InputMaybe<Scalars['String']['input']>;
  category?: InputMaybe<Scalars['String']['input']>;
  deadline?: InputMaybe<Scalars['String']['input']>;
  description: Scalars['String']['input'];
  fee: Scalars['Int']['input'];
  imageUrl?: InputMaybe<Scalars['String']['input']>;
  owner: Scalars['String']['input'];
  place: Scalars['String']['input'];
  publicity?: InputMaybe<Scalars['Boolean']['input']>;
  raidId?: InputMaybe<Scalars['Int']['input']>;
  requiredSkill?: InputMaybe<Scalars['String']['input']>;
  targetRole?: InputMaybe<Scalars['String']['input']>;
  title: Scalars['String']['input'];
};

export type CreateNewOfferResponse = {
  __typename?: 'CreateNewOfferResponse';
  id: Scalars['Int']['output'];
};

export type CreateNewPrizeInput = {
  condition?: InputMaybe<Scalars['String']['input']>;
  description: Scalars['String']['input'];
  imgUrl?: InputMaybe<Scalars['String']['input']>;
  name: Scalars['String']['input'];
  point: Scalars['Int']['input'];
  publicity?: InputMaybe<Scalars['Boolean']['input']>;
  representation: Scalars['String']['input'];
};

export type CreateNewPrizeResponse = {
  __typename?: 'CreateNewPrizeResponse';
  id: Scalars['Int']['output'];
};

export type CreateNewTransactionInput = {
  amount: Scalars['Int']['input'];
  from?: InputMaybe<Scalars['String']['input']>;
  note?: InputMaybe<Scalars['String']['input']>;
  to: Scalars['String']['input'];
};

export type CreateNewTransactionResponse = {
  __typename?: 'CreateNewTransactionResponse';
  txId: Scalars['String']['output'];
};

export type CreateNewUserDataInput = {
  category: Scalars['String']['input'];
  email: Scalars['String']['input'];
  fcmToken?: InputMaybe<Scalars['String']['input']>;
  id: Scalars['String']['input'];
  imageUrl?: InputMaybe<Scalars['String']['input']>;
  invitedBy?: InputMaybe<Scalars['String']['input']>;
  name: Scalars['String']['input'];
  primaryCategory: Scalars['String']['input'];
  realname: Scalars['String']['input'];
};

export type CreateNewUserDataResponse = {
  __typename?: 'CreateNewUserDataResponse';
  imageUrl?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  userId: Scalars['String']['output'];
};

export type CreateQuestInput = {
  description: Scalars['String']['input'];
  name: Scalars['String']['input'];
};

export type CreateQuestResponse = {
  __typename?: 'CreateQuestResponse';
  questId: Scalars['Int']['output'];
};

export type Credit = {
  __typename?: 'Credit';
  date: Scalars['String']['output'];
  email: Scalars['String']['output'];
  isrc: Scalars['String']['output'];
  name: Scalars['String']['output'];
  role: Scalars['String']['output'];
  title: Scalars['String']['output'];
  user: Scalars['String']['output'];
};

export type DeleteCreditInput = {
  creditId: Scalars['Int']['input'];
};

export type DeleteCreditResponse = {
  __typename?: 'DeleteCreditResponse';
  isSuccess: Scalars['Boolean']['output'];
};

export type DeleteOfferInput = {
  id: Scalars['Int']['input'];
};

export type DeleteOfferResponse = {
  __typename?: 'DeleteOfferResponse';
  id: Scalars['Int']['output'];
};

export type DeletePortfolioInput = {
  id: Scalars['Int']['input'];
};

export type DeletePortfolioResponse = {
  __typename?: 'DeletePortfolioResponse';
  portfolioId: Scalars['Int']['output'];
};

export type DeleteShortnoteResponse = {
  __typename?: 'DeleteShortnoteResponse';
  id: Scalars['String']['output'];
};

export type EditShortnoteResponse = {
  __typename?: 'EditShortnoteResponse';
  id: Scalars['String']['output'];
};

export type ExchangeHistoryData = {
  __typename?: 'ExchangeHistoryData';
  amount: Scalars['Int']['output'];
  email: Scalars['String']['output'];
  exchangedAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  imgUrl?: Maybe<Scalars['String']['output']>;
  isRequested: Scalars['Boolean']['output'];
  isUsed: Scalars['Boolean']['output'];
  pointUsed: Scalars['Int']['output'];
  prizeId: Scalars['Int']['output'];
  realname: Scalars['String']['output'];
  requestedAt?: Maybe<Scalars['String']['output']>;
  usedAt?: Maybe<Scalars['String']['output']>;
  userId: Scalars['String']['output'];
  username: Scalars['String']['output'];
};

export type ExchangePrizeInput = {
  amount?: InputMaybe<Scalars['Int']['input']>;
  prizeId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};

export type ExchangePrizeResponse = {
  __typename?: 'ExchangePrizeResponse';
  id: Scalars['Int']['output'];
  txId: Scalars['String']['output'];
};

export type FspHistory = {
  __typename?: 'FspHistory';
  amount: Scalars['Int']['output'];
  date: Scalars['String']['output'];
  from: Scalars['String']['output'];
  notes?: Maybe<Scalars['String']['output']>;
  to: Scalars['String']['output'];
};

export type GenPlaybackRate = {
  __typename?: 'GenPlaybackRate';
  gen1822: Scalars['Int']['output'];
  gen2327: Scalars['Int']['output'];
  gen2834: Scalars['Int']['output'];
  gen3544: Scalars['Int']['output'];
  gen4559: Scalars['Int']['output'];
  gen60150: Scalars['Int']['output'];
  genUnknown: Scalars['Int']['output'];
  under17: Scalars['Int']['output'];
};

export type GenderGenRateData = {
  __typename?: 'GenderGenRateData';
  genRate: GenPlaybackRate;
  genderRate: GenderPlaybackRate;
};

export type GenderPlaybackRate = {
  __typename?: 'GenderPlaybackRate';
  femaleCount: Scalars['Int']['output'];
  maleCount: Scalars['Int']['output'];
  neutralCount: Scalars['Int']['output'];
  unknownCount: Scalars['Int']['output'];
};

export type GetAllCreditsOutput = {
  __typename?: 'GetAllCreditsOutput';
  credits: Array<TrackCreditsByAdmin>;
};

export type HealthCheck = {
  __typename?: 'HealthCheck';
  status: Scalars['String']['output'];
};

export type LeaveBelongedArtistInput = {
  artistId: Scalars['String']['input'];
  operatorUserId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type LeaveBelongedArtistResponse = {
  __typename?: 'LeaveBelongedArtistResponse';
  leftArtist: ArtistByUserData;
};

export type LineChartData = {
  __typename?: 'LineChartData';
  amazon: Scalars['Int']['output'];
  apple: Scalars['Int']['output'];
  date: Scalars['String']['output'];
  line: Scalars['Int']['output'];
  spotify: Scalars['Int']['output'];
  youtube: Scalars['Int']['output'];
};

export type LineChartDataForAdmin = {
  __typename?: 'LineChartDataForAdmin';
  amazon: Scalars['Int']['output'];
  apple: Scalars['Int']['output'];
  date: Scalars['String']['output'];
  line: Scalars['Int']['output'];
  spotify: Scalars['Int']['output'];
  youtube: Scalars['Int']['output'];
};

export type LoginRewardResponse = {
  __typename?: 'LoginRewardResponse';
  fsp: Scalars['Int']['output'];
  rewardGiven: Scalars['Boolean']['output'];
};

export type MarkAsAdminInput = {
  adminMember: Scalars['String']['input'];
  artistId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type MarkAsAdminResponse = {
  __typename?: 'MarkAsAdminResponse';
  checkedUserId: Scalars['String']['output'];
};

export type MarkAsDoneResponse = {
  __typename?: 'MarkAsDoneResponse';
  questId: Scalars['Int']['output'];
};

export type MarkAsMemberInput = {
  artistId: Scalars['String']['input'];
  mapping: Array<StatusUser>;
  member: Scalars['String']['input'];
};

export type MarkAsMemberResponse = {
  __typename?: 'MarkAsMemberResponse';
  checkedUserId: Array<Scalars['String']['output']>;
};

export type MarkAsReadInput = {
  messageId: Scalars['String']['input'];
  roomId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type MarkAsReadResponse = {
  __typename?: 'MarkAsReadResponse';
  isSuccess: Scalars['Boolean']['output'];
};

export type MarkFavoriteResponse = {
  __typename?: 'MarkFavoriteResponse';
  id: Scalars['String']['output'];
};

export type MessageRoomData = {
  __typename?: 'MessageRoomData';
  category?: Maybe<Scalars['String']['output']>;
  id: Scalars['String']['output'];
  isRead: Scalars['Boolean']['output'];
  latestMessage?: Maybe<Scalars['String']['output']>;
  latestMessageId?: Maybe<Scalars['String']['output']>;
  latestSentAt?: Maybe<Scalars['String']['output']>;
  users: Array<UserSimpleData>;
};

export type MessageRoomsByUserData = {
  __typename?: 'MessageRoomsByUserData';
  countOfMessageRooms: Scalars['Int']['output'];
  messageRoomList: Array<MessageRoomData>;
};

export type MessageTempData = {
  __typename?: 'MessageTempData';
  attachedFile?: Maybe<Scalars['String']['output']>;
  attachedImg?: Maybe<Scalars['String']['output']>;
  content: Scalars['String']['output'];
  id: Scalars['String']['output'];
  sentAt: Scalars['String']['output'];
  sentBy: Scalars['String']['output'];
};

export type MessagesByRoomIdByUserData = {
  __typename?: 'MessagesByRoomIdByUserData';
  id: Scalars['String']['output'];
  messageList: Array<MessageTempData>;
  to: UserSimpleData;
};

export type MutationRoot = {
  __typename?: 'MutationRoot';
  addShortnote: AddShortnoteResponse;
  blockUser: BlockUserResponse;
  cancelRequestToAccessArtist: CancelRequestToAccessArtistResponse;
  contactToAdmin: Scalars['Boolean']['output'];
  createBulkFspTx: CreateNewTransactionResponse;
  createFspTx: CreateNewTransactionResponse;
  createFspTxBetweenUserids: CreateNewTransactionResponse;
  createNewArtist: CreateNewArtistsResponse;
  createNewMessageRoom: CreateNewMessageRoomResponse;
  createNewOffer: CreateNewOfferResponse;
  createNewUserData: CreateNewUserDataResponse;
  createPrize: CreateNewPrizeResponse;
  createQuest: CreateQuestResponse;
  deleteBlock: Scalars['Boolean']['output'];
  deleteCredit: DeleteCreditResponse;
  deleteOffer: DeleteOfferResponse;
  deleteOfferReport: Scalars['Boolean']['output'];
  deletePortfolio: DeletePortfolioResponse;
  deleteProduct: Scalars['Boolean']['output'];
  deleteReleaseReport: Scalars['Boolean']['output'];
  deleteShortnote: DeleteShortnoteResponse;
  deleteTrack: Scalars['Boolean']['output'];
  deleteUserReport: Scalars['Boolean']['output'];
  editShortnote: EditShortnoteResponse;
  exchangePrize: ExchangePrizeResponse;
  invite: Scalars['Boolean']['output'];
  joinWithInvitationCode: Scalars['Boolean']['output'];
  leaveBelongedArtist: LeaveBelongedArtistResponse;
  markAsAdmin: MarkAsAdminResponse;
  markAsMember: MarkAsMemberResponse;
  markAsRead: MarkAsReadResponse;
  markAsSolved: Scalars['Int']['output'];
  markFavorite: MarkFavoriteResponse;
  markNotificationAsRead: Scalars['Int']['output'];
  questMarkAsDone: MarkAsDoneResponse;
  registerCredit: RegisterCreditResponse;
  registerPortfolio: RegisterPortfolioResponse;
  registerReleases: RegisterReleasesResponse;
  reportOffer: ReportOfferResponse;
  reportUser: ReportUserResponse;
  requestPrize: RequestPrizeResponse;
  requestToAccessArtist: RequestToAccessArtistResponse;
  resendRequestToAccessArtist: ResendRequestToAccessArtistResponse;
  sendMessage: SendMessageResponse;
  setDefaultBelongedArtist: SetDefaultBelongedArtistResponse;
  unmarkFavorite: MarkFavoriteResponse;
  updateArtist: UpdateArtistResponse;
  updateBelongsToArtistStatus: UpdateBelongsToArtistStatusResponse;
  updateCredit: UpdateCreditResponse;
  updateOfferInfo: UpdateOfferResponse;
  updateOfferStatus: UpdateOfferStatusResponse;
  updatePortfolio: UpdatePortfolioResponse;
  updateProduct: Scalars['String']['output'];
  updateTrack: Scalars['String']['output'];
  updateUserData: UpdateUserDataResponse;
  usePrize: UsePrizeResponse;
};


export type MutationRootAddShortnoteArgs = {
  comment: Scalars['String']['input'];
  toUser: Scalars['String']['input'];
  writer: Scalars['String']['input'];
};


export type MutationRootBlockUserArgs = {
  input: BlockUserInput;
};


export type MutationRootCancelRequestToAccessArtistArgs = {
  input: CancelRequestToAccessArtistInput;
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
  input: Array<CreateNewArtistInput>;
};


export type MutationRootCreateNewMessageRoomArgs = {
  input: CreateNewMessageRoomInput;
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


export type MutationRootDeleteBlockArgs = {
  id: Scalars['Int']['input'];
};


export type MutationRootDeleteCreditArgs = {
  input: DeleteCreditInput;
};


export type MutationRootDeleteOfferArgs = {
  input: DeleteOfferInput;
};


export type MutationRootDeleteOfferReportArgs = {
  id: Scalars['Int']['input'];
};


export type MutationRootDeletePortfolioArgs = {
  input: DeletePortfolioInput;
};


export type MutationRootDeleteProductArgs = {
  upc: Scalars['String']['input'];
};


export type MutationRootDeleteReleaseReportArgs = {
  id: Scalars['Int']['input'];
};


export type MutationRootDeleteShortnoteArgs = {
  shortnoteId: Scalars['String']['input'];
};


export type MutationRootDeleteTrackArgs = {
  isrc: Scalars['String']['input'];
};


export type MutationRootDeleteUserReportArgs = {
  id: Scalars['Int']['input'];
};


export type MutationRootEditShortnoteArgs = {
  comment: Scalars['String']['input'];
  shortnoteId: Scalars['String']['input'];
};


export type MutationRootExchangePrizeArgs = {
  input: ExchangePrizeInput;
};


export type MutationRootInviteArgs = {
  pass: Scalars['String']['input'];
};


export type MutationRootJoinWithInvitationCodeArgs = {
  code: Scalars['String']['input'];
  joinedEmail: Scalars['String']['input'];
  joinedUserId: Scalars['String']['input'];
};


export type MutationRootLeaveBelongedArtistArgs = {
  input: LeaveBelongedArtistInput;
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


export type MutationRootMarkAsSolvedArgs = {
  id: Scalars['Int']['input'];
};


export type MutationRootMarkFavoriteArgs = {
  likedBy: Scalars['String']['input'];
  targetUserId: Scalars['String']['input'];
};


export type MutationRootMarkNotificationAsReadArgs = {
  notificationId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type MutationRootQuestMarkAsDoneArgs = {
  questId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type MutationRootRegisterCreditArgs = {
  input: RegisterCreditInput;
};


export type MutationRootRegisterPortfolioArgs = {
  input: RegisterPortfolioInput;
};


export type MutationRootRegisterReleasesArgs = {
  input: RegisterReleases;
};


export type MutationRootReportOfferArgs = {
  input: ReportOfferInput;
};


export type MutationRootReportUserArgs = {
  input: ReportUserInput;
};


export type MutationRootRequestPrizeArgs = {
  input: RequestPrizeInput;
};


export type MutationRootRequestToAccessArtistArgs = {
  input: RequestToAccessArtistInput;
};


export type MutationRootResendRequestToAccessArtistArgs = {
  input: ResendRequestToAccessArtistInput;
};


export type MutationRootSendMessageArgs = {
  input: SendMessageInput;
};


export type MutationRootSetDefaultBelongedArtistArgs = {
  input: SetDefaultBelongedArtistInput;
};


export type MutationRootUnmarkFavoriteArgs = {
  favoriteId: Scalars['String']['input'];
};


export type MutationRootUpdateArtistArgs = {
  input: UpdateArtistInput;
};


export type MutationRootUpdateBelongsToArtistStatusArgs = {
  input: UpdateBelongsToArtistStatusInput;
};


export type MutationRootUpdateCreditArgs = {
  input: UpdateCreditInput;
};


export type MutationRootUpdateOfferInfoArgs = {
  input: UpdateOfferInput;
};


export type MutationRootUpdateOfferStatusArgs = {
  input: UpdateOfferStatusInput;
};


export type MutationRootUpdatePortfolioArgs = {
  input: UpdatePortfolioInput;
};


export type MutationRootUpdateProductArgs = {
  input: UpdateProductInput;
};


export type MutationRootUpdateTrackArgs = {
  input: UpdateTrackInput;
};


export type MutationRootUpdateUserDataArgs = {
  input: UpdateUserDataInput;
};


export type MutationRootUsePrizeArgs = {
  input: UsePrizeInput;
};

export enum NotificationChannel {
  Email = 'EMAIL',
  Home = 'HOME',
  MobilePush = 'MOBILE_PUSH'
}

export type NotificationData = {
  __typename?: 'NotificationData';
  category?: Maybe<Scalars['String']['output']>;
  content: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  id: Scalars['String']['output'];
  isRead: Scalars['Boolean']['output'];
  title: Scalars['String']['output'];
};

export type NotificationListData = {
  __typename?: 'NotificationListData';
  hasNextPage: Scalars['Boolean']['output'];
  notifications: Array<NotificationListItem>;
  unreadCount: Scalars['Int']['output'];
};

export type NotificationListItem = {
  __typename?: 'NotificationListItem';
  content: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  isRead: Scalars['Boolean']['output'];
  title: Scalars['String']['output'];
};

export type NotificationsData = {
  __typename?: 'NotificationsData';
  notifications: Array<NotificationData>;
};

export type OfferByStatusData = {
  __typename?: 'OfferByStatusData';
  appliedOffers: Array<OfferData>;
  inprogressOffers: Array<OfferData>;
};

export type OfferData = {
  __typename?: 'OfferData';
  category?: Maybe<Scalars['String']['output']>;
  description: Scalars['String']['output'];
  fee: Scalars['Int']['output'];
  id: Scalars['Int']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  place: Scalars['String']['output'];
  publicity: Scalars['Boolean']['output'];
  title: Scalars['String']['output'];
};

export type OfferDetailData = {
  __typename?: 'OfferDetailData';
  attachedFiles?: Maybe<Array<Scalars['String']['output']>>;
  attachedImgs?: Maybe<Array<Scalars['String']['output']>>;
  attention?: Maybe<Scalars['String']['output']>;
  category?: Maybe<Scalars['String']['output']>;
  createdAt: Scalars['String']['output'];
  description: Scalars['String']['output'];
  fee: Scalars['Int']['output'];
  id: Scalars['Int']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  owner: UserSimpleData;
  place: Scalars['String']['output'];
  publicity?: Maybe<Scalars['Boolean']['output']>;
  raidId?: Maybe<Scalars['Int']['output']>;
  requiredSkill?: Maybe<Scalars['String']['output']>;
  status?: Maybe<Scalars['String']['output']>;
  targetRole?: Maybe<Scalars['String']['output']>;
  title: Scalars['String']['output'];
  updatedAt: Scalars['String']['output'];
};

export type OfferReport = {
  __typename?: 'OfferReport';
  createdAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  offerId: Scalars['Int']['output'];
  reportContent: Scalars['String']['output'];
  reporterUserId: Scalars['String']['output'];
};

export type OfferStatsByUserData = {
  __typename?: 'OfferStatsByUserData';
  appliedOffers: Scalars['Int']['output'];
  completedOffers: Scalars['Int']['output'];
  ongoingOffers: Scalars['Int']['output'];
  totalEarnings: Scalars['Int']['output'];
  totalOffers: Scalars['Int']['output'];
};

export type OffersData = {
  __typename?: 'OffersData';
  offerList: Array<OfferData>;
};

export type OverviewData = {
  __typename?: 'OverviewData';
  mobileAppUsersCount: Scalars['Int']['output'];
  totalArtists: Scalars['Int']['output'];
  totalFsp: Scalars['Int']['output'];
  totalPlayCount: Scalars['Int']['output'];
  totalRevenue: Scalars['Int']['output'];
  totalUsers: Scalars['Int']['output'];
};

export type PendingMember = {
  __typename?: 'PendingMember';
  email: Scalars['String']['output'];
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  realname: Scalars['String']['output'];
};

export type PlayCountByDspDetails = {
  __typename?: 'PlayCountByDSPDetails';
  amazon: Scalars['Int']['output'];
  apple: Scalars['Int']['output'];
  line: Scalars['Int']['output'];
  spotify: Scalars['Int']['output'];
  youtube: Scalars['Int']['output'];
};

export type Portfolio = {
  __typename?: 'Portfolio';
  category: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  description: Scalars['String']['output'];
  externalUrl?: Maybe<Scalars['String']['output']>;
  id: Scalars['Int']['output'];
  imgUrl?: Maybe<Scalars['String']['output']>;
  releaseDate?: Maybe<Scalars['String']['output']>;
  title: Scalars['String']['output'];
  updatedAt: Scalars['String']['output'];
  userId: Scalars['String']['output'];
};

export type PortfolioData = {
  __typename?: 'PortfolioData';
  createdAt: Scalars['String']['output'];
  description: Scalars['String']['output'];
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  refLink: Array<Scalars['String']['output']>;
  title: Scalars['String']['output'];
};

export type PrizeData = {
  __typename?: 'PrizeData';
  id: Scalars['Int']['output'];
  imgUrl?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  point: Scalars['Int']['output'];
};

export type PrizeDetailData = {
  __typename?: 'PrizeDetailData';
  condition?: Maybe<Scalars['String']['output']>;
  description: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  imgUrl?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  point: Scalars['Int']['output'];
  representation: Scalars['String']['output'];
};

export type PrizesByUserIdData = {
  __typename?: 'PrizesByUserIdData';
  requestedPrizeList: Array<PrizeDetailData>;
  unusedPrizeList: Array<PrizeDetailData>;
  usedPrizeList: Array<PrizeDetailData>;
};

export type PrizesHistoryByUserIdData = {
  __typename?: 'PrizesHistoryByUserIdData';
  requestedHistory: Array<ExchangeHistoryData>;
  unusedHistory: Array<ExchangeHistoryData>;
  usedHistory: Array<ExchangeHistoryData>;
};

export type Product = {
  __typename?: 'Product';
  artistId?: Maybe<Scalars['String']['output']>;
  imgUrl?: Maybe<Scalars['String']['output']>;
  title: Scalars['String']['output'];
  type?: Maybe<Scalars['String']['output']>;
  upc: Scalars['String']['output'];
};

export type ProductData = {
  __typename?: 'ProductData';
  artistId: Scalars['String']['output'];
  artistNameJa: Scalars['String']['output'];
  distributedAt?: Maybe<Scalars['String']['output']>;
  imgUrl?: Maybe<Scalars['String']['output']>;
  numberOfTracks: Scalars['Int']['output'];
  productType?: Maybe<Scalars['String']['output']>;
  title: Scalars['String']['output'];
  upc: Scalars['String']['output'];
};

export type ProductWithTracks = {
  __typename?: 'ProductWithTracks';
  product: Product;
  tracks: Array<Track>;
};

export type ProductsData = {
  __typename?: 'ProductsData';
  album: Array<ProductWithTracks>;
  ep: Array<ProductWithTracks>;
  single: Array<ProductWithTracks>;
};

export type QueryRoot = {
  __typename?: 'QueryRoot';
  askLlm: Scalars['String']['output'];
  getAdminNotificationDetail: AdminNotificationDetail;
  getAdminNotificationList: AdminNotificationListData;
  getAllArtists: ArtistsData;
  getAllBlockData: Array<BlockUserDataResponse>;
  getAllCredits: GetAllCreditsOutput;
  getAllNotifications: NotificationsData;
  getAllOfferReports: Array<OfferReport>;
  getAllPendingMembers: Array<AllPendingMember>;
  getAllPortfolios: Array<Portfolio>;
  getAllPrizes: Array<PrizeData>;
  getAllReleaseReports: Array<ReleaseReport>;
  getAllTrackPlaybackHistoryForAdmin: ChartDataForAdmin;
  getAllUserReports: Array<UserReport>;
  getAllUsers: AllUsersData;
  getAllUsersExceptMe: AllUsersData;
  getAllUsersForAdmin: Array<User>;
  getArtistById: ArtistFullData;
  getArtistsByIds: ArtistsData;
  getArtistsByName: ArtistsData;
  getBelongedArtists: ArtistByUserDataList;
  getBlockData: BlockUserDataResponse;
  getCredits: Array<TrackCredit>;
  getFspHistory: TransactionsData;
  getFspHistoryByUser: TransactionsByUserData;
  getFspHistoryForAdmin: Array<FspHistory>;
  getGenderGenRateByArtist: GenderGenRateData;
  getGenderGenRateByIsrc: GenderGenRateData;
  getGenderGenRateByUpc: GenderGenRateData;
  getMembersBelongedToArtist: Array<UserSimpleData>;
  getMembersJoinedToArtist: Array<UserSimpleData>;
  getMessageRooms: MessageRoomsByUserData;
  getMessagesByMessageRoomId: MessagesByRoomIdByUserData;
  getMessagesInProgress: MessageRoomsByUserData;
  getNotificationList: NotificationListData;
  getNotifications: Array<NotificationData>;
  getOfferStatsByUser: OfferStatsByUserData;
  getOffers: OffersData;
  getOffersById: OfferDetailData;
  getOffersByOwner: OffersData;
  getOffersByStatus: OfferByStatusData;
  getOtherUserCommunity: ConnectedUsersData;
  getOverview: TotalOverviewData;
  getOverviewByUpc: TotalOverviewData;
  getOwnCommunity: ConnectedUsersData;
  getPlayCountHistory: ChartData;
  getPlaycountHistoryByIsrc: ChartData;
  getPlaycountHistoryByUpc: ChartDataByUpc;
  getPopularPrizes: Array<PrizeData>;
  getPortfoliosByUserId: Array<Portfolio>;
  getPrizeByUserId: PrizesByUserIdData;
  getPrizeDetail: PrizeDetailData;
  getPrizeHistoryByUserId: PrizesHistoryByUserIdData;
  getProducts: ProductsData;
  getQuestByUserId: Array<QuestData>;
  getQuests: Array<QuestData>;
  getSystemOverview: OverviewData;
  getTrackCreditsHistoryForAdmin: Array<Credit>;
  getTrackInfo: TrackInfoData;
  getTrending: TrendingData;
  getTrendingByUpc: TrendingByUpcData;
  getUserData: UserDetailData;
  getUserDetailProfile: UserDetailData;
  getUserPointBalance: UserPointBalanceData;
  getUserProfile: UserDataOnDetailPage;
  getUsersInOffer: UsersInOfferData;
  healthCheck: HealthCheck;
  loginReward: LoginRewardResponse;
  searchOffers: OffersData;
  searchProducts: Array<ProductData>;
  searchTracks: Array<TrackData>;
  searchUsers: Array<UserSimpleData>;
};


export type QueryRootAskLlmArgs = {
  question: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetAdminNotificationDetailArgs = {
  notificationId: Scalars['Int']['input'];
};


export type QueryRootGetAdminNotificationListArgs = {
  limit?: Scalars['Int']['input'];
  offset?: Scalars['Int']['input'];
};


export type QueryRootGetAllCreditsArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetAllPendingMembersArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetAllTrackPlaybackHistoryForAdminArgs = {
  period: Scalars['Int']['input'];
};


export type QueryRootGetAllUsersExceptMeArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetArtistByIdArgs = {
  artistId: Scalars['String']['input'];
};


export type QueryRootGetArtistsByIdsArgs = {
  artistIds: Array<Scalars['String']['input']>;
};


export type QueryRootGetArtistsByNameArgs = {
  name: Scalars['String']['input'];
};


export type QueryRootGetBelongedArtistsArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetBlockDataArgs = {
  id: Scalars['Int']['input'];
};


export type QueryRootGetCreditsArgs = {
  artistId: Scalars['String']['input'];
  isrc: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetFspHistoryArgs = {
  count: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetFspHistoryByUserArgs = {
  count: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetFspHistoryForAdminArgs = {
  count: Scalars['Int']['input'];
};


export type QueryRootGetGenderGenRateByArtistArgs = {
  artistId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetGenderGenRateByIsrcArgs = {
  artistId: Scalars['String']['input'];
  isrc: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetGenderGenRateByUpcArgs = {
  artistId: Scalars['String']['input'];
  upc: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetMembersBelongedToArtistArgs = {
  artistId: Scalars['String']['input'];
  userId?: InputMaybe<Scalars['String']['input']>;
};


export type QueryRootGetMembersJoinedToArtistArgs = {
  artistId: Scalars['String']['input'];
  userId?: InputMaybe<Scalars['String']['input']>;
};


export type QueryRootGetMessageRoomsArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetMessagesByMessageRoomIdArgs = {
  messageRoomId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetMessagesInProgressArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetNotificationListArgs = {
  limit?: Scalars['Int']['input'];
  offset?: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetNotificationsArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetOfferStatsByUserArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetOffersByIdArgs = {
  offerId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetOffersByOwnerArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetOffersByStatusArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetOtherUserCommunityArgs = {
  targetUserId: Scalars['String']['input'];
  viewerId: Scalars['String']['input'];
};


export type QueryRootGetOverviewArgs = {
  artistId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetOverviewByUpcArgs = {
  artistId: Scalars['String']['input'];
  upc: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetOwnCommunityArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetPlayCountHistoryArgs = {
  artistId: Scalars['String']['input'];
  period: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetPlaycountHistoryByIsrcArgs = {
  isrc: Scalars['String']['input'];
  period: Scalars['Int']['input'];
};


export type QueryRootGetPlaycountHistoryByUpcArgs = {
  period: Scalars['Int']['input'];
  upc: Scalars['String']['input'];
};


export type QueryRootGetPortfoliosByUserIdArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetPrizeByUserIdArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetPrizeDetailArgs = {
  prizeId: Scalars['Int']['input'];
};


export type QueryRootGetPrizeHistoryByUserIdArgs = {
  prizeId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetProductsArgs = {
  artistId: Scalars['String']['input'];
};


export type QueryRootGetQuestByUserIdArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetTrackCreditsHistoryForAdminArgs = {
  count: Scalars['Int']['input'];
};


export type QueryRootGetTrackInfoArgs = {
  isrc: Scalars['String']['input'];
};


export type QueryRootGetTrendingArgs = {
  artistId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetTrendingByUpcArgs = {
  upc: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootGetUserDataArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetUserDetailProfileArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetUserPointBalanceArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootGetUserProfileArgs = {
  userId: Scalars['String']['input'];
  viewerId: Scalars['String']['input'];
};


export type QueryRootGetUsersInOfferArgs = {
  offerId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};


export type QueryRootLoginRewardArgs = {
  userId: Scalars['String']['input'];
};


export type QueryRootSearchOffersArgs = {
  options: SearchOptionsOffersInput;
  query: Scalars['String']['input'];
};


export type QueryRootSearchProductsArgs = {
  input: SearchProductsQuery;
};


export type QueryRootSearchTracksArgs = {
  input: SearchTracksQuery;
};


export type QueryRootSearchUsersArgs = {
  username: Scalars['String']['input'];
};

export type QuestData = {
  __typename?: 'QuestData';
  category: Scalars['String']['output'];
  description: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  name: Scalars['String']['output'];
};

export type RegisterCreditInput = {
  registerInfo: Array<RegisterInfo>;
};

export type RegisterCreditResponse = {
  __typename?: 'RegisterCreditResponse';
  isSuccess: Scalars['Boolean']['output'];
};

export type RegisterInfo = {
  commitUser: Scalars['String']['input'];
  creditName: Scalars['String']['input'];
  creditRole: Scalars['String']['input'];
  email: Scalars['String']['input'];
  isInvite: Scalars['Boolean']['input'];
  isrc: Scalars['String']['input'];
  memo?: InputMaybe<Scalars['String']['input']>;
};

export type RegisterPortfolioInput = {
  category: Scalars['String']['input'];
  description: Scalars['String']['input'];
  externalUrl: Scalars['String']['input'];
  imgUrl: Scalars['String']['input'];
  releaseDate: Scalars['String']['input'];
  title: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type RegisterPortfolioResponse = {
  __typename?: 'RegisterPortfolioResponse';
  portfolioId: Scalars['Int']['output'];
};

export type RegisterReleases = {
  releases: Array<ReleaseData>;
};

export type RegisterReleasesResponse = {
  __typename?: 'RegisterReleasesResponse';
  success: Scalars['Boolean']['output'];
};

export type ReleaseData = {
  artistId: Scalars['String']['input'];
  format: Scalars['String']['input'];
  imageUrl?: InputMaybe<Scalars['String']['input']>;
  isrc: Scalars['String']['input'];
  releaseDate: Scalars['String']['input'];
  title: Scalars['String']['input'];
  trackCount: Scalars['Int']['input'];
  trackNo: Scalars['Int']['input'];
  trackTitle: Scalars['String']['input'];
  trackTitleVersion: Scalars['String']['input'];
  upc: Scalars['String']['input'];
};

export type ReleaseReport = {
  __typename?: 'ReleaseReport';
  createdAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  release: Scalars['String']['output'];
  reportContent: Scalars['String']['output'];
  reporterUserId: Scalars['String']['output'];
};

export type ReportOfferInput = {
  offerId: Scalars['Int']['input'];
  reportContent: Scalars['String']['input'];
  reporterUserId: Scalars['String']['input'];
};

export type ReportOfferResponse = {
  __typename?: 'ReportOfferResponse';
  id: Scalars['Int']['output'];
};

export type ReportUserInput = {
  reportContent: Scalars['String']['input'];
  reportedUserId: Scalars['String']['input'];
  reporterUserId: Scalars['String']['input'];
};

export type ReportUserResponse = {
  __typename?: 'ReportUserResponse';
  id: Scalars['Int']['output'];
};

export type RequestPrizeInput = {
  prizeId: Scalars['Int']['input'];
  userId: Scalars['String']['input'];
};

export type RequestPrizeResponse = {
  __typename?: 'RequestPrizeResponse';
  id: Scalars['Int']['output'];
};

export type RequestToAccessArtistInput = {
  artistIds?: InputMaybe<Array<Scalars['String']['input']>>;
  requests?: InputMaybe<Array<RequestToAccessArtistItemInput>>;
  userId: Scalars['String']['input'];
};

export type RequestToAccessArtistItemInput = {
  artistId: Scalars['String']['input'];
  message?: InputMaybe<Scalars['String']['input']>;
};

export type RequestToAccessArtistResponse = {
  __typename?: 'RequestToAccessArtistResponse';
  createdMappings: Array<ArtistByUserDataWithMappingId>;
};

export type ResendRequestToAccessArtistInput = {
  artistId: Scalars['String']['input'];
  message?: InputMaybe<Scalars['String']['input']>;
  userId: Scalars['String']['input'];
};

export type ResendRequestToAccessArtistResponse = {
  __typename?: 'ResendRequestToAccessArtistResponse';
  updatedMapping: ArtistByUserDataWithMappingId;
};

export type SearchOptionsOffersInput = {
  category?: InputMaybe<Scalars['String']['input']>;
  maxPrice?: InputMaybe<Scalars['Int']['input']>;
  minPrice?: InputMaybe<Scalars['Int']['input']>;
  owner?: InputMaybe<Scalars['String']['input']>;
  place?: InputMaybe<Scalars['String']['input']>;
  sortBy?: InputMaybe<Scalars['String']['input']>;
  targetRole?: InputMaybe<Scalars['String']['input']>;
};

export type SearchProductsQuery = {
  artistId?: InputMaybe<Scalars['String']['input']>;
  productTitle?: InputMaybe<Scalars['String']['input']>;
  productType?: InputMaybe<Scalars['String']['input']>;
  upc?: InputMaybe<Scalars['String']['input']>;
};

export type SearchTracksQuery = {
  artistId?: InputMaybe<Scalars['String']['input']>;
  isrc?: InputMaybe<Scalars['String']['input']>;
  trackTitle?: InputMaybe<Scalars['String']['input']>;
};

export type SendMessageInput = {
  attachedFile?: InputMaybe<Array<Scalars['String']['input']>>;
  attachedImg?: InputMaybe<Array<Scalars['String']['input']>>;
  message: Scalars['String']['input'];
  roomId: Scalars['String']['input'];
  sentBy: Scalars['String']['input'];
};

export type SendMessageResponse = {
  __typename?: 'SendMessageResponse';
  attachedFile?: Maybe<Array<Scalars['String']['output']>>;
  attachedImg?: Maybe<Array<Scalars['String']['output']>>;
  id: Scalars['String']['output'];
  message: Scalars['String']['output'];
  sentAt: Scalars['String']['output'];
};

export type SetDefaultBelongedArtistInput = {
  artistId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type SetDefaultBelongedArtistResponse = {
  __typename?: 'SetDefaultBelongedArtistResponse';
  defaultArtist: ArtistByUserData;
};

export type StatusUser = {
  status: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type TotalOverviewData = {
  __typename?: 'TotalOverviewData';
  totalPlaybacks: Scalars['Int']['output'];
  weeklyPlaybacks: Scalars['Int']['output'];
};

export type Track = {
  __typename?: 'Track';
  imgUrl?: Maybe<Scalars['String']['output']>;
  isrc: Scalars['String']['output'];
  title?: Maybe<Scalars['String']['output']>;
};

export type TrackCredit = {
  __typename?: 'TrackCredit';
  commitUser: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  creditName: Scalars['String']['output'];
  creditRole: Scalars['String']['output'];
  email: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  isInvite?: Maybe<Scalars['Boolean']['output']>;
  isrc: Scalars['String']['output'];
  memo?: Maybe<Scalars['String']['output']>;
};

export type TrackCreditsByAdmin = {
  __typename?: 'TrackCreditsByAdmin';
  commitUser: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  creditName: Scalars['String']['output'];
  creditRole: Scalars['String']['output'];
  creditUser?: Maybe<Scalars['String']['output']>;
  email: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  isInvite?: Maybe<Scalars['Boolean']['output']>;
  isrc: Scalars['String']['output'];
  memo?: Maybe<Scalars['String']['output']>;
};

export type TrackData = {
  __typename?: 'TrackData';
  artistId: Scalars['String']['output'];
  artistName: Scalars['String']['output'];
  isrc: Scalars['String']['output'];
  productTitle: Scalars['String']['output'];
  trackTitle: Scalars['String']['output'];
};

export type TrackInfoData = {
  __typename?: 'TrackInfoData';
  product: Array<Product>;
  track: Track;
};

export type TransactionByUserData = {
  __typename?: 'TransactionByUserData';
  amount: Scalars['Int']['output'];
  counterParty: UserSimpleData;
  direction: TransactionDirection;
  id: Scalars['String']['output'];
  note?: Maybe<Scalars['String']['output']>;
  txAt: Scalars['String']['output'];
};

export type TransactionData = {
  __typename?: 'TransactionData';
  amount: Scalars['Int']['output'];
  from?: Maybe<UserSimpleData>;
  id: Scalars['String']['output'];
  to?: Maybe<UserSimpleData>;
  txAt: Scalars['String']['output'];
};

export enum TransactionDirection {
  In = 'IN',
  Out = 'OUT'
}

export type TransactionsByUserData = {
  __typename?: 'TransactionsByUserData';
  transactionList: Array<TransactionByUserData>;
};

export type TransactionsData = {
  __typename?: 'TransactionsData';
  transactionList: Array<TransactionData>;
};

export type TrendTrack = {
  __typename?: 'TrendTrack';
  imageUrl?: Maybe<Scalars['String']['output']>;
  isrc: Scalars['String']['output'];
  totalPlayCount: Scalars['Int']['output'];
  totalPlayCountDetails: PlayCountByDspDetails;
  trackTitle?: Maybe<Scalars['String']['output']>;
  upcTitle?: Maybe<Scalars['String']['output']>;
  weeklyPlayCount: Scalars['Int']['output'];
  weeklyPlayCountDetails: PlayCountByDspDetails;
};

export type TrendingByUpcData = {
  __typename?: 'TrendingByUPCData';
  artistName: Scalars['String']['output'];
  productImgUrl?: Maybe<Scalars['String']['output']>;
  productTitle: Scalars['String']['output'];
  trendingTracks: Array<TrendTrack>;
};

export type TrendingData = {
  __typename?: 'TrendingData';
  trendingTracks: Array<TrendTrack>;
};

export type UpdateArtistInput = {
  amazonKey?: InputMaybe<Scalars['String']['input']>;
  appleKey?: InputMaybe<Scalars['String']['input']>;
  artistId: Scalars['String']['input'];
  displayNameEn?: InputMaybe<Scalars['String']['input']>;
  displayNameJp?: InputMaybe<Scalars['String']['input']>;
  displayNameKana?: InputMaybe<Scalars['String']['input']>;
  fsp?: InputMaybe<Scalars['Int']['input']>;
  imgUrl?: InputMaybe<Scalars['String']['input']>;
  lineKey?: InputMaybe<Scalars['String']['input']>;
  since?: InputMaybe<Scalars['String']['input']>;
  spotifyKey?: InputMaybe<Scalars['String']['input']>;
  status?: InputMaybe<Scalars['String']['input']>;
  universalId?: InputMaybe<Scalars['String']['input']>;
  youtubeKey?: InputMaybe<Scalars['String']['input']>;
};

export type UpdateArtistResponse = {
  __typename?: 'UpdateArtistResponse';
  artistId: Scalars['String']['output'];
};

export type UpdateBelongsToArtistStatusInput = {
  artistId: Scalars['String']['input'];
  nextStatus?: InputMaybe<Scalars['String']['input']>;
  nextStatusIsAdmin?: InputMaybe<Scalars['Boolean']['input']>;
  userId: Scalars['String']['input'];
};

export type UpdateBelongsToArtistStatusResponse = {
  __typename?: 'UpdateBelongsToArtistStatusResponse';
  updatedUserArtist: ArtistByUserData;
};

export type UpdateCreditInput = {
  commitUser: Scalars['String']['input'];
  creditId: Scalars['Int']['input'];
  creditName?: InputMaybe<Scalars['String']['input']>;
  creditRole?: InputMaybe<Scalars['String']['input']>;
  email?: InputMaybe<Scalars['String']['input']>;
  isInvite?: InputMaybe<Scalars['Boolean']['input']>;
  memo?: InputMaybe<Scalars['String']['input']>;
};

export type UpdateCreditResponse = {
  __typename?: 'UpdateCreditResponse';
  isSuccess: Scalars['Boolean']['output'];
};

export type UpdateOfferInput = {
  attachedFiles?: InputMaybe<Array<Scalars['String']['input']>>;
  attachedImgs?: InputMaybe<Array<Scalars['String']['input']>>;
  attention?: InputMaybe<Scalars['String']['input']>;
  category?: InputMaybe<Scalars['String']['input']>;
  deadline?: InputMaybe<Scalars['String']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  fee?: InputMaybe<Scalars['Int']['input']>;
  id: Scalars['Int']['input'];
  imageUrl?: InputMaybe<Scalars['String']['input']>;
  place?: InputMaybe<Scalars['String']['input']>;
  publicity?: InputMaybe<Scalars['Boolean']['input']>;
  requiredSkill?: InputMaybe<Scalars['String']['input']>;
  targetRole?: InputMaybe<Scalars['String']['input']>;
  title?: InputMaybe<Scalars['String']['input']>;
};

export type UpdateOfferResponse = {
  __typename?: 'UpdateOfferResponse';
  id: Scalars['Int']['output'];
};

export type UpdateOfferStatusInput = {
  id: Scalars['Int']['input'];
  status: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type UpdateOfferStatusResponse = {
  __typename?: 'UpdateOfferStatusResponse';
  id: Scalars['Int']['output'];
  offerId: Scalars['Int']['output'];
};

export type UpdatePortfolioInput = {
  category?: InputMaybe<Scalars['String']['input']>;
  description?: InputMaybe<Scalars['String']['input']>;
  externalUrl?: InputMaybe<Scalars['String']['input']>;
  id: Scalars['Int']['input'];
  imgUrl?: InputMaybe<Scalars['String']['input']>;
  releaseDate?: InputMaybe<Scalars['String']['input']>;
  title?: InputMaybe<Scalars['String']['input']>;
};

export type UpdatePortfolioResponse = {
  __typename?: 'UpdatePortfolioResponse';
  portfolioId: Scalars['Int']['output'];
};

export type UpdateProductInput = {
  artistId?: InputMaybe<Scalars['String']['input']>;
  distributedAt?: InputMaybe<Scalars['String']['input']>;
  imgUrl?: InputMaybe<Scalars['String']['input']>;
  title?: InputMaybe<Scalars['String']['input']>;
  type?: InputMaybe<Scalars['String']['input']>;
  upc: Scalars['String']['input'];
};

export type UpdateTrackInput = {
  isrc: Scalars['String']['input'];
  title?: InputMaybe<Scalars['String']['input']>;
};

export type UpdateUserDataInput = {
  email?: InputMaybe<Scalars['String']['input']>;
  evmAddr?: InputMaybe<Scalars['String']['input']>;
  fbHandle?: InputMaybe<Scalars['String']['input']>;
  fcmToken?: InputMaybe<Scalars['String']['input']>;
  greeting?: InputMaybe<Scalars['String']['input']>;
  id: Scalars['String']['input'];
  imageUrl?: InputMaybe<Scalars['String']['input']>;
  instagramHandle?: InputMaybe<Scalars['String']['input']>;
  interestOffer?: InputMaybe<Scalars['String']['input']>;
  name?: InputMaybe<Scalars['String']['input']>;
  primaryCategory?: InputMaybe<Scalars['String']['input']>;
  skill?: InputMaybe<Scalars['String']['input']>;
  xHandle?: InputMaybe<Scalars['String']['input']>;
};

export type UpdateUserDataResponse = {
  __typename?: 'UpdateUserDataResponse';
  userInfo: UserDetailData;
};

export type UsePrizeInput = {
  code?: InputMaybe<Scalars['String']['input']>;
  prizeId: Scalars['Int']['input'];
  representationUserId: Scalars['String']['input'];
  userId: Scalars['String']['input'];
};

export type UsePrizeResponse = {
  __typename?: 'UsePrizeResponse';
  id: Scalars['Int']['output'];
};

export type User = {
  __typename?: 'User';
  createdAt: Scalars['String']['output'];
  email: Scalars['String']['output'];
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  primaryRole: Scalars['String']['output'];
  realname: Scalars['String']['output'];
  role: Scalars['String']['output'];
  username: Scalars['String']['output'];
};

export type UserConnectionData = {
  __typename?: 'UserConnectionData';
  category: Scalars['String']['output'];
  connections: Array<Scalars['String']['output']>;
  favoriteId?: Maybe<Scalars['String']['output']>;
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  lastLoggedIn?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  shortNote?: Maybe<Scalars['String']['output']>;
  shortNoteId?: Maybe<Scalars['String']['output']>;
  weight: Scalars['Int']['output'];
};

export type UserDataOnDetailPage = {
  __typename?: 'UserDataOnDetailPage';
  belongsToArtists: Array<Scalars['String']['output']>;
  category: Scalars['String']['output'];
  connections: Array<Scalars['String']['output']>;
  fbHandle?: Maybe<Scalars['String']['output']>;
  greeting?: Maybe<Scalars['String']['output']>;
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  instagramHandle?: Maybe<Scalars['String']['output']>;
  interestOffer?: Maybe<Scalars['String']['output']>;
  lastLoggedIn?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  offers: Array<OfferData>;
  portfolios: Array<PortfolioData>;
  shortNote?: Maybe<Scalars['String']['output']>;
  shortNoteId?: Maybe<Scalars['String']['output']>;
  skill?: Maybe<Scalars['String']['output']>;
  xHandle?: Maybe<Scalars['String']['output']>;
};

export type UserDetailData = {
  __typename?: 'UserDetailData';
  belongsToArtists: Array<ArtistByUserData>;
  createdAt: Scalars['String']['output'];
  credentialBalance: Scalars['Int']['output'];
  email: Scalars['String']['output'];
  evmAddr?: Maybe<Scalars['String']['output']>;
  fbHandle?: Maybe<Scalars['String']['output']>;
  fspBalance: Scalars['Int']['output'];
  greeting?: Maybe<Scalars['String']['output']>;
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  instagramHandle?: Maybe<Scalars['String']['output']>;
  interestOffer?: Maybe<Scalars['String']['output']>;
  isSuperAdmin: Scalars['Boolean']['output'];
  name: Scalars['String']['output'];
  primaryArtist?: Maybe<ArtistByUserData>;
  primaryRole: Scalars['String']['output'];
  realname: Scalars['String']['output'];
  role: Scalars['String']['output'];
  skill?: Maybe<Scalars['String']['output']>;
  xHandle?: Maybe<Scalars['String']['output']>;
};

export type UserInOfferData = {
  __typename?: 'UserInOfferData';
  category: Scalars['String']['output'];
  email: Scalars['String']['output'];
  imgUrl: Scalars['String']['output'];
  statusInOffer: Scalars['String']['output'];
  userId: Scalars['String']['output'];
  username: Scalars['String']['output'];
};

export type UserPointBalanceData = {
  __typename?: 'UserPointBalanceData';
  credentialBalance: Scalars['Int']['output'];
  fspBalance: Scalars['Int']['output'];
  fspBalanceTemp: Scalars['Int']['output'];
  isCredentialAvailable: Scalars['Boolean']['output'];
};

export type UserReport = {
  __typename?: 'UserReport';
  createdAt: Scalars['String']['output'];
  id: Scalars['Int']['output'];
  reportContent: Scalars['String']['output'];
  reportedUserId: Scalars['String']['output'];
  reporterUserId: Scalars['String']['output'];
};

export type UserSimpleData = {
  __typename?: 'UserSimpleData';
  id: Scalars['String']['output'];
  imageUrl?: Maybe<Scalars['String']['output']>;
  name: Scalars['String']['output'];
  realname: Scalars['String']['output'];
};

export type UsersInOfferData = {
  __typename?: 'UsersInOfferData';
  users: Array<UserInOfferData>;
};
