# モバイルアプリ向け GraphQL 改修仕様

作成日: 2026-04-22

この文書は、`server-core` の現行 GraphQL 実装を前提に、モバイルアプリ開発会社へ共有するための改修仕様を整理したものです。

「改修」は既存の GraphQL schema / resolver / usecase を軸に拡張します。「新設」は新しい GraphQL field / input / output / usecase を追加します。ここに記載する schema は実装予定の外部公開仕様案であり、実装完了後は `presentation/src/graphql/schema.graphql` の生成結果と照合してください。

## 現行実装の前提

- GraphQL schema は `presentation/src/graphql/schema.graphql` に生成されています。
- dashboard 系 Query は `presentation/src/graphql/queries/dashboard/mod.rs` から、`application/src/usecases/dashboard/*` を呼び出しています。
- 所属アーティスト系 Mutation / Query は `presentation/src/graphql/mutations/artist/mod.rs` と `presentation/src/graphql/queries/general/mod.rs` から、`user_artist` と `artists` を参照しています。
- `user_artist.status` の現行値は `Check`, `Accept`, `Reject` に対応しています。
- 通知は `notifications` と `notification_user` に分かれており、`notification_user` がユーザー別既読状態を持ちます。
- 再生数は主に `plays_daily`、性別・世代別再生数は `gender_gen_playback` を参照します。
- 国別再生数は GraphQL model の未使用型はありますが、現行 entity / repository として永続化されていません。

## 共通方針

### 日付と期間

既存 dashboard 集計は、日本時間基準で直近数日を除外するロジックを持っています。現行 `getOverview` / `getTrending` は概ね `today_jst - 3 days` を集計終端にしています。

新規・改修後の期間定義は、モバイル側の表示と一致させるため、実装前に以下を確定してください。

- `all`: 集計可能な全期間。直近未確定日を除外するかは要確認。
- `monthly`: 直近30日、または直近の確定済み暦月のどちらか要確認。
- `weekly`: 直近7日相当。現行は `today_jst - 9 days` から `today_jst - 3 days` まで。
- `daily`: 直近の確定済み1日。現行のデータ鮮度に合わせるなら `today_jst - 3 days`。

### 認可

現行 resolver は `userId` を受け取るものの、dashboard 系の一部 usecase では `userId` が実質的に使われていません。外部公開仕様としては、`userId` が対象 `artistId` への閲覧権限を持つかを `user_artist` で確認する方針を推奨します。

## 対象項目一覧

| No | 内容 | 種類 | 主な対応 |
| --- | --- | --- | --- |
| 1 | API-39: `requestToAccessArtist` | 改修 | 申請メッセージを追加 |
| 2 | API-44: `getBelongedArtists` | 改修 | 所属ステータスの追加・返却 |
| 3 | アーティスト申請の再送用 Mutation | 新設 | 既存申請の再送・メッセージ更新 |
| 4 | アーティスト申請のキャンセル用 Mutation | 新設 | 申請のキャンセル |
| 5 | 所属先アーティストのデフォルト設定 Mutation | 新設 | デフォルト所属アーティスト設定 |
| 6 | notifications のリスト取得 schema | 新設 | 管理者送付通知の一覧取得 |
| 7 | notifications の個別コンテンツ取得 schema | 新設 | 通知詳細取得 |
| 8 | d-2 Query `getOverview` | 改修 | all / monthly / weekly / daily 合計を返却 |
| 9 | Most Recent Release 用 Query | 新設 | 最近再生されているリリース・楽曲を返却 |
| 10 | Trending 用 Query | 新設 | ISRC単位で前期比40%以上変動した楽曲を返却 |
| 11 | d-4 Query `getTrending` | 改修 | all / monthly / weekly / daily 合計を返却 |
| 12 | d-5 Query `getPlayCountHistory` | 改修 | 任意期間で絞り込み |
| 13 | 国別再生数取得用 Query | 新設 | 国別再生数を返却 |
| 14 | d-8 Query `getGenderGenRateByArtist` | 改修 | 世代区切り調整・不要 field 削除 |

## 1. API-39: `requestToAccessArtist`

種類: 改修

### 現行 schema

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

### 現行実装

- `RequestToAccessUsecase` が `artistIds` の重複を除外します。
- `user_artist` に同じ `user_id` / `artist_id` の mapping が存在する場合はスキップします。
- 新規 mapping は `user_artist` に作成され、status は DB / SeaORM default に依存します。実運用上は申請中の `Check` を想定します。
- 現行 `user_artist` に申請メッセージを保存する column はありません。

### 改修内容

- 申請時にユーザーが入力したメッセージを受け取れるようにします。
- メッセージは任意入力です。ただし、指定する場合は1字以上200字以内とし、空文字は許可しません。
- 200字は日本語の入力を前提にした文字数上限です。実装では Rust の `chars().count()` 等で Unicode scalar value 数として扱う方針を推奨します。
- 現行の複数件一括申請 schema との互換性は維持します。
- モバイル画面上では1件ずつ申請するため、モバイルからは `artistIds` に1件だけ入れて送信します。
- 申請メッセージは、同一リクエスト内の `artistIds` すべてに適用されます。モバイル利用では常に1件なので、結果として1申請ごとに1つのメッセージを持ちます。
- 申請メッセージを永続化するため、`user_artist` に `request_message` を追加します。
- 既存 mapping がある場合の扱いは、項目 3 の再送 Mutation と整合させます。`requestToAccessArtist` は新規申請専用にし、既存申請は再送 Mutation へ誘導する方針を推奨します。

### 利用可能にする schema

```graphql
input RequestToAccessArtistInput {
  userId: String!
  artistIds: [String!]!
  message: String
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

### 不明点・確認事項

- `request_message` の DB column 長は、日本語200字を保存できる型にします。
- 既存のバルク申請で複数 `artistIds` と `message` が指定された場合、同じメッセージを全申請に適用します。個別メッセージ付きバルク申請は今回の対象外です。

## 2. API-44: `getBelongedArtists`

種類: 改修

### 現行 schema

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

### 現行実装

- `getBelongedArtists(userId)` は `user_artist` を `user_id` で取得し、対応する `artists` 情報と結合して返します。
- status は `Check`, `Accept`, `Reject` の文字列として返却されます。

### 改修内容

- アーティスト申請の状態管理に必要な status を追加します。
- モバイル側は `status` によって、申請中、承認済み、却下、キャンセル済みなどの表示を切り替えられるようにします。
- status 値を string のまま追加するか、GraphQL enum 化するかを選びます。既存互換を重視するなら string のまま拡張します。
- `Reject` 後に再申請する場合は、既存の `user_artist` mapping を再利用し、status を `Check` に戻します。

### 利用可能にする schema

既存互換を優先する場合:

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

enum 化する場合:

```graphql
enum UserArtistStatus {
  CHECK
  ACCEPT
  REJECT
  CANCELED
}
```

### 不明点・確認事項

- 追加する status の正式名称が未確定です。この文書ではキャンセル済みを `CANCELED` と仮置きしています。
- 申請日時、更新日時、却下理由をモバイルで表示するか未確定です。

## 3. アーティスト申請の再送用 Mutation

種類: 新設

### 新設理由

現行 `requestToAccessArtist` は、既存 mapping がある場合にスキップします。そのため、却下済み・キャンセル済み・申請中のレコードに対して、再送としてメッセージを更新し、申請状態に戻す処理が必要です。

### 実装内容

- `userId` と `artistId` で既存 `user_artist` を取得します。
- 再送可能な status の場合、status を申請中に戻します。
- 申請メッセージを更新します。
- 既存 mapping がない場合は、通常の申請 Mutation を使うか、この Mutation で新規作成も許可するかを決めます。

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

- 再送可能な status が未確定です。候補は `Reject`, `Canceled`, `Check` です。
- 申請中 `Check` の再送を許可する場合、申請日時や通知を更新するか未確定です。
- 再送時にアーティスト管理者へ通知を送るか未確定です。

## 4. アーティスト申請のキャンセル用 Mutation

種類: 新設

### 新設理由

ユーザーが申請中のアーティスト所属申請を取り下げるための Mutation を追加します。

### 実装内容

- `userId` と `artistId` で `user_artist` を取得します。
- 申請中の mapping をキャンセル済みに更新します。
- 履歴を残すため、物理削除より status 更新を推奨します。
- キャンセル後も `getBelongedArtists` には表示します。
- 承認済み `Accept` の所属解除はこの Mutation では扱いません。
- 承認済み所属の解除は、別 Mutation `leaveBelongedArtist` を新設して扱います。

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

承認済み所属解除用の別 Mutation:

```graphql
input LeaveBelongedArtistInput {
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

- キャンセル済み status の正式名称が未確定です。

## 5. 所属先アーティストのデフォルト設定 Mutation

種類: 新設

### 現行実装

- `UserDetailData.primaryArtist` は schema に存在します。
- ただし、現行 usecase は `primary_artist: None` を返しており、DB entity にデフォルト所属アーティストを保存する column はありません。

### 実装内容

- ユーザーごとにデフォルト所属アーティストを1つ保存できるようにします。
- 保存先は `user_artist` table とし、`is_default` column を追加します。
- デフォルト設定可能な対象は、`user_artist.status = Accept` の所属アーティストのみに限定します。
- デフォルト所属アーティストを未設定に戻す Mutation は追加しません。
- デフォルト設定後、`getUserData` / `getUserDetailProfile` の `primaryArtist` に反映します。

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
- モバイルアプリ側は、管理者画面から送付された通知を `getNotificationList` / `getNotificationDetail` で取得・表示します。
- server-core 側では、管理者画面から呼び出す通知作成 Mutation を追加する必要があります。

### モバイル取得仕様

- モバイル向けの通知一覧取得 Query を追加します。
- 既存 `getNotifications(userId)` は互換性維持のため残します。
- 一覧では本文全文を返さず、詳細は項目 7 の個別取得 Query で取得する方針を推奨します。
- pagination は `limit` / `offset` 方式にします。
- `notification_user.is_deleted = false` のみを返却します。
- `notifications.created_at` 降順で返却します。

#### 利用可能にする schema

```graphql
type NotificationListItem {
  id: String!
  title: String!
  category: String
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

- 管理者画面からの送付時は、`notifications` に通知本文を作成し、送付対象ユーザーごとに `notification_user` を作成します。
- 送付対象は以下を選択可能にします。
  - 全体通知: 全登録ユーザーへ送付します。
  - アーティスト代表者通知: 指定アーティストの代表者へ送付します。
- アーティスト代表者は、`user_artist.status = Accept` かつ `user_artist.is_admin = true` のユーザーとして扱います。

#### 利用可能にする schema

```graphql
enum NotificationAudienceType {
  ALL
  ARTIST_REPRESENTATIVES
}

input CreateAdminNotificationInput {
  title: String!
  content: String!
  category: String
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

### 不明点・確認事項

- 通知 category の正式な種類が未整理です。
- 管理者通知作成 Mutation の認可方式は、既存の管理者権限設計に合わせて確定する必要があります。

## 7. notifications の個別コンテンツ取得 schema

種類: 新設

### 新設内容

- 通知 ID を指定して、通知の詳細本文を取得します。
- ユーザー本人に紐づく `notification_user` が存在する場合のみ返します。
- `notification_user.is_deleted = true` の通知は、専用エラーとして `NotificationDeletedError` を返します。
- `NotificationDeletedError` の GraphQL error `extensions.code` は `NOTIFICATION_DELETED` とします。
- 詳細取得時に既読化するかは、既存 `markNotificationAsRead` と責務を分ける方針を推奨します。

### 利用可能にする schema

```graphql
type NotificationDetailData {
  id: String!
  title: String!
  category: String
  content: String!
  isRead: Boolean!
  createdAt: String!
}

type QueryRoot {
  getNotificationDetail(
    userId: String!
    notificationId: Int!
  ): NotificationDetailData!
}
```

既読化は既存 Mutation を利用します。

```graphql
type MutationRoot {
  markNotificationAsRead(notificationId: Int!, userId: String!): Int!
}
```

### 不明点・確認事項

- 詳細取得時に自動既読化するか未確定です。

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
- `dailyPlaybacks` は直近確定日の再生数とします。現行実装と同様、直近未確定日は集計対象に含めません。
- `totalPlaybacks` は直近確定日までの全期間合計とします。現行実装と同様、直近未確定日は集計対象に含めません。
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

- monthly を直近30日とするか、確定済み暦月とするか未確定です。

## 9. Most Recent Release 用 Query

種類: 新設

### 新設内容

- 対象アーティストのリリースを、最新リリース順で返す Query を追加します。
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

- 「最近」の期間が未確定です。

## 10. Trending 用 Query

種類: 新設

### 現行との差分

現行 `getTrending` は、全期間再生数上位の楽曲と weekly 再生数を返す Query です。今回の「変動が大きい楽曲」は、既存 `getTrending` へ転用せず、新規 `getTrendingChanges` として追加します。上位楽曲ではなく、ISRC、つまり楽曲単位で前期比40%以上増加した楽曲を返します。

### 新設内容

- 表示する作品は ISRC 単位、つまり楽曲単位です。
- 現期間と前期間を同じ日数で比較し、前期比40%以上増加した楽曲のみを返します。
- 変動率は `((currentPlayCount - previousPlayCount) / previousPlayCount) * 100` で算出します。
- `changeRate` は増加率を表します。
- `changeRate >= 40.0` を表示基準にします。
- `previousPlayCount = 0` の楽曲は変動率を算出不能として通常の `tracks` から除外し、別枠の `unavailableTracks` に返します。
- 初期案では比較期間を `periodDays` で指定可能にし、未指定時は7日対7日の前期比とします。

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

type TrendingChangeUnavailableTrack {
  isrc: String!
  trackTitle: String
  upc: String
  productTitle: String
  imageUrl: String
  currentPlayCount: Int!
  previousPlayCount: Int!
  reason: String!
}

type TrendingChangeData {
  tracks: [TrendingChangeTrack!]!
  unavailableTracks: [TrendingChangeUnavailableTrack!]!
  thresholdRate: Float!
}

type QueryRoot {
  getTrendingChanges(
    artistId: String!
    userId: String!
    periodDays: Int = 7
    limit: Int = 10
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
- DSP 別内訳も同じ期間軸で返せるようにします。
- `getTrendingByUpc` も同じ `TrendTrack` を利用するため、同様に field が増えます。

### 利用可能にする schema

```graphql
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
```

### 不明点・確認事項

- monthly / daily の期間定義が未確定です。
- `getTrending` の順位付けを total のままにするか、weekly / monthly を基準にするか未確定です。

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
- それ以外は `Invalid period` になります。

### 改修内容

- 任意の `startDate` / `endDate` で絞り込めるようにします。
- 任意期間指定は artist 版だけでなく、UPC / ISRC 版にも追加します。
- 既存互換のため `period` は残し、`startDate` / `endDate` が指定された場合は任意期間指定を優先する方針を推奨します。
- date format は `YYYY-MM-DD` を基本とします。既存 repository には `YYYY/MM/DD` と `YYYYMMDD` を許容する parser があります。

### 利用可能にする schema

```graphql
enum PlaybackHistoryGranularity {
  DAILY
  MONTHLY
}

type QueryRoot {
  getPlayCountHistory(
    artistId: String!
    userId: String!
    period: Int
    startDate: String
    endDate: String
    granularity: PlaybackHistoryGranularity = DAILY
  ): ChartData!
}
```

UPC / ISRC 版にも同じ任意期間指定を追加します。

```graphql
type QueryRoot {
  getPlaycountHistoryByUpc(
    upc: String!
    period: Int
    startDate: String
    endDate: String
    granularity: PlaybackHistoryGranularity = DAILY
  ): ChartDataByUPC!

  getPlaycountHistoryByIsrc(
    isrc: String!
    period: Int
    startDate: String
    endDate: String
    granularity: PlaybackHistoryGranularity = DAILY
  ): ChartData!
}
```

### 不明点・確認事項

- 日次 / 月次の切り替えを自動判定にするか、`granularity` で明示するか未確定です。
- `period` と `startDate` / `endDate` が同時指定された場合の優先順位は要確定です。

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
