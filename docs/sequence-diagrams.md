# 処理フロー図（シーケンス図）

各機能の処理フローをシーケンス図で示します。  
本ドキュメントはソースコードの実装に基づいて作成されています。

---

## 目次

1. [サインイン](#サインイン)
2. [認証](#認証)
3. [クエスト](#クエスト)
4. [ポイントシステム（購入時）](#ポイントシステム購入時)
5. [ポイントシステム（送付時）](#ポイントシステム送付時)
6. [ポイントシステム（特典ポイント）](#ポイントシステム特典ポイント)
7. [ポイントシステム（FSP配分）](#ポイントシステムfsp配分)
8. [ポイントシステム（FSPからクレデンシャルに変換）](#ポイントシステムfspからクレデンシャルに変換)
9. [タスクマッチング（作成時）](#タスクマッチング作成時)
10. [タスクマッチング（完了時）](#タスクマッチング完了時)
11. [AIチャットボット](#aiチャットボット)
12. [クレジット入力時の招待メール配信](#クレジット入力時の招待メール配信)
13. [景品交換](#景品交換)

---

## サインイン

ユーザーはクライアントアプリケーションを通じて、メールアドレスとパスワードを用いてFirebase Authでサインインまたはサインアップを行います。サインアップ時はメール認証を経てプロフィール設定を行い、GraphQL mutationでバックエンドにユーザーレコードを作成します。サインイン時はFirebase ID Tokenを取得し、Next.js API Routeでトークンを検証した後、GraphQLでユーザー情報を取得します。セッションはHTTP-only cookieで管理されます。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    participant クライアント
    participant Firebase認証
    participant NextJS as Next.js API Route
    participant バックエンド as バックエンド（GraphQL）
    participant データベース

    ユーザー->>クライアント: サインイン/サインアップ画面表示

    alt サインアップ（新規登録）
        ユーザー->>クライアント: メールアドレスとパスワード入力
        クライアント->>Firebase認証: createUserWithEmailAndPassword
        Firebase認証-->>クライアント: UserCredential
        Firebase認証-->>ユーザー: メール認証リンク送信
        ユーザー->>Firebase認証: メール認証リンクをクリック

        ユーザー->>クライアント: プロフィール情報入力（表示名、本名、画像、カテゴリー）
        クライアント->>バックエンド: createNewUserData mutation（Firebase UID、メール、名前、カテゴリー等）
        バックエンド->>データベース: ユーザーレコード作成
        データベース-->>バックエンド: 作成完了
        バックエンド-->>クライアント: ユーザーデータ

    else サインイン（既存ユーザー）
        ユーザー->>クライアント: メールアドレスとパスワード入力
        クライアント->>Firebase認証: signInWithEmailAndPassword
        Firebase認証-->>クライアント: UserCredential

        クライアント->>クライアント: getIdToken(true)でID Token取得
        クライアント->>NextJS: POST /api/auth/verify（ID Token）
        NextJS->>Firebase認証: verifyIdToken（Firebase Admin SDK）
        Firebase認証-->>NextJS: decodedToken（uid, email）
        NextJS-->>クライアント: uid, email, emailVerified

        クライアント->>バックエンド: getUserData query（Firebase UID）
        バックエンド->>データベース: ユーザー情報検索
        alt ユーザー存在
            データベース-->>バックエンド: ユーザー情報
            バックエンド-->>クライアント: ユーザーデータ
        else ユーザー不存在
            バックエンド-->>クライアント: ユーザーなし
            クライアント->>ユーザー: プロフィール設定画面にリダイレクト
        end
    end

    クライアント->>NextJS: POST /api/auth/session（ID Token + UID）
    NextJS->>NextJS: HTTP-only cookie設定（24時間有効）
    NextJS-->>クライアント: セッション作成完了

    クライアント->>ユーザー: ダッシュボード/ホーム画面表示
```

---

## 認証

認証済みユーザーのリクエストはNext.js middlewareでセッションcookieの存在を確認します。セッションcookieにはFirebase ID TokenとUIDが含まれます。バックエンドのGraphQLエンドポイントは現在トークン検証を行っておらず、クライアントがuser_idをパラメータとして明示的に渡します。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    participant クライアント
    participant Middleware as Next.js Middleware
    participant NextJS as Next.js API Route
    participant バックエンド as バックエンド（GraphQL）

    ユーザー->>クライアント: 認証が必要なページにアクセス
    クライアント->>Middleware: リクエスト（sessionクッキー付き）

    alt セッションcookieが存在
        Middleware->>Middleware: sessionクッキーからidToken, uidを取得
        Middleware-->>クライアント: リクエスト許可

        クライアント->>バックエンド: GraphQLリクエスト（user_idをパラメータとして送信）
        Note over クライアント, バックエンド: バックエンドではトークン検証ミドルウェアが無効化されている
        バックエンド-->>クライアント: レスポンス
        クライアント->>ユーザー: ページ表示

    else セッションcookieが不存在
        Middleware-->>クライアント: /loginにリダイレクト
        クライアント->>ユーザー: ログイン画面表示
    end

    Note over ユーザー, バックエンド: ログアウト
    ユーザー->>クライアント: ログアウト操作
    クライアント->>NextJS: POST /api/auth/logout
    NextJS->>NextJS: sessionクッキー削除
    NextJS-->>クライアント: ログアウト完了
    クライアント->>ユーザー: ログイン画面にリダイレクト
```

---

## クエスト

クエストはシステム管理型で、シード データとして事前登録されています（「ログインボーナス」「プロフィールを編集しよう」等）。ユーザーはクエスト一覧から未完了のクエストを閲覧し、完了報告を行います。クエストにオーナー概念はなく、ポイントの自動移転もありません。ログインボーナスは日次で1FSPが付与されます。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    participant フロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース

    %% クエスト一覧取得
    ユーザー->>フロントエンド: ホーム画面を表示
    フロントエンド->>バックエンド: getQuestByUserId query（ユーザーID）
    バックエンド->>データベース: 全クエストを取得
    データベース-->>バックエンド: クエスト一覧
    バックエンド->>データベース: ユーザーの完了済みクエストを取得
    データベース-->>バックエンド: 完了済みクエスト一覧
    バックエンド->>バックエンド: 未完了クエストをフィルタリング
    バックエンド-->>フロントエンド: 未完了クエスト一覧
    フロントエンド->>ユーザー: クエスト一覧をカルーセルで表示

    %% クエスト完了
    ユーザー->>フロントエンド: クエスト完了を報告
    フロントエンド->>バックエンド: questMarkAsDone mutation（クエストID、ユーザーID）
    バックエンド->>データベース: quest_userレコード作成（is_done: true）
    データベース-->>バックエンド: 作成完了
    バックエンド-->>フロントエンド: 完了レスポンス（クエストID）
    フロントエンド->>ユーザー: 完了メッセージを表示

    Note over バックエンド, データベース: ポイント自動移転・報告内容検証は未実装
```

---

## ポイントシステム（購入時）

ユーザーはフロントエンドからポイント購入ページを開き、固定の購入オプション（100/300/500/1000/5000 FSP）から選択します。Next.js API RouteでStripe Checkout Sessionを作成し、ユーザーをStripeの決済ページにリダイレクトします。決済完了後、Stripeからバックエンドにwebhook（checkout.session.completed）が送信され、内部的にtransfer(from: None)を経由してユーザーのポイントが加算されます。ポイント受取時にDB通知・FCMプッシュ通知・SendGridメール通知が非同期で送信されます。なお、Webhook署名検証は現在未実装です。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    participant フロントエンド
    participant NextJS as Next.js API Route
    participant Stripe
    participant バックエンド as バックエンド（Webhook）
    participant データベース
    participant FCM
    participant SendGrid

    ユーザー->>フロントエンド: ポイント購入ページを開く
    フロントエンド->>ユーザー: 購入オプションを表示（100/300/500/1000/5000 FSP）

    ユーザー->>フロントエンド: 購入ポイント数を選択
    フロントエンド->>NextJS: POST /api/create-checkout-session（ポイント数、金額、ユーザーID）
    NextJS->>Stripe: Checkout Session作成（mode: payment, currency: JPY, metadata: user_id, points）
    Stripe-->>NextJS: Session URL
    NextJS-->>フロントエンド: Session URL
    フロントエンド->>Stripe: Stripeの決済ページにリダイレクト

    ユーザー->>Stripe: カード情報入力・決済実行

    alt 決済成功
        Stripe->>バックエンド: Webhook（checkout.session.completed）
        Note over バックエンド: Webhook署名検証は未実装（JSONボディを直接パース）
        バックエンド->>バックエンド: イベントJSONをパース、metadataからuser_id, pointsを抽出
        バックエンド->>バックエンド: transfer(from: None, to: user_id, amount: points)を実行
        バックエンド->>データベース: 送付先ユーザーのFSPを加算
        バックエンド->>データベース: FSPトランザクション履歴を作成（notes: "Stripeにより購入"）
        データベース-->>バックエンド: 更新完了

        バックエンド->>データベース: 通知レコード作成（非同期）
        バックエンド-)FCM: プッシュ通知送信（非同期）
        FCM-)ユーザー: 「ポイントを受け取りました」
        バックエンド-)SendGrid: ポイント受取通知メール送信（非同期）
        SendGrid-)ユーザー: メール配信

        Stripe-->>フロントエンド: 成功ページにリダイレクト
        フロントエンド->>ユーザー: 購入完了メッセージを表示

    else 決済失敗
        Stripe-->>フロントエンド: エラーページにリダイレクト
        フロントエンド->>ユーザー: エラーメッセージを表示
    end
```

---

## ポイントシステム（送付時）

ユーザーはフロントエンドからポイント送付ページを開き、送付先ユーザー（ユーザー名またはメールアドレス）とポイント数を入力します。createFspTx mutationは内部的にtransfer_by_username_or_emailを呼び出し、先に送付先ユーザーのFSPを加算した後、送付元ユーザーの残高チェック・FSP減算を行います。送付完了後、受取側ユーザーにのみDB通知・FCMプッシュ通知・SendGridメール通知が送信されます。

```mermaid
sequenceDiagram
    autonumber

    actor 送付元ユーザー
    actor 送付先ユーザー
    participant フロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース
    participant FCM
    participant SendGrid

    送付元ユーザー->>フロントエンド: ポイント送付ページを開く
    フロントエンド->>送付元ユーザー: 送付フォームを表示

    送付元ユーザー->>フロントエンド: 送付先（ユーザー名 or メールアドレス）、ポイント数を入力
    フロントエンド->>バックエンド: createFspTx mutation（送付先、ポイント数、送付元ユーザーID）
    Note over バックエンド: 内部的にtransfer_by_username_or_emailを呼び出し

    %% 1. 送付先のFSP加算が先に実行される
    バックエンド->>データベース: 送付先ユーザー情報を取得（ユーザー名 or メールで検索）
    データベース-->>バックエンド: ユーザー情報
    バックエンド->>データベース: 送付先ユーザーのFSPを加算

    %% 2. その後、送付元の残高チェック・減算
    バックエンド->>データベース: 送付元ユーザー情報を取得
    データベース-->>バックエンド: ユーザー情報（FSP残高含む）
    バックエンド->>バックエンド: 送付元のFSP残高チェック

    alt 残高不足
        Note over バックエンド: 送付先への加算は既に実行済み（ロールバックなし）
        バックエンド-->>フロントエンド: エラー（Insufficient balance）
        フロントエンド->>送付元ユーザー: 残高不足エラーを表示
    else 残高充足
        バックエンド->>データベース: 送付元ユーザーのFSPを減算
        バックエンド->>データベース: FSPトランザクション履歴を作成
        データベース-->>バックエンド: 更新完了
        バックエンド-->>フロントエンド: 送付成功レスポンス
        フロントエンド->>送付元ユーザー: 送付完了メッセージを表示

        Note over バックエンド, SendGrid: 受取側への通知のみ（送付元への通知なし）
        バックエンド->>データベース: 通知レコード作成（非同期）
        バックエンド-)FCM: プッシュ通知送信（非同期）
        FCM-)送付先ユーザー: 「ポイントを受け取りました」
        バックエンド-)SendGrid: メール通知送信（非同期）
        SendGrid-)送付先ユーザー: ポイント受取通知メール
    end
```

---

## ポイントシステム（特典ポイント）

現在実装されている特典ポイントはログインボーナスのみです。ユーザーがログインすると、バックエンドは最終ログイン日時を確認し、当日初回ログインの場合に1FSPを付与します。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    participant フロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース

    ユーザー->>フロントエンド: ログイン完了後、ホーム画面表示
    フロントエンド->>バックエンド: loginReward query（ユーザーID）

    バックエンド->>データベース: ユーザー情報を取得（last_login_at含む）
    データベース-->>バックエンド: ユーザー情報

    alt last_login_atが未設定（初回ログイン）
        バックエンド->>データベース: last_login_atを現在時刻に更新
        バックエンド-->>フロントエンド: ポイント付与なし（rewarded: false）
    else last_login_atが当日と異なる日付
        バックエンド->>データベース: ユーザーのFSPを+1加算
        バックエンド->>データベース: last_login_atを現在時刻に更新
        データベース-->>バックエンド: 更新完了
        バックエンド-->>フロントエンド: ポイント付与成功（fsp: 更新前の残高, rewarded: true）
        Note over フロントエンド: fspは更新前の値が返される（user.fsp）
        フロントエンド->>ユーザー: ログインボーナス獲得メッセージを表示
    else last_login_atが当日と同じ日付
        バックエンド-->>フロントエンド: ポイント付与なし（rewarded: false）
    end
```

---

## ポイントシステム（FSP配分）

管理者はバックエンドのGraphQL mutation（createBulkFspTx）を通じて、一括でユーザーにFSPを配分できます。データベースは単一のPostgreSQLで、組織とユーザーのデータは同一DB内に存在します。送付元にはアーティストアカウント（artist_*）も指定可能で、その場合はアーティストのFSPから減算されます。なお、bulk_transferでは通知（DB通知・FCM・SendGrid）は送信されません。

```mermaid
sequenceDiagram
    autonumber

    actor 管理者
    participant 管理画面 as 管理画面（Admin）
    participant バックエンド as バックエンド（GraphQL）
    participant データベース

    管理者->>管理画面: FSP配分画面を開く
    管理画面->>バックエンド: システム概要を取得（総配布ポイント数等）
    バックエンド->>データベース: データ取得
    データベース-->>バックエンド: システム概要情報
    バックエンド-->>管理画面: ダッシュボード表示

    管理者->>管理画面: 配分対象ユーザーとポイント数を入力
    管理画面->>バックエンド: createBulkFspTx mutation（配分リスト）

    loop 各対象ユーザーについて
        alt 送付元がアーティストアカウント（artist_*）
            バックエンド->>データベース: アーティストのFSP残高チェック
            alt 残高不足
                バックエンド-->>管理画面: エラー（Insufficient artist balance）
            else 残高充足
                バックエンド->>データベース: アーティストFSP減算
            end
        else 送付元が通常ユーザー
            バックエンド->>データベース: ユーザーのFSP残高チェック
            alt 残高不足
                バックエンド-->>管理画面: エラー（Insufficient balance）
            else 残高充足
                バックエンド->>データベース: 送付元ユーザーFSP減算
            end
        else 送付元が管理者アカウント
            Note over バックエンド: 残高チェック・減算をスキップ
        end
        バックエンド->>データベース: 対象ユーザーFSP加算
        end
    end

    バックエンド->>データベース: FSPトランザクション履歴を一括作成（create_many）
    データベース-->>バックエンド: 作成完了

    Note over バックエンド: bulk_transferでは通知（DB通知・FCM・SendGrid）は送信されない

    バックエンド-->>管理画面: 配分完了レスポンス
    管理画面->>管理者: 配分結果を表示
```

---

## ポイントシステム（FSPからクレデンシャルに変換）

クレデンシャルはERC20トークン（Credential.sol）としてブロックチェーン上に存在します。FSPからクレデンシャルへの直接変換ではなく、スマートコントラクトのMINTER_ROLEがクレデンシャルを各ウォレットアドレスにmintし、バックエンドのパイプライン処理がオンチェーンのクレデンシャル残高を定期的にデータベースに同期します。クレデンシャルはユーザー間で転送不可（mint/burnのみ可）です。

```mermaid
sequenceDiagram
    autonumber

    participant パイプライン as バックエンド（パイプライン）
    participant スマートコントラクト as Credential.sol（ERC20）
    participant データベース

    Note over パイプライン, データベース: クレデンシャル残高同期処理

    パイプライン->>データベース: EVMアドレスを持つ全ユーザーを取得
    データベース-->>パイプライン: ユーザー一覧（evm_addr付き）

    パイプライン->>スマートコントラクト: 各アドレスのクレデンシャル残高を取得（balanceOf）
    スマートコントラクト-->>パイプライン: 各アドレスの残高

    パイプライン->>データベース: ユーザーのcredentialフィールドを一括更新
    データベース-->>パイプライン: 更新完了

    Note over スマートコントラクト: クレデンシャルのmint（別プロセス）
    Note over スマートコントラクト: MINTER_ROLEがmint(address[], uint256[])を実行
    Note over スマートコントラクト: ユーザー間転送は不可（mint/burnのみ）
```

---

## タスクマッチング（作成時）

内部的に「オファー」と呼ばれるタスクをオーナーがシステムに公開します。ユーザーがオファーにアプライすると、オーナーに通知が送信されます。オーナーがアプライを承認するとステータスが「Ongoing」に変更され、他のアプライはキャンセルされます。メッセージ機能により、オーナーとユーザー間でコミュニケーションが可能です。

```mermaid
sequenceDiagram
    autonumber

    actor オーナー as タスクオーナー
    actor ユーザー
    participant フロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース

    %% タスク（オファー）公開
    オーナー->>フロントエンド: オファー作成ページを開く
    オーナー->>フロントエンド: タイトル、説明、場所、報酬、締切、画像、カテゴリー等を入力
    フロントエンド->>バックエンド: createNewOffer mutation
    バックエンド->>データベース: オファー情報を保存（publicity: true）
    データベース-->>バックエンド: 保存完了
    バックエンド-->>フロントエンド: オファー作成成功
    フロントエンド->>オーナー: 作成完了を表示

    %% ユーザーがアプライ
    ユーザー->>フロントエンド: オファー一覧から詳細を確認
    ユーザー->>フロントエンド: オファーにアプライ
    フロントエンド->>バックエンド: updateOfferStatus mutation（Applied）
    バックエンド->>データベース: offer_userレコード作成（status: Applied）
    データベース-->>バックエンド: 作成完了
    バックエンド-->>フロントエンド: アプライ成功
    バックエンド-)オーナー: アプライ通知

    %% メッセージ交換
    alt メッセージ交換
        ユーザー->>フロントエンド: メッセージを送信
        フロントエンド->>バックエンド: メッセージ送信 mutation
        バックエンド->>データベース: メッセージ保存
        バックエンド-->>オーナー: メッセージ通知
        オーナー->>フロントエンド: メッセージを返信
        フロントエンド->>バックエンド: メッセージ送信 mutation
        バックエンド->>データベース: メッセージ保存
        バックエンド-->>ユーザー: メッセージ通知
    end

    %% オーナーが承認 → Ongoing
    オーナー->>フロントエンド: アプライを承認
    フロントエンド->>バックエンド: updateOfferStatus mutation（Ongoing）
    バックエンド->>データベース: ステータスを「Ongoing」に変更
    バックエンド->>データベース: 他のアプライをキャンセル
    バックエンド->>データベース: publicity を false に変更
    データベース-->>バックエンド: 更新完了
    バックエンド-->>フロントエンド: ステータス変更成功
    バックエンド-)ユーザー: ステータス変更通知
```

---

## タスクマッチング（完了時）

タスクオーナーがオファーのステータスを「Finished」に変更すると、報酬FSPがオーナーから担当ユーザーに自動的に移転されます。担当ユーザーにはDB通知・FCMプッシュ通知・SendGridメール通知が送信されます。

```mermaid
sequenceDiagram
    autonumber

    actor オーナー as タスクオーナー
    actor ユーザー
    participant フロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース
    participant FCM
    participant SendGrid

    オーナー->>フロントエンド: オファーのステータスを「完了」に変更
    フロントエンド->>バックエンド: updateOfferStatus mutation（Finished）

    バックエンド->>データベース: オファー情報を取得（報酬額、オーナーID）
    バックエンド->>データベース: 担当ユーザーのoffer_user_mappingを取得
    バックエンド->>バックエンド: ステータスがOngoingであることを検証
    alt ステータスがOngoingでない
        バックエンド-->>フロントエンド: エラー
        フロントエンド-->>オーナー: エラーメッセージを表示
    end

    %% ポイント移転
    バックエンド->>データベース: 担当ユーザーのFSPを加算（+fee）
    バックエンド->>データベース: オーナーのFSPを減算（-fee）
    バックエンド->>データベース: FSPトランザクション履歴を作成（notes: "[Offer] {title} completed"）
    データベース-->>バックエンド: 更新完了

    バックエンド-->>フロントエンド: 完了レスポンス
    フロントエンド->>オーナー: 完了メッセージを表示

    %% 通知（担当ユーザーへ）
    バックエンド->>データベース: 通知レコード作成（「オファーが完了しました」）
    バックエンド-)FCM: プッシュ通知送信（非同期）
    FCM-)ユーザー: 「オファーが完了しました」
    バックエンド-)SendGrid: メール通知送信（非同期）
    SendGrid-)ユーザー: オファー完了通知メール
```

---

## AIチャットボット

ユーザーがチャットボットUIに質問を送信すると、バックエンドはユーザー情報に加え、所属アーティスト情報、アクティブなオファー情報、リリースの再生データ（過去6ヶ月・7日分）をコンテキストとして構築し、Google Gemini 2.0 Flash APIにリクエストします。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    participant フロントエンド as フロントエンド（チャットボットUI）
    participant バックエンド as バックエンド（GraphQL）
    participant データベース
    participant Gemini as Google Gemini 2.0 Flash API

    ユーザー->>フロントエンド: 質問を送信
    フロントエンド->>バックエンド: askLlm query（ユーザーID、質問内容）

    バックエンド->>データベース: ユーザー情報を取得
    データベース-->>バックエンド: ユーザー情報
    alt ユーザーが存在しない
        バックエンド-->>フロントエンド: エラー（User not found）
        フロントエンド->>ユーザー: エラーメッセージ表示
    end

    %% コンテキスト構築
    バックエンド->>データベース: ユーザーの所属アーティスト情報を取得
    データベース-->>バックエンド: アーティスト一覧
    バックエンド->>データベース: アクティブなオファー情報を取得
    データベース-->>バックエンド: オファー一覧
    バックエンド->>データベース: リリースの月次再生データを取得（過去6ヶ月、Spotify+Apple+LINE+Amazon+YouTube）
    データベース-->>バックエンド: 月次再生データ
    バックエンド->>データベース: リリースの日次再生データを取得（過去7日、Spotify+Apple+LINEのみ）
    データベース-->>バックエンド: 日次再生データ

    バックエンド->>バックエンド: プロンプトテンプレートにコンテキストを組み込み

    バックエンド->>Gemini: 質問 + コンテキスト（アーティスト、オファー、再生データ）を送信
    Gemini-->>バックエンド: 生成された回答

    バックエンド-->>フロントエンド: 回答を返却
    フロントエンド->>ユーザー: 回答を表示
```

---

## クレジット入力時の招待メール配信

入力ユーザーがクレジット情報（ISRC、ロール、名前、メールアドレス）を登録すると、バックエンドはUUIDベースの招待コード（digest_code）を生成し、招待レコードを作成します。招待処理の実行にはハードコードされたパスワード認証が必要です。SendGridを用いて招待メールを送信し、招待されたユーザーは招待コードを使ってアカウントを作成します。

```mermaid
sequenceDiagram
    autonumber

    actor 入力ユーザー
    actor 招待ユーザー
    participant フロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース
    participant SendGrid

    %% クレジット情報登録
    入力ユーザー->>フロントエンド: ISRC、ロール、名前、メールアドレスを入力
    フロントエンド->>バックエンド: registerCredit mutation（RegisterInfo）
    バックエンド->>データベース: track_creditsにクレジット情報を保存
    データベース-->>バックエンド: 保存完了
    バックエンド-->>フロントエンド: 登録完了

    %% 招待処理（invite関数の実行）
    フロントエンド->>バックエンド: invite mutation（パスワード）
    バックエンド->>バックエンド: パスワード認証（ハードコード値と比較）
    alt パスワード不一致
        バックエンド-->>フロントエンド: エラー（Invalid password）
    end

    バックエンド->>データベース: 未招待のクレジット情報を集約
    データベース-->>バックエンド: 招待対象ユーザー一覧

    loop 各招待対象ユーザー
        バックエンド->>バックエンド: UUIDベースの招待コード（digest_code）を生成
        バックエンド->>データベース: 招待レコード作成（invitee, inviter_email, digest_code）
        データベース-->>バックエンド: 作成完了
        バックエンド->>SendGrid: 招待メール送信リクエスト（招待コード付きリンク）
        SendGrid-)招待ユーザー: 招待メールを送信
    end

    %% アカウント作成
    招待ユーザー->>フロントエンド: 招待メールのリンクからアクセス
    招待ユーザー->>フロントエンド: 招待コード（digest_code）を入力
    フロントエンド->>バックエンド: joinWithCode mutation（招待コード、ユーザーID）

    バックエンド->>データベース: digest_codeで招待レコードを検索
    alt 招待コードが有効
        データベース-->>バックエンド: 招待レコード
        バックエンド->>バックエンド: コードが未使用か確認
        バックエンド->>データベース: 招待レコードを「参加済み」に更新
        バックエンド->>データベース: ユーザーと招待者の紐付けを保存
        データベース-->>バックエンド: 更新完了
        バックエンド-->>フロントエンド: アカウント作成完了
        フロントエンド->>招待ユーザー: 登録完了メッセージを表示
    else 招待コードが無効または使用済み
        バックエンド-->>フロントエンド: エラーメッセージ
        フロントエンド->>招待ユーザー: エラーを表示
    end
```

---

## 景品交換

ユーザーはFSPポイントを使って景品と交換できます。モバイルアプリユーザーはQRコードが生成され、景品提供者がQRコードをスキャンして利用を確定します。Webユーザーはボタン操作で交換・利用申請を行います。景品利用時はrepresentation_user_id（景品提供者）の検証が行われます。

```mermaid
sequenceDiagram
    autonumber

    actor ユーザー
    actor 景品提供者
    participant モバイルアプリ
    participant Web as Webフロントエンド
    participant バックエンド as バックエンド（GraphQL）
    participant データベース

    Note over ユーザー, データベース: 景品交換
    alt モバイルアプリから交換
        ユーザー->>モバイルアプリ: 景品と交換
        モバイルアプリ->>バックエンド: exchangePrize mutation（景品ID、ユーザーID、数量※デフォルト1）
    else Webから交換
        ユーザー->>Web: 景品と交換
        Web->>バックエンド: exchangePrize mutation（景品ID、ユーザーID、数量※デフォルト1）
    end

    バックエンド->>バックエンド: total_points = prize.point × amount を計算
    バックエンド->>データベース: ユーザーのFSP残高確認
    alt 残高不足（fsp < total_points）
        バックエンド-->>ユーザー: エラー（Insufficient balance）
    else 残高充足
        バックエンド->>データベース: ユーザーのFSPを減算（-total_points）
        バックエンド->>データベース: 景品提供者（representation_user）のFSPを加算（+total_points）
        バックエンド->>データベース: exchange_prize_historyレコード作成
        バックエンド->>データベース: fsp_txトランザクション履歴作成（notes: "Exchange prize: {景品名}"）
        データベース-->>バックエンド: 交換完了
        バックエンド-->>ユーザー: 交換成功レスポンス
    end

    Note over ユーザー, データベース: 景品利用申請
    ユーザー->>モバイルアプリ: 景品利用画面を表示
    モバイルアプリ->>バックエンド: requestPrize mutation（景品ID）
    バックエンド->>データベース: exchange_prize_historyのis_requestedをtrueに更新
    データベース-->>バックエンド: 更新完了
    バックエンド-->>モバイルアプリ: 利用申請完了

    Note over ユーザー, データベース: 景品利用確定（QRコード方式）
    モバイルアプリ->>モバイルアプリ: QRコード生成（userId|prizeId）
    ユーザー->>景品提供者: QRコード提示

    景品提供者->>モバイルアプリ: QRコードスキャン
    モバイルアプリ->>モバイルアプリ: QRデータ解析（userId, prizeId）
    モバイルアプリ->>バックエンド: usePrize mutation（景品ID、ユーザーID）

    バックエンド->>データベース: 景品情報を取得
    バックエンド->>バックエンド: representation_user_id（景品提供者）を検証
    alt 検証成功
        バックエンド->>データベース: is_usedをtrue、used_atを現在時刻に更新
        データベース-->>バックエンド: 更新完了
        バックエンド-->>モバイルアプリ: 利用確定完了
        モバイルアプリ->>景品提供者: 確定結果を表示
    else 検証失敗
        バックエンド-->>モバイルアプリ: エラー（権限なし）
        モバイルアプリ->>景品提供者: エラーを表示
    end
```
