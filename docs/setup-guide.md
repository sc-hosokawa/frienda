# 開発環境構築手順書

FRIENDA プロジェクトの開発環境をローカルにセットアップする手順です。

## 目次

1. [前提条件](#1-前提条件)
2. [リポジトリのクローン](#2-リポジトリのクローン)
3. [必須ツールのインストール](#3-必須ツールのインストール)
4. [セットアップの実行](#4-セットアップの実行)
5. [環境変数の設定](#5-環境変数の設定)
6. [各サービスの起動](#6-各サービスの起動)
7. [動作確認](#7-動作確認)
8. [トラブルシューティング](#8-トラブルシューティング)

---

## 1. 前提条件

- macOS（推奨）または Linux
- Git がインストール済みであること
- Docker Desktop がインストール・起動済みであること

## 2. リポジトリのクローン

```bash
git clone --recursive https://github.com/FRIENDSHIP-DAO/frienda.git
cd frienda
```

> `--recursive` を付けることで、サブモジュールも同時にクローンされます。

## 3. 必須ツールのインストール

### 3.1 バージョン管理ツール（asdf）

プロジェクトでは `.tool-versions` でツールバージョンを管理しています。[asdf](https://asdf-vm.com/) の利用を推奨します。

```bash
# asdf のインストール（Homebrew）
brew install asdf

# Node.js プラグインの追加とインストール
asdf plugin add nodejs
asdf install
```

これにより `.tool-versions` に定義された Node.js 20.18.1 がインストールされます。

### 3.2 必須ツール一覧

| ツール | バージョン | 用途 | インストール方法 |
|--------|-----------|------|-----------------|
| **Rust (stable)** | latest stable | バックエンド開発 | https://rustup.rs |
| **Node.js** | 20.18.1 | WebUI・コントラクト開発 | asdf または https://nodejs.org |
| **pnpm** | 9+ | Node.js パッケージ管理 | `npm install -g pnpm` |
| **Docker** | latest | PostgreSQL コンテナ | https://www.docker.com |

### 3.3 オプションツール（対象サービスを開発する場合に必要）

| ツール | 用途 | インストール方法 |
|--------|------|-----------------|
| **cargo-watch** | バックエンドのホットリロード | `cargo install cargo-watch` |
| **sea-orm-cli** | DB エンティティ生成 | `cargo install sea-orm-cli` |
| **fvm** | Flutter バージョン管理 | `dart pub global activate fvm` |
| **Flutter** (SDK >= 3.3.1) | モバイルアプリ開発 | `fvm install` (services/mobile 内で実行) |
| **melos** | Flutter モノレポ管理 | `fvm dart pub global activate melos` |
| **Foundry (forge)** | スマートコントラクト開発 | https://getfoundry.sh |

> **注意**: Flutter/Dart コマンドは必ず `fvm` 経由で実行してください（例: `fvm flutter run`, `fvm dart format`）。

### 3.4 ツールバージョンの確認

全ツールのインストール状態を一括確認できます。

```bash
make check-tools
```

## 4. セットアップの実行

以下のコマンドで、全サービスの依存関係インストールと初期設定が行われます。

```bash
make setup
```

このコマンドは以下を実行します:

1. 必須ツールのバージョン確認 (`check-tools`)
2. PostgreSQL コンテナの起動 (`run-pg`)
3. バックエンドの依存関係取得 (`cargo fetch`)
4. WebUI の依存関係インストール (`pnpm install`)
5. コントラクトの依存関係インストール (`pnpm install`)
6. モバイルの依存関係インストール (`melos bootstrap`、melos がある場合のみ)
7. `.env.example` から `.env` ファイルを作成（既存の場合はスキップ）

> `make setup` は何度実行しても安全です。

## 5. 環境変数の設定

`make setup` により以下の `.env` ファイルが作成されます。必要に応じて値を設定してください。

### 5.1 バックエンド (`services/backend/.env`)

| 変数名 | 必須 | 説明 |
|--------|------|------|
| `DATABASE_URL` | ローカル開発時は設定済み | PostgreSQL 接続文字列 |
| `HOST` | 設定済み | サーバーホスト（`0.0.0.0`） |
| `PORT` | 設定済み | サーバーポート（`8080`） |
| `ENV` / `ENVIRONMENT` | 設定済み | 環境名（`dev`） |
| `JWK_URL` | 認証機能利用時 | Firebase JWT 検証用 URL |
| `JWK_ISSUER` | 認証機能利用時 | Firebase JWT 発行者 |
| `GEMINI_API_KEY` | AI 機能利用時 | Gemini API キー |
| `SENDGRID_API_KEY` | メール機能利用時 | SendGrid API キー |
| `ETH_RPC_URL` | ブロックチェーン機能利用時 | Ethereum RPC エンドポイント |

> ローカル開発で基本的な API サーバーを起動するだけであれば、デフォルト値のままで動作します。

### 5.2 WebUI Client (`services/webui/apps/client/.env.local`)

| 変数名 | 必須 | 説明 |
|--------|------|------|
| `NEXT_PUBLIC_ENV` | 設定済み | 環境名 |
| `NEXT_PUBLIC_GRAPHQL_ENDPOINT` | 設定済み | GraphQL エンドポイント（`http://localhost:8080/graphql`） |
| `NEXT_PUBLIC_BASE_URL` | 設定済み | ベース URL（`http://localhost:3000`） |
| `NEXT_PUBLIC_CTF_SPACE_ID` | CMS 連携時 | Contentful スペース ID |
| `FIREBASE_PROJECT_ID` | Firebase 認証時 | Firebase プロジェクト ID |
| `STRIPE_SECRET_KEY` | 決済機能利用時 | Stripe シークレットキー |

### 5.3 WebUI Admin (`services/webui/apps/admin/.env.local`)

| 変数名 | 必須 | 説明 |
|--------|------|------|
| `NEXT_PUBLIC_ENV` | 設定済み | 環境名 |
| `NEXT_PUBLIC_GRAPHQL_ENDPOINT` | 設定済み | GraphQL エンドポイント |
| `BASIC_AUTH_USER` | Basic 認証利用時 | 管理画面ユーザー名 |
| `BASIC_AUTH_PASSWORD` | Basic 認証利用時 | 管理画面パスワード |

### 5.4 コントラクト (`services/contract/.env`)

| 変数名 | 必須 | 説明 |
|--------|------|------|
| `INFURA_KEY` | デプロイ時 | Infura API キー |
| `ETHERSCAN_KEY` | Verify 時 | Etherscan API キー |
| `DEPLOYER_PRIVATE_KEY` | デプロイ時 | デプロイヤーの秘密鍵 |

## 6. 各サービスの起動

### 6.1 データベース（PostgreSQL）

```bash
# 起動
make run-pg

# 停止
make stop-pg

# コンテナ削除（データもリセット）
make down-pg
```

- PostgreSQL 16 が Docker コンテナで起動します
- ポート: `5432`
- ユーザー/パスワード/DB名: すべて `postgres`
- DB スキーマは初回起動時に自動初期化されます

### 6.2 バックエンド（Rust）

```bash
# ホットリロード付きで起動（推奨、cargo-watch が必要）
make api-dev

# ホットリロードなしで起動
make api
```

- `http://localhost:8080` で GraphQL API サーバーが起動します
- PostgreSQL コンテナも自動的に起動されます

### 6.3 WebUI（Next.js）

```bash
# クライアントアプリ
make webui-client-dev    # http://localhost:3000

# 管理画面アプリ
make webui-admin-dev
```

### 6.4 モバイル（Flutter）

```bash
# iOS シミュレータを起動してアプリを実行
make mobile-dev
```

> 事前に Xcode と iOS シミュレータが必要です。

### 6.5 GraphQL コード生成

GraphQL スキーマを変更した場合は、クライアント側のコードを再生成します。

```bash
# 全サービス
make setup-gql

# WebUI のみ
make gql-webui

# モバイルのみ
make gql-mobile
```

## 7. 動作確認

### 7.1 バックエンド

```bash
# サーバー起動後、GraphQL Playground にアクセス
open http://localhost:8080/graphql
```

### 7.2 WebUI

```bash
# クライアントアプリにアクセス
open http://localhost:3000
```

### 7.3 テスト実行

```bash
# バックエンド
cd services/backend && cargo test

# WebUI
cd services/webui && pnpm lint

# モバイル
cd services/mobile && melos run test

# コントラクト
cd services/contract && pnpm foundrytest
```

## 8. トラブルシューティング

### PostgreSQL に接続できない

```bash
# Docker が起動しているか確認
docker ps

# コンテナを再作成
make down-pg && make run-pg
```

### ポート 5432 が使用中

ローカルに PostgreSQL がインストールされている場合、ポートが競合します。

```bash
# ローカルの PostgreSQL を停止
brew services stop postgresql

# または、使用中のプロセスを確認
lsof -i :5432
```

### `cargo watch` が見つからない

```bash
cargo install cargo-watch
```

### `fvm` コマンドが見つからない

```bash
dart pub global activate fvm
# PATH に ~/.pub-cache/bin が含まれていることを確認
```

### `pnpm install` でエラーが発生する

```bash
# Node.js のバージョンを確認（20+ が必要）
node --version

# キャッシュクリアして再試行
pnpm store prune
cd services/webui && pnpm install
```

### DB スキーマをリセットしたい

```bash
make down-pg && make run-pg
```

---

## 補足: プロジェクト構成

```
frienda/
├── services/
│   ├── backend/        # Rust (Actix-web, Sea-ORM, async-graphql)
│   ├── webui/          # Next.js (pnpm, Turborepo)
│   │   ├── apps/
│   │   │   ├── client/ # クライアント向け Web アプリ
│   │   │   └── admin/  # 管理画面 Web アプリ
│   │   └── packages/   # 共有パッケージ
│   ├── mobile/         # Flutter (fvm, melos)
│   │   ├── apps/
│   │   │   ├── client/ # クライアント向けモバイルアプリ
│   │   │   └── admin/  # 管理画面モバイルアプリ
│   │   └── packages/   # 共有パッケージ
│   ├── contract/       # Solidity (Foundry, Hardhat)
│   └── postgres/       # DB 初期化スクリプト
├── docker-compose.yaml # PostgreSQL コンテナ定義
├── Makefile            # 開発コマンド集
└── .tool-versions      # asdf ツールバージョン定義
```
