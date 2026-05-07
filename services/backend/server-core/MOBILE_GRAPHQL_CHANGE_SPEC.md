# モバイルアプリ向け GraphQL 改修仕様

作成日: 2026-04-22

この文書は、`server-core` の現行 GraphQL 実装を前提に、モバイルアプリ開発会社へ共有するための改修仕様を整理したものです。

「改修」は既存の GraphQL schema / resolver / usecase を軸に拡張します。「新設」は新しい GraphQL field / input / output / usecase を追加します。ここに記載する schema は外部公開仕様案であり、実装完了後は `presentation/src/graphql/schema.graphql` の生成結果と照合してください。API-39〜API-5 は現行実装に反映済みです。

## 現行実装の前提

- GraphQL schema は `presentation/src/graphql/schema.graphql` に生成されています。
- dashboard 系 Query は `presentation/src/graphql/queries/dashboard/mod.rs` から、`application/src/usecases/dashboard/*` を呼び出しています。
- 所属アーティスト系 Mutation / Query は `presentation/src/graphql/mutations/artist/mod.rs` と `presentation/src/graphql/queries/general/mod.rs` から、`user_artist` と `artists` を参照しています。
- `user_artist.status` の現行値は `Check`, `Accept`, `Reject`, `Canceled` に対応しています。DB enum 値は lowercase の `check`, `accept`, `reject`, `canceled`、GraphQL 表示は PascalCase の `Check`, `Accept`, `Reject`, `Canceled` です。
- `user_artist` には申請メッセージ用の `request_message`、デフォルト所属アーティスト用の `is_default`、申請日時用の `requested_at` が追加済みです。
- 通知は `notifications` と `notification_user` に分かれており、`notification_user` がユーザー別既読状態を持ちます。
- 再生数は主に `plays_daily`、性別・世代別再生数は `gender_gen_playback` を参照します。
- 国別再生数は GraphQL model の未使用型はありますが、現行 entity / repository として永続化されていません。

## 共通方針

### 日付と期間

既存 dashboard 集計は、日本時間基準で直近数日を除外するロジックを持っています。新規・改修後の期間定義も JST を基準にし、直近確定日を `today_jst - 3 days` として扱います。

各期間は直近確定日を集計終端にして、以下のように定義します。

- `all`: 集計可能な全期間。直近確定日までを対象とし、直近未確定日は除外します。
- `monthly`: 直近確定日を終端とする直近30日間。
- `weekly`: 直近確定日を終端とする直近7日間。
- `daily`: 直近確定日1日分。

### 認可

現行 resolver は `userId` を受け取るものの、dashboard 系の一部 usecase では `userId` が実質的に使われていません。外部公開仕様としては、`userId` が対象 `artistId` への閲覧権限を持つかを `user_artist` で確認する方針を推奨します。

### GraphQL エラー

GraphQL エラーは `extensions.code` を必ず設定し、モバイルアプリ側は `extensions.code` を見て表示文言を出し分けます。`message` は開発者向けの補足として扱い、ユーザー向け文言の主判定には使いません。

標準の `extensions.code` は以下の通りです。

- `FORBIDDEN`: 権限がない場合。例: `userId` が対象 `artistId` への閲覧・操作権限を持たない。
- `BAD_USER_INPUT`: 入力値が不正な場合。例: 申請メッセージの文字数超過、空文字、日付形式不正、`limit` / `offset` の不正値。
- `NOT_FOUND`: 対象が存在しない場合。例: `artistId`、`upc`、`isrc`、`user_artist` mapping が存在しない。
- `INVALID_STATE`: 状態遷移できない場合。例: 承認済み申請のキャンセル、再送不可 status の再送、承認済みでないアーティストのデフォルト設定。

機能固有のエラーコードが必要な場合は、上記の標準コードに加えて個別に定義します。

## 対象項目一覧

| No | 内容 | 種類 | 主な対応 |
| --- | --- | --- | --- |
| 1 | API-39: `requestToAccessArtist` | 改修 | 申請メッセージを追加 |
| 2 | API-44: `getBelongedArtists` | 改修 | 所属ステータスの追加・返却 |
| 3 | アーティスト申請の再送用 Mutation | 新設 | 既存申請の再送・メッセージ更新 |
| 4 | アーティスト申請のキャンセル用 Mutation | 新設 | 申請のキャンセル |
| 5 | 所属先アーティストのデフォルト設定 Mutation | 新設 | デフォルト所属アーティスト設定 |
| 6 | notifications のリスト取得 schema | 新設 | 管理者送付通知の一覧取得 |
| 7 | notifications の個別コンテンツ取得 schema | 対象外 | 詳細取得は行わない |
| 8 | d-2 Query `getOverview` | 改修 | all / monthly / weekly / daily 合計を返却 |
| 9 | Most Recent Release 用 Query | 新設 | リリース日が一番最近のリリース・楽曲を返却 |
| 10 | Trending 用 Query | 新設 | ISRC単位で前期比の増加率上位3件を返却 |
| 11 | d-4 Query `getTrending` | 改修 | all / monthly / weekly / daily 合計を返却 |
| 12 | d-5 Query `getPlayCountHistory` | 改修 | 任意期間で絞り込み |
| 13 | 国別再生数取得用 Query | 新設 | 国別再生数を返却 |
| 14 | d-8 Query `getGenderGenRateByArtist` | 改修 | 世代区切り調整・不要 field 削除 |

## 1. API-39: `requestToAccessArtist`

種類: 改修

### 改修前 schema

```graphql
input RequestToAccessArtistInput {
  userId: String!
  artistIds: [String!]!
}

type RequestToAccessArtistResponse {
  createdMappings: [ArtistByUserDataWithMappingId!]!
}

type MutationRoot {
  requestToAccessArtist(input: RequestToAccessArtistInput!): RequestToAccessArtistResponse!
}
```

### 実装済みの状態

- `RequestToAccessUsecase` は `artistIds` / `requests.artistId` の重複を先勝ちで除外します。
- `user_artist` に同じ `user_id` / `artist_id` の mapping が存在する場合はスキップします。
- 新規 mapping は `user_artist` に作成され、status は DB / SeaORM default の `Check` になります。
- 新規 mapping 作成時のみ、`request_message` に申請メッセージを保存し、`requested_at` に現在時刻を保存します。
- 既存 mapping がある場合は新規作成せず、既存 mapping の status / message / requested_at も更新しません。

### 改修内容

- 申請時にユーザーが入力したメッセージを受け取れるようにします。
- メッセージは任意入力です。ただし、指定する場合は1文字以上200文字以内とし、空文字は許可しません。
- 200文字は日本語の入力を前提にした文字数上限です。実装では Rust の `chars().count()` 等で Unicode scalar value 数として扱う方針を推奨します。
- 現行の複数件一括申請 schema との互換性は維持しつつ、申請ごとにメッセージを適用できる `requests` を追加します。
- モバイル画面上では1件ずつ申請するため、モバイルからは `requests` に1件だけ入れて送信します。
- バルク申請でも `requests` の各要素ごとに個別メッセージを持てるようにします。
- 申請メッセージを永続化するため、`user_artist` に `request_message` を追加します。
- `request_message` の DB column 長は、日本語200文字を保存できる型にします。
- 申請日時を永続化するため、`user_artist` に `requested_at` を追加します。
- `requestToAccessArtist` は新規申請専用とします。既存 mapping がある場合は新規作成せず、既存 mapping の status / message も更新しません。既存申請の更新は項目 3 の再送 Mutation を利用します。

### 利用可能にする schema

```graphql
input RequestToAccessArtistItemInput {
  artistId: String!
  message: String
}

input RequestToAccessArtistInput {
  userId: String!
  requests: [RequestToAccessArtistItemInput!]
  artistIds: [String!]
}

type ArtistByUserDataWithMappingId {
  mappingId: Int!
  id: String!
  artistId: String!
  name: String!
  imageUrl: String
  fsp: Int!
  status: String!
  isAdmin: Boolean!
  requestMessage: String
}

type RequestToAccessArtistResponse {
  createdMappings: [ArtistByUserDataWithMappingId!]!
}
```

#### `RequestToAccessArtistInput` の field 説明

- `userId`: 申請を行うユーザー ID です。
- `requests`: 新形式の申請入力です。申請対象ごとに `artistId` と任意の `message` を指定できます。モバイルアプリはこちらを利用します。
- `requests.artistId`: 申請対象のアーティスト ID です。
- `requests.message`: 申請対象アーティストに送る申請メッセージです。任意入力ですが、指定する場合は1文字以上200文字以内です。
- `artistIds`: 既存クライアント互換用の旧形式です。複数アーティスト ID を指定できますが、申請メッセージは指定できません。

`requests` と `artistIds` はどちらか一方のみ指定します。両方指定された場合、または両方未指定の場合は `BAD_USER_INPUT` を返します。モバイルアプリは `requests` を利用し、`artistIds` は既存クライアントを壊さないために残します。

既存互換の `artistIds` で申請された場合は、申請メッセージなしとして扱います。個別メッセージが必要なクライアントは `requests` を利用します。

### 不明点・確認事項

- なし。

## 2. API-44: `getBelongedArtists`

種類: 改修

### 改修前 schema

```graphql
type ArtistByUserData {
  id: String!
  artistId: String!
  name: String!
  imageUrl: String
  fsp: Int!
  status: String!
  isAdmin: Boolean!
}

type ArtistByUserDataList {
  artistList: [ArtistByUserData!]!
}

type QueryRoot {
  getBelongedArtists(userId: String!): ArtistByUserDataList!
}
```

### 実装済みの状態

- `getBelongedArtists(userId)` は `user_artist` を `user_id` で取得し、対応する `artists` 情報と結合して返します。
- status は `Check`, `Accept`, `Reject`, `Canceled` の文字列として返却されます。
- `requestMessage` と `isDefault` を返却します。
- 明示的な default artist が存在しない場合、`Accept` の所属アーティストのうち `artist_id` が最も小さいものを response 上の default として扱い、その artist の `isDefault` を `true` に補正します。

### 改修内容

- アーティスト申請の状態管理に必要な status を追加します。
- モバイル側は `status` によって、申請中、承認済み、却下、キャンセル済みなどの表示を切り替えられるようにします。
- status 値は既存互換を優先し、GraphQL enum 化せず `String` のまま返却します。
- status 値は `Check`, `Accept`, `Reject`, `Canceled` を利用します。
- `Reject` 後に再申請する場合は、既存の `user_artist` mapping を再利用し、status を `Check` に戻します。
- 申請日時、更新日時、却下理由は GraphQL output では返却しません。

### 利用可能にする schema

```graphql
type ArtistByUserData {
  id: String!
  artistId: String!
  name: String!
  imageUrl: String
  fsp: Int!
  status: String!
  isAdmin: Boolean!
  requestMessage: String
  isDefault: Boolean!
}
```

### 不明点・確認事項

- なし。

## 3. アーティスト申請の再送用 Mutation

種類: 新設

### 新設理由

現行 `requestToAccessArtist` は、既存 mapping がある場合にスキップします。そのため、却下済み・キャンセル済み・申請中のレコードに対して、再送としてメッセージを更新し、申請状態に戻す処理が必要です。

### 実装内容

- `userId` と `artistId` で既存 `user_artist` を取得します。
- 再送可能な status は `Reject`, `Canceled`, `Check` です。
- `Accept` など再送不可 status の場合は更新せず、`INVALID_STATE` を返します。
- 再送時は status を申請中の `Check` に戻します。
- 申請メッセージを更新します。
- 再送時は申請日時を現在時刻に更新します。申請日時は GraphQL output では返却しません。
- 再送時はアーティスト管理者へ通知を送ります。対象は同一 artist の `Accept && is_admin` mapping を持つユーザーで、重複 user は1件にまとめます。
- 既存 mapping がない場合は新規作成せず、`NOT_FOUND` を返します。新規申請は `requestToAccessArtist` を利用します。

### 利用可能にする schema

```graphql
input ResendRequestToAccessArtistInput {
  userId: String!
  artistId: String!
  message: String
}

type ResendRequestToAccessArtistResponse {
  updatedMapping: ArtistByUserDataWithMappingId!
}

type MutationRoot {
  resendRequestToAccessArtist(
    input: ResendRequestToAccessArtistInput!
  ): ResendRequestToAccessArtistResponse!
}
```

### 不明点・確認事項

- なし。

## 4. アーティスト申請のキャンセル用 Mutation

種類: 新設

### 新設理由

ユーザーが申請中のアーティスト所属申請を取り下げるための Mutation を追加します。

### 実装内容

- `userId` と `artistId` で `user_artist` を取得します。
- 申請中の mapping をキャンセル済み status `Canceled` に更新します。
- キャンセル可能な status は `Check` のみです。`Accept`, `Reject`, `Canceled` は更新せず、`INVALID_STATE` を返します。
- キャンセル時は `request_message`, `requested_at`, `is_default` を更新せず保持します。
- 履歴を残すため、物理削除より status 更新を推奨します。
- キャンセル後も `getBelongedArtists` には表示します。
- 承認済み `Accept` の所属解除はこの Mutation では扱いません。
- 承認済み所属の解除は、別 Mutation `leaveBelongedArtist` を新設して扱います。
- モバイルアプリから利用するのは `cancelRequestToAccessArtist` のみです。
- `leaveBelongedArtist` は superadmin およびアーティスト代表のみが利用できる Mutation とし、モバイルアプリからは利用しません。
- `leaveBelongedArtist` の `operatorUserId` は実行者、`userId` は解除対象ユーザーとして扱います。
- `leaveBelongedArtist` は `Accept` の所属アーティストを解除対象とし、解除後の status は `Reject` に更新します。
- `leaveBelongedArtist` の成功時は `is_admin` と `is_default` を false に更新し、`request_message` と `requested_at` は保持します。
- `leaveBelongedArtist` の実行権限がない場合は `FORBIDDEN` を返します。
- 解除対象が default artist の場合でも解除します。この場合、対象 mapping の `is_default` は解除されます。

### 利用可能にする schema

```graphql
input CancelRequestToAccessArtistInput {
  userId: String!
  artistId: String!
}

type CancelRequestToAccessArtistResponse {
  canceledMapping: ArtistByUserDataWithMappingId!
}

type MutationRoot {
  cancelRequestToAccessArtist(
    input: CancelRequestToAccessArtistInput!
  ): CancelRequestToAccessArtistResponse!
}
```

承認済み所属解除用の別 Mutation。superadmin およびアーティスト代表のみ利用可能:

```graphql
input LeaveBelongedArtistInput {
  operatorUserId: String!
  userId: String!
  artistId: String!
}

type LeaveBelongedArtistResponse {
  leftArtist: ArtistByUserData!
}

type MutationRoot {
  leaveBelongedArtist(input: LeaveBelongedArtistInput!): LeaveBelongedArtistResponse!
}
```

### 不明点・確認事項

- なし。

## 5. 所属先アーティストのデフォルト設定 Mutation

種類: 新設

### 実装済みの状態

- `UserDetailData.primaryArtist` は schema に存在します。
- `user_artist.is_default` に明示的な default artist を保存します。
- `getUserData` / `getUserDetailProfile` は `primaryArtist` を返します。
- `getBelongedArtists` の `isDefault` は、明示 default または fallback default を反映した effective default として返します。

### 実装内容

- ユーザーごとにデフォルト所属アーティストを1つ保存できます。
- 保存先は `user_artist` table の `is_default` column です。
- `is_default = true` は1ユーザーにつき1件だけ許可します。新しい default artist を設定する場合は、repository transaction 内で同一ユーザーの他 mapping の `is_default` を false に更新し、対象 mapping だけ true に更新します。
- デフォルト設定可能な対象は、`user_artist.status = Accept` の所属アーティストのみに限定します。
- 対象 mapping がない場合、または artist がない場合は `NOT_FOUND` を返します。対象 mapping が `Accept` でない場合は更新せず、`INVALID_STATE` を返します。
- デフォルト所属アーティストを未設定に戻す Mutation は追加しません。
- 明示的な default artist が存在しない場合は、DB には保存せず、response 上だけ `Accept` の所属アーティストのうち `artist_id` が最も小さいものをデフォルトとして扱います。
- 複数の明示的な default artist が存在する異常データでは、`Accept && is_default` の mapping のうち `artist_id` が最も小さいものを primary artist として扱います。
- デフォルト設定後、`getUserData` / `getUserDetailProfile` の `primaryArtist` と `getBelongedArtists` の `isDefault` に反映します。

### 利用可能にする schema

```graphql
input SetDefaultBelongedArtistInput {
  userId: String!
  artistId: String!
}

type SetDefaultBelongedArtistResponse {
  defaultArtist: ArtistByUserData!
}

type MutationRoot {
  setDefaultBelongedArtist(
    input: SetDefaultBelongedArtistInput!
  ): SetDefaultBelongedArtistResponse!
}
```

### 不明点・確認事項

- なし。

## 6. notifications のリスト取得 schema

種類: 新設

### 現行実装

- `getNotifications(userId: String!): [NotificationData!]!` は存在し、ユーザーの通知一覧を返します。
- `NotificationQuery` に `get_notifications(count, offset)` と `get_all_notifications` の stub がありますが、処理は `todo!()` です。
- 現行 `NotificationData` は `content` も一覧で返します。
- 現行 server-core には、管理者が任意に通知を作成し、送付対象を選択するための GraphQL Mutation は見当たりません。

### 管理者画面との関係

- 通知の作成・送付 UI は Web の管理者画面に設置します。
- 管理者画面は今回のモバイルアプリ改修範囲には含めません。
- モバイルアプリ側は、モバイルプッシュ channel で送付された通知を `getNotificationList` で取得・表示します。通知の詳細取得 Query は追加しません。
- server-core 側では、管理者画面から呼び出す通知作成 Mutation を追加する必要があります。
- 通知を送付できるのは管理者のみです。モバイルアプリから通知送付操作は行いません。

### 通知送付の共通仕様

- 通知 channel は `MOBILE_PUSH`, `EMAIL`, `HOME` の3種類です。
- 通知送付方式は、管理者画面からの手動送付と、server-core 側のバッチ送付の2種類です。
- 手動送付では、送付 channel と送付先を管理者が選択します。channel は `MOBILE_PUSH`, `EMAIL`, `HOME` の任意の組み合わせを1つ以上指定必須とします。
- 手動送付の channel に重複が含まれる場合は `BAD_USER_INPUT` を返します。
- 手動送付の送付先は `ALL` または `ARTIST_REPRESENTATIVES` のいずれかを指定必須とします。
- `audienceType = ALL` の場合、`artistIds` は指定しません。指定された場合は `BAD_USER_INPUT` を返します。
- `audienceType = ARTIST_REPRESENTATIVES` の場合、`artistIds` は1件以上指定必須とします。未指定または空配列の場合は `BAD_USER_INPUT` を返します。
- 複数アーティストの代表者に同一ユーザーが含まれる場合は、送付対象ユーザーを重複排除し、1ユーザーにつき1通知として扱います。
- 送付対象ユーザーは送付実行時に確定し、snapshot として保存します。送付後に所属や代表者が変更されても、過去通知の送付対象は変わりません。
- バッチ送付では、イベントごとに事前定義された channel の組み合わせで通知を送付します。例: 再生数が閾値を超えた場合など。
- バッチ送付の送付先と channel はバッチ定義に従い、モバイルアプリや管理者画面の手動入力では変更しません。
- 通知一覧に表示されるのは、手動 / バッチを問わず `MOBILE_PUSH` channel で送付された通知のみです。`EMAIL` / `HOME` のみで送付された通知は `getNotificationList` には表示しません。

### モバイル取得仕様

- モバイル向けの通知一覧取得 Query を追加します。
- 既存 `getNotifications(userId)` は互換性維持のため残します。
- 通知一覧の対象は、`MOBILE_PUSH` channel で送付された通知とします。
- 詳細取得は行わないため、一覧でタイトルと本文を返します。
- `category` は返却しません。
- pagination は `limit` / `offset` 方式にします。`limit` は `1` 以上 `100` 以下、default は `20` とし、範囲外は `BAD_USER_INPUT` を返します。`offset` は `0` 以上とし、負数は `BAD_USER_INPUT` を返します。
- `notification_user.is_deleted = false` のみを返却します。
- 削除済み通知は一覧に返しません。削除済みであることを個別エラーとして返す詳細取得 API は追加しません。
- `notifications.created_at` 降順で返却します。
- `hasNextPage` は、同条件の総件数が `offset + notifications.length` より大きい場合に `true` とします。
- 既読化は `getNotificationList` を実行して通知一覧を確認したタイミングで行います。レスポンスの `isRead` / `unreadCount` は既読化前の状態を返し、その後で取得対象ユーザーの未削除通知を既読に更新します。次回取得時やバッジ再計算時には New 表示が消える想定です。
- `getNotificationList` の `userId` が存在しない場合は `NOT_FOUND` を返します。
- 他人の通知一覧を取得しようとした場合は `FORBIDDEN` を返します。

#### 利用可能にする schema

```graphql
type NotificationListItem {
  id: Int!
  title: String!
  content: String!
  isRead: Boolean!
  createdAt: String!
}

type NotificationListData {
  notifications: [NotificationListItem!]!
  unreadCount: Int!
  hasNextPage: Boolean!
}

type QueryRoot {
  getNotificationList(
    userId: String!
    limit: Int = 20
    offset: Int = 0
  ): NotificationListData!
}
```

### 管理者送付仕様

- `createAdminNotification` は管理者画面からの手動送付用 Mutation とします。バッチ送付は事前定義された内部処理から実行します。
- 管理者画面からの送付時は、`notifications` に通知本文と送付 channel を保存します。
- `MOBILE_PUSH` channel を含む場合のみ、モバイル通知一覧表示用の `notification_user` を作成します。
- `title` は1文字以上50文字以内、`content` は1文字以上100文字以内とします。空文字、上限超過は `BAD_USER_INPUT` を返します。
- 管理者通知作成権限がない場合は `FORBIDDEN` を返します。
- 送付対象は以下を選択可能にします。
  - 全体通知: 全登録ユーザーへ送付します。
  - アーティスト代表者通知: 指定アーティストの代表者へ送付します。
- アーティスト代表者は、`user_artist.status = Accept` かつ `user_artist.is_admin = true` のユーザーとして扱います。
- `audienceType = ARTIST_REPRESENTATIVES` で指定された `artistIds` が存在しない場合は `NOT_FOUND` を返します。

#### 利用可能にする schema

```graphql
enum NotificationAudienceType {
  ALL
  ARTIST_REPRESENTATIVES
}

enum NotificationChannel {
  MOBILE_PUSH
  EMAIL
  HOME
}

input CreateAdminNotificationInput {
  title: String!
  content: String!
  channels: [NotificationChannel!]!
  audienceType: NotificationAudienceType!
  artistIds: [String!]
}

type CreateAdminNotificationResponse {
  notificationId: Int!
  deliveredUserCount: Int!
}

type MutationRoot {
  createAdminNotification(
    input: CreateAdminNotificationInput!
  ): CreateAdminNotificationResponse!
}
```

`deliveredUserCount` は、重複排除後の送付対象ユーザー数を返します。

### 不明点・確認事項

- 管理者通知作成 Mutation の認可判定に利用する既存の管理者権限フィールド / ロール名は、実装時に現行設計へ合わせます。権限がない場合のエラーコードは `FORBIDDEN` で固定します。

## 7. notifications の個別コンテンツ取得 schema

種類: 対象外

### 方針

- 通知の詳細取得 Query は追加しません。
- モバイルアプリは `getNotificationList` の返却内容のみで通知一覧を表示します。
- 既読化は `getNotificationList` 実行時に行います。既存 `markNotificationAsRead` は互換性維持のため残してもよいですが、モバイルアプリでは使用しません。
- 削除済み通知は `getNotificationList` に返さないため、`NotificationDeletedError` / `NOTIFICATION_DELETED` は新設しません。

### 不明点・確認事項

- なし。

## 8. d-2 Query `getOverview`

種類: 改修

### 現行 schema

```graphql
type TotalOverviewData {
  totalPlaybacks: Int!
  weeklyPlaybacks: Int!
}

type QueryRoot {
  getOverview(artistId: String!, userId: String!): TotalOverviewData!
  getOverviewByUpc(artistId: String!, userId: String!, upc: String!): TotalOverviewData!
}
```

### 現行実装

- `products.artist_id` から対象 UPC を取得します。
- `product_track` から ISRC を取得します。
- `plays_daily` を ISRC で取得し、Rust 側で集計します。
- 現行 output は全期間相当の `totalPlaybacks` と `weeklyPlaybacks` のみです。

### 改修内容

- all / monthly / weekly / daily の4区分で合計再生数を返します。
- `monthlyPlaybacks` は共通方針と同じく、直近確定日を終端とする直近30日間の再生数とします。
- `weeklyPlaybacks` は共通方針と同じく、直近確定日を終端とする直近7日間の再生数とします。
- `dailyPlaybacks` は直近確定日の再生数とします。
- `totalPlaybacks` は直近確定日までの全期間合計とします。
- `getOverviewByUpc` も同じ output を返すように揃えます。

### 利用可能にする schema

```graphql
type TotalOverviewData {
  totalPlaybacks: Int!
  monthlyPlaybacks: Int!
  weeklyPlaybacks: Int!
  dailyPlaybacks: Int!
}
```

### 不明点・確認事項

- なし。

## 9. Most Recent Release 用 Query

種類: 新設

### 新設内容

- 対象アーティストのリリースを、リリース日が新しい順で返す Query を追加します。
- 「最近」はリリース順で一番最近のものを指します。再生日時や再生数の新しさではなく、`products.distributed_at` / release date を基準にします。
- 返却 list の先頭が一番最近のリリースです。モバイル側で一番最近の1件のみが必要な場合は `limit = 1` を指定します。
- 対象単位は product、つまり UPC 単位です。
- 現行 `products.distributed_at` と `product_track` / `tracks` / `plays_daily` を利用して実装できます。

### 利用可能にする schema

```graphql
type RecentReleaseProduct {
  upc: String!
  productTitle: String!
  imageUrl: String
  releaseDate: String
  productType: String
  trackCount: Int!
  totalPlayCount: Int!
  monthlyPlayCount: Int!
  weeklyPlayCount: Int!
  dailyPlayCount: Int!
}

type MostRecentReleaseData {
  products: [RecentReleaseProduct!]!
}

type QueryRoot {
  getMostRecentRelease(
    artistId: String!
    userId: String!
    limit: Int = 10
  ): MostRecentReleaseData!
}
```

### 不明点・確認事項

- なし。

## 10. Trending 用 Query

種類: 新設

### 現行との差分

現行 `getTrending` は、全期間再生数上位の楽曲と weekly 再生数を返す Query です。今回の「変動が大きい楽曲」は、既存 `getTrending` へ転用せず、新規 `getTrendingChanges` として追加します。上位楽曲ではなく、ISRC、つまり楽曲単位で前期比の増加率が大きい楽曲をランキングとして返します。

### 新設内容

- 表示する作品は ISRC 単位、つまり楽曲単位です。
- 現期間と前期間を同じ日数で比較し、増加率が大きい上位3件を返します。
- 変動率は `((currentPlayCount - previousPlayCount) / previousPlayCount) * 100` で算出します。
- `changeRate` は増加率を表します。
- `tracks` は `changeRate` の降順で返します。
- `previousPlayCount = 0` の楽曲は変動率を算出不能としてランキング対象から除外します。
- 比較期間は `periodDays` で指定可能にし、未指定時は7日対7日の前期比とします。

### 利用可能にする schema

```graphql
type TrendingChangeTrack {
  isrc: String!
  trackTitle: String
  upc: String
  productTitle: String
  imageUrl: String
  currentPlayCount: Int!
  previousPlayCount: Int!
  diffPlayCount: Int!
  changeRate: Float!
}

type TrendingChangeData {
  tracks: [TrendingChangeTrack!]!
}

type QueryRoot {
  getTrendingChanges(
    artistId: String!
    userId: String!
    periodDays: Int = 7
  ): TrendingChangeData!
}
```

### 不明点・確認事項

- なし。

## 11. d-4 Query `getTrending`

種類: 改修

### 現行 schema

```graphql
type TrendTrack {
  isrc: String!
  trackTitle: String
  upcTitle: String
  imageUrl: String
  totalPlayCount: Int!
  weeklyPlayCount: Int!
  totalPlayCountDetails: PlayCountByDSPDetails!
  weeklyPlayCountDetails: PlayCountByDSPDetails!
}

type TrendingData {
  trendingTracks: [TrendTrack!]!
}

type QueryRoot {
  getTrending(artistId: String!, userId: String!): TrendingData!
  getTrendingByUpc(upc: String!, userId: String!): TrendingByUPCData!
}
```

### 現行実装

- `getTrending` はアーティスト配下の ISRC を対象に、全期間相当の再生数上位5件を抽出します。
- 各 track に total と weekly の再生数、DSP 別内訳を返します。

### 改修内容

- track ごとに all / monthly / weekly / daily の合計再生数を返します。
- `monthlyPlayCount` は直近30日間の再生数とします。
- `weeklyPlayCount` は直近7日間の再生数とします。
- `dailyPlayCount` は直近確定日の再生数とします。
- `getTrending` の順位付けは指定された時間軸に応じて切り替えます。`ALL` は `totalPlayCount`、`WEEK` は `weeklyPlayCount`、`MONTH` は `monthlyPlayCount` を基準にします。
- `getTrending` の返却件数は5件固定です。
- DSP 別内訳も同じ期間軸で返せるようにします。
- `getTrendingByUpc` も同じ `TrendTrack` を利用するため、同様に field が増えます。返却件数も5件固定です。

### 利用可能にする schema

```graphql
enum TrendingTimeAxis {
  ALL
  WEEK
  MONTH
}

type TrendTrack {
  isrc: String!
  trackTitle: String
  upcTitle: String
  imageUrl: String
  totalPlayCount: Int!
  monthlyPlayCount: Int!
  weeklyPlayCount: Int!
  dailyPlayCount: Int!
  totalPlayCountDetails: PlayCountByDSPDetails!
  monthlyPlayCountDetails: PlayCountByDSPDetails!
  weeklyPlayCountDetails: PlayCountByDSPDetails!
  dailyPlayCountDetails: PlayCountByDSPDetails!
}

type QueryRoot {
  getTrending(
    artistId: String!
    userId: String!
    timeAxis: TrendingTimeAxis = ALL
  ): TrendingData!
}
```

### 不明点・確認事項

- なし。

## 12. d-5 Query `getPlayCountHistory`

種類: 改修

### 現行 schema

```graphql
type QueryRoot {
  getPlayCountHistory(
    artistId: String!
    userId: String!
    period: Int!
  ): ChartData!
}
```

### 現行実装

- `period = 7` または `30` の場合は日次で返します。
- `period = 12` または `36` の場合は月次で返します。
- `period = -1` の場合は全期間を月次で返します。
- それ以外は `Invalid period` になります。改修後は共通エラー方針に合わせ、`BAD_USER_INPUT` を返します。

### 改修内容

- UI 側で `ALL` / `MONTHLY` / `WEEKLY` / `DAILY` の期間種別を指定できるようにします。
- `MONTHLY` はユーザーが指定した `startDate` から30日間のデータを返します。
- `WEEKLY` はユーザーが指定した `startDate` から7日間のデータを返します。
- `DAILY` はユーザーが指定した `startDate` の1日分のデータを返します。
- `ALL` は集計可能な全期間を返します。`ALL` の場合、`startDate` は指定不要です。
- `startDate` は JST の日付として解釈し、返却期間は `startDate` を含みます。
- 任意期間指定は artist 版だけでなく、UPC / ISRC 版にも追加します。
- UPC / ISRC 版にも `userId` を追加し、artist 版と同様に閲覧権限を確認します。
- 既存互換のため `period` は残します。新規 UI は `range` / `startDate` を利用します。
- `range` と `period` が同時指定された場合は `BAD_USER_INPUT` を返します。
- `range` と `period` がどちらも未指定の場合は `BAD_USER_INPUT` を返します。
- `range = ALL` で `startDate` が指定された場合は `BAD_USER_INPUT` を返します。
- `range = MONTHLY` / `WEEKLY` / `DAILY` で `startDate` が未指定の場合は `BAD_USER_INPUT` を返します。
- date format は `YYYY-MM-DD` のみ許可します。`YYYY/MM/DD` や `YYYYMMDD` など他形式は `BAD_USER_INPUT` を返します。

### 利用可能にする schema

```graphql
enum PlaybackHistoryRange {
  ALL
  MONTHLY
  WEEKLY
  DAILY
}

type QueryRoot {
  getPlayCountHistory(
    artistId: String!
    userId: String!
    period: Int
    startDate: String
    range: PlaybackHistoryRange
  ): ChartData!
}
```

UPC / ISRC 版にも同じ任意期間指定を追加します。

```graphql
type QueryRoot {
  getPlaycountHistoryByUpc(
    upc: String!
    userId: String!
    period: Int
    startDate: String
    range: PlaybackHistoryRange
  ): ChartDataByUPC!

  getPlaycountHistoryByIsrc(
    isrc: String!
    userId: String!
    period: Int
    startDate: String
    range: PlaybackHistoryRange
  ): ChartData!
}
```

### 不明点・確認事項

- なし。

## 13. 国別再生数取得用 Query

種類: 新設

### 現行実装

- `PlaybacksByCountryData` という GraphQL model はありますが、現行 Query には公開されていません。
- `gender_gen_playback` には country column がありません。
- DSP fetcher は raw JSON の `streams.country` を走査していますが、国情報自体は保存していません。

### 新設内容

- 国別再生数を保存する table / entity / repository を追加します。
- 国別データは裏側のデータ連携で取得・保存します。
- 国コードは ISO 3166-1 alpha-2 形式で表現します。
- アーティスト、UPC、ISRC で絞り込めるようにします。
- 返却対象は、指定期間内の再生数が多い順の上位10件です。
- 各国ごとに国名、合計再生数、全体に占める割合を返します。
- 前期間との比較として、順位の変化方向、再生数の増減、割合の変化率を返します。
- `previousRate = 0` の場合、`rateChange` は算出不能として `null` を返します。
- JP / US / Other の固定3分類ではなく、国コードごとの list で返します。

### 利用可能にする schema

```graphql
input CountryPlaybackInput {
  artistId: String!
  userId: String!
  upc: String
  isrc: String
  startDate: String
  endDate: String
  limit: Int = 10
}

enum CountryPlaybackRankDirection {
  UP
  DOWN
  STAY
}

type CountryPlaybackItem {
  countryCode: String!
  countryName: String!
  rank: Int!
  rankDirection: CountryPlaybackRankDirection!
  playCount: Int!
  rate: Float!
  previousPlayCount: Int!
  playCountDiff: Int!
  previousRate: Float!
  rateDiff: Float!
  rateChange: Float
}

type CountryPlaybackData {
  countries: [CountryPlaybackItem!]!
  totalPlayCount: Int!
  previousTotalPlayCount: Int!
}

type QueryRoot {
  getCountryPlaybacks(input: CountryPlaybackInput!): CountryPlaybackData!
}
```

### 不明点・確認事項

- 前期間の定義は、指定された `startDate` / `endDate` と同じ日数を直前にずらした期間とする想定です。別定義が必要な場合は要確認です。

## 14. d-8 Query `getGenderGenRateByArtist`

種類: 改修

### 現行 schema

```graphql
type GenderPlaybackRate {
  maleCount: Int!
  femaleCount: Int!
  neutralCount: Int!
  unknownCount: Int!
}

type GenPlaybackRate {
  under17: Int!
  gen18_22: Int!
  gen23_27: Int!
  gen28_34: Int!
  gen35_44: Int!
  gen45_59: Int!
  gen60_150: Int!
  genUnknown: Int!
}

type GenderGenRateData {
  genderRate: GenderPlaybackRate!
  genRate: GenPlaybackRate!
}

type QueryRoot {
  getGenderGenRateByArtist(artistId: String!, userId: String!): GenderGenRateData!
  getGenderGenRateByUpc(artistId: String!, userId: String!, upc: String!): GenderGenRateData!
  getGenderGenRateByIsrc(artistId: String!, userId: String!, isrc: String!): GenderGenRateData!
}
```

### 現行実装

- `gender_gen_playback` を ISRC 単位で取得します。
- gender は `male`, `female`, `neutral`, `unknown` を集計します。
- age は `0-17`, `18-22`, `23-27`, `28-34`, `35-44`, `45-59`, `60-150`, `unknown` を集計します。
- 返却値は再生数そのものではなく、全体に対する割合を `Int` に丸めた値です。

### 改修内容

- 世代区分を新しい定義に合わせて変更します。
- ジェンダーに関する field は GraphQL output からすべて削除し、世代データのみを返します。
- 返却値は割合のみとし、実数の `playCount` は返しません。
- 今後の世代区分変更に備えるなら、固定 field ではなく list 形式に変更する方針を推奨します。

### 利用可能にする schema 案

固定 field を避ける場合:

```graphql
type PlaybackRateBucket {
  key: String!
  label: String!
  rate: Int!
}

type GenderGenRateData {
  generationRate: [PlaybackRateBucket!]!
}
```

既存形式を維持する場合は、確定した世代区分に合わせて `GenPlaybackRate` の field を置き換えます。

```graphql
type GenPlaybackRate {
  under18: Int!
  gen18_24: Int!
  gen25_34: Int!
  gen35_44: Int!
  gen45Plus: Int!
  genUnknown: Int!
}
```

### 不明点・確認事項

- 新しい世代区分の正式定義が未確定です。

## フロントエンド / Sandbox 用 GraphQL 操作例

ここでは、モバイルアプリや GraphQL Sandbox から実行する操作例を示します。ID や日付はサンプル値なので、実環境の値に置き換えてください。

### 1. API-39: `requestToAccessArtist`

```graphql
mutation RequestToAccessArtist($input: RequestToAccessArtistInput!) {
  requestToAccessArtist(input: $input) {
    createdMappings {
      mappingId
      artistId
      name
      imageUrl
      status
      isAdmin
      requestMessage
    }
  }
}
```

```json
{
  "input": {
    "userId": "user_001",
    "requests": [
      {
        "artistId": "artist_001",
        "message": "所属申請をお願いします。"
      }
    ]
  }
}
```

### 2. API-44: `getBelongedArtists`

```graphql
query GetBelongedArtists($userId: String!) {
  getBelongedArtists(userId: $userId) {
    artistList {
      artistId
      name
      imageUrl
      status
      isAdmin
      requestMessage
      isDefault
    }
  }
}
```

```json
{
  "userId": "user_001"
}
```

### 3. アーティスト申請の再送用 Mutation

```graphql
mutation ResendRequestToAccessArtist($input: ResendRequestToAccessArtistInput!) {
  resendRequestToAccessArtist(input: $input) {
    updatedMapping {
      mappingId
      artistId
      name
      status
      requestMessage
    }
  }
}
```

```json
{
  "input": {
    "userId": "user_001",
    "artistId": "artist_001",
    "message": "内容を更新して再申請します。"
  }
}
```

### 4. アーティスト申請のキャンセル用 Mutation

モバイルアプリから利用するのは `cancelRequestToAccessArtist` のみです。

```graphql
mutation CancelRequestToAccessArtist($input: CancelRequestToAccessArtistInput!) {
  cancelRequestToAccessArtist(input: $input) {
    canceledMapping {
      mappingId
      artistId
      name
      status
      requestMessage
    }
  }
}
```

```json
{
  "input": {
    "userId": "user_001",
    "artistId": "artist_001"
  }
}
```

承認済み所属解除は別 Mutation `leaveBelongedArtist` を利用します。この Mutation は superadmin およびアーティスト代表のみ利用可能で、モバイルアプリからは利用しません。

```graphql
mutation LeaveBelongedArtist($input: LeaveBelongedArtistInput!) {
  leaveBelongedArtist(input: $input) {
    leftArtist {
      artistId
      name
      status
      isAdmin
      isDefault
    }
  }
}
```

```json
{
  "input": {
    "operatorUserId": "operator_001",
    "userId": "user_001",
    "artistId": "artist_001"
  }
}
```

### 5. 所属先アーティストのデフォルト設定 Mutation

```graphql
mutation SetDefaultBelongedArtist($input: SetDefaultBelongedArtistInput!) {
  setDefaultBelongedArtist(input: $input) {
    defaultArtist {
      artistId
      name
      status
      isDefault
    }
  }
}
```

```json
{
  "input": {
    "userId": "user_001",
    "artistId": "artist_001"
  }
}
```

### 6. notifications のリスト取得 schema

モバイルの通知一覧取得:

```graphql
query GetNotificationList($userId: String!, $limit: Int, $offset: Int) {
  getNotificationList(userId: $userId, limit: $limit, offset: $offset) {
    unreadCount
    hasNextPage
    notifications {
      id
      title
      content
      isRead
      createdAt
    }
  }
}
```

```json
{
  "userId": "user_001",
  "limit": 20,
  "offset": 0
}
```

管理者画面からの通知作成・送付:

```graphql
mutation CreateAdminNotification($input: CreateAdminNotificationInput!) {
  createAdminNotification(input: $input) {
    notificationId
    deliveredUserCount
  }
}
```

```json
{
  "input": {
    "title": "新機能のお知らせ",
    "content": "新しい分析機能が利用できるようになりました。",
    "channels": ["MOBILE_PUSH", "EMAIL"],
    "audienceType": "ARTIST_REPRESENTATIVES",
    "artistIds": ["artist_001", "artist_002"]
  }
}
```

### 7. notifications の個別コンテンツ取得 schema

通知の詳細取得 Query は追加しません。モバイルアプリは `getNotificationList` の返却内容のみで通知一覧を表示し、既読化も `getNotificationList` 実行時に行います。

### 8. d-2 Query `getOverview`

アーティスト全体の overview:

```graphql
query GetOverview($artistId: String!, $userId: String!) {
  getOverview(artistId: $artistId, userId: $userId) {
    totalPlaybacks
    monthlyPlaybacks
    weeklyPlaybacks
    dailyPlaybacks
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001"
}
```

UPC 指定の overview:

```graphql
query GetOverviewByUpc($artistId: String!, $userId: String!, $upc: String!) {
  getOverviewByUpc(artistId: $artistId, userId: $userId, upc: $upc) {
    totalPlaybacks
    monthlyPlaybacks
    weeklyPlaybacks
    dailyPlaybacks
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "upc": "4988000000000"
}
```

### 9. Most Recent Release 用 Query

```graphql
query GetMostRecentRelease($artistId: String!, $userId: String!, $limit: Int) {
  getMostRecentRelease(artistId: $artistId, userId: $userId, limit: $limit) {
    products {
      upc
      productTitle
      imageUrl
      releaseDate
      productType
      trackCount
      totalPlayCount
      monthlyPlayCount
      weeklyPlayCount
      dailyPlayCount
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "limit": 10
}
```

### 10. Trending 用 Query

```graphql
query GetTrendingChanges($artistId: String!, $userId: String!, $periodDays: Int) {
  getTrendingChanges(
    artistId: $artistId
    userId: $userId
    periodDays: $periodDays
  ) {
    tracks {
      isrc
      trackTitle
      upc
      productTitle
      imageUrl
      currentPlayCount
      previousPlayCount
      diffPlayCount
      changeRate
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "periodDays": 7
}
```

### 11. d-4 Query `getTrending`

```graphql
query GetTrending($artistId: String!, $userId: String!, $timeAxis: TrendingTimeAxis) {
  getTrending(artistId: $artistId, userId: $userId, timeAxis: $timeAxis) {
    trendingTracks {
      isrc
      trackTitle
      upcTitle
      imageUrl
      totalPlayCount
      monthlyPlayCount
      weeklyPlayCount
      dailyPlayCount
      totalPlayCountDetails {
        spotify
        apple
        line
        amazon
        youtube
      }
      monthlyPlayCountDetails {
        spotify
        apple
        line
        amazon
        youtube
      }
      weeklyPlayCountDetails {
        spotify
        apple
        line
        amazon
        youtube
      }
      dailyPlayCountDetails {
        spotify
        apple
        line
        amazon
        youtube
      }
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "timeAxis": "MONTH"
}
```

### 12. d-5 Query `getPlayCountHistory`

アーティスト単位:

```graphql
query GetPlayCountHistory(
  $artistId: String!
  $userId: String!
  $startDate: String
  $range: PlaybackHistoryRange
) {
  getPlayCountHistory(
    artistId: $artistId
    userId: $userId
    startDate: $startDate
    range: $range
  ) {
    lineChartData {
      date
      spotify
      apple
      line
      amazon
      youtube
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "startDate": "2026-03-01",
  "range": "MONTHLY"
}
```

UPC 単位:

```graphql
query GetPlaycountHistoryByUpc(
  $upc: String!
  $userId: String!
  $startDate: String
  $range: PlaybackHistoryRange
) {
  getPlaycountHistoryByUpc(
    upc: $upc
    userId: $userId
    startDate: $startDate
    range: $range
  ) {
    lineChartData {
      date
      trackCount
    }
  }
}
```

```json
{
  "upc": "4988000000000",
  "userId": "user_001",
  "startDate": "2026-03-01",
  "range": "WEEKLY"
}
```

ISRC 単位:

```graphql
query GetPlaycountHistoryByIsrc(
  $isrc: String!
  $userId: String!
  $startDate: String
  $range: PlaybackHistoryRange
) {
  getPlaycountHistoryByIsrc(
    isrc: $isrc
    userId: $userId
    startDate: $startDate
    range: $range
  ) {
    lineChartData {
      date
      spotify
      apple
      line
      amazon
      youtube
    }
  }
}
```

```json
{
  "isrc": "JPG000000001",
  "userId": "user_001",
  "startDate": "2026-03-01",
  "range": "DAILY"
}
```

### 13. 国別再生数取得用 Query

```graphql
query GetCountryPlaybacks($input: CountryPlaybackInput!) {
  getCountryPlaybacks(input: $input) {
    totalPlayCount
    previousTotalPlayCount
    countries {
      countryCode
      countryName
      rank
      rankDirection
      playCount
      rate
      previousPlayCount
      playCountDiff
      previousRate
      rateDiff
      rateChange
    }
  }
}
```

```json
{
  "input": {
    "artistId": "artist_001",
    "userId": "user_001",
    "startDate": "2026-03-01",
    "endDate": "2026-03-31",
    "limit": 10
  }
}
```

### 14. d-8 Query `getGenderGenRateByArtist`

アーティスト単位:

```graphql
query GetGenderGenRateByArtist($artistId: String!, $userId: String!) {
  getGenderGenRateByArtist(artistId: $artistId, userId: $userId) {
    generationRate {
      key
      label
      rate
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001"
}
```

UPC 単位:

```graphql
query GetGenderGenRateByUpc($artistId: String!, $userId: String!, $upc: String!) {
  getGenderGenRateByUpc(artistId: $artistId, userId: $userId, upc: $upc) {
    generationRate {
      key
      label
      rate
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "upc": "4988000000000"
}
```

ISRC 単位:

```graphql
query GetGenderGenRateByIsrc($artistId: String!, $userId: String!, $isrc: String!) {
  getGenderGenRateByIsrc(artistId: $artistId, userId: $userId, isrc: $isrc) {
    generationRate {
      key
      label
      rate
    }
  }
}
```

```json
{
  "artistId": "artist_001",
  "userId": "user_001",
  "isrc": "JPG000000001"
}
```
