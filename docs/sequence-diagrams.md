# 処理フロー図（シーケンス図）

各機能の処理フローをシーケンス図で示します。

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

---

## サインイン

ユーザーはクライアントアプリケーションを通じて、メールアドレスとパスワードを用いてFirebase Authで認証を行います。認証に成功すると、クライアントはFirebaseから取得したユーザー情報をバックエンドサーバーに送信します。バックエンドサーバーはデータベースにアクセスし、ユーザー情報を確認・登録後、クライアントにユーザートークンを発行します。最後に、クライアントはユーザーをダッシュボードまたはホーム画面に遷移させます。

```mermaid
sequenceDiagram
    autonumber

    actor User as ユーザー
    participant Client as クライアント
    participant Firebase as Firebase Auth
    participant Server as バックエンドサーバー
    participant DB as データベース

    User->>Client: メールアドレス・パスワードを入力
    Client->>Firebase: サインインリクエスト
    activate Firebase
    Firebase-->>Client: 認証成功（ユーザー情報）
    deactivate Firebase

    Client->>Server: ユーザー情報を送信
    activate Server
    Server->>DB: ユーザー情報を確認・登録
    activate DB
    DB-->>Server: 登録結果
    deactivate DB
    Server-->>Client: ユーザートークンを発行
    deactivate Server

    Client-->>User: ダッシュボード/ホーム画面に遷移
```

---

## 認証

ユーザーはクライアントアプリケーションを通じて、メールアドレスとパスワードを用いてFirebase認証を行います。認証に成功すると、クライアントはFirebaseから発行されたIDトークンをバックエンドサーバーに送信します。バックエンドサーバーはFirebase認証にトークン検証を依頼し、その結果に応じて処理を分岐します。

```mermaid
sequenceDiagram
    autonumber

    actor User as ユーザー
    participant Client as クライアント
    participant Firebase as Firebase Auth
    participant Server as バックエンドサーバー
    participant DB as データベース

    User->>Client: メールアドレス・パスワードを入力
    Client->>Firebase: 認証リクエスト
    activate Firebase
    Firebase-->>Client: IDトークン発行
    deactivate Firebase

    Client->>Server: IDトークンを送信
    activate Server
    Server->>Firebase: トークン検証を依頼
    activate Firebase

    alt トークンが有効
        Firebase-->>Server: 検証成功
        deactivate Firebase
        Server->>DB: ユーザー情報を検索
        activate DB

        alt ユーザーが存在する
            DB-->>Server: ユーザー情報
            deactivate DB
            Server-->>Client: アクセストークン + ユーザー情報
            Client-->>User: ダッシュボード/ホーム画面に遷移
        else ユーザーが存在しない
            DB-->>Server: ユーザー未登録
            Server-->>Client: エラーメッセージ
            Client-->>User: エラーを表示
        end
    else トークンが無効
        Firebase-->>Server: 検証失敗
        Server-->>Client: エラーメッセージ
        deactivate Server
        Client-->>User: エラーを表示
    end
```

---

## クエスト

クエストオーナーはフロントエンドからクエストを投稿します。ユーザーはクエスト一覧を閲覧し、参加やタスク完了報告を行います。バックエンドはデータベースを更新してポイントの付与や減算などを行い、トランザクションでデータの整合性を保ちます。

```mermaid
sequenceDiagram
    autonumber

    actor Owner as クエストオーナー
    actor User as ユーザー
    participant Frontend as フロントエンド
    participant Backend as バックエンド
    participant DB as データベース

    %% クエスト投稿
    rect rgb(230, 240, 255)
    Note over Owner, DB: クエスト投稿フロー
    Owner->>Frontend: クエスト投稿ページを開く
    Frontend->>Backend: ポイント残高・カテゴリ一覧を取得
    activate Backend
    Backend->>DB: データ取得
    DB-->>Backend: ポイント残高・カテゴリ一覧
    Backend-->>Frontend: 投稿ページ情報
    deactivate Backend
    Frontend-->>Owner: 投稿ページを表示

    Owner->>Frontend: クエスト情報を入力・投稿
    Frontend->>Backend: クエスト情報を送信
    activate Backend
    Backend->>Backend: 入力情報を検証
    Backend->>DB: クエストを保存
    DB-->>Backend: 保存完了
    Backend-->>Frontend: 投稿成功
    deactivate Backend
    end

    %% クエスト参加
    rect rgb(230, 255, 230)
    Note over User, DB: クエスト参加フロー
    User->>Frontend: クエスト一覧を閲覧
    Frontend->>Backend: クエスト一覧を取得
    Backend->>DB: クエスト一覧を取得
    DB-->>Backend: クエスト一覧
    Backend-->>Frontend: クエスト一覧
    Frontend-->>User: クエスト一覧を表示

    User->>Frontend: クエスト詳細を確認
    User->>Frontend: クエストに参加
    Frontend->>Backend: 参加リクエスト
    activate Backend
    Backend->>DB: 参加情報を保存
    DB-->>Backend: 保存完了
    Backend-->>Frontend: 参加成功
    deactivate Backend
    end

    %% タスク完了
    rect rgb(255, 245, 230)
    Note over User, DB: タスク完了・ポイント処理
    User->>Frontend: タスク完了報告
    Frontend->>Backend: 完了報告を送信
    activate Backend
    Backend->>DB: トランザクション開始
    activate DB
    Backend->>DB: タスクステータス更新
    Backend->>DB: ポイント付与・減算
    DB-->>Backend: トランザクション完了
    deactivate DB
    Backend-->>Frontend: 処理成功
    deactivate Backend
    Frontend-->>User: 完了通知を表示
    end
```

---

## ポイントシステム（購入時）

ユーザーはフロントエンドからポイント購入ページを開き、購入するポイント数を選択します。バックエンドはStripeを用いて決済処理を行い、決済が成功するとデータベースに購入履歴を記録し、ユーザーのポイント残高を加算します。

```mermaid
sequenceDiagram
    autonumber

    actor User as ユーザー
    participant Frontend as フロントエンド
    participant Backend as バックエンド
    participant Stripe as Stripe
    participant DB as データベース

    User->>Frontend: ポイント購入ページを開く
    User->>Frontend: 購入ポイント数を選択
    Frontend->>Backend: ポイント数 + ユーザーIDを送信
    activate Backend

    Backend->>Stripe: 決済処理リクエスト
    activate Stripe

    alt 決済成功
        Stripe-->>Backend: 決済成功
        deactivate Stripe
        Backend->>DB: トランザクション開始
        activate DB
        Backend->>DB: 購入履歴を記録
        Backend->>DB: ポイント残高を加算
        DB-->>Backend: トランザクション完了
        deactivate DB
        Backend-->>Frontend: 購入成功
        deactivate Backend
        Frontend-->>User: 購入完了を表示

        Backend-)User: 購入完了メールを送信
    else 決済失敗
        Stripe-->>Backend: 決済失敗
        Backend-->>Frontend: エラーメッセージ
        Frontend-->>User: エラーを表示
    end
```

---

## ポイントシステム（送付時）

ユーザーはフロントエンドからポイント送付ページを開き、送付先ユーザーとポイント数、メモを入力します。バックエンドは送付元ユーザーのポイント残高を確認し、十分な残高がある場合にトランザクションでポイントの移動を行います。

```mermaid
sequenceDiagram
    autonumber

    actor Sender as 送付元ユーザー
    actor Receiver as 送付先ユーザー
    participant Frontend as フロントエンド
    participant Backend as バックエンド
    participant DB as データベース

    Sender->>Frontend: ポイント送付ページを開く
    Sender->>Frontend: 送付先・ポイント数・メモを入力
    Frontend->>Backend: 送付情報 + 送付元ユーザーIDを送信
    activate Backend

    Backend->>DB: 送付元ユーザーのポイント残高を確認
    activate DB
    DB-->>Backend: ポイント残高
    deactivate DB

    alt 残高が十分
        Backend->>DB: トランザクション開始
        activate DB
        Backend->>DB: 送付元ポイントを減算
        Backend->>DB: 送付先ポイントを加算
        DB-->>Backend: トランザクション完了
        deactivate DB
        Backend-->>Frontend: 送付完了
        deactivate Backend
        Frontend-->>Sender: 送付完了を表示

        par 通知処理（非同期）
            Backend-)Sender: 送付完了通知
        and
            Backend-)Receiver: ポイント受取通知
        end
    else 残高不足
        Backend-->>Frontend: 残高不足エラー
        Frontend-->>Sender: エラーを表示
    end
```

---

## ポイントシステム（特典ポイント）

ユーザーがログインや特定の操作を実行すると、バックエンドはログインボーナスや操作内容に応じたポイント付与条件を判定し、トランザクションでポイントを加算します。

```mermaid
sequenceDiagram
    autonumber

    actor User as ユーザー
    participant Frontend as フロントエンド
    participant Backend as バックエンド
    participant DB as データベース

    User->>Frontend: ログイン/特定操作を実行
    Frontend->>Backend: 操作情報 + ユーザーIDを送信
    activate Backend

    Backend->>Backend: ポイント付与条件を判定

    alt 付与条件を満たす
        Backend->>DB: トランザクション開始
        activate DB
        Backend->>DB: ユーザーポイントを加算
        DB-->>Backend: トランザクション完了
        deactivate DB
        Backend-->>Frontend: ポイント付与成功
        deactivate Backend
        Frontend-->>User: ポイント獲得メッセージ + 更新残高を表示
    else 付与条件を満たさない
        Backend-->>Frontend: ポイント付与なし
        Frontend-->>User: 通常画面を表示
    end
```

---

## ポイントシステム（FSP配分）

アーティストグループが持つFSPをユーザーに配分するフローです。管理者画面で、アドミンユーザーがポイント配分のリクエストを入力し、組織アカウントのポイントを所属ユーザーに配分します。

```mermaid
sequenceDiagram
    autonumber

    actor Admin as アドミンユーザー
    actor Member as 所属ユーザー
    participant Frontend as 管理者画面
    participant Server as サーバー
    participant OrgDB as 組織データベース
    participant UserDB as ユーザーデータベース

    Admin->>Frontend: ポイント配分リクエストを入力
    Frontend->>Server: 配分情報を送信
    activate Server

    Server->>OrgDB: 組織アカウントのポイント残高を確認
    activate OrgDB
    OrgDB-->>Server: ポイント残高
    deactivate OrgDB

    alt ポイントが十分
        Server->>OrgDB: 組織ポイントを減算
        activate OrgDB
        OrgDB-->>Server: 更新完了
        deactivate OrgDB

        Server->>UserDB: 所属ユーザーにポイントを加算
        activate UserDB
        UserDB-->>Server: 更新完了
        deactivate UserDB

        Server-->>Frontend: 配分成功
        deactivate Server
        Frontend-->>Admin: 配分完了を表示
        Server-)Member: ポイント受取通知を送信
    else ポイント不足
        Server-->>Frontend: ポイント不足エラー
        Frontend-->>Admin: ポイント不足を表示
    end
```

---

## ポイントシステム（FSPからクレデンシャルに変換）

フロントエンドからウォレットアドレスをバックエンドに通知し、ポイントのトランザクション履歴に基づいてクレデンシャルを計算し、スマートコントラクト経由で各ウォレットアドレスに送付します。

```mermaid
sequenceDiagram
    autonumber

    actor User as ユーザー
    participant Frontend as フロントエンド
    participant Backend as バックエンド
    participant DB as データベース
    participant SC as スマートコントラクト

    Frontend->>Backend: ウォレットアドレスを通知
    activate Backend

    Backend->>DB: ウォレットアドレスを格納
    activate DB
    DB-->>Backend: 格納完了
    deactivate DB

    Backend->>DB: ポイントトランザクション履歴を取得
    activate DB
    DB-->>Backend: トランザクション履歴
    deactivate DB

    Backend->>Backend: クレデンシャル計算処理を実行

    Backend->>SC: クレデンシャル量を送付
    activate SC
    SC->>SC: 各ウォレットアドレスにクレデンシャルを送付

    SC->>DB: クレデンシャル情報をインデックス
    activate DB
    DB-->>SC: インデックス完了
    deactivate DB

    SC-->>Backend: 処理完了
    deactivate SC

    Backend->>DB: インデックスされたデータを取得
    activate DB
    DB-->>Backend: クレデンシャルデータ
    deactivate DB

    Backend-->>Frontend: 処理結果を返却
    deactivate Backend
    Frontend-->>User: 最新の残高を表示
```

---

## タスクマッチング（作成時）

タスクオーナーがシステムにタスクを公開し、ユーザーがアプライします。募集期間中はメッセージ交換が可能で、遂行条件がクリアされるとタスクのステータスが「Ongoing（進行中）」に変更されます。

```mermaid
sequenceDiagram
    autonumber

    actor Owner as タスクオーナー
    actor User as ユーザー
    participant System as システム

    Owner->>System: タスクを公開
    System-->>User: タスク内容を表示

    User->>System: タスクにアプライ
    System-)Owner: アプライ通知を送信

    rect rgb(230, 240, 255)
    Note over Owner, User: 募集期間中のメッセージ交換
    loop メッセージ交換
        User->>System: メッセージを送信
        System-->>Owner: メッセージを転送
        Owner->>System: メッセージを送信
        System-->>User: メッセージを転送
    end
    end

    Owner->>System: 遂行条件クリアを確認
    User->>System: 遂行条件クリアを確認

    Note over System: 双方から条件クリア確認を受領
    System->>System: ステータスを「Ongoing」に変更
    System-->>Owner: ステータス変更通知
    System-->>User: ステータス変更通知
```

---

## タスクマッチング（完了時）

タスクオーナーがタスクのステータスを「finish（完了）」に変更すると、ポイントの送信処理が行われます。

```mermaid
sequenceDiagram
    autonumber

    actor Owner as タスクオーナー
    actor User as ユーザー
    participant System as システム

    Owner->>System: ステータスを「finish」に変更
    activate System
    System-->>Owner: 完了確認メッセージ

    alt 正常完了
        System-)User: タスク完了通知を送信
        System->>System: ポイント送信処理を開始
        System-->>Owner: ポイント減少を確認
        System-->>User: ポイント受取を確認
    else 異常終了
        System-->>Owner: エラーメッセージ
    end
    deactivate System
```

---

## AIチャットボット

ユーザーがチャットボットUIに質問を送信すると、サーバーはユーザー情報と質問内容をGoogle Gemini APIに送信し、生成された回答をユーザーに表示します。

```mermaid
sequenceDiagram
    autonumber

    actor User as ユーザー
    participant Frontend as フロントエンド
    participant Server as サーバー
    participant Gemini as Google Gemini API

    User->>Frontend: チャットボットUIに質問を送信
    Frontend->>Server: 質問内容をリクエスト
    activate Server

    Server->>Server: ユーザー情報を確認

    Server->>Gemini: 質問内容 + ユーザー情報を送信
    activate Gemini
    Gemini->>Gemini: 回答を生成
    Gemini-->>Server: 生成された回答
    deactivate Gemini

    Server-->>Frontend: 回答を送信
    deactivate Server
    Frontend-->>User: 回答を表示
```

---

## クレジット入力時の招待メール配信

入力ユーザーがクレジット情報を入力すると、サーバーはハッシュを生成してデータベースに保存します。定期的に楽曲情報を集約し、SendGridを用いてメールを送信します。メール受信者はハッシュコードを用いてアカウントを作成できます。

```mermaid
sequenceDiagram
    autonumber

    actor InputUser as 入力ユーザー
    actor InvitedUser as 招待ユーザー
    participant Frontend as フロントエンド
    participant Server as サーバー
    participant DB as データベース
    participant SendGrid as SendGrid

    %% クレジット情報の入力
    rect rgb(230, 240, 255)
    Note over InputUser, DB: クレジット情報入力フロー
    InputUser->>Frontend: ロール・名前・メールアドレスを入力
    Frontend->>Server: 入力情報を送信
    activate Server
    Server->>Server: クレジット識別用ハッシュを生成
    Server->>DB: ハッシュと入力情報を保存
    activate DB
    DB-->>Server: 保存完了
    deactivate DB
    Server-->>Frontend: 入力完了
    deactivate Server
    end

    %% 定期的なメール配信
    rect rgb(255, 245, 230)
    Note over Server, SendGrid: 定期メール配信フロー
    loop 定期実行
        Server->>DB: 楽曲情報を集約
        activate DB
        DB-->>Server: 集約データ
        deactivate DB
        Server->>SendGrid: メール送信リクエスト
        activate SendGrid
        SendGrid-)InvitedUser: 招待メールを送信
        deactivate SendGrid
    end
    end

    %% アカウント作成
    rect rgb(230, 255, 230)
    Note over InvitedUser, DB: アカウント作成フロー
    InvitedUser->>Server: アカウント作成リクエスト
    activate Server
    Server-->>InvitedUser: ハッシュコードを要求
    InvitedUser->>Server: ハッシュコードを入力

    Server->>DB: ハッシュコードを照合
    activate DB

    alt ハッシュコードが一致
        DB-->>Server: 照合成功
        deactivate DB
        Server->>Server: アカウントを作成
        Server-->>InvitedUser: アカウント作成完了
    else ハッシュコードが不一致
        DB-->>Server: 照合失敗
        Server-->>InvitedUser: エラーメッセージ
    end
    deactivate Server
    end
```
